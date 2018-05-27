// Wavelet transformation based on JWave library
// https://github.com/cscheiblich/JWave/
// Tomasz Sulej, generateme.blog@gmail.com, http://generateme.tumblr.com
// Licence: http://unlicense.org/

// Usage:
//   * press SPACE to save
//   * click to random change of parameters

// Description
// How does it work - read here: http://en.wikipedia.org/wiki/Wavelet
// In short not mathematical words: image (each channel) is converted to wavelet representation (forward transformation),
// then some of the data are removed or simplified (compression) and transformed back to image. Since some data are lost, reverse transformed image has lower quality
//

import math.jwave.transforms.DiscreteFourierTransform;
import math.jwave.transforms.wavelets.Wavelet;
import math.jwave.transforms.wavelets.WaveletBuilder;
import math.jwave.Transform;
import math.jwave.TransformBuilder;
import math.jwave.compressions.Compressor;
import math.jwave.compressions.CompressorMagnitude;
import math.jwave.compressions.CompressorPeaksAverage;
import math.jwave.exceptions.JWaveException;

// set up filename
String filename = "test";
String fileext = ".jpg";
String foldername = "./";

int max_display_size = 800; // viewing window size (regardless image size)

// configuration
boolean equalize = true; // equalize and normalize histogram?
int colorspace = RGB; // RGB or HSB
boolean same_transform = true ; // true to use the same transform for each channel (transform 1)

// configure each transform
void initialize() {
  // inital transform configuration, click to set them to random.
  // There are three transformations, one per each channel
  // List of all wavelets is under this link (search for 'case' list: https://github.com/cscheiblich/JWave/blob/master/src/math/jwave/transforms/wavelets/WaveletBuilder.java

  // Transform 1
  Wavelet w1 = WaveletBuilder.create("Haar"); // set wavelet using it's name
  GMTrans gmtrans1 = new GMTrans(w1, FTW);   // FTW or WPT - transform type, FTW is faster
  gmtrans1.compressor_type = CompressorGM; // CompressorGM, CompressorM, CompressorPA
  gmtrans1.threshold = 20; // 10-50, only for M and PA compressors
  // only for GM processor
  gmtrans1.gm_sum = true; // true or false
  gmtrans1.cond_type = OR; // OR, AND, XOR
  gmtrans1.cond_negate = true; // true or false
  gmtrans1.low_x = 2; // 1-10
  gmtrans1.low_y = 3; // 1-10
  gmtrans1.high_x = 0.01; // 0.01 - 0.5
  gmtrans1.high_y = 0.02; // 0.02 - 0.5

  // Transform 2
  Wavelet w2 = WaveletBuilder.create("Daubechies 4"); // set wavelet using it's name
  GMTrans gmtrans2 = new GMTrans(w2, FTW);   // FTW or WPT - transform type, FTW is faster
  gmtrans2.compressor_type = CompressorM; // CompressorGM, CompressorM, CompressorPA
  gmtrans2.threshold = 50; // 10-50, only for M and PA compressors
  // only for GM processor
  gmtrans2.gm_sum = true; // true or false
  gmtrans2.cond_type = AND; // OR, AND, XOR
  gmtrans2.cond_negate = false; // true or false
  gmtrans2.low_x = 2; // 1-10
  gmtrans2.low_y = 3; // 1-10
  gmtrans2.high_x = 0.01; // 0.01 - 0.5
  gmtrans2.high_y = 0.02; // 0.02 - 0.5

  // Transform 3
  Wavelet w3 = WaveletBuilder.create("Haar"); // set wavelet using it's name
  GMTrans gmtrans3 = new GMTrans(w3, FTW);   // FTW or WPT - transform type, FTW is faster
  gmtrans3.compressor_type = CompressorGM; // CompressorGM, CompressorM, CompressorPA
  gmtrans3.threshold = 20; // 10-50, only for M and PA compressors
  // only for GM processor
  gmtrans3.gm_sum = true; // true or false
  gmtrans3.cond_type = XOR; // OR, AND, XOR
  gmtrans3.cond_negate = true; // true or false
  gmtrans3.low_x = 2; // 1-10
  gmtrans3.low_y = 3; // 1-10
  gmtrans3.high_x = 0.01; // 0.01 - 0.5
  gmtrans3.high_y = 0.02; // 0.02 - 0.5

  // do not touch
  gmtrans1.setup();
  gmtrans2.setup();
  gmtrans3.setup();
  transformr = gmtrans1;
  transformg = gmtrans2;
  transformb = gmtrans3;

  if(same_transform) transformb = transformg = transformr;

  println("Transform 1");
  transformr.printSetup();

  println("Transform 2");
  transformg.printSetup();

  println("Transform 3");
  transformb.printSetup();
}

