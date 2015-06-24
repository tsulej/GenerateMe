// Moire pattern generator
// Tomasz Sulej, generateme.blog@gmail.com, http://generateme.tumblr.com
// Licence: http://unlicense.org/

// Usage:
//   * press SPACE to save
//   * click to random change

// set up filename
String filename = "moire";
String fileext = ".jpg";
String foldername = "./";

int image_size = 1000; // setup result size
int max_display_size = 800; // viewing window size (regardless result size)

float stripe_density = 25; // higher number, narrower stripes 

float rx = 2; // operating range for x from -rx to rx, from 0.5 to 5
float ry = 2; // operating range for x from -ry to ry, from 0.5 to 5

// working buffer
PGraphics buffer;

String sessionid;

void setup() {
  sessionid = hex((int)random(0xffff), 4);
  buffer = createGraphics(image_size, image_size);
  buffer.beginDraw();
  buffer.noStroke();
  buffer.smooth(8);
  buffer.background(0);
  buffer.endDraw();

  size(max_display_size, max_display_size);

  processImage();
}

void draw() {
  // fill for iterative processing
}

final static int[] non_random_folds = {
  175, 173, 170, 171, 167, 168, 169, 165, 160, 161, 162, 163, 159, 153, 154, 155, 156, 157, 152, 150, 148, 149, 147, 144, 143, 136, 137, 138, 135, 134, 130, 131, 126, 127, 128, 129, 125, 123, 121, 118, 119, 116, 115, 111, 106, 107, 108, 109, 102, 103, 104, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 61, 62, 63, 64, 65, 66, 67, 68, 69, 60, 59, 56, 55, 54, 52, 49, 47, 46, 44, 43, 31, 32, 33, 34, 29, 30, 28, 25, 26, 27, 24, 23, 22, 21, 19, 18, 17, 16, 15, 14, 12, 13, 11, 9, 8, 7, 6, 3, 4, 5
};

void processImage() {
  buffer.beginDraw();

  Folds f = new Folds(width, -rx, rx, -ry, ry);

  int foldnumber = (int)floor(random(3))+1;
  int[] folds = new int[foldnumber];
  for (int i=0;i<foldnumber;i++)
    folds[i] = non_random_folds[(int)floor(random(non_random_folds.length))];

  boolean stype = random(1)<0.5;

  String s = "p->";
  for (int i=0;i<foldnumber;i++) {
    s += f.foldnames[folds[i]]+"->";
  }
  println("");
  println(s + "p");
  if (stype) println("linear"); 
  else println("circular");

  for (int x=0;x<buffer.width;x++) {
    float xx = map(x, 0, buffer.width, -rx, rx);
    for (int y=0;y<buffer.height;y++) {
      float yy = map(y, 0, buffer.height, -ry, ry);

      PVector p = new PVector(xx, yy);

      for (int i=0;i<foldnumber;i++) {
        p = f.getFoldbyNo(folds[i], p, 1);
      }
      PVector v = p;

      float r = sin(stripe_density*TWO_PI * (stype?(v.y+v.x):(sqrt(sq(v.x)+sq(v.y)))));
      buffer.fill( map(r, -1, 1, 0, 255) );
      buffer.rect(x, y, 1, 1);
    }
  }

  buffer.endDraw();

  image(buffer, 0, 0, width, height);
}

void mouseClicked() {
  processImage();  
}

void keyPressed() {
  // SPACE to save
  if (keyCode == 32) {
    String fn = foldername + filename + "/res_" + sessionid + hex((int)random(0xffff), 4)+"_"+filename+fileext;
    buffer.save(fn);
    println("Image "+ fn + " saved");
  }
}
