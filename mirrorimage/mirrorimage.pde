/* Mirror image in several ways, works well on rectangular images
 * there are 24 modes for rectangular and 12 in square
 * Author: Tomasz Sulej, generateme.blog@gmail.com, 2015, <http://unlicense.org>
 * Thanks Gus Holiday for inspiration <https://www.facebook.com/gus.graphics>
 */
 
// Configure
// - set image filename
// - put list of actions
// Actions (hard to explain, just experiment):
//  UL - mirror upper left triangle onto down right
//  UR - ^ upper right -> down left
//  DL, DR - similar
//  L - mirror left part to right
//  R, U, D - similar (right, up, down)
//  version 2 - copy (flip and flop)
//  S* - versions for rectangle, choose the right or down side of the image
//  R* - use rectangles diagonals to copy 
 
// Usage:
//   click to do one more actions on current result
//   ENTER/RETURN to reset
//   SPACE to save

// filename here:
String filename = "test";
String fileext = ".jpg";
String foldername = "./";

int max_display_size = 800; // viewing window size (regardless image size)

// actions here (comma separated in curly braces):
int[] order = { UL, L, DL };

// do you want order of operations choosen by machine? If true, script ignores what you set up
boolean automatic = true;

// mirror
final static int UL = 0;
final static int UR = 1;
final static int DL = 2;
final static int DR = 3;
final static int U = 4;
final static int D = 5;
final static int L = 6;
final static int R = 7;

// mirror 2
final static int UL2 = 8;
final static int UR2 = 9;
final static int DL2 = 10;
final static int DR2 = 11;

// shift mirror
final static int SUL = 12;
final static int SUR = 13;
final static int SDL = 14;
final static int SDR = 15;

// shift mirror2
final static int SUL2 = 16;
final static int SUR2 = 17;
final static int SDL2 = 18;
final static int SDR2 = 19;

// rectangle mirror2
final static int RUL = 20;
final static int RUR = 21;
final static int RDL = 22;
final static int RDR = 23;

int size;
int tx,ty;

PImage img;

// working buffer
PGraphics buffer;

String sessionid;

void setup() {
  sessionid = hex((int)random(0xffff),4);
  img = loadImage(foldername+filename+fileext);
  
  buffer = createGraphics(img.width, img.height);
  buffer.beginDraw();
  buffer.image(img,0,0);
  buffer.noStroke();
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
  //<>//
  size = img.width<img.height?img.width:img.height;
  
  tx=ty=0;
  if(img.width>size) tx = img.width-size;
  if(img.height>size) ty = img.height-size;
  
  image(buffer,0,0,width,height);
}

void draw() {}

void mouseClicked() {
  buffer.beginDraw();
  if(automatic) {
    int n = (int)random(1,16);
    order = new int[n];
    for(int i=0;i<n;i++) order[i] = (int)random(24);
  }
  
  for(int i=0;i<order.length;i++) doMirror(order[i]);
  buffer.endDraw();
  image(buffer,0,0,width,height);  
}

void keyPressed() {
  if(keyCode == ENTER || keyCode == RETURN) {
    buffer.beginDraw();
    buffer.image(img,0,0);
    buffer.endDraw();
    image(buffer,0,0,width,height);
  }
  if(keyCode == 32) buffer.save(foldername + filename + "/res_" + sessionid + hex((int)random(0xffff),4)+"_"+filename+fileext);
}

void doMirror(int type) {
  switch(type) {
    case U: doHorizontal(true); break;
    case D: doHorizontal(false); break;
    case L: doVertical(true); break;
    case R: doVertical(false); break;
    case DL: doDiagUL(0,false); break;
    case UR: doDiagUL(1,false); break;
    case DR: doDiagUR(0,false); break;
    case UL: doDiagUR(1,false); break;
    case DL2: doDiagUL(2,false); break;
    case UR2: doDiagUL(3,false); break;
    case DR2: doDiagUR(2,false); break;
    case UL2: doDiagUR(3,false); break;
    case SDL: doDiagUL(0,true); break;
    case SUR: doDiagUL(1,true); break;
    case SDR: doDiagUR(0,true); break;
    case SUL: doDiagUR(1,true); break;
    case SDL2: doDiagUL(2,true); break;
    case SUR2: doDiagUL(3,true); break;
    case SDR2: doDiagUR(2,true); break;
    case SUL2: doDiagUR(3,true); break;
    case RDL: doDiagLRect(true); break;
    case RUL: doDiagLRect(false); break;
    case RUR: doDiagRRect(true); break;
    case RDR: doDiagRRect(false); break;
  }
  
}

void doDiagUL(int type, boolean shift) {
  for(int y=0;y<size;y++)
    for(int x=0;x<=y;x++)
      switch(type) {
        case 0: drawPoint(x,y,y,x,shift); break;
        case 1: drawPoint(y,x,x,y,shift); break;
        case 2: drawPoint(x,y,size-x-1,size-y-1,shift); break;
        case 3: drawPoint(y,x,size-y-1,size-x-1,shift); break;
        default: break;
      }   
}

void doDiagUR(int type, boolean shift) {
  for(int y=0;y<size;y++)
    for(int x=size-1;x>=size-y-1;x--)
      switch(type) {
        case 0: drawPoint(x,y,size-y-1,size-x-1,shift); break;
        case 1: drawPoint(size-y-1,size-x-1,x,y,shift); break;
        case 2: drawPoint(x,y,size-x-1,size-y-1,shift); break;
        case 3: drawPoint(size-x-1,size-y-1,x,y,shift); break;
        default: break;
      }
}

void doHorizontal(boolean type) {
  for(int y=0;y<img.height/2;y++)
    for(int x=0;x<img.width;x++)
      if(type) drawPoint(x,y,x,img.height-y-1,false);
      else     drawPoint(x,img.height-y-1,x,y,false);
}

void doVertical(boolean type) {
  for(int x=0;x<img.width/2;x++)
    for(int y=0;y<img.height;y++)
      if(type) drawPoint(x,y,img.width-x-1,y,false);
      else     drawPoint(img.width-x-1,y,x,y,false);
}

void doDiagLRect(boolean m) {
  for(int y=0;y<img.height;y++) {
    int d = m?(int)map(y,0,img.height,0,img.width):(int)map(y,0,img.height,img.width,0);
    for(int x=0;x<d;x++) {
      buffer.fill(buffer.get(x,y));
      buffer.rect(img.width-x-1,img.height-y-1,1,1);
    }
  }
}


void doDiagRRect(boolean m) {
  for(int y=0;y<img.height;y++) {
    int d = m?(int)map(y,0,img.height,0,img.width):(int)map(y,0,img.height,img.width,0);
    for(int x=0;x<d;x++) {
      buffer.fill(buffer.get(img.width-x-1,img.height-y-1));
      buffer.rect(x,y,1,1);
    }
  }
}

void drawPoint(int oldx, int oldy, int newx, int newy, boolean shift) {
  
  int sx=0;
  int sy=0;
  if(shift) { sx = tx; sy = ty; } // fucking rectangles...
  
  buffer.fill(buffer.get(oldx+sx,oldy+sy));
  buffer.rect(newx+sx,newy+sy,1,1);
}