final static int AND = 0;
final static int OR = 1;
final static int XOR = 2;

final static String FTW = "Fast Wavelet Transform";
final static String WPT = "Wavelet Packet Transform";
final static String[] wtypes = {FTW,WPT};

final static int CompressorGM = 0;
final static int CompressorM = 1;
final static int CompressorPA = 2;

boolean do_blend = false; // blend image after process
int blend_mode = OVERLAY; // blend type

// working buffer
PGraphics buffer;

// image
PImage img;

String sessionid;

Wavelet[] wtab;

void setup() {
  sessionid = hex((int)random(0xffff),4);
  img = loadImage(foldername+filename+fileext);

  buffer = createGraphics(img.width, img.height);
  buffer.beginDraw();
  buffer.noStroke();
  buffer.smooth(8);
  buffer.background(0);
  buffer.fill(128);
  buffer.endDraw();

  // calculate window size
  float ratio = (float)img.width/(float)img.height;
  int neww, newh;
  if(ratio < 1.0) {
    neww = (int)(max_display_size * ratio);
    newh = max_display_size;
  } else {
    neww = max_display_size;
    newh = (int)(max_display_size / ratio);
  }

  surface.setSize(neww, newh);

  wtab = WaveletBuilder.create2arr();

  initialize();
  processImage2d();
}

void draw() {
  // fill for iterative processing
}

void mouseClicked() {
  setupWavelets();
  processImage2d();
}

GMTrans transformr, transformg, transformb;

void setupWavelets() {
  colorspace = random(1)<0.5?RGB:HSB;
  same_transform = random(1)<0.5;
  Wavelet w1,w2,w3;
  if(random(1)<0.3) {
    w1 = w2 = w3 = wtab[(int)random(wtab.length)];
  } else {
    w1 = wtab[(int)random(wtab.length)];
    w2 = wtab[(int)random(wtab.length)];
    w3 = wtab[(int)random(wtab.length)];
  }

  String wt1, wt2, wt3;
  if(random(1)<0.3) {
    wt1 = wt2 = wt3 = wtypes[(int)random(2)];
  } else {
    wt1 = wtypes[(int)random(2)];
    wt2 = wtypes[(int)random(2)];
    wt3 = wtypes[(int)random(2)];
  }

  transformr = new GMTrans(w1,wt1);
  transformg = new GMTrans(w2,wt2);
  transformb = new GMTrans(w3,wt3);

  if(same_transform) transformb = transformg = transformr;

  println("Transform 1");
  transformr.printSetup();

  println("Transform 2");
  transformg.printSetup();

  println("Transform 3");
  transformb.printSetup();

  do_blend = random(1)<0.2;
  blend_id = (int)random(blends.length);
  blend_mode = blends[blend_id];
}

