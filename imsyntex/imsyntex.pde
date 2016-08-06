// Image reconstruction using texture synthesis
// Based on:
//  https://github.com/mxgmn/SynTex/blob/master/SynTex.cs
//  http://graphics.stanford.edu/projects/texture/
//  http://www.visgraf.impa.br/Courses/ip00/papers/texture.pdf

// Adaptation to image glitch by GenerateMe (generateme.blog@gmail.com)
// http://generateme.tumblr.com
// Licence: Unlicence

// Description and setup guide
// NOTE: algorithm is slow, as hell, if you find a way to speed up a little bit let me know
// How does it work:
// It's typical pixel-based synthesis based on matching neighborhood (Wei-Levoy).
// The only difference is that each generated pixel is based on different texture.
// Texture is taken from scaled down (or up) input image from corresponding rectangular region.
// Region size is defined by "radius" variable. Neighborhood size is determined by "N" value (N=1 - 4 pixels; N=2 - 12 pixels; N=3 - 24 pixels; etc...)
// Bigger values of radius and N give more pixels to check and slows whole algorithm dramatically.
// NOTE: N=1 and radius = 20 is nice, also
//       N=3 and radius = 5 and low input_image_scale (eg. 0.2) is nice too
//
// Besides of N and radius you can create quite complicated rule for metric (function which measures distance between pixels or colors).
// These are:
// - colorspace - you can select from 14 different colorspaces
// - metric - based on norms L1,L2,L-inf + discrete and french (found on wolfram)
// - what to measure - single channel (eg. r, g or b), color value (it's 24 bit integer, PACKED) or all 3 channels (SEPARATE)
// - in case of SEPARATE - define what to do with 3 values: add them, take min or max
// (the truth is: we don't need math metric, you can add own functions or method, more strange, better artifacts)
// NOTE: if you have B&W image, most optimal (speed) colorspace is RGB and metric_val set to PACKED
// NOTE: DISCRETE metric is most strange
// NOTE: working with Hue is nice (HCL,HSB,HWB + CH1 as metric_val)
//
// Last crucial information is about scaling input/output image.
// - if you need artifacts: scale down input image (set input_image_scale < 1). Lower value more artifacts, you can instead (or also) scale up output image (output_image_scale > 1)
// - if you need painting-like result - do the opposite
// - if both are set to the same value - you get nothing, just loose time (you can think about this as sophisticated method for scaling :) )
// NOTE: to summarize, keep the values different, bigger difference - better.
//
// Scripts saves result after rendering under unique filename

// configuration
// set up filename
final static String filename = "test";
final static String fileext = ".jpg";
final static String foldername = "./";

final int colorspace = RGB; // see colorspaces tab
// metric
final int metric_val = PACKED; // see below
final int separate_opt = SUM; // see below
final int metric = ABS; // see below
// patch size
final static int N = 2; // 1 - fast, 3 - slow
final static int radius = 5; // radius of sample rectangle: 1-20
// image resize, values should be different!
final static float input_image_scale = 0.2; // how to resize input image, it will be your texture source (1 = original image size)
final static float output_image_scale = 1; // how to resize output image, it will be your result (1 = original image size)

// Metric constants
// What to measure
final static int CH1 = 0; // first channel value (Red or Hue or ...)
final static int CH2 = 1; // second channel value (Green or Saturation)
final static int CH3 = 2; // third channel value (Blue or Brightness)
final static int PACKED = 3; // packed color value (24 bits)
final static int SEPARATE = 4; // treat each channel separately

// What to do if separate
final static int MAX = 0; // max of values, chebyshev metric
final static int MIN = 1; // min of values
final static int SUM = 2; // sum of values

// Metric type
final static int ABS = 0; // abs differences (taxicab)
final static int SQ = 1; // squares of differences (L2)
final static int DISCRETE = 2; // discrete metric
final static int FRENCH = 3; // modified french metro metric, c=FRENCH_C_PAR

final static float FRENCH_C_PAR = 0.5; // 0-1;

int SW, SH, OW, OH;
int[][] sample, result;
boolean[][] made;

void setup() {  
  PImage img = loadImage(foldername + filename + fileext);

  SW = (int)(img.width*input_image_scale);
  SH = (int)(img.height*input_image_scale);
  OW = (int)(img.width*output_image_scale);
  OH = (int)(img.height*output_image_scale);

  frameRate=1000;
  noLoop();
  size(OW, OH);

  img.resize(SW, SH);

  // texture (sample)
  sample = new int[SW][SH];
  for (int x=0; x<SW; x++) {
    for (int y=0; y<SH; y++) {
      sample[x][y] = toColorspace(img.get(x, y), colorspace);
    }
  }

  // output
  result = new int[OW][OH];
  made = new boolean[OW][OH];

  loop();
}

