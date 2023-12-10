class colKernel implements dKernel{

  float startValue = 0;
  float tippingR = 255;
  float tippingG = 255;
  float tippingB = 255;
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

    accumulatorR = startValue;
    accumulatorG = startValue;
    accumulatorB = startValue;
    startValue = 0;

    float tippingR = oversampling * 255;
    float tippingG = oversampling * 255;
    float tippingB = oversampling * 255;

    float currentR = 0;
    float currentG = 0;
    float currentB = 0;

    for ( int i = 0; i < image.pixels.length; i++) {

      if( lineByLine && i % image.width == 0 ) {
         accumulatorR = startValue;
         accumulatorG = startValue;
         accumulatorB = startValue;
      }
      
      accumulatorR += red(image.pixels[i]);
      accumulatorG += green(image.pixels[i]);
      accumulatorB += blue(image.pixels[i]);

      if ( accumulatorR >= tippingR ) {
        currentR = whiteVal;
        accumulatorR = startValue;
      } else {
        currentR = blackVal;
      }
      
      if ( accumulatorG >= tippingG ) {
        currentG = whiteVal;
        accumulatorG = startValue;
      } else {
        currentG = blackVal;
      }
      
      if ( accumulatorB >= tippingB ) {
        currentB = whiteVal;
        accumulatorB = startValue;
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
