// Watmap - map set of images into target image
// Tomasz Sulej, generateme.blog@gmail.com, http://generateme.tumblr.com
// Licence: http://unlicense.org/

// Usage:
//   * press SPACE to save

// set up filename of target image
String filename = "test";
String fileext = ".jpg";
String foldername = "./";

// set up source image set
// using below variables filenames from the set are constructed
//   example: my images have names: bl1000.jpg, bl1001.jpg etc...
//            and are located in 'bl/' folder
//            I have 6 of them, with constant prefix: "bl/bl100" (pattern_prefix)
//            then every file has one sequence digit from 0 to 5 (pattern_init and pattern_length)
//            with 'pattern_size' digits for the sequence (here: one digit)
//            at the end 'file_ext' is added
//   below setting produce six names: bl/bl1000.jpg, bl/bl1001.jpg, bl/bl1002.jpg, bl/bl1003.jpg, bl/bl1004.jpg, bl/bl1005.jpg
//final static String pattern_prefix = "bl/bl100";
//final static String file_ext = ".jpg";
//final static int pattern_init = 0; // starting number
//final static int pattern_length = 6; // how many images from the set
//final static int pattern_size = 1; // number of digits

// another example
final static String pattern_prefix = "nyt/NYTimes-Dec1900-Jan1901_";
final static String file_ext = ".jpg";
final static int pattern_init = 3; // starting number
final static int pattern_length = 8; // how many images from the set
final static int pattern_size = 4; // number of digits

// choose method of mapping
int mode = ABS_MODE;  // list below AVG_MODE, ABS_MODE, DIST_MODE

int THR = 20; // higher value bigger rectangles (1..200)
int MINR = 8; // minimum block (4..200)

int number_of_iterations = 20; // more = more variety
int number_of_blocks = 50; // more = more search tries

// MODEs LIST
final static int AVG_MODE = 0; // worst matching, difference of avgs of the luma
final static int ABS_MODE = 1; // difference of the luma each pixel
final static int DIST_MODE = 2; // best matching, distance between pixels colors (vectors)

int max_display_size = 1000; // viewing window size (regardless image size)

boolean do_blend = false; // blend image after process
int blend_mode = OVERLAY; // blend type

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

  processImage();
}

void draw() {
  // fill for iterative processing
}

ArrayList<LImage> imgsb = new ArrayList<LImage>();
HashMap<String, ArrayList<Part>> parts = new HashMap<String, ArrayList<Part>>();

class LImage {
  PVector[][] b;
  String name;
  int w, h;
}

class Part {
  int posx, posy, w, h;
  int x, y;

  String toString() {
    return "(" + posx + "," + posy + "," + w + "," + h + ") -> (" + x + "," + y + ")" ;
  }
}


