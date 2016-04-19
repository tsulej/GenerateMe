// Decompose image and paint
// Tomasz Sulej, generateme.blog@gmail.com, http://generateme.tumblr.com
// Licence: http://unlicense.org/
// angle mode based on chapter 2 from this paper http://arxiv.org/abs/1602.05975

// Usage:
//   * press SPACE to save
//   * click to random change

// set up filename
String filename = "test";
String fileext = ".jpg";
String foldername = "./";

// config
int div_type = RECTANGLES; // division type: SQUARES, RECTANGLES, CONSTSIZE or RANDOM

float threshold = 20; // 2-100 - how to divide, smaller number smaller decomposition
int size = 8; // size of square and minimum size of block
int maxsize = 64; // maximum block size

// block type for each channel R,G,B,A
int block_type[] = { V_STRIPES, H_STRIPES, VH_STRIPES, V_STRIPES}; // ONECOLOR, SORT, LIGHT, DARK, V_STRIPES, H_STRIPES, VH_STRIPES, ANGLE
float stripes_size = 0; // 0-1, 0:random, 1:two stripes, between more stripes 

int max_display_size = 800; // viewing window size (regardless image size)

boolean do_blend = false; // blend image after process
int blend_mode = OVERLAY; // blend type

static final int RANDOM = -1; // random division or block

// type of division
static final int SQUARES = 0; // sqaures
static final int RECTANGLES = 1; // rectangles
static final int CONSTSIZE = 2; // squares constant size 

// block type
static final int ONECOLOR = 0; // one color
static final int SORT = 1; // sort pixels
static final int LIGHT = 2; // lightest color 
static final int DARK = 3; // darkest color
static final int V_STRIPES = 4; // vertical stripes
static final int H_STRIPES = 5; // horizontal stripes
static final int VH_STRIPES = 6; // both directions
static final int ANGLE = 7; // lines 

// working buffer
PGraphics buffer;

// image
PImage img;

String sessionid;

void setup() {
  sessionid = hex((int)random(0xffff),4);
  img = loadImage(foldername+filename+fileext);
  
  buffer = createGraphics(img.width, img.height);
  buffer.beginDraw();
  buffer.noStroke();
  buffer.smooth(8);
  buffer.background(0);
  buffer.image(img,0,0);
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

  size(neww,newh);
  p = new Planes(img);
  
  processImage();
}

void draw() {
  // fill for iterative processing
}

void mouseClicked() {
  do_blend = random(1)<0.3;
  blend_mode = blends[(int)random(blends.length)];
  
  div_type = (int)random(-1.5,3);
  block_type[0] = (int)random(-1.5,8);
  block_type[1] = (int)random(-1.5,8);
  block_type[2] = (int)random(-1.5,8);
  block_type[3] = (int)random(-1.5,8);
  
  println("");
  println("div_type="+div_type);
  println("plane R type: "+getTypeName(0));
  println("plane G type: "+getTypeName(1));
  println("plane B type: "+getTypeName(2));
  println("plane A type: "+getTypeName(3));
  
  threshold = random(10,50);
  size = (int)random(4,20);
  maxsize = (int)random(size+4,250);
  
  println("threshold="+threshold);
  println("size="+size);
  println("maxsize="+maxsize);
  
  p.preparePlanes();
  processImage();
}

String getTypeName(int t) {
  int type = block_type[t];
    switch(type) {
      case ONECOLOR: return "ONECOLOR";
      case SORT: return "SORT";
      case LIGHT: return "LIGHT";
      case DARK: return "DARK";
      case V_STRIPES: return "V_STRIPES";
      case H_STRIPES: return "H_STRIPES";
      case VH_STRIPES: return "VH_STRIPES";
      case ANGLE: return "ANGLE";
      case RANDOM: return "RANDOM";
    }
    return "unknown";
}

Planes p;