void processImage2d() {
  println("");

  buffer.beginDraw();

  int ww = 1 << (int)ceil(log(img.width)/log(2));
  int hh = 1 << (int)ceil(log(img.height)/log(2));

  print("Preparing channels ("+(colorspace==RGB?"RGB":"HSB")+")...");
  double[][] r = new double[ww][hh];
  double[][] g = new double[ww][hh];
  double[][] b = new double[ww][hh];

  for(int y=0;y<hh;y++) {
    for(int x=0;x<ww;x++) {
      double rr,gg,bb;
      color c = img.get(x,y);
      if(colorspace == RGB) {
        rr = red(c)/255.0;
        gg = green(c)/255.0;
        bb = blue(c)/255.0;
      } else {
        rr = hue(c)/255.0;
        gg = saturation(c)/255.0;
        bb = brightness(c)/255.0;
      }

      r[x][y] = rr;
      g[x][y] = gg;
      b[x][y] = bb;
    }
  }
  println("done");

  print("Compression.");
    r = transformr.process(r);
    print(".");
    g = transformg.process(g);
    print(".");
    b = transformb.process(b);
  println("done");

  print("Combining channels ("+(colorspace==RGB?"RGB":"HSB")+")...");
  if(colorspace == HSB) colorMode(HSB,255);
  for(int y=0;y<hh;y++) {
    for(int x=0;x<ww;x++) {
      buffer.fill( clamp((float)r[x][y]),clamp((float)g[x][y]),clamp((float)b[x][y]) );
      buffer.rect(x,y,1,1);
    }
  }
  colorMode(RGB);
  println("done");

  if(do_blend) {
    print("Blending ("+blends_names[blend_id]+")...");
    buffer.blend(img,0,0,img.width,img.height,0,0,buffer.width,buffer.height,blend_mode);
    println("done");
  }

  buffer.endDraw();

  if(equalize) {
    print("Equalize...");
    buffer.loadPixels();
    equalize(buffer.pixels);
    buffer.updatePixels();
    println("done");
  }

  image(buffer,0,0,width,height);
  println("Processed");
}



final static int MIN = 0;
final static int MAX = 1;

void equalize(color[] p) {
  float[][] hist = new float[3][256];
  int[][] look = new int[3][256];

  for(int i=0;i<256;i++) {
    hist[0][i] = 0;
    hist[1][i] = 0;
    hist[2][i] = 0;
  }

  float d = 1.0/p.length;
  for(int i=0;i<p.length;i++) {
      color c = p[i];
      hist[0][ (c >> 16) & 0xff ] += d;
      hist[1][ (c >> 8) & 0xff ] += d;
      hist[2][ (c) & 0xff ] += d;
  }

  for(int c=0;c<3;c++) {
    float sum = 0.0;
    for(int i=0;i<256;i++) {
      sum += hist[c][i];
      look[c][i] = (int)constrain(floor(sum * 255),0,255);
    }
  }

  int[][] minmax = new int[3][2];
  minmax[0][MIN] = 256;
  minmax[1][MIN] = 256;
  minmax[2][MIN] = 256;
  minmax[0][MAX] = -1;
  minmax[1][MAX] = -1;
  minmax[2][MAX] = -1;
  for(int i=0;i<256;i++) {
      int r = look[0][i];
      int g = look[1][i];
      int b = look[2][i];
      if(r<minmax[0][MIN]) minmax[0][MIN]=r;
      if(r>minmax[0][MAX]) minmax[0][MAX]=r;
      if(g<minmax[1][MIN]) minmax[1][MIN]=g;
      if(g>minmax[1][MAX]) minmax[1][MAX]=g;
      if(b<minmax[2][MIN]) minmax[2][MIN]=b;
      if(b>minmax[2][MAX]) minmax[2][MAX]=b;
  }

  for(int i=0;i<p.length;i++) {
      color c = p[i];
      int r = (int)map(look[0][ (c >> 16) & 0xff ],minmax[0][MIN],minmax[0][MAX],0,255);
      int g = (int)map(look[1][ (c >> 8) & 0xff ],minmax[1][MIN],minmax[1][MAX],0,255);
      int b = (int)map(look[2][ (c) & 0xff ],minmax[2][MIN],minmax[2][MAX],0,255);
      int cres = 0xff000000 | (r << 16) | (g << 8) | b;
      p[i] = cres;
  }
}

final float clamp(float c) {
  return(constrain(255*c,0,255));
}

void keyPressed() {
  // SPACE to save
  if(keyCode == 32) {
    String fn = foldername + filename + "/res_" + sessionid + hex((int)random(0xffff),4)+"_"+filename+fileext;
    buffer.save(fn);
    println("Image "+ fn + " saved");
  }
}


