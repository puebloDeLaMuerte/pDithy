class accuratecolKernel implements dKernel{

  float startValue = 0;
  float tippingR = 4*255;
  float tippingG = 4*255;
  float tippingB = 4*255;
  float accumulatorR = 0;
  float accumulatorG = 0;
  float accumulatorB = 0;

  float whiteVal = 255;
  float blackVal = 0;

  float currentR = 0;
  float currentG = 0;
  float currentB = 0;
  

  public PGraphics dither(PImage image) {

    PGraphics pg = createGraphics(image.width, image.height, P2D);

    pg.loadPixels();
    image.loadPixels();
    
    float tippingR = oversampling * 255;
    float tippingG = oversampling * 255;
    float tippingB = oversampling * 255;
    
    accumulatorR = startValue;
    accumulatorG = startValue;
    accumulatorB = startValue;
    startValue = 0;

    float currentR = 0;
    float currentG = 0;
    float currentB = 0;

    for ( int i = 0; i < image.pixels.length; i++) {

      accumulatorR += red(image.pixels[i]);
      accumulatorG += green(image.pixels[i]);
      accumulatorB += blue(image.pixels[i]);

      if( lineByLine && i % image.width == 0 ) {
         accumulatorR = startValue;
         accumulatorG = startValue;
         accumulatorB = startValue;
      }
      
      if( i % image.width == 0 ) { // on every new line        
        if( randomInit ) {
          //startValue = random(tipping/2);
          accumulatorR = i % tippingR;
          accumulatorG = i % tippingG;
          accumulatorB = i % tippingB;
        }
      }

      if ( accumulatorR >= tippingR ) {
        currentR = whiteVal;
        accumulatorR = accumulatorR - tippingR;
      } else {
        currentR = blackVal;
      }
      
      if ( accumulatorG >= tippingG ) {
        currentG = whiteVal;
        accumulatorG = accumulatorG - tippingG;
      } else {
        currentG = blackVal;
      }
      
      if ( accumulatorB >= tippingB ) {
        currentB = whiteVal;
        accumulatorB = accumulatorB - tippingB;
      } else {
        currentB = blackVal;
      }
      
      pg.pixels[i] = color( currentR, currentG, currentB);
      
    }

    pg.updatePixels();
    image.updatePixels();
    return pg;
  }
}
