// PNG glitch tool
// Based on hacked pngj and zlib libraries
//   https://github.com/leonbloy/pngj
//   http://jazzlib.sourceforge.net
// Tomasz Sulej, generateme.blog@gmail.com, http://generateme.tumblr.com
// Licence: http://unlicense.org/

// Description: Prepare PNG image, it has to be PNG 24bit.
// Note: Choose different compression level to get different artifacts!
//   eg. ImageMagick compression level from 1 to 5 selects different filters:
//          1 - Sub, 2 - Up, 3 - Average, 4 - Paeth, 5 - None
//          0,6-9 are combination of above (based probably on some heuristics)
//   Note 2: other convert programs can give different results!

// Usage:
//   * press SPACE to save
//   * press 0 to turn on/off filter decode
//   * press 1-5 to choose filter used
//   * click to glitch around pointed place
//   * press q,w,e,r,t to choose glitch method
//   * press u for remove (undo) last glitch point
//   * press a for add random glitches for lines
//   * prezz z for reset all glitches (but not filter)

// One more reminder: prepare your PNG first, choose PNG24 and compression level (from 0 to 9)

import ar.com.hjg.pngj.*;
import tsl.corruptinfo.Corruptor;
import java.io.InputStream;

// set up filename
String filename = "test";
String fileext = ".png";
String foldername = "./";

int max_display_size = 1000; // viewing window size (regardless image size)

// select global filtering
boolean do_filtering = false;
int filter = 0; // 0-4, 0 - NONE, 1 - SUB, 2 - UP, 3 - AVERAGE, 4 - PAETH
// choose method for glitch by click (to be honest, do not see any difference)
int glitch_method = Corruptor.RANDOM; // Corruptor.SUB1, Corruptor.ZERO, Corruptor.NEGATE, Corruptor.RANDOM, Corruptor.ADD1
int lines_glitched = 10; // this is average number of glitched lines after 'a' pressed

// working buffer
PGraphics buffer;

String sessionid;

PngReader pngr;

void setup() {
  
  sessionid = hex((int)random(0xffff),4);
  
  Corruptor.force_filter = do_filtering;
  Corruptor.filtermethod = filter;
  
  readPNG();
  buffer = createGraphics(pngr.imgInfo.cols, pngr.imgInfo.rows);
  buffer.smooth(8);
  buffer.beginDraw();
  buffer.noStroke();
  buffer.background(0);
  buffer.endDraw();
  
  // calculate window size
  float ratio = (float)buffer.width/(float)buffer.height;
  int neww, newh;
  if(ratio < 1.0) {
    neww = (int)(max_display_size * ratio);
    newh = max_display_size;
  } else {
    neww = max_display_size;
    newh = (int)(max_display_size / ratio);
  }

  surface.setResizable(true);
  surface.setSize(neww, newh);
  
  processImage();
}

void draw() {
  if (frameCount == 1) {
    image(buffer,0,0,width,height);
  }
  // fill for iterative processing
}

void readPNG() {
  InputStream is = createInput(foldername+filename+fileext);
  pngr = new PngReader(is);
}

void redo() {
  print("Reading image...");
  readPNG();
  processImage();
  println("done");  
}

void processImage() {
  buffer.beginDraw();

   try {
    IImageLineSet lines = pngr.readRows();
    for(int i=0;i<lines.size();i++) {
      ImageLineInt line = (ImageLineInt)lines.getImageLine(i);
      ImageLineHelper.scaleUp(line);
      for(int y=0;y<pngr.imgInfo.cols;y++) {
         color c = 0xff000000 | ImageLineHelper.getPixelRGB8(line,y);
         buffer.fill(c);
         buffer.rect(y,i,1,1);
      }
    }
  
  } catch (Exception e) {
    e.printStackTrace();
  }


  buffer.endDraw();
  image(buffer,0,0,width,height);
}

void mouseClicked() {
  int xx = (int)map(mouseX,0,width-1,0,buffer.width-1);
  int yy = (int)map(mouseY,0,height-1,0,buffer.height-1);
  println("Glitch point set at ("+xx+","+yy+") using " + getGlitchMethodName(glitch_method));
  // need to add yy, line has one more byte for filter method
  int pos = 3 * (yy * buffer.width + xx)+yy;
  Corruptor.addData(pos,glitch_method);
  redo();
}

String getGlitchMethodName(int v) {
  switch(v) {
    case Corruptor.ZERO: return "ZERO";
    case Corruptor.ADD1: return "ADD1";
    case Corruptor.SUB1: return "SUB1";
    case Corruptor.NEGATE: return "NEGATE";
    default: return "RANDOM";
  }
}

String getFilterMethodName(int v) {
  switch(v) {
    case 0: return "NONE";
    case 1: return "SUB";
    case 2: return "UP";
    case 3: return "AVERAGE";
    default: return "PAETH";
  }
}

void keyPressed() {
  // SPACE to save
  if(keyCode == 32) {
    String fn = foldername + filename + "/res_" + sessionid + hex((int)random(0xffff),4)+"_"+filename+fileext;
    buffer.save(fn);
    println("Image "+ fn + " saved");
  }
  if(key == 'u') {
    println("Undo");
    Corruptor.undo();
    redo();
  }
  if(keyCode >= 49 && keyCode <=53) {
    if(Corruptor.force_filter) { 
      Corruptor.filtermethod = keyCode - 49;
      println("Filter method set to " + getFilterMethodName(Corruptor.filtermethod));
      redo();
    } else {
      println("Turn on filtering (press 0)");
    }
  }
  if(key == 'q') { glitch_method = 0; println("Glitch method set to: " + getGlitchMethodName(0)); }
  if(key == 'w') { glitch_method = 1; println("Glitch method set to: " + getGlitchMethodName(1)); }
  if(key == 'e') { glitch_method = 2; println("Glitch method set to: " + getGlitchMethodName(2)); }
  if(key == 'r') { glitch_method = 3; println("Glitch method set to: " + getGlitchMethodName(3)); }
  if(key == 't') { glitch_method = 4; println("Glitch method set to: " + getGlitchMethodName(4)); }
  if(keyCode == 48) {
    Corruptor.force_filter = !Corruptor.force_filter;
    println("Force filter: " + Corruptor.force_filter);
    redo();
  }
  if(key == 'a') {
    println("Random glitches");
    float prob = lines_glitched/(float)buffer.height;
    for(int l=0;l<buffer.height;l++) {
      if(random(1)<prob) {
        int pos = 3*l*buffer.width+l;
        Corruptor.addData(pos,glitch_method);        
      }
    }
    redo();    
  }
  if(key == 'z') {
    println("Reset all glitches");
    Corruptor.reset();
    redo();
  }
}