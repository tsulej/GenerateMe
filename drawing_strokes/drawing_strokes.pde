// http://buntworthy.github.io/Robot-artist-revisted/
// Robot drawing algorithm by catsquash/Justin
// this code has rewriten idea to speed up process and give more parametrization
// Tomasz Sulej, https://generateme.tumblr.com, generateme.blog@gmail.com, 2015
// Licence:

// Usage:
// * set image filename and parameters
// * run
//   * SPACE to save
//   * click to set random settings
//   * press 'i' for interactive mode, mouse drag starts line, short mouse movement please until you want wait loooong 
// NOTE: small change to stroke_len, angles_no, stroke_alpha may have dramatic effect

// image filename
String filename = "test.jpg";

int stat_type = ABSDIST2; // type of diff calculation: fast: ABSDIST, DIST, slow: HUE, SATURATION, BRIGHTNESS
int stroke_len = 3; // length of the stroke, values: 1 and above
int angles_no = 30; // number of directions stroke can be drew, 2 and above
int segments = 500; // number of segments of single thread
float stroke_width = 1; // width of the stroke, 0.5 - 3
int stroke_alpha = 100; // alpha channel of the stroke: 30 - 200 

boolean interactive = false;

PImage img;
void setup() {
  img = loadImage(filename);
  size(img.width,img.height);
  
  noFill();
  smooth(8);
 
  reinit();
  printParameters();
}

void reinit() {
  strokeWeight(stroke_width);
  
  currx = (int)random(width);
  curry = (int)random(height); 
 
  sintab = new int[angles_no];
  costab = new int[angles_no];
 
  for(int i=0;i<angles_no;i++) {
    sintab[i] = (int)(stroke_len * sin(TWO_PI*i/(float)angles_no));
    costab[i] = (int)(stroke_len * cos(TWO_PI*i/(float)angles_no));
  } 
  
  sqwidth = stroke_len * 2 + 10;
  background(255);
}

int currx, curry;
int[] sintab, costab;
int sqwidth;

int calcDiff(PImage img1, PImage img2) {
  int err = 0;
  for(int i=0;i<img1.pixels.length;i++)
    err += getStat(img1.pixels[i],img2.pixels[i]); //<>//
  return err;  
}

void drawMe() {
  //draw next 200 points using current color
  stroke(img.get(currx,curry),stroke_alpha);
  
  for(int iter=0;iter<segments;iter++) {
    // corners of square containing new strokes
    int corx = currx-stroke_len-5;
    int cory = curry-stroke_len-5;
  
    // take square from image and current screen
    PImage imgpart = img.get(corx,cory,sqwidth,sqwidth);
    PImage mypart = get(corx,cory,sqwidth,sqwidth);
    imgpart.loadPixels();
    mypart.loadPixels();
    
    // calc current diff 
    float localerr = calcDiff(imgpart,mypart);
  
    // chosen stroke will be here
    PImage destpart = null;
    int _nx=currx,_ny=curry;
  
    // start with random angle
    int i = (int)random(angles_no);
    int iterangles = angles_no;
    
    while(iterangles-- > 0) {
      // take end points
      int nx = currx + costab[i];
      int ny = curry + sintab[i];
     
      // if not out of the screen
      if(nx>=0 && nx<width-1 && ny>=0 && ny<height-1) {
        // clean region and draw line
        image(mypart,corx,cory);
        line(currx,curry,nx,ny);
      
        // take region with line and calc diff
        PImage curr = get(corx,cory,sqwidth,sqwidth);
        curr.loadPixels();
        int currerr = calcDiff(imgpart,curr);
        
        // if better, remember this region and line endpoint
        if(currerr < localerr) {
          destpart = curr;
          _nx = nx;
          _ny = ny;
          localerr = currerr;
        }
      }
      
      // next angle
      i = (i+1)%angles_no;
    }
  
    // if we have new stroke, draw it
    if(destpart != null) {
      image(destpart,corx,cory);
      currx = _nx;
      curry = _ny;
    } else {
      break; // skip
    }
  }
}

void draw() {
  if(!interactive) {
    currx = (int)random(width);
    curry = (int)random(height);
    drawMe();
  }
}

void mouseDragged() {
  if(interactive) {
    print("+");
    currx = mouseX;
    curry = mouseY;
    drawMe();
  }
}

void mouseClicked() {
  if(!interactive) {
    stat_type = random(1)<0.05?(int)random(1,4):random(1)<0.3?ABSDIST:random(1)<0.5?ABSDIST2:DIST;
    stroke_len = (int)random(1,15);
    angles_no = (int)random(2,50);
    segments = (int)random(50,1500);
    stroke_width = random(1)<0.7?1.0:random(0.5,3);
    stroke_alpha = (int)random(50,200);
    reinit();
    printParameters();
  }
}

void printParameters() {
  String s_stat_type = "";
  switch(stat_type) {
    case DIST: s_stat_type = "DIST"; break;
    case ABSDIST: s_stat_type = "ABSDIST"; break;
    case ABSDIST2: s_stat_type = "ABSDIST2"; break;
    case HUE: s_stat_type = "HUE"; break;
    case SATURATION: s_stat_type = "SATURATION"; break;
    case BRIGHTNESS: s_stat_type = "BRIGHTNESS"; break;
    default: break; 
  }
  println("stat_type=" + s_stat_type);
  println("stroke_len=" + stroke_len);
  println("angles_no=" + angles_no);
  println("segments=" + segments);
  println("stroke_alpha=" + stroke_alpha);
  println("stroke_width=" + stroke_width);
  println("");
}

void keyPressed() {
  println("");
  if(keyCode == 32) {
    save("res_"+(int)random(10000,99999)+"_"+filename);
    print("image saved");
  } else if(key == 'i') {
    interactive = !interactive;
    println("interactive mode: " + (interactive?"ON":"OFF"));
  }
}

final static int DIST = 0;
final static int HUE = 1;
final static int BRIGHTNESS = 2;
final static int SATURATION = 3;
final static int ABSDIST = 4;
final static int ABSDIST2 = 5;

final float getStat(color c1, color c2) {
  switch(stat_type) {
    case HUE: abs(hue(c1)-hue(c2));
    case BRIGHTNESS: abs(brightness(c1)-brightness(c2));
    case SATURATION: abs(saturation(c1)-saturation(c2));
    case ABSDIST: return abs(red(c1)-red(c2))+abs(green(c1)-green(c2))+abs(blue(c1)-blue(c2));
    case ABSDIST2: return abs( (red(c1)+blue(c1)+green(c1)) - (red(c2)+blue(c2)+green(c2)) );
    default: return sq(red(c1)-red(c2)) + sq(green(c1)-green(c2)) + sq(blue(c1)-blue(c2)); 
  }
}