void processImage() {
  buffer.beginDraw();
  
  // START CODE HERE! use buffer to draw/manipulate
  for (int i=0; i<4; i++) {
    println("plane="+i);
    int _div_type = div_type==RANDOM?(int)random(3):div_type;
    if(_div_type == SQUARES) createDivideSegm(p, i, size, maxsize, threshold, true);
    else if(_div_type == RECTANGLES) createDivideSegm(p, i, size, maxsize, threshold, false);
    else createSquareSegm(p, i, size);


    for (Block b : p.segments[i].segments) {

        int xstripes = stripes_size==0?(int)random(1,b.sizex):(int)constrain(b.sizex*stripes_size,1,b.sizex);
        int ystripes = stripes_size==0?(int)random(1,b.sizey):(int)constrain(b.sizey*stripes_size,1,b.sizey);
        int _block_type = block_type[i]==RANDOM?(int)random(8):block_type[i];
        switch(_block_type) {
          case ONECOLOR: colorSingle(b); break;
          case SORT: sortBlock(b); break;
          case LIGHT: colorMinMax(b,false); break;
          case DARK: colorMinMax(b,true); break;
          case V_STRIPES: stripesMinMax(b, xstripes, ystripes, true); break;
          case H_STRIPES: stripesMinMax(b, xstripes, ystripes, false); break;
          case VH_STRIPES: stripesMinMax(b, xstripes, ystripes, random(1)<0.5); break;
          case ANGLE: angle(b); break;
        }
     
    } 

    
  }
  buffer.image(p.toImage(),0,0);
  
  // END CODE HERE!
  
  if(do_blend)
    buffer.blend(img,0,0,img.width,img.height,0,0,buffer.width,buffer.height,blend_mode);
    
  buffer.endDraw();
  image(buffer,0,0,width,height);
}

void keyPressed() {
  // SPACE to save
  if(keyCode == 32) {
    String fn = foldername + filename + "/res_" + sessionid + hex((int)random(0xffff),4)+"_"+filename+fileext;
    buffer.save(fn);
    println("Image "+ fn + " saved");
  }
}


void sortBlock(Block b) {
  int[] buff = new int[b.sizex*b.sizey];
  for (int x=0; x<b.sizex; x++) {
    for (int y=0; y<b.sizey; y++) {
      int idx = x+y*b.sizex;
      buff[idx]=p.get(b.pno,b.posx+x,b.posy+y);
    }
  }
  buff = sort(buff);
  for (int x=0; x<b.sizex; x++) {
    for (int y=0; y<b.sizey; y++) {
      int idx = x+y*b.sizex;
      p.set(b.pno,b.posx+x,b.posy+y,buff[idx]);
    }
  }
}

void colorSingle(Block b) {
  int c = p.get(b.pno, b.posx+b.sizex/2, b.posy+b.sizey/2);
  for (int x=b.posx; x<b.posx+b.sizex; x++) {
    for (int y=b.posy; y<b.posy+b.sizey; y++) {
      p.set(b.pno, x, y, c);
    }
  }
}

void colorMinMax(Block b, boolean domin) {
  PVector mnmx = getMinMax(b);
  for (int x=b.posx; x<b.posx+b.sizex; x++) {
    for (int y=b.posy; y<b.posy+b.sizey; y++) {
      if (domin) p.set(b.pno, x, y, (int)mnmx.x);
      else p.set(b.pno, x, y, (int)mnmx.y);
    }
  }
}

// sx - x modulo sx < sx/2 - how many stripes
// sy - as above
// xx - vertical (true) or horizontal (false) stripes
void stripesMinMax(Block b, int sx, int sy, boolean xx) {
  PVector mnmx = getMinMax(b);
  for (int x=b.posx; x<b.posx+b.sizex; x++) {
    for (int y=b.posy; y<b.posy+b.sizey; y++) {
      if ( (xx& x%sx<sx/2) || ((!xx)&y%sx<sx/2)) p.set(b.pno, x, y, (int)mnmx.x);
      else p.set(b.pno, x, y, (int)mnmx.y);
    }
  }
}

PVector getMinMax(Block b) {
  int mn = 256;
  int mx = -1;
  for (int x=b.posx; x<b.posx+b.sizex; x++) {
    for (int y=b.posy; y<b.posy+b.sizey; y++) {
      int c = p.get(b.pno, x, y);
      if (c>mx) mx=c;
      if (c<mn) mn=c;
    }
  }
  return new PVector(mn, mx);
}