int y = 0;
void draw() { // process line each frame
  println(nf(y, 4)+"/"+nf(OH, 4));
  for (int x=0; x<OW; x++) { // for each line pixel

    long maxx = Long.MAX_VALUE; // best match, for now it's biggest possible number 

    // our texture position and size, based on target pixel position
    int yystart = (int)constrain( map(y, 0, OH-1, 0, SH-1)-radius, 0, SH-radius);
    int yystop = (int)constrain( map(y, 0, OH-1, 0, SH-1)+radius, radius, SH);
    int xxstart = (int)constrain( map(x, 0, OW-1, 0, SW-1)-radius, 0, SW-radius);
    int xxstop = (int)constrain( map(x, 0, OW-1, 0, SW-1)+radius, radius, SW);

    // calculate neighborhood pixel positions to match against + their value
    ArrayList<Position> t = getValuesToMatch(x, y, result, OW, OH, N, made);

    int argmax_x = xxstart;
    int argmax_y = yystart;

    // let's run through our texture and find best matching pixel
    for (int yy=yystart; yy<yystop; yy++) {
      for (int xx=xxstart; xx<xxstop; xx++) {

        // what's the distance for current position
        long s = calcDistance(xx, yy, sample, SW, SH, N, t);
        if (s < maxx) { // better than previous? remember
          maxx = s;
          argmax_x = xx;
          argmax_y = yy;
        }
      }
    }

    result[x][y] = sample[argmax_x][argmax_y]; // save the best match
    made[x][y] = true; // if pixel is processed, remember it
  }

  // draw line
  loadPixels();
  for (int x=0; x<OW; x++) {
    pixels[x+y*OW] = fromColorspace(result[x][y], colorspace);
  }
  updatePixels();

  y++;

  // if finished, save and stop
  if (y==OH) {
    String fn = foldername + filename + "/res_" + hex((int)random(0xffffff+1), 6)+"_"+filename+fileext;
    save(fn);
    noLoop();
    println("Done. Image " + fn + " saved");
  }
}

// Neighborhood pixel position and value from target
class Position {
  int val;
  int x, y;
}

// take all pixels to match against (they are taken from already rendered part of the image)
ArrayList<Position> getValuesToMatch(int x2, int y2, int[][] b2, int w2, int h2, int N, boolean[][] made) {
  ArrayList<Position> res = new ArrayList<Position>();

  for (int dy = -N; dy <= 0; dy++) {
    for (int dx = -N; (dy < 0 && dx <= N) || (dy == 0 && dx < 0); dx++) {
      // wrap is necessary - it may give errors
      int sx2 = (x2 + dx + w2) % w2;
      int sy2 = (y2 + dy + h2) % h2;
      if (made[sx2][sy2]) {
        Position p = new Position();
        p.val = b2[sx2][sy2];
        p.x = dx;
        p.y = dy;
        res.add(p);
      }
    }
  }

  return res;
}

long calcDistance(int x1, int y1, int[][] b1, int w1, int h1, int N, ArrayList<Position> t) {
  long sum = 0;

  for (Position p : t) {
    int sx1 = (x1 + p.x);
    int sy1 = (y1 + p.y);

    // wrap
    if (sx1<0) sx1+=w1;
    if (sy1<0) sy1+=h1;
    if (sx1>=w1) sx1-=w1;
    if (sy1>=h1) sy1-=h1;

    sum += cdist(b1[sx1][sy1], p.val);
  }


  return sum;
}

long cdist(int c1, int c2) {
  
  if(metric_val < 4) {
    int v1,v2;
    switch(metric_val) {
    case CH1:
      v1 = getR(c1);
      v2 = getR(c2);
      break;
    case CH2:
      v1 = getG(c1);
      v2 = getG(c2);
      break;
    case CH3:
      v1 = getB(c1);
      v2 = getB(c2);
      break;
    default:
      v1 = c1 & 0xffffff;
      v2 = c2 & 0xffffff;
    }
    
    switch(metric) {
      case SQ:
        long v = v1-v2;
        return v*v;
      case FRENCH: return french_metric(v1,v2);
      case DISCRETE: return v1==v2?0:1;
      default: return abs(v1-v2);
    }
  } else { // separate
    int r1 = getR(c1);
    int g1 = getG(c1);
    int b1 = getB(c1);
    
    int r2 = getR(c2);
    int g2 = getG(c2);
    int b2 = getB(c2);
    
    int v1,v2,v3;
    switch(metric) {
      case SQ:
        v1 = (r1-r2)*(r1-r2);
        v2 = (g1-g2)*(g1-g2);
        v3 = (b1-b2)*(b1-b2);
        break;
      case FRENCH:
        v1 = french_metric(r1,r2);
        v2 = french_metric(g1,g2);
        v3 = french_metric(b1,b2);
        break;
      case DISCRETE:
        v1 = r1==r2?0:1;
        v2 = g1==g2?0:1;
        v3 = b1==b2?0:1;
        break;
      default:
        v1 = abs(r1-r2);
        v2 = abs(g1-g2);
        v3 = abs(b1-b2);
    }
    
    switch(separate_opt) {
      case MIN: return min(v1,v2,v3);
      case MAX: return max(v1,v2,v3);
      default: return v1+v2+v3;
    }
  }
 
}

final int french_metric(int a, int b) {
  if (a>=(int)(b*FRENCH_C_PAR)) return abs(a-b);
  else return abs(a)+abs(b);
}


