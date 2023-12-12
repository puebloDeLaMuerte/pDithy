public class RandoKernel implements dKernel {
  
  
  float startValue = 0;
  float tipping = 3*255;
  float accumulator = 0;

  int whiteCol = 255;// color(56,141,252);
  int blackCol = 2;//color(19,8,64);
  
  private PGraphics dithg;
  
  int dirX = 1;
  int dirY = 1;
  int posX, posY;

  int iterationsPerFrame = 50000;
  
  int backgroundColor = color(0);

  public PGraphics dither(PImage image) {

    if( dithg == null ) {
      println("new graphics");
      dithg = createGraphics(image.width, image.height, P2D);  
      dithg.loadPixels();
      dithg.beginDraw();
      dithg.background(backgroundColor);
      dithg.endDraw();
      dithg.updatePixels();
      
      posX = dithg.width / 2;
      posY = dithg.height / 2;
      
      dirX = getRand();
      dirY = getRand();
      
      println("img: w " + image.width + " h " + image.height);
      println("dth: w " + dithg.width + " h " + dithg.height);
    }
    
    tipping = oversampling * 255;
    
    //PGraphics pg = kernG;

    dithg.beginDraw();
    dithg.loadPixels();
    image.loadPixels();

    accumulator = startValue;
    startValue = 0;
    tipping = oversampling * 255;
    
    //posX += getRand();
    //posY += getRand();
    
    for( int iterations = 0; iterations < iterationsPerFrame; iterations++ ) {
    
      posX += dirX;
      posY += dirY;
      
      if(posX >= image.width || posY >= image.height || posX < 0 || posY < 0) {
        int tries = 0;
        boolean isFree = false;   
        randomXYpos(image.width, image.height);
        
        while(tries < 10000 && isFree ) {
        
          isFree = dithg.pixels[pixPos(posX,posY,image.width)] == backgroundColor;
          tries++;
        }
      }
      
      
      //posX = i % image.width;
      //posY = (i - posX) / image.width;
      
      accumulator += red(image.pixels[pixPos(posX,posY,image.width)]) + green(image.pixels[pixPos(posX,posY,image.width)]) + blue(image.pixels[pixPos(posX,posY,image.width)]);
  
      if ( accumulator >= tipping ) {
        dithg.pixels[pixPos(posX,posY,image.width)] = whiteCol;
        // less accurate
        accumulator = startValue;
        // more accurate
        //accumulator = accumulator - tipping;
        
        dirX = getRand();
        dirY = getRand();
        
      } else {
        dithg.pixels[pixPos(posX,posY,image.width)] = blackCol;
        //println("black");
      }
    
    
    }
    
    /*
    for(int x = frameCount; x < dithg.width && x < frameCount+1; x++ ) {
      for( int y = 0; y < dithg.height; y++ ) {
        dithg.pixels[ pixPos(x,y,dithg.width) ] = color(random(255));
      }
    }
    */
  

    dithg.updatePixels();
    image.updatePixels();
    dithg.endDraw();
    
    return dithg;
  }
  
  private int pixPos(int x, int y, int w) {
    return x + ( y * w );
  }
  
  private int getRand() {
    float d = random(-100,100);
    if( d < 0 ) return -1;
    else return 1;
  }
  
  private void randomXYpos(int w, int h) {
    posX = (int) random( w );
    posY = (int) random( h );    
  }
  
}
