// OBJ -> RAW, RAW -> OBJ
// 2016 Tomasz Sulej, generateme.blog@gmail.com, http://generateme.tumblr.com
// Licence: http://unlicense.org/

// Export Obj vertex data and save them into 8bit unsigned RAW file
// You can choose between two modes:
// - interleaved (planar = false) - where vertices are saved one after another, xyzxyzxyzxyz....
// - planar (planar = true) - where first X coordinates are dumped, then Y and finally Z, xxxxxx...yyyyyy...zzzzzz
//
// Since 8 bits per coordinate is used, coordinates are quantized and normalized to have values between -120 to 120

// Usage:
// - setup filename of your OBJ file (without extension)
// - run - OBJ file is loaded and rendered, corresponding RAW file is saved
// - move mouse to rotate object 
//
// Keys:
// - o - reload original OBJ file and regenerate RAW
// - r - load RAW file with name <filename>_res.raw
// - SPACE - save image and resulted OBJ file
//
// Sonification process (filename: teapot):
// - setup filename (teapot) and planar variable (true or false)
// - run, scripts loads teapot.obj and saves teapot/teapot.raw
// - import RAW file into Audacity as 8 bit signed int or other
// - do whatever you want but don't change length of the audio!
//   echo, compressor, reverse, etc...
// - export RAW as 8 bit signed int or other and save under teapot/teapot_res.raw name
// - press 'r'
// - press SPACE to save view and OBJ
//
// Additional notes:
// - material, textures, normals are ignored
// - groups are ignored (packed into one group)
// - resulting OBJ has only vertices and faces
// - it's good to have your OBJ aligned to origin (especially Z axis)
// - saving and reading RAW causes quality lost (due to quantization)
// - importing/exporting as 8 bit signed int removes some faces (rounding errors in Audacity), you can choose A-law to keep them all

// set up filename
String filename = "teapot";
String fileext = ".jpg";
String foldername = "./";

boolean planar = true;
boolean do_not_display = false; // for big number of faces

/////////////////////////

PShape s;

PVector mx = new PVector(-1000000, -1000000, -1000000);
PVector mn = new PVector(1000000, 1000000, 1000000);
float midx, midy, scalef;
int datacnt = 0;

String sessionid;

void setup() {
  sessionid = hex((int)random(0xffff), 4);
  size(960, 960, P3D);
  smooth(8);
  shapeMode(CORNER);

  readObj();
}

void draw() {
  if (!do_not_display) {
    background(3, 22, 52);

    lights();
    ambient(205, 179, 128);
    shininess(5.0);

    camera(width/2, mouseY, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);

    translate(width/2, height/2); 
    scale(scalef);

    rotateY(map(mouseX, 0, width, -PI, PI));
    rotateZ(PI);

    shape(s, -midx, -midy);
  }
}

int fn_iter = 0;
void keyPressed() {
  // SPACE to save
  if (keyCode == 32) {
    String fn = foldername + filename + "/res_" + sessionid + nf(fn_iter++, 4) +"_"+filename;
    save(fn+fileext);
    saveObj(fn+".obj");
    println("Image "+ fn +fileext+ " saved");
    println("Obj " + fn + ".obj saved");
  }

  if (key == 'o') {
    readObj();
  }

  if (key == 'r') {
    readRaw();
  }
}

void saveObj(String fn) {
  PrintWriter out = createWriter(fn);
  ArrayList<String> faces = new ArrayList<String>();

  out.println("# Obj->Raw converter, export by GenerateMe");
  out.println("# original object: " + filename + ".obj");
  out.println("# https://github.com/tsulej/GenerateMe/tree/master/Obj2Raw");
  out.println("# http://generateme.tumblr.com");

  out.println("");
  int iter = 1;
  for (int p = 0; p<s.getChildCount (); p++) {
    PShape sh = s.getChild(p);
    String f = "f ";
    for (int v=0; v<sh.getVertexCount (); v++) {
      PVector vec = sh.getVertex(v);
      out.println("v " + vec.x + " " + vec.y + " " + vec.z);
      f += iter + " ";
      iter++;
    }
    faces.add(f);
  }

  out.println("");
  out.println("# faces");

  for (String s : faces) {
    out.println(s);
  }

  out.flush();
  out.close();
}