void processImage() {
  buffer.beginDraw();

  println("Preparing data");
  prepare_image();
  prepare_patterns();
  segment(0, img.width-1, 0, img.height-1, 2);

  println("Layering");
  for (String key : parts.keySet ()) {
    ArrayList<Part> p = parts.get(key);
    PImage _img = loadImage(key);
    println("Parts from image: " + key);
    for (Part part : p) {
      buffer.image(_img.get(part.posx, part.posy, part.w, part.h), part.x, part.y);
    }
  }

  println("done");
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

PVector[][] imgb;
void prepare_image() {
  imgb = new PVector[img.width][img.height];
  for (int x=0; x<img.width; x++) {
    for (int y=0; y<img.height; y++) {
      int c = img.get(x, y);
      float r = map((c>>16)&0xff, 0, 255, 0, 1);
      float g = map((c>>8)&0xff, 0, 255, 0, 1);
      float b = map(c&0xff, 0, 255, 0, 1);
      PVector v = new PVector(r, g, b);
      imgb[x][y] = v;
    }
  }
}

void prepare_patterns() {
  for (int i=pattern_init; i< (pattern_init+pattern_length); i++) {
    String suf = nf(i, pattern_size);
    String fname = pattern_prefix + suf + file_ext;
    PImage _img = loadImage(fname);
    println(fname);
    LImage bi = new LImage();
    bi.b = new PVector[_img.width][_img.height];
    bi.name = fname;
    bi.w = _img.width;
    bi.h = _img.height;
    for (int x=0; x<_img.width; x++) {
      for (int y=0; y<_img.height; y++) {
        int c = _img.get(x, y);
        float r = map((c>>16)&0xff, 0, 255, 0, 1);
        float g = map((c>>8)&0xff, 0, 255, 0, 1);
        float b = map(c&0xff, 0, 255, 0, 1);
        PVector v = new PVector(r, g, b);
        bi.b[x][y] = v;
      }
    }
    imgsb.add(bi);
  }
}

void find_match(int posx, int posy, int w, int h) {
  float br = 0;
  if (mode == AVG_MODE) {
    for (int x=posx; x< (posx+w); x++) {
      for (int y=posy; y< (posy+h); y++) {
        br+= getLuma(imgb[x][y]);
      }
    }
  }

  float currdiff = 1.0e10;
  int currxx = -1;
  int curryy = -1;
  LImage currimg = null;

  for (int i=0; i<number_of_iterations; i++) {
    LImage _img = imgsb.get( (int)random(imgsb.size()) );
    for (int iter=0; iter<number_of_blocks; iter++) {
      int xx = (int)random(_img.w-w-1);
      int yy = (int)random(_img.h-h-1);

      if(xx+w >= _img.w || yy+h >= _img.h) break;

      float lbr = 0;
      for (int x=xx, xi=posx; x< (xx+w); x++, xi++) {
        for (int y=yy, yi=posy; y< (yy+h); y++, yi++) {
          if(mode == DIST_MODE)
            lbr += _img.b[x][y].dist(imgb[xi][yi]);
          else if(mode == AVG_MODE)
            lbr += getLuma(_img.b[x][y]);
          else if(mode == ABS_MODE)
            lbr += abs(getLuma(_img.b[x][y])-getLuma(imgb[xi][yi]));
          }
        }


      float ldiff = mode == AVG_MODE?abs(br-lbr):lbr;
      if (ldiff<currdiff) {
        currdiff = ldiff;
        currxx = xx;
        curryy = yy;
        currimg = _img;
      }
    }
  }

  Part p = new Part();
  p.posx = currxx;
  p.posy = curryy;
  p.w = w;
  p.h = h;
  p.x = posx;
  p.y = posy;

  ArrayList<Part> list;
  if (parts.containsKey(currimg.name)) {
    list = parts.get(currimg.name);
  } else {
    list = new ArrayList<Part>();
    parts.put(currimg.name, list);
  }
  list.add(p);

  println("Matched: " + currimg.name + "; " + p);
}

void segment(int x1, int x2, int y1, int y2, int obl) {
  int diffx = x2-x1;
  int diffy = y2-y1;
  if ((obl>0) || (diffx>MINR && diffy>MINR && godeeper(x1, x2, y1, y2))) {
    int midx = (int)random(diffx/2-diffx/4, diffx/2+diffx/4);
    int midy = (int)random(diffy/2-diffy/4, diffy/2+diffy/4);
    segment(x1, x1+midx, y1, y1+midy, obl-1);
    segment(x1+midx+1, x2, y1, y1+midy, obl-1);
    segment(x1, x1+midx, y1+midy+1, y2, obl-1);
    segment(x1+midx+1, x2, y1+midy+1, y2, obl-1);
  } else {
    find_match(x1, y1, diffx+1, diffy+1);
  }
}

final float getLuma(PVector v) {
  return v.x*0.3+0.59*v.y+0.11*v.z;
}

final int getLumaN(PVector v) {
  return (int)(255*getLuma(v));
}

boolean godeeper(int x1, int x2, int y1, int y2) {
  int[] h = new int[256];
  // top and bottom line
  for (int x=x1; x<=x2; x++) {
    h[getLumaN(imgb[x][y1])]++;
    h[getLumaN(imgb[x][y2])]++;
  }
  // left and right, without corners
  for (int y=y1+1; y<y2; y++) {
    h[getLumaN(imgb[x1][y])]++;
    h[getLumaN(imgb[x2][y])]++;
  }
  int midx = x1+(x2-x1)/2;
  int midy = y1+(y2-y1)/2;
  // horizontal, without endpoints
  for (int x=x1+1; x<x2; x++) h[getLumaN(imgb[x][midy])]++;
  // vertical, without endpoints
  for (int y=y1+1; y<y2; y++) h[getLumaN(imgb[midx][y])]++;
  // remove crossingpoint
  h[getLumaN(imgb[midx][midy])]--;

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

  return stddev > THR;
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