final static int[] blends = {ADD, SUBTRACT, DARKEST, LIGHTEST, DIFFERENCE, EXCLUSION, MULTIPLY, SCREEN, OVERLAY, HARD_LIGHT, SOFT_LIGHT, DODGE, BURN};
final static String[] blends_names = {"ADD", "SUBTRACT", "DARKEST", "LIGHTEST", "DIFFERENCE", "EXCLUSION", "MULTIPLY", "SCREEN", "OVERLAY", "HARD_LIGHT", "SOFT_LIGHT", "DODGE", "BURN"};
int blend_id;

class GMTrans {
  public Transform trans;
  public int compressor_type;
  public Compressor comp;
  public Wavelet wavelet;
  public String wavelet_type;

  public GMTrans(Wavelet w, String wavelettype) {
    trans = TransformBuilder.create(wavelettype, w);
    wavelet = w;
    wavelet_type = wavelettype;
    randomize();
  }

  public void setup() {
    if(compressor_type == CompressorM) comp = new CompressorMagnitude(threshold);
    if(compressor_type == CompressorPA) comp = new CompressorPeaksAverage(threshold/5000.0);
  }

  public void randomize() {
    compressor_type = random(1)<0.5?CompressorGM:random(1)<0.5?CompressorM:CompressorPA;
    threshold = random(5,50);
    gm_sum = random(1)<0.7;
    cond_type = (int)random(3);
    cond_negate = random(1)<0.5;
    low_x = (int)random(1,10);
    low_y = (int)random(1,10);
    high_x = random(0.05,0.5);
    high_y = random(0.05,0.5);
    if(random(1)<0.5) {
      high_x /= 10.0;
      high_y /= 10.0;
    }
    setup();
  }

  public void printSetup() {
    println("  Wavelet: " + wavelet.getName());
    println("  Type: " + wavelet_type);
    println("  Compressor: " + (compressor_type==CompressorGM?"CompressorGM":compressor_type==CompressorM?"CompressorM":"CompressorPA"));

    if(compressor_type == CompressorGM) {
      println("  gm_sum: " + gm_sum);
      println("  cond_type: " + (cond_type == AND?"AND":cond_type==OR?"OR":"XOR"));
      println("  cond_negate: " + cond_negate);
      println("  low_x: " + low_x);
      println("  low_y: " + low_y);
      println("  high_x: " + high_x);
      println("  high_y: " + high_y);
    } else {
      println("  threshold: " + threshold);
    }
  }

  float threshold;
  boolean gm_sum;
  int cond_type;
  boolean cond_negate = true;
  int low_x;
  int low_y;
  float high_x;
  float high_y;

  public double[][] process(double[][] input) {
    if(compressor_type == CompressorGM)
      return trans.reverse(processtrans(trans.forward(input)));
     else
      return trans.reverse(comp.compress(trans.forward(input)));
  }

  private final boolean between(int v, float a, float b) { return (v>=a) && (v<=b); }
  private final boolean cond(boolean one, boolean two) {
    boolean res;
    switch (cond_type) {
      case AND: res = (one && two);break;
      case OR: res = (one || two);break;
      default: res = (one ^ two);
    }
   if(cond_negate) return !res; else return res;
  }

  private double[][] processtrans(double[][] _r) {
   int ww = _r.length;
   int hh = _r[0].length;
   double[][] rr = new double[ww][hh];

   for(int y=0;y<hh;y+=2) {
    for(int x=0;x<ww;x+=2) {
      if( cond( between(x,low_x,high_x*ww),between(y,low_y,high_y*hh) ) ) {
        rr[x][y] = 0.0;
        rr[x+1][y+1] = 0.0;
        rr[x][y+1] = 0.0;
        rr[x+1][y] = 0.0;
      } else {
          if(gm_sum) {
            rr[x][y] = _r[x][y]+(_r[x+1][y]+_r[x][y+1])/2.0;
            rr[x+1][y+1] = _r[x+1][y+1] + (_r[x+1][y]+_r[x][y+1])/2.0;
            rr[x+1][y] = 0;
            rr[x][y+1] = 0;
          } else {
            rr[x][y] = _r[x][y];
            rr[x+1][y+1] = _r[x+1][y+1];
            rr[x+1][y] = _r[x+1][y];
            rr[x][y+1] = _r[x][y+1];
          }
        }
      }
    }
    return rr;
  }

}
