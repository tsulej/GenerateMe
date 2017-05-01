// Granular resynthesis
// Recreate target file using samples from source files
// generateme @ 2017

// Prepare source files as RAW (audio/images etc. any type) and set filenames
String[] sources = { 
  "test_img.raw", "test_wav.raw"
};
// Prepare target file and set filename below
String target_fn = "test_wav.raw";
// Save to filename
String save_to = "result.raw";
// Number of grains (10-10000), give low number for SELF to get more glitch
final static int gnum = 10;
// Size of grain in bytes (100-10000)
final static int gsize = 3000;
// How far search for grains (only for SELF) in number of grain sizes
final static int gspread = 25;
// How to gather grains:
// - SELF - use target as a source and take grains from neighborhood
// - ALL - use all files as sources
int type = SELF;

// do not touch below

// list of types
final static int SELF = 0;
final static int ALL = 1;

void setup() {
  byte[] target = loadBytes(target_fn);
  ArrayList source = new ArrayList();

  if (type == ALL) {
    for (String s : sources) {
      source.add( loadBytes(s) );
    }
  }

  byte[] result = new byte[target.length];

  for (int i=0; i<target.length/gsize; i++) {
    int pos = i*gsize;
    println( (int)(100*(pos / (float)target.length)) + "%");

    int currmatch = -1;
    byte[] currsource = null;
    long currval = Long.MAX_VALUE;

    for (int g=0; g<gnum; g++) {
      long val = 0;
      byte[] mysource;
      int pos2;
      if (type == SELF) {
        mysource = target;
        pos2 = constrain((int)((random(1)<0.5?1:-1)*random(gsize, gsize*gspread)+pos), 0, mysource.length-gsize-1);
      } else {
        mysource = (byte[])source.get( (int)random(source.size()) );
        pos2 = (int)random(mysource.length-gsize-1);
      }

      for (int p=0; p<gsize; p++) {
        val += sq( target[pos+p]-mysource[pos2+p] );
      }  
      val = (long)Math.sqrt((double)val);

      if (val<currval) {
        currmatch = pos2;
        currsource = mysource;
        currval = val;
      }
    }

    arrayCopy( currsource, currmatch, result, pos, gsize);
  }

  saveBytes(save_to, result);
  println("done");
  exit();
}

