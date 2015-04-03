// Image Slicer / Segmenter
// Tomasz Sulej, http://generateme.tumblr.com/, generateme.blog@gmail.com, 2015
// Licence: http://unlicense.org/

// based on following code and paper
// https://github.com/subokita/Sandbox/blob/master/EfficientGraphBasedImageSegmentation
// http://cs.brown.edu/~pff/segment/

//********** for users
// Set up:
// a) image filename with extension
// b) set parameters
// c) run
// 
// SPACE to save
// CLICK to random change
//

//********** for developers
// if you need to use segmentation in your own sketches, copy parts marked in comments (segmentation config and segmentation code)
// steps:
// a) setup variables 
// b) make somewhere img = loadImage(/your file name/);
// c) call processImage()
// after a while number of segments will be printed
// each segment has it's own identifier - this is just int number (not sorted)
// to find identifer for particular pixel in (x,y) position, call findEnd(y*img.width+x)
// this script has few usage examples built in, check function drawSegments()

import java.util.Collections;
import java.util.Arrays;
import java.util.Map;

// set up filename
String filename = "test.jpg";

float max_rotation = TWO_PI; // random rotation up to specified angle, 0 - TWO_PI, 0 - no rotation
int thr_min = -1; // you can change color of segment for specified brightness threshold
int thr_max = -1; // set to -1 if you don't want to use it, values from 0 to 255
color[] palette = { #000000, #ff0000, #ffffff }; // choose colors for palette you want to use with threshold, colors will be choosen randomly

// PATTERNS config
int max_patterns = 20; // how much patterns download from colourlovers, higher number, more to download

// SEPARATE config
float max_shift = 2; // max expected shift, using gaussian random, so bigger number, more distortion

int type = ROTATE; // choose type of distortion: PATTERNS, SEPARATE, ROTATE, SHIFTCOPY
boolean do_blend = false; // blend result with original?
int blend_type = SUBTRACT; // list here: https://processing.org/reference/blend_.html

// segmentation config START
float threshold = 500.0; // higher number - bigger segments
int min_comp_size = 50; // minimal segment size (in pixels), minimum 10
int blur = 0; // sometimes it's good to blur image to have less sharp segment edges, 0 = off, blur > 0 - blur kernel size
int stat_type = DIST; // edge calculation method

final static int DIST = 0;
final static int HUE = 1;
final static int BRIGHTNESS = 2;
final static int SATURATION = 3;
final static int ABSDIST = 4;

// do not touch it
PImage img; // load image to this variable
// segmentation config END

// do not touch, list of types
final static int PATTERNS = 0;
final static int SEPARATE = 1;
final static int ROTATE = 2;
final static int SHIFTCOPY = 3;


void setup() {
  img = loadImage(filename);
  size(img.width, img.height);
  background(0);
  noStroke();
  
  processImage();
  processSlices();
}

void draw() {}

void keyPressed() {
  if(keyCode == 32)
    saveFrame("res_"+(int)random(10000,99999)+"_"+filename);
}

void mouseClicked() {
  setupRandom();
  processImage();
  processSlices();
}

// random parameters
final static int[] blends = {ADD, SUBTRACT, DARKEST, LIGHTEST, DIFFERENCE, EXCLUSION, MULTIPLY, SCREEN, OVERLAY, HARD_LIGHT, SOFT_LIGHT, DODGE, BURN};
void setupRandom() {
  if(random(1)<0.8) max_rotation = TWO_PI; else max_rotation = random(TWO_PI);
  if(random(1)<0.05) {
    thr_min = (int)random(150);
    thr_max = (int)random(150,255);
  } else {
    thr_min = -1;
    thr_max = -1;
  }
  if(random(1)<0.5) max_shift = 0; else max_shift = random(5);
  type = (int)random(4);
  if(random(1)<0.3) {
    do_blend = true;
    blend_type = blends[(int)random(blends.length)];
  } else do_blend = false;
  threshold = random(100,2000);
  min_comp_size = (int)random(10,500);
  if(random(1)<0.1) blur = (int)random(1,6); else blur = 0;
  stat_type = (int)random(6);
}

// general class to save distortions for particular segment
class S {
    color c; // color of the segment root point
    int x,y; // position of segment root point
    int dx, dy; // segment shift
    float rot, pats;
    PImage pat;
}
Map<Integer,S> m = new HashMap<Integer,S>();

void processSlices() {
  m.clear();
  
  if(type == PATTERNS) preparePatterns();
  
  for(int x=0;x<width;x++)
    for(int y=0;y<height;y++) {
      Integer segment = findEnd(y*width+x);
      
      S segm;
      if(m.containsKey(segment)) segm = m.get(segment);
      else { 
        segm = new S();
        segm.rot = random(max_rotation);
        segm.c = img.get(x,y);
        segm.dx = (int)(max_shift*randomGaussian());
        segm.dy = (int)(max_shift*randomGaussian());
        segm.x = x; segm.y = y;
        if(brightness(segm.c)>=thr_min && brightness(segm.c)<=thr_max) segm.c = palette[(int)random(palette.length)];
        if(type == PATTERNS) { 
          segm.pat = patterns[(int)random(max_patterns)];
          segm.pats = random(0.5,10);
        }
        m.put(segment,segm);
      }

    
      if(type == PATTERNS) {
        int vx = segm.x-x;
        int vy = segm.y-y;
        float sinr = sin(segm.rot);
        float cosr = cos(segm.rot);
        int imgx = int(segm.pat.width+x+(cosr*vx-sinr*vy))%segm.pat.width;
        int imgy = int(segm.pat.height+x+(sinr*vx+cosr*vy))%segm.pat.height;
        fill(segm.pat.get(imgx,imgy));
        rect(x,y,1,1);
      } else if(type == SEPARATE) {
        fill(segm.c);
        rect(x+segm.dx,y+segm.dy,1,1);
      } else if(type == SHIFTCOPY) {
        int imgx = (2*x-segm.x)%width;
        int imgy = (2*y-segm.y)%height;
        fill(img.get(imgx,imgy));
        rect(x,y,1,1);
      } else {
        int vx = segm.x-x;
        int vy = segm.y-y;
        float sinr = sin(segm.rot);
        float cosr = cos(segm.rot);
        int imgx = int(width+x+(cosr*vx-sinr*vy))%width;
        int imgy = int(height+y+(sinr*vx+cosr*vy))%height;
        fill(img.get(imgx,imgy));
        rect(x,y,1,1);
      }
    }
  
  if(do_blend)
    blend(img,0,0,img.width,img.height,0,0,width,height,blend_type);
}

// segmentation code START

final float getStat(color c1, color c2) {
  switch(stat_type) {
    case HUE: abs(hue(c1)-hue(c2));
    case BRIGHTNESS: abs(brightness(c1)-brightness(c2));
    case SATURATION: abs(saturation(c1)-saturation(c2));
    case ABSDIST: return abs(red(c1)-red(c2)) + abs(green(c1)-green(c2)) + abs(blue(c1)-blue(c2));
    default: return sq(red(c1)-red(c2)) + sq(green(c1)-green(c2)) + sq(blue(c1)-blue(c2)); 
  }
}

void processImage() {
  println("Processing...");
  edges.clear();
  makeEdges();
  calculateSegmentation();
}

class Edge implements Comparable {
  int a,b;
  float weight;
  
  int compareTo(Object o) {
    Edge e = (Edge)o;
    return this.weight<e.weight?-1:this.weight>e.weight?1:0;
  }
}

ArrayList<Edge> edges = new ArrayList<Edge>();

void makeEdges() {
  PImage img2 = img.get(0,0,img.width,img.height);
  if(blur > 0) img2.filter(BLUR,blur);
  // make grid each point connected to neighbours
  for(int x=0;x<img2.width;x++)
    for(int y=0;y<img2.height;y++) {
      color c = img2.get(x,y);
      
      if(x<img2.width-1) {
        Edge e = new Edge();
        e.a = y*img2.width+x;
        e.b = y*img2.width+x+1;
        e.weight = getStat(c,img2.get(x+1,y));  
        edges.add(e);
      }
      
      if(y<img2.height-1) {
        Edge e = new Edge();
        e.a = y*img2.width+x;
        e.b = (y+1)*img2.width+x;
        e.weight = getStat(c,img2.get(x,y+1));  
        edges.add(e);
      }
      
      if( (x<img2.width-1) && (y<img2.height-1)) {
        Edge e = new Edge();
        e.a = y*img2.width+x;
        e.b = (y+1)*img2.width+x+1;
        e.weight = getStat(c,img2.get(x+1,y+1));  
        edges.add(e);
      }
      
      if( (x<img2.width-1) && (y>0)) {
        Edge e = new Edge();
        e.a = y*img2.width+x;
        e.b = (y-1)*img2.width+x+1;
        e.weight = getStat(c,img2.get(x+1,y-1));  
        edges.add(e);
      }
    }
    
    // sort edges
    Collections.sort(edges);
}

int findEnd(int x) {
  int y = x;
  while(y != elements[y].parent) y = elements[y].parent;
  elements[x].parent = y;
  return y;
}

void joinSegments(int x, int y) {
  if(elements[x].rank > elements[y].rank) {
    elements[y].parent = x;
    elements[x].size += elements[y].size;
  } else {
    elements[x].parent = y;
    elements[y].size += elements[x].size;
    if(elements[x].rank == elements[y].rank) elements[y].rank++;
  }
  num--;
}

class SegmentNode {
  int rank,parent,size;
}

SegmentNode[] elements;
int num;

void calculateSegmentation() {
  int no_vertices = img.width*img.height;
  num = no_vertices;
  
  elements = new SegmentNode[no_vertices];
  // init nodes
  for(int i=0;i<no_vertices;i++) {
    SegmentNode s = new SegmentNode();
    s.rank = 0;
    s.size = 1;
    s.parent = i;
    elements[i]=s;
  }
  
  float[] thresholds = new float[no_vertices];
  Arrays.fill(thresholds,threshold);
  
  for(Edge edge: edges) {
    int a = findEnd(edge.a);
    int b = findEnd(edge.b);
    
    if(a!=b) {
      if(edge.weight <= thresholds[a] && edge.weight <= thresholds[b]) {
        joinSegments(a,b);
        a = findEnd(a);
        thresholds[a] = edge.weight + threshold/elements[a].size;
      }
    }
  }
  
  for(Edge edge: edges) {
    int a = findEnd(edge.a);
    int b = findEnd(edge.b);
    if( (a != b) && ((elements[a].size < min_comp_size) || (elements[b].size < min_comp_size))) {
      joinSegments(a,b);
    } 
  }
  
  println("Segments: " +num);
  
}
// segmentation code END


// Pattern loader

PImage[] patterns;
void preparePatterns() {
  patterns = new PImage[max_patterns];
  for(int i=0;i<max_patterns;i++) {
    patterns[i] = getCLPattern();
  }
}

PImage getCLPattern() {
  int n = (int)random(1,4728837); // should be taken from API, http://www.colourlovers.com/api/stats/patterns
  print("Loading pattern from ColourLovers number: "+n+"...");
  
  String pad="";
  if(n<1000) pad = "0";
  else {
    String nn = ""+n;
    pad = nn.substring(0,nn.length()-3);
  }
  
  PImage pimg = null;
  String clname = "http://colourlovers.com.s3.amazonaws.com/images/patterns/"+pad+"/"+n+".png";
  try {
    pimg = loadImage(clname, "png");
  } catch(Exception e) {
    // ignore
  }
  
  if(pimg == null) {
    pimg = getCLPattern(); 
  } else if(pimg.width <0) pimg = getCLPattern();  
  
  println("done");
  return pimg;
}