void readRaw() {
  String fn = foldername + filename + "/" + filename + "_res.raw";

  try {
    byte[] buf = loadBytes(fn);

    int counter = 0;
    int off = datacnt/3;
    for (int p = 0; p<s.getChildCount (); p++) {
      PShape sh = s.getChild(p);
      for (int v=0; v<sh.getVertexCount (); v++) {
        byte xx, yy, zz;
        if (planar) {
          xx = buf[counter];
          yy = buf[off+counter];
          zz = buf[off+off+counter];
          counter++;
        } else {
          xx = buf[counter++];
          yy = buf[counter++];
          zz = buf[counter++];
        }

        PVector vec = new PVector(
        map(xx, -120, 120, mn.x, mx.x), 
        map(yy, -120, 120, mn.y, mx.y), 
        map(zz, -120, 120, mn.z, mx.z));

        sh.setVertex(v, vec);
      }
    }

    recalculate();

    println("Raw file " + fn + " loaded");
  } 
  catch(Exception e) {
    println("ERROR: can't find file: " + fn);
  }
}

void saveRaw() {
  String fn = foldername + filename + "/" + filename + ".raw";

  byte[] buf = new byte[datacnt];

  int off = datacnt/3;
  int counter = 0;
  for (int p = 0; p<s.getChildCount (); p++) {
    PShape sh = s.getChild(p);
    for (int v=0; v<sh.getVertexCount (); v++) {

      PVector vec = sh.getVertex(v);
      byte xx = (byte)((int)map(vec.x, mn.x, mx.x, -120, 120));
      byte yy = (byte)((int)map(vec.y, mn.y, mx.y, -120, 120));
      byte zz = (byte)((int)map(vec.z, mn.z, mx.z, -120, 120));

      if (planar) {
        buf[counter] = xx;
        buf[off+counter] = yy;
        buf[off+off+counter] = zz;
        counter++;
      } else {
        buf[counter++] = xx;
        buf[counter++] = yy;
        buf[counter++] = zz;
      }
    }
  }

  saveBytes(fn, buf);

  println("Raw file " + fn + " saved");
}

// read native Obj and save to RAW
void readObj() {  
  println("Loading obj");
  s = loadShape(foldername + filename + ".obj");
  s.disableStyle();

  recalculate();

  println("Obj file " + foldername + filename + ".obj" + " loaded");
  saveRaw();

  println("");
}

void recalculate() {
  // normalize data
  datacnt = 0;
  println("Number of faces: " + s.getChildCount());
  for (int p = 0; p<s.getChildCount (); p++) {
    PShape sh = s.getChild(p);
    for (int v=0; v<sh.getVertexCount (); v++) {
      PVector vec = sh.getVertex(v);
      if (vec.x > mx.x) mx.x = vec.x;
      if (vec.x < mn.x) mn.x = vec.x;
      if (vec.y > mx.y) mx.y = vec.y;
      if (vec.y < mn.y) mn.y = vec.y;
      if (vec.z > mx.z) mx.z = vec.z;
      if (vec.z < mn.z) mn.z = vec.z;
      datacnt+=3;
    }
  }

  println("x = (" + mn.x + ", " + mx.x + ")");
  println("y = (" + mn.y + ", " + mx.y + ")");
  println("z = (" + mn.z + ", " + mx.z + ")");

  midy = mn.y+(mx.y-mn.y)*0.5;
  midx = mn.x+(mx.x-mn.x)*0.5;
  scalef = min(width, height) / (max( (mx.x-mn.x), (mx.y-mn.y))*1.5);

  println("scale factor (display): " + scalef);
  println("bytes: " + datacnt);
}

