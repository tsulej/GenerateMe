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
String filename = "test";
String fileext = ".jpg";
String foldername = "./";

// you can use different image as mask
String mask = null;

int max_display_size = 800; // viewing window size (regardless image size)

float max_rotation = TWO_PI; // random or fixed rotation up to specified angle, 0 - TWO_PI, 0 - no rotation
boolean fixed_rotation = true; // fixed or random rotation
int thr_min = -1; // you can change color of segment for specified brightness threshold
int thr_max = -1; // set to -1 if you don't want to use it, values from 0 to 255
color[] palette = { #000000, #E7CBB3, #CEC6AF, #A0C3BC, #7C7F84, #ffffff }; // choose colors for palette you want to use with threshold, colors will be choosen randomly

// PATTERNS config
int max_patterns = 20; // how much patterns download from colourlovers, higher number, more to download

// SEPARATE config
float max_shift = 2; // max expected shift, using gaussian random, so bigger number, more distortion

int type = ROTATE; // choose type of distortion: PATTERNS, SEPARATE, ROTATE, SHIFTCOPY, SORT
boolean do_blend = false; // blend result with original?
int blend_type = SUBTRACT; // list here: https://processing.org/reference/blend_.html

boolean downloadPatterns = false; // download patterns or cut some from image

// segmentation config START
float threshold = 500.0; // higher number - bigger segments
int min_comp_size = 200; // minimal segment size (in pixels), minimum 10
int blur = 0; // sometimes it's good to blur image to have less sharp segment edges, 0 = off, blur > 0 - blur kernel size
int stat_type = DIST; // edge calculation method

final static int DIST = 0;
final static int HUE = 1;
final static int BRIGHTNESS = 2;
final static int SATURATION = 3;
final static int ABSDIST = 4;

// do not touch it
PImage img, mimg; // load image to this variable
// segmentation config END

// do not touch, list of types
final static int PATTERNS = 0; // fill segments with patterns
final static int SEPARATE = 1; // separate segments (black background visible)
final static int ROTATE = 2; // rotate content of the segments
final static int SHIFTCOPY = 3; // copy content from shifted image
final static int SORT = 4; // sort segments by color value

// working buffer
PGraphics buffer;

String sessionid;

void setup() {
  sessionid = hex((int)random(0xffff),4);
  img = loadImage(foldername+filename+fileext);
  
  if(mask != null) mimg = loadImage(foldername + mask);
  else mimg = img;
  
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

  size(neww,newh);
  
  processImage();
  processSlices();
  printOptions(null);
}

void draw() {}

void keyPressed() {
  if(keyCode == 32) {
    String fn = foldername + filename + "/res_" + sessionid + hex((int)random(0xffff),4)+"_"+filename+fileext;
    buffer.save(fn);
    PrintWriter w = createWriter(fn+".txt");
      printOptions(w);
    w.flush();
    w.close();
    println("Image "+ fn + " saved");
  }
}

void mouseClicked() {
  setupRandom();
  processImage();
  processSlices();
  printOptions(null);
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
  type = (int)random(5);
  if(random(1)<0.3) {
    do_blend = true;
    blend_type = blends[(int)random(blends.length)];
  } else do_blend = false;
  threshold = random(100,2000);
  min_comp_size = (int)random(10,500);
  if(random(1)<0.1) blur = (int)random(1,6); else blur = 0;
  stat_type = (int)random(6);
  downloadPatterns = random(1)<0.5;
  fixed_rotation = random(1)<0.5;
}

void printOptions(PrintWriter w) {
  ArrayList<String> buff = new ArrayList<String>();
  buff.add("max_rotation = " + max_rotation);
  buff.add("thr_min = " + thr_min);
  buff.add("thr_max = " + thr_max);
  buff.add("max_shift = " + max_shift);
  String s = "type = ";
  switch(type) {
    case PATTERNS: s += "PATTERNS"; break;
    case SHIFTCOPY: s+= "SHIFTCOPY"; break;
    case ROTATE: s+= "ROTATE"; break;
    case SEPARATE: s+= "SEPARATE"; break;
    case SORT: s+= "SORT"; break;
    default: break;   
  }
  buff.add(s);
  buff.add("do_blend = " + (do_blend?"true":"false"));
  s = "blend_type = ";
  switch(blend_type) {
    case ADD: s+="ADD"; break;
    case SUBTRACT: s+="SUBTRACT"; break;
    case DARKEST: s+="DARKEST"; break;
    case LIGHTEST: s+="LIGHTEST"; break; 
    case DIFFERENCE: s+="DIFFERENCE"; break;
    case EXCLUSION: s+="EXCLUSION";break;
    case MULTIPLY: s+="MULTIPLY"; break;
    case SCREEN: s+="SCREEN"; break;
    case OVERLAY: s+="OVERLAY"; break;
    case HARD_LIGHT: s+="HARD_LIGHT";break;
    case SOFT_LIGHT: s+="SOFT_LIGHT"; break;
    case DODGE: s+="DODGE"; break; 
    case BURN: s+="BURN"; break;
    default: break;    
  }
  buff.add(s);
  buff.add("threshold = " + threshold);
  buff.add("min_comp_size = " + min_comp_size);
  buff.add("blur = " + blur);
  s = "stat_type = ";
  switch(stat_type) {
    case HUE: s+="HUE"; break;
    case BRIGHTNESS: s+="BRIGHTNESS"; break;
    case SATURATION: s+="SATURATION"; break;
    case ABSDIST: s+="ABSDIST"; break;
    default: s+="DIST"; break; 
  }  
  buff.add(s);
  buff.add("fixed_rotation = " + fixed_rotation);
  buff.add("downloadPatterns = " + downloadPatterns);
  
  for(String str : buff) {
    if(w == null) println(str);
    else w.println(str);
  }
}

// general class to save distortions for particular segment
class S {
    color c; // color of the segment root point
    int x,y; // position of segment root point
    int dx, dy; // segment shift
    float rots, rotc, pats;
    PImage pat;
    // sort
    color[] clrs;
    int[] positions;
    boolean xy;
    int iters;
}
Map<Integer,S> m = new HashMap<Integer,S>();

void sortHelper(S segm, int x, int y) {
  int xyval;
  if(segm.xy)
    xyval = (x << 16) | y;
  else
    xyval = (y << 16) | x;
  segm.clrs[segm.iters] = img.get(x,y);
  segm.positions[segm.iters++] = xyval; 
}

void processSlices() {
  buffer.beginDraw();
  m.clear();
  
  if(type == PATTERNS) preparePatterns();
  
  for(int x=0;x<img.width;x++)
    for(int y=0;y<img.height;y++) {
      Integer segment = findEnd(y*img.width+x);
      
      S segm;
      if(m.containsKey(segment)) {
        segm = m.get(segment);
        if(type == SORT) sortHelper(segm,x,y);
      }
      else { 
        segm = new S();
        segm.rots = sin(fixed_rotation?max_rotation:random(max_rotation));
        segm.rotc = cos(fixed_rotation?max_rotation:random(max_rotation));
        segm.c = img.get(x,y);
        segm.dx = (int)(max_shift*randomGaussian());
        segm.dy = (int)(max_shift*randomGaussian());
        segm.x = x; segm.y = y;
        if(brightness(segm.c)>=thr_min && brightness(segm.c)<=thr_max) segm.c = palette[(int)random(palette.length)];
        if(type == PATTERNS) { 
          segm.pat = patterns[(int)random(max_patterns)];
          segm.pats = random(0.5,10);
        }
        if(type == SORT) {
          segm.xy = random(1)<0.5;
          int size = elements[segment].size;
          segm.clrs = new color[size];
          segm.positions = new int[size];
          segm.iters = 0;
          sortHelper(segm,x,y);
        }
        m.put(segment,segm);
      }
   
      if(type == PATTERNS) {
        int vx = segm.x-x;
        int vy = segm.y-y;
        float sinr = segm.rots;
        float cosr = segm.rotc;
        int imgx = int(segm.pat.width+x+(cosr*vx-sinr*vy))%segm.pat.width;
        int imgy = int(segm.pat.height+x+(sinr*vx+cosr*vy))%segm.pat.height;
        buffer.fill(segm.pat.get(imgx,imgy));
        buffer.rect(x,y,1,1);
      } else if(type == SEPARATE) {
        buffer.fill(segm.c);
        buffer.rect(x+segm.dx,y+segm.dy,1,1);
      } else if(type == SHIFTCOPY) {
        int imgx = (2*x-segm.x)%img.width;
        int imgy = (2*y-segm.y)%img.height;
        buffer.fill(img.get(imgx,imgy));
        buffer.rect(x,y,1,1);
      } else if(type == ROTATE) {
        int vx = segm.x-x;
        int vy = segm.y-y;
        float sinr = segm.rots;
        float cosr = segm.rotc;
        int imgx = int(img.width+x+(cosr*vx-sinr*vy))%img.width;
        int imgy = int(img.height+y+(sinr*vx+cosr*vy))%img.height;
        buffer.fill(img.get(imgx,imgy));
        buffer.rect(x,y,1,1);
      }
    }
  
  if(type == SORT) {
    for(Integer key : m.keySet()) {
      S segm = m.get(key);
      segm.clrs = sort(segm.clrs);
      segm.positions = sort(segm.positions);
    }  
    
    for(Integer key : m.keySet()) {
      S segm = m.get(key);
      for(int i=0;i<segm.positions.length;i++) {
        int x,y;
        if(segm.xy) {
          x = (segm.positions[i] >> 16) & 0xffff;
          y = segm.positions[i] & 0xffff;
        } else {
          y = (segm.positions[i] >> 16) & 0xffff;
          x = segm.positions[i] & 0xffff;
        }
        buffer.fill(segm.clrs[i]);
        buffer.rect(x,y,1,1);
      }
    }  
  }
  
  if(do_blend)
    buffer.blend(img,0,0,img.width,img.height,0,0,buffer.width,buffer.height,blend_type);
    
  buffer.endDraw();
  image(buffer,0,0,width,height);  
}

// segmentation code START

final float getStat(color c1, color c2) {
  switch(stat_type) {
    case HUE: return abs(hue(c1)-hue(c2));
    case BRIGHTNESS: return abs(brightness(c1)-brightness(c2));
    case SATURATION: return abs(saturation(c1)-saturation(c2));
    case ABSDIST: return abs(red(c1)-red(c2)) + abs(green(c1)-green(c2)) + abs(blue(c1)-blue(c2));
    default: return sq(red(c1)-red(c2)) + sq(green(c1)-green(c2)) + sq(blue(c1)-blue(c2)); 
  }
}

void processImage() {
  println("");
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
  PImage img2 = mimg.get(0,0,img.width,img.height);
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
    patterns[i] = downloadPatterns?getCLPattern():getSelfPattern();
  }
}

PImage getSelfPattern() {
  int x = (int)random(img.width-50);
  int y = (int)random(img.height-50);
  int sx = (int)random(50,img.width-x-1);
  int sy = (int)random(50,img.height-y-1);
  return img.get(x,y,sx,sy);
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