// only squares!!
void angle(Block b) {
  int w = b.sizex;
  float step = 1.0/w;

  float best = -1;

  int[][] buff = new int[w][w];

  for (float a=0; a<1.0; a+=step) {
    float[][] vals = new float[4][2*w];
    int[][] cnts = new int[4][2*w];

    for (int x=0; x<w; x++) {
      for (int y=0; y<w; y++) {
        float c = p.get(b.pno, b.posx+x, b.posy+y)/255.0;

        for (int i=0; i<4; i++) {
          int idx = getIdx(i, x, y, a, w);
          vals[i][idx] += c;
          cnts[i][idx]++;
        }
      }
    }

    for (int i=0; i<4; i++) {
      float curr=0;
      for (int idx=0; idx<2*w; idx++) {
        if (cnts[i][idx]>0) {
          curr += sq(vals[i][idx])/cnts[i][idx];
        }
      }

      if (curr>best) {
        best = curr;
        for (int x=0; x<w; x++) {
          for (int y=0; y<w; y++) {
            int _idx = getIdx(i, x, y, a, w);
            buff[x][y] = (int)(255*vals[i][_idx]/cnts[i][_idx]);
          }
        }
      }
    }
  }

  for (int x=0; x<w; x++) {
    for (int y=0; y<w; y++) {
      p.set(b.pno, b.posx+x, b.posy+y, buff[x][y]);
    }
  }
}


int getIdx(int i, int x, int y, float a, int w) {
  switch(i) {
  case 0: 
    return (int)round(x+y*a);
  case 1: 
    return (int)round(y+x*a);
  case 2: 
    return (int)round((w-x-1)+y*a);
  case 3: 
    return (int)round((w-y-1)+x*a);
  default: 
    return 0;
  }
}

class Block {
  int sizex, sizey;
  int posx, posy;
  int pno;

  public Block(int posx, int posy, int sizex, int sizey, int pno) {
    this.posx = posx;
    this.posy = posy;
    this.sizex = sizex;
    this.sizey = sizey;
    this.pno = pno;
  }
}

class Segmentation {
  ArrayList<Block> segments = new ArrayList<Block>();
}

class Planes {
  int[][][] data;
  PImage img;
  Segmentation[] segments;
  int w, h;
  int ww, hh;

  public Planes(PImage img) {
    this.img = img;
    w = img.width;
    h = img.height;
    ww = 1 << (int)ceil(log(w)/log(2));
    hh = 1 << (int)ceil(log(h)/log(2));
    preparePlanes();
  }

  void set(int pno, int x, int y, int val) {
    if (x>=0 && x<w && y>=0 && y<h) {
      data[pno][x][y] = val;
    }
  }

  int get(int pno, int x, int y) {
    if (x>=0 && x<w && y>=0 && y<h) {
      return data[pno][x][y];
    } else return 0;
  }

  void preparePlanes() {
    // convert to colorspace
    int[][] d = decomposeImage(img);
    data = new int[4][w][h];
    for (int x=0; x<w; x++) {
      for (int y=0; y<h; y++) {
        int idx = y*w+x;
        data[0][x][y] = d[0][idx];
        data[1][x][y] = d[1][idx];
        data[2][x][y] = d[2][idx];
        data[3][x][y] = d[3][idx];
      }
    }
    segments = new Segmentation[4];
  }

  PImage toImage() {
    PImage _img = img.get();
    _img.loadPixels();
    int[][] d = new int[4][_img.pixels.length];
    for (int x=0; x<w; x++) {
      for (int y=0; y<h; y++) {
        int idx = y*w+x;
        d[0][idx] = data[0][x][y];
        d[1][idx] = data[1][x][y];
        d[2][idx] = data[2][x][y];
        d[3][idx] = data[3][x][y];
      }
    }
    updateImage(_img, d);
    return _img;
  }
}

int[][] decomposeImage(PImage img) {
  img.loadPixels();
  int[][] ch = new int[4][img.pixels.length];
  for (int i=0; i<img.pixels.length; i++) {
    int c = img.pixels[i];
    ch[0][i] = (c >> 16) & 0xff; // R
    ch[1][i] = (c >> 8) & 0xff; // G
    ch[2][i] = (c ) & 0xff; // B
    ch[3][i] = (c >> 24) & 0xff; // A
  }
  return ch;
}

void updateImage(PImage img, int[][] ch) {
  for (int i=0; i<img.pixels.length; i++) {
    img.pixels[i] = ((ch[0][i] & 0xff) << 16) 
      | ((ch[1][i] & 0xff) << 8)
        | (ch[2][i] & 0xff)
          | ((ch[3][i] & 0xff) << 24);
  }
  img.updatePixels();
}

