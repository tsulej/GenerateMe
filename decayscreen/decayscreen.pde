// Decay image
// Original source: xscreensaver 5.32, authors: David Wald (1988), Vivek Khera (1993), JWZ (1997), R. Schultz (1999)
// Not exact port to Processing, Tomasz Sulej, generateme.blog@gmail.com, 2015
// Licence at the end of file

// Set file name
// press: i - to change drag method between in/out
//        SPACE - to save
//        ENTER - to decay automaticly
// drag clicked mouse to decay in or out

String filename = "test.jpg";

//

void setup() {
  PImage img = loadImage(filename);
  size(img.width,img.height);
  image(img,0,0); 
  frameRate(100); 
  
  printStats();
}

boolean auto = false;

void draw() {
  if(auto) doDecay();
}

boolean in = true;

void mouseDragged() {
  doBias(in,mouseX,mouseY);
}

void keyPressed() {
  if(key == 'i') in = !in;
  if(keyCode == RETURN || keyCode == ENTER) auto = !auto;
  if(keyCode == 32) { saveFrame("res_"+(int)random(10000,99999)+"_"+filename); print("saved... "); };
  printStats();
}

void printStats() {
  println("method: " + (in?"in":"out") + "; "+(auto?"auto":""));
}

void doDecay() {
  int a = (random(1)<0.05)?(int)random(6):(int)random(2);
  switch(a) {
    case 0: doBias(); break;
    case 1: doFuzz(); break;
    case 2: doStretchV(); break;
    case 3: doSqueezeV(); break;
    case 4: doStretchH(); break;
    case 5: doSqueezeV(); break;
    default: doBias();
  }
}

static final int L = 0;
static final int R = 1;
static final int U = 2;
static final int D = 3;

static final int[][] bias = {
    { L,L,L,L, R,R,R,R, U,U,U,U, D,D,D,D },
    { L,L,L,L, R,R,R,R, U,U,U,U, U,U,D,D },
    { L,L,L,L, R,R,R,R, U,U,D,D, D,D,D,D },
    { L,L,L,L, L,L,R,R, U,U,U,U, D,D,D,D },
    { L,L,R,R, R,R,R,R, U,U,U,U, D,D,D,D },
    
    { L,L,L,L, L,L,L,R, U,U,U,U, U,U,U,D },
    { L,L,L,L, L,L,L,R, U,D,D,D, D,D,D,D },
    { L,R,R,R, R,R,R,R, U,U,U,U, U,U,U,D },
    { L,R,R,R, R,R,R,R, U,D,D,D, D,D,D,D }
};

void doBias(boolean in, int mx, int my) {
  int left = (int)random(width-1);
  int top = (int)random(height);
  int w = (int)random(width-left);
  int h = (int)random(height-top);
  int toleft = left;
  int totop = top;
  
  int biasno = 0;
  
  if(in) {
    if      (top>my && left>mx) biasno = 5;
    else if (top>my && left<mx) biasno = 7;
    else if (top<my && left>mx) biasno = 6;
    else                        biasno = 8;
  } else {
    if      (top>my && left>mx) biasno = 8;
    else if (top>my && left<mx) biasno = 6;
    else if (top<my && left>mx) biasno = 7;
    else                        biasno = 5;
  }
  
  switch( bias[biasno][(int)random(16)] ) {
    case L: {toleft = left-2;break;}
    case R: {toleft = left+2;break;}
    case U: {totop = top-2;break;}
    case D: {totop = top+2; break;}
    default: {toleft = left-1; totop=top+1;}break;
  }
  
  PImage img = get(left,top,w,h);
  image(img,toleft,totop);
}

void doBias() {
  int left = (int)random(width-1);
  int top = (int)random(height);
  int w = (int)random(width-left);
  int h = (int)random(height-top);
  int toleft = left;
  int totop = top;
  
  switch( bias[(int)random(9)][(int)random(16)] ) {
    case L: {toleft = left-1;break;}
    case R: {toleft = left+1;break;}
    case U: {totop = top-1;break;}
    case D: {totop = top+1; break;}
    default: {toleft = left-1; totop=top+1;}break;
  }
  
  PImage img = get(left,top,w,h);
  image(img,toleft,totop); 
}

boolean fuzz_toggle = true;
void doFuzz() {
  int left = (int)random(width-1);
  int top = (int)random(height-1);
  int h,w,totop,toleft;
  
  // bad code, bad... 
  if(fuzz_toggle) {
    totop = top;
    h = 1;
    toleft = (int)random(width-1);
    if(toleft>left) {
      w = toleft-left;
      toleft = left;
      left++;
    } else {
      w = left-toleft;
      left = toleft;
      toleft++;
    }
  } else {
    toleft = left;
    w = 1;
    totop = (int)random(height-1);
    if(totop>top) {
      h = totop-top;
      totop = top;
      top++;
    } else {
      h = top-totop;
      top = totop;
      totop++;
    }
  }
  fuzz_toggle = !fuzz_toggle;
  
  PImage img = get(left,top,w,h);
  image(img,toleft,totop);  
}

void doStretchV() {
  int top = (int)random(height);

  PImage img = get(0,height-top-2,width,top+1);
  image(img,0,height-top-1);
}

void doSqueezeV() {
  int top = (int)random(height);

  PImage img = get(0,height-top-1,width,top+1);
  image(img,0,height-top-2);
}

void doStretchH() {
  int left = (int)random(width);

  PImage img = get(width-left-2,0,left+1,height);
  image(img,width-left-1,0);
}

void doSqueezeH() {
  int left = (int)random(width);

  PImage img = get(width-left-1,0,left+1,height);
  image(img,width-left-2,0);
}

/*
 * Permission to use, copy, modify, distribute, and sell this software and its
 * documentation for any purpose is hereby granted without fee, provided that
 * the above copyright notice appear in all copies and that both that
 * copyright notice and this permission notice appear in supporting
 * documentation.  No representations are made about the suitability of this
 * software for any purpose.  It is provided "as is" without express or
 * implied warranty.
*/
