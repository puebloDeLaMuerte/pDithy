

PImage[] imgs;
PGraphics[] pgs;
boolean showDither = false;

int maxwidth = 0;
int maxheight = 0;
int currentImage = 0;

dKernel kernel;

public boolean lineByLine = false;
public int oversampling = 1;

int saveCounter = 0;

void settings() {

  //pixelDensity(pixelDensity);
  
  String path = sketchPath() + "/../_sourceImages/scenes B/single/";//
  File folder = new File(path);
  File[] listOfFiles = folder.listFiles(); //<>//
  ArrayList<String> filenames = new ArrayList<String>();

  for (int i = 0; i < listOfFiles.length; i++) {
    if (listOfFiles[i].isFile()) {
      String f = listOfFiles[i].getName();
      System.out.println("File " + f);
      
      if( f.endsWith(".jpg") || f.endsWith(".JPG") || f.endsWith(".png") )
      filenames.add( f );
      
    } else if (listOfFiles[i].isDirectory()) {
      System.out.println("Directory " + listOfFiles[i].getName());
    }
  }

  imgs= new PImage[filenames.size()];
  for (int i = 0; i < imgs.length; i++) {
    imgs[i] = loadImage(path + "/" + filenames.get(i));
    if( imgs[i].width  > maxwidth ) maxwidth = imgs[i].width;
    if( imgs[i].height > maxheight ) maxheight = imgs[i].height;
  }
  
  pgs = new PGraphics[filenames.size()];
  
  kernel = new bwKernel();

  //size(maxwidth, maxheight, P2D);
  fullScreen(P2D);
}


void setup() {

  //kernel = new colKernel();

  for (int i = 0; i < imgs.length; i++) {
    
    imgs[i] = resizeToScreen(imgs[i]);  
    //pgs[i] = kernel.dither( imgs[i]);
  }
  
}


void draw() {
  
  background(0);
  //println(oversampling);
  int thisx = (width  - imgs[currentImage].width ) / 2;
  int thisy = (height - imgs[currentImage].height) / 2;
  
  if ( showDither ) image( kernel.dither(imgs[currentImage]), thisx, thisy );
  else image( imgs[currentImage], thisx, thisy) ;
}


void keyPressed() {

  if( key == 'S' ) {
    println("saving frame " + saveCounter);
    saveCounter++;
    saveFrame("../out/pdityh_procedural/pdithy_"+saveCounter+".png");
  }
  
  if ( key == 's' ) showDither = !showDither;
  
  if( key == '1' ) {
    kernel = new bwKernel();
    //setup();
  }
  if( key == '2' ) {
    kernel = new accuratebwKernel();
    //setup();
  }
  if( key == '3' ) {
    kernel = new colKernel();
    //setup();
  }
  if( key == '4' ) {
    kernel = new accuratecolKernel();
    //setup();
  }
  if( key == '5' ) {
    kernel = new monocolKernel();
    //setup();
  }
  if( key == '6' ) {
    kernel = new RandoKernel();
    //setup();
  }
  
  if( key == 'l' ) {
    lineByLine = !lineByLine;
    //setup();
  }
  
  if( key == '0' ) oversampling = 1;
  
  if( key == CODED ) {
    if( keyCode == LEFT ) {
      if( currentImage == 0 ) currentImage = imgs.length-1;
      else currentImage = --currentImage % imgs.length; 
    }
    if( keyCode == RIGHT ) {
      currentImage = ++currentImage % imgs.length; 
    }
    if( keyCode == UP ) {
      oversampling++; 
    }
    if( keyCode == DOWN ) {
      if( oversampling <= 2 ) oversampling = 1;
      else oversampling--;  
    }
  }
}


public PImage resizeToScreen( PImage i ) {
  
  //println(width + "/" + height);
  
  if( i.width > width ) {
    float fact = (float)width / i.width; //<>//
    i.resize( (int)(i.width * fact), (int)(i.height* fact));
  }
  if ( i.height > height ) {
    float fact = (float)height / i.height; //<>//
    i.resize( (int)(i.width * fact), (int)(i.height* fact));
  }
  return i;
}
