class accuratebwKernel implements dKernel{


  float startValue = 0;
  float tipping = 255;
  float accumulator = 0;

  float whiteVal = 255;
  float blackVal = 0;

  public PGraphics dither(PImage image) {

    PGraphics pg = createGraphics(image.width, image.height, P2D);

    pg.loadPixels();
    image.loadPixels();

    accumulator = startValue;
    startValue = 0;
    tipping = oversampling * 255;
    
    for ( int i = 0; i < image.pixels.length; i++) {

      if( i % image.width == 0 ) { // on every new line
        
        if( lineByLine  ) {
           accumulator = startValue;
        }
        
        if( randomInit ) {
          //startValue = random(tipping/2);
          startValue = i % tipping;
        }
      }
       
      
      accumulator += red(image.pixels[i]) + green(image.pixels[i]) + blue(image.pixels[i]);

      if ( accumulator >= tipping ) {
        pg.pixels[i] = color(whiteVal);
        // less accurate
        //accumulator = startValue;
        // more accurate
        accumulator = accumulator - tipping;
      } else {
        pg.pixels[i] = color( blackVal );
      }
    }

    pg.updatePixels();
    image.updatePixels();
    return pg;
  }
}