void createSquareSegm(Planes p, int plane_no, int size) {
  Segmentation segments = new Segmentation();

  for (int y=0; y<p.h; y+=size) {
    for (int x=0; x<p.w; x+=size) {
      Block b = new Block(x, y, size, size, plane_no);
      segments.segments.add(b);
    }
  }

  p.segments[plane_no] = segments;
}

float THR = 20;
int MINR = 4;
int MAXR = 64;
void createDivideSegm(Planes p, int plane_no, int min_size, int max_size, float thr, boolean sq) {
  Segmentation segments = new Segmentation();
  p.segments[plane_no] = segments;

  MINR = min_size;
  MAXR = max_size;
  THR = thr;

  if (sq) {
    int size = p.ww>p.hh?p.ww:p.hh;
    segment(p, plane_no, 0, 0, size, size, sq);
  } else
    segment(p, plane_no, 0, 0, p.w, p.h, sq);
}

void segment(Planes p, int plane_no, int x, int y, int sizex, int sizey, boolean sq) {
  if (x>=p.w || y>=p.h) return;
  float gd = godeeper(p, plane_no, x, y, sizex, sizey);
  if ( (sizex>MAXR && sizey>MAXR) || (sizex>MINR && sizey>MINR && gd>THR)) {
    int midx, midy;
    if (sq) {
      midx = sizex/2;
      midy = sizey/2;
    } else {
      midx = (int)random(sizex*0.25, sizex*0.75);
      midy = (int)random(sizey*0.25, sizey*0.75);
    }
    segment(p, plane_no, x, y, midx, midy, sq);
    segment(p, plane_no, x+midx, y, sizex-midx, midy, sq);
    segment(p, plane_no, x, y+midy, midx, sizey-midy, sq);
    segment(p, plane_no, x+midx, y+midy, sizex-midx, sizey-midy, sq);
  } else {
    Block b = new Block(x, y, sizex, sizey, plane_no);
    p.segments[plane_no].segments.add(b);
  }
}

float godeeper(Planes p, int plane_no, int x, int y, int sizex, int sizey) {
  int[] h = new int[256];
  // top and bottom line
  for (int xx=x; xx<x+sizex; xx++) {
    h[p.get(plane_no, xx, y)]++;
    h[p.get(plane_no, xx, y+sizey-1)]++;
  }
  // left and right, without corners
  for (int yy=y+1; yy<y+sizey-1; yy++) {
    h[p.get(plane_no, x, yy)]++;
    h[p.get(plane_no, x+sizex-1, yy)]++;
  }

  int midx = x+sizex/2;
  int midy = y+sizey/2;
  // horizontal, without endpoints
  for (int xx=x+1; xx<x+sizex-1; xx++) h[p.get(plane_no, xx, midy)]++;
  // vertical, without endpoints
  for (int yy=y+1; yy<y+sizey-1; yy++) h[p.get(plane_no, midx, yy)]++;
  // remove crossingpoint
  h[p.get(plane_no, midx, midy)]--;

  // calculate mean
  float mean = 0;
  int sum = 0;
  for (int i=0; i<256; i++) {
    mean += i * h[i];
    sum += h[i];
  }
  mean /= sum;

  float stddev = 0;
  for (int i=0; i<256; i++) {
    stddev += sq(i-mean)*h[i];
  }
  stddev = sqrt(stddev/sum);
  return stddev;
}


//

final static int[] blends = {ADD, SUBTRACT, DARKEST, LIGHTEST, DIFFERENCE, EXCLUSION, MULTIPLY, SCREEN, OVERLAY, HARD_LIGHT, SOFT_LIGHT, DODGE, BURN};

// ALL Channels, Nxxx stand for negative (255-value)
// channels to work with
final static int RED = 0;
final static int GREEN = 1;
final static int BLUE = 2;
final static int HUE = 3;
final static int SATURATION = 4;
final static int BRIGHTNESS = 5;
final static int NRED = 6;
final static int NGREEN = 7;
final static int NBLUE = 8;
final static int NHUE = 9;
final static int NSATURATION = 10;
final static int NBRIGHTNESS = 11;

float getChannel(color c, int channel) {
  int ch = channel>5?channel-6:channel;
  float cc;
  
  switch(ch) {
    case RED: cc = red(c); break;
    case GREEN: cc = green(c); break;
    case BLUE: cc = blue(c); break;
    case HUE: cc = hue(c); break;
    case SATURATION: cc = saturation(c); break;
    default: cc= brightness(c); break;
  }
  
  return channel>5?255-cc:cc;
}
