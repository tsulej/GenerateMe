// Ultimate Sort Machine
// Tomasz Sulej, generateme.blog@gmail.com, http://generateme.tumblr.com
// Licence: http://unlicense.org/

// Usage:
//   * press SPACE to save
//   * press 'a' to save animation frames
//   * press 'b' for batch process files from set folder

// Read ALL (I repeat ALL) text below until written "STOP READING HERE" :)

// This is quite complicated machine for sort images in many various ways.
// I'll try to explain how to use it and what all this stuff means.
//
// Here is the idea:
// 1. You select pixels which are involved in sorting. Selection is made using few rules and logical operators.
//    You can think about this as more sophisticated threshold. Remember only chosen pixels are involved in sorting.
//    That means that any gaps between pixels are left untouched.
// 2. You can define "select and sort" process as many times as you want
// 3. You can sort pixels partly. That means you can interrupt sorting in defined moment.
//    It's very crutial, every sorting method has its own patterns and you can achieve various results
// 4. You can sort in ascending/descending order
// 5. You can sort negated pixels
// 6. You can "lay down" result in 4 direction: from left to right, from top to bottom and opposite. It is different than sorting order (and can be combined)
// 7. Having above 3 possibilities you can achive 16 possible way to produce result using one single sorting algorithm.
// 8. Finally, you can use many different sorting algorithms (+3 extra bonus nonsorting methods :))

// Ok, that was idea and now let's go through configuration

// First, set up filename you want to operate, remember when you see the result you can save it by pressing SPACE
String filename = "test";
String fileext = ".jpg";
String foldername = "./"; // folder used for batch process also

// Second, set up window size (image size can be huge, this parameter will help you to see it)
int max_display_size = 800;

// Third, you can choose to blend result with original image
boolean do_blend = false;
int blend_mode = OVERLAY; // blend type

// Here are all blend modes available
final static int[] blends = {
  ADD, SUBTRACT, DARKEST, LIGHTEST, DIFFERENCE, EXCLUSION, MULTIPLY, SCREEN, OVERLAY, HARD_LIGHT, SOFT_LIGHT, DODGE, BURN
};

// If you want to animate process, set number of frames you want to save
int animation_frames_count = 60;
int animation_easing = LINEAR; // LINEAR or CUBIC

// We are near to the crucial part, configuration of sorting machine
// But first look at block below, you need to remember one thing here: name of the variable ie. HUE_RED, HUE_CYAN_W, etc...
// See, there is also name 'TRUE'
// It will be explained later, skip now

IEval HUE_RED_W = OR(RANGE(HUE, hs(0), hs(20)), RANGE(HUE, hs(346), hs(359)));
IEval HUE_RED = OR(RANGE(HUE, hs(0), hs(10)), RANGE(HUE, hs(355), hs(359)));
IEval HUE_ORANGE_W = RANGE(HUE, hs(11), hs(50));
IEval HUE_ORANGE = RANGE(HUE, hs(21), hs(40));
IEval HUE_YELLOW_W = RANGE(HUE, hs(41), hs(80));
IEval HUE_YELLOW = RANGE(HUE, hs(51), hs(60));
IEval HUE_GREEN_W = RANGE(HUE, hs(61), hs(169));
IEval HUE_GREEN = RANGE(HUE, hs(81), hs(140));
IEval HUE_CYAN_W = RANGE(HUE, hs(141), hs(220));
IEval HUE_CYAN = RANGE(HUE, hs(170), hs(200));
IEval HUE_BLUE_W = RANGE(HUE, hs(201), hs(280));
IEval HUE_BLUE = RANGE(HUE, hs(221), hs(240));
IEval HUE_MAGENTA_W = RANGE(HUE, hs(241), hs(330));
IEval HUE_MAGENTA = RANGE(HUE, hs(281), hs(320));
IEval HUE_PINK_W = RANGE(HUE, hs(321), hs(355));
IEval HUE_PINK = RANGE(HUE, hs(331), hs(345));
IEval TRUE = new C_TRUE();

// HERE IT IS, machine configuration, every single step (select and sort process) begins with name RECIPE.
// rules (recipes) are separated by comma
// Find example configuration below. It means exactly this: make 2 steps where in
//   Step 1: Sort only RED pixels using HEAPSORT algorithm and stop sorting when you get 5% better sort than at beginning, lay down pixels from left to right, sort negated pixels in ascending order
//   Step 2: Sort only pixels which are not RED using QUICKSORT, interrupt when you get 20% improvement, sort in descent order, lay down pixels bottom to top
// Run script now and see result.

Configurator[] recipes = { // do not touch this line...
  RECIPE(QUICK, 0.5, DEFAULT, RIGHT, HUE_RED_W), // comma!
  RECIPE(MERGE, 0.95, DEFAULT, BOTTOM, NOT(HUE_RED_W)) // last rule do not have comma
}; // ...neither this

  //another example below
  //Configurator[] recipes = { // do not touch this line...
  //  RECIPE(PERMUTE, 0.523635, ABSOLUTE | DESC, RIGHT, OR(HUE_RED,HUE_PINK_W)), // comma!
  //  RECIPE(SHELL, 0.01523635, DESC, BOTTOM, OR(HUE_RED,HUE_PINK_W)), // comma!
  //  RECIPE(HEAP, 0.008751599, DEFAULT | DESC, TOP, NOT(OR(HUE_RED,HUE_PINK_W)))
  //  }; // ...neither this

  // If you want to add/replace your rules for your step, you need to construct your own RECIPE line. You have to define 5 things:
  // 1. Set sort algorithm (full list below, look for "SORTING ALGORITHMS" line)
  // 2. Set amount of sort. This is a number between 0 (no sort) and 1 (full sort). You can have two meanings of this parameter:
  //    a) in RELATIVE mode it means how much sort improvement you want to achive. Eg. 0.123 value means that you get 12,3% more sorted pixels than at beginning.
  //    b) in ABSOLUTE mode it means how much sort you want to have regardless of current value. Eg. 0.75 means that sort stops after 75% of pixels will be sorted.
  //       one note here, pixels taken from image are usually partly sorted (let's say it's 50% moreless), some algorithms can lower this value, some only improves, you need to experiment
  // 3. Set some specific flags. Flags can be combined together using "|" delimiter (obligatory)
  //    a) DEFAULT - ascending sort with relative amount
  //    b) RELATIVE (default) or ABSOLUTE - described in point 2
  //    c) ASC (default) or DESC - ascending or descending sort
  //    d) POSITIVE (default) or NEGATIVE - work on image as it is or negate pixels
  // 4. Set sort direction: RIGHT (to right), LEFT (to left), TOP (to top), BOTTOM (to bottom)
  // 5. Threshold rule. This is hardest stuff. Rule has a grammar and it's as follows
  //    a) Remember now block above with variable names starting HUE_... and TRUE at the end. These are predefined rules for you.
  //       HUE_color means: choose pixels with particular color. There are two modes: normal range and wide range.
  //       Eg. HUE_MAGENTA is normale range and chooses magenta pixels (hue range between 281 and 320) but
  //           HUE_MAGENTA_W is wider version of magenta with pink and blue touch (hue range between 241 and 330).
  //           All ranges are described under following link: http://www.workwithcolor.com/color-names-01.htm
  //       TRUE means - sort me whole line, no treshold!
  //    b) you can define your own range on any possible channel, syntax is:
  //       RANGE( channel, minimum value, maximum value)
  //         - list of all possible channels is below (look for "CHANNELS" line)
  //         - minimum and maximum value can have 3 options:
  //           Option a: integer number between 0 and 255, typical channels value.
  //           Option b: float number between 0 and 0.99999999 (normalized form)
  //           Option c: uniform random value between specified range in form RAND(from, to)
  //        Example 1: RANGE(BRIGHTNESS,0,100) - choose pixels with brighntess value between 0 and 100. Only dark pixel.
  //        Example 2: RANGE(RED, 0.5, 0.8) - choose pixels with red channel value between 50% and 80%
  //        Example 3: RANGE(ALPHA, RAND(0,0.1), 0.5) - choose pixel with alpha value between random value (from 0 to 10%) and 50%
  //    c) you can make nagation of every rule using NOT(your rule here)
  //        Example 1: NOT(HUE_PINK) - choose not pink pixels
  //        Example 2: NOT( RANGE(SATURATION, 50,100) ) - choose pixels with saturation between 0-49 and 101-255.
  //    d) you can use logical operator AND and OR.
  //       - AND(first rule, second rule) - first and second rule must be valid for choosen pixel
  //       - OR(first rule, second rule) - first or second rule (or both) must be valid
  //       Example 1: AND( NOT(HUE_RED), RANGE(BRIGHTNESS,0,50) ) - choose pixels which are not red and are dark (brightness between 0 and 50
  //       Example 2: OR( HUE_GREEN_W, AND( NOT(HUE_RED), RANGE(BRIGHTNESS,0,50) ) ) - choose pixels which are green (wide range) or are as described above (dark, not red)
  //    NOTE: you can build threshold as complicated as you want

  // now names you will use

  // FLAGS (described in point 2 above)
  final static int DEFAULT = 0;
final static int ABSOLUTE = 1;
final static int RELATIVE = 0;
final static int ASC = 0;
final static int DESC = 2;
final static int POSITIVE = 0;
final static int NEGATE = 4;

// SORTING ALGORITHMS
final static int BUBBLE = 0;
final static int INSERTION = 1;
final static int SELECTION = 2;
final static int HEAP = 3; // kind of echo, http://generateme.tumblr.com/post/121956583990/splice
final static int SHELL = 4;
final static int MERGE = 5; // nice blocky patterns, http://generateme.tumblr.com/post/121920710155/unmerged-sculpture-based-on-work-by-stefanie
final static int QUICK = 6; // nice mess pattern
final static int SMOOTH = 7; // lines
// bonus, not sort methods
final static int PERMUTE = 8; // pixels are just randomized, amount is not used
final static int ONECOLOR = 9; // set pixels to one color, amount means which color use (0 first pixel, 1 last pixel, 0.5 middle pixel, etc)
final static int ROLL = 10; // roll pixels left, amount means how much to roll (0.5 - halfway)
final static int ONECOLORB = 11; // as one color but made in blocks (based on noise), amount means scale factor for noise function
// more algorithms to come: coctail, gnome, comb, oddeven, maybe more...

// CHANNELS
// ALL Channels, Nxxx stand for negative (255-value)
final static int RED = 0;
final static int GREEN = 1;
final static int BLUE = 2;
final static int HUE = 3;
final static int SATURATION = 4;
final static int BRIGHTNESS = 5;
final static int ALPHA = 6;
final static int NRED = 7;
final static int NGREEN = 8;
final static int NBLUE = 9;
final static int NHUE = 10;
final static int NSATURATION = 11;
final static int NBRIGHTNESS = 12;
final static int NALPHA = 13;

// EASING in animations
final static int LINEAR = 0;
final static int CUBIC = 1;

// if you press 'b' every frame following code will be called, put here anything you want
void batchCallback(float step) {
// recipes[0].amount = map(sin(step*TWO_PI),-1,1,0.2,0.8);
}

// YOU ARE READY TO USE, EXPERIMENT, EXPLORE, DON'T GIVE UP, ENJOY
// STOP READING HERE

int sortType = HEAP; // sort method, list below
float sortAmount = 0.01; // percent of sort to achive
boolean relativeThr = true; // is above relative to current value or absolute
boolean reverseSort = false; // reverse sort order
boolean negateColors = false;
int direction = LEFT;

IEval eval;

color[] bufw;
color[] bufh;
int[] posx;
int[] posy;

// working buffer
PGraphics buffer;

// image
PImage img;
PImage orig;

String sessionid;

void setup() {
  sessionid = hex((int)random(0xffff), 4);
  img = loadImage(foldername+filename+fileext);
  orig = img.get();

  buffer = createGraphics(img.width, img.height);
  buffer.beginDraw();
  buffer.noStroke();
  buffer.smooth(8);
  buffer.background(0);
  buffer.image(img, 0, 0);
  buffer.endDraw();

  // calculate window size
  float ratio = (float)img.width/(float)img.height;
  int neww, newh;
  if (ratio < 1.0) {
    neww = (int)(max_display_size * ratio);
    newh = max_display_size;
  } else {
    neww = max_display_size;
    newh = (int)(max_display_size / ratio);
  }

  surface.setSize(neww, newh);

  bufw = new color[img.width];
  bufh = new color[img.height];
  posx = new int[img.width];
  posy = new int[img.height];


  processImage();
}

float anim_step = 0;
boolean animate = false;
String anim_hash = "1234";
int anim_cnt = 1000;

void draw() {
  if (animate) {
    buffer.image(orig, 0, 0);
    img = orig.get();
    for (int i=0; i<recipes.length; i++) {
      Configurator c = recipes[i];
      c.amount = animation_easing == LINEAR ? anim_step : sq(anim_step);
    }
    anim_step += 1.0/animation_frames_count;
    println(anim_step);
    processImage();
    saveFrame(foldername + filename + "/anim"+sessionid+anim_hash+"/frame" + anim_cnt +fileext);
    anim_cnt++;
    if(anim_step>1.0) animate = false;
  }
  if(doBatch) {
    batchStep();
  }
}

void processImage() {
  for (int i=0; i<recipes.length; i++) {
    Configurator c = recipes[i];
    sortType = c.sort;
    sortAmount = c.amount;
    eval = c.evaluator;
    direction = c.direction;

    if ( (c.flags & ABSOLUTE) > 0)
      relativeThr = false;
    else
      relativeThr = true;

    if ( (c.flags & DESC) > 0)
      reverseSort = true;
    else
      reverseSort = false;

    if ( (c.flags & NEGATE) > 0)
      negateColors = true;
    else
      negateColors = false;

    println("Sorting, pass: " + (i+1));

    buffer.beginDraw();

    if (direction == LEFT || direction == RIGHT)
      sortH();
    else
      sortV();

    buffer.endDraw();
    img = buffer.get(0, 0, img.width, img.height);
  }


  buffer.beginDraw();

  if (do_blend)
    buffer.blend(orig, 0, 0, img.width, img.height, 0, 0, buffer.width, buffer.height, blend_mode);

  buffer.endDraw();
  image(buffer, 0, 0, width, height);
}

void keyPressed() {
  // SPACE to save
  if (keyCode == 32) {
    String fn = foldername + filename + "/res_" + sessionid + hex((int)random(0xffff), 4)+"_"+filename+fileext;
    buffer.save(fn);
    println("Image "+ fn + " saved");
  }
  if(key == 'a') {
    anim_hash = hex((int)random(0xffff), 4);
    anim_step = 0;
    animate = true;
    anim_cnt = 1000;
  }
  if(key == 'b' && !doBatch) {
    batchProcess();
  }
}

//

void sortH() {
  for (int y=0; y<img.height; y++) {
    int s = 0;
    for (int x=0; x<img.width; x++) {
      currentColor = img.get(x, y);
      if ( eval.eval() ) {
        posx[s] = x;
        bufw[s] = currentColor;
        s++;
      }
    }
    if (reverseSort | negateColors) reverseTab(bufw, s);

    if (relativeThr) {
      float thr = sortRatio(bufw, s);
      thr+=(1.0-thr)*sortAmount;
      sortMe(bufw, s, thr);
    } else {
      sortMe(bufw, s, sortAmount);
    }
    if (reverseSort | negateColors) reverseTab(bufw, s);


    for (int i=0; i<s; i++) {
      int ii = direction == RIGHT ? i : s-1-i;
      buffer.set(posx[ii], y, bufw[i]);
    }
  }
}

void sortV() {
  for (int x=0; x<img.width; x++) {
    int s = 0;
    for (int y=0; y<img.height; y++) {
      currentColor = img.get(x, y);
      if ( eval.eval() ) {
        posy[s] = y;
        bufh[s] = currentColor;
        s++;
      }
    }
    if (reverseSort | negateColors) reverseTab(bufh, s);
    if (relativeThr) {
      float thr = sortRatio(bufh, s);
      thr+=(1.0-thr)*sortAmount;
      sortMe(bufh, s, thr);
    } else sortMe(bufh, s, sortAmount);
    if (reverseSort | negateColors) reverseTab(bufh, s);

    for (int i=0; i<s; i++) {
      int ii = direction == BOTTOM ? i : s-1-i;
      buffer.set(x, posy[ii], bufh[i]);
    }
  }
}

void reverseTab(color[] t, int cnt) {
  for (int i=0; i<cnt; i++) {
    if (reverseSort) t[i] *= -1;
    if (negateColors) t[i] = ~t[i];
  }
}

void sortMe(color[] t, int cnt, float thr) {
  switch(sortType) {
  case BUBBLE:
    bubbleSort(t, cnt, thr);
    break;
  case INSERTION:
    insertionSort(t, cnt, thr);
    break;
  case SELECTION:
    selectionSort(t, cnt, thr);
    break;
  case HEAP:
    heapSort(t, cnt, thr);
    break;
  case SHELL:
    shellSort(t, cnt, thr);
    break;
  case MERGE:
    mergeSort(t, cnt, thr);
    break;
  case QUICK:
    quickSort(t, cnt, thr);
    break;
  case SMOOTH:
    smoothSort(t, cnt, thr);
    break;
  case PERMUTE:
    permute(t, cnt, thr);
    break;
  case ONECOLOR:
    onecolor(t, cnt, thr);
    break;
  case ROLL:
    roll(t, cnt, thr);
    break;
  case ONECOLORB:
    onecolorb(t, cnt, thr);
    break;
  default:
    bubbleSort(t, cnt, thr);
  }
}

void roll(color[] t, int cnt, float thr) {
  if (cnt>2) {
    int i = (int)map(thr, 0, 1, 2, cnt-2);
    color[] tmp = new int[cnt-i];
    arrayCopy(t, i, tmp, 0, cnt-i);
    arrayCopy(t, 0, t, cnt-i-1, i);
    arrayCopy(tmp, 0, t, 0, cnt-i);
  }
}

void permute(color[] t, int cnt, float thr) {
  for (int i=1; i<cnt; i++) {
    int r = (int)random(i, cnt);
    swap(t, r, i-1);
  }
}

void onecolorb(color[] t, int cnt, float thr) {
  float np = 0;
  boolean nv = noise(np, 0.5) > 0.5;
  color c = t[0];
  for (int i=0; i<cnt-1; i++) {
    t[i] = c;
    boolean cv = noise(np, 0.5) > 0.5;
    if ( nv != cv ) {
      nv = cv;
      c = t[i+1];
    }
    np += thr;
  }
}

void onecolor(color[] t, int cnt, float thr) {
  int i = (int)constrain(map(thr, 0, 1, 0, cnt-1), 0, cnt-1);
  color c = t[i];
  for (i=0; i<cnt; i++) t[i] = c;
}

// https://kenai.com/projects/java-lab/sources/java-svn/content/Sorting/src/sorting/algorithms/selection/SmoothSort.java

final static int LP[] = {
  1, 1, 3, 5, 9, 15, 25, 41, 67, 109,
  177, 287, 465, 753, 1219, 1973, 3193, 5167, 8361, 13529, 21891,
  35421, 57313, 92735, 150049, 242785, 392835, 635621, 1028457,
  1664079, 2692537, 4356617, 7049155, 11405773, 18454929, 29860703,
  48315633, 78176337, 126491971, 204668309, 331160281, 535828591,
  866988873
};

void smoothSort(color[] t, int lo, int hi, int cnt, float thr) {
  int head = lo;

  int p = 1;
  int pshift = 1;

  while (head < hi) {
    if ((p & 3) == 3) {
      sift(t, pshift, head, cnt, thr);
      p >>>= 2;
      pshift += 2;
    } else {
      if (LP[pshift - 1] >= hi - head) {
        trinkle(t, p, pshift, head, false, cnt, thr);
      } else {
        sift(t, pshift, head, cnt, thr);
      }

      if (pshift==1) {
        p <<= 1;
        pshift--;
      } else {
        p <<= (pshift - 1);
        pshift = 1;
      }
    }
    p |= 1;
    head++;
    if (sortRatio(t, cnt)>=thr) return;
  }

  trinkle(t, p, pshift, head, false, cnt, thr);

  while (pshift != 1 || p != 1) {
    if (pshift<=1) {
      int trail = Integer.numberOfTrailingZeros(p & ~1);
      p >>>= trail;
      pshift += trail;
    } else {
      p <<= 2;
      p ^= 7;
      pshift -= 2;
      trinkle(t, p >>> 1, pshift + 1, head - LP[pshift] - 1, true, cnt, thr);
      if (sortRatio(t, cnt)>=thr) return;
      trinkle(t, p, pshift, head - 1, true, cnt, thr);
      if (sortRatio(t, cnt)>=thr) return;
    }
    head--;
  }
}

void sift(int[] m, int pshift, int head, int cnt, float thr) {
  int val = m[head];

  while (pshift > 1) {
    int rt = head - 1;
    int lf = head - 1 - LP[pshift - 2];

    if (val >= m[lf] && val >= m[rt]) {
      break;
    }
    if (m[lf] >= m[rt]) {
      m[head] = m[lf];
      head = lf;
      pshift -= 1;
    } else {
      m[head] = m[rt];
      head = rt;
      pshift -= 2;
    }
  }
  m[head] = val;
}

private void trinkle(int[] m, int p, int pshift, int head, boolean isTrusty, int cnt, float thr) {
  int val = m[head];

  while (p != 1) {
    int stepson = head - LP[pshift];

    if (m[stepson] <= val) {
      break;
    }
    if (!isTrusty && pshift > 1) {
      int rt = head - 1;
      int lf = head - 1 - LP[pshift - 2];
      if (m[rt] > m[stepson] || m[lf] > m[stepson]) {
        break;
      }
    }

    m[head] = m[stepson];

    head = stepson;
    int trail = Integer.numberOfTrailingZeros(p & ~1);
    p >>>= trail;
    pshift += trail;
    isTrusty = false;
  }

  if (!isTrusty) {
    m[head] = val;
    sift(m, pshift, head, cnt, thr);
  }
}

void smoothSort(color[] t, int cnt, float thr) {
  smoothSort(t, 0, cnt-1, cnt, thr);
}

void quickSort(color[] t, int a, int b, int cnt, float thr) {
  if (a>=b) return;
  if (sortRatio(t, cnt)>=thr) return;
  int pivotidx = a+(b-a)/2;
  color pivot = t[pivotidx];
  swap(t, pivotidx, b);

  int i=a-1;
  int j=b;
  do {
    do {
      i++;
    }
    while (t[i] < pivot);
    do {
      j--;
    }
    while (t[j] > pivot && j>a);
    if (i<j) swap(t, i, j);
  }
  while (i<j);
  swap(t, b, i);
  if (sortRatio(t, cnt)>=thr) return;
  quickSort(t, a, i-1, cnt, thr);
  quickSort(t, i+1, b, cnt, thr);
}

void quickSort(color[] t, int cnt, float thr) {
  quickSort(t, 0, cnt-1, cnt, thr);
}

void topdownMerge(color[] t, color[] b, int ibegin, int imiddle, int iend) {
  int i0=ibegin;
  int i1=imiddle;
  for (int j=ibegin; j<iend; j++) {
    if (i0<imiddle && (i1 >= iend || t[i0] <= t[i1])) {
      b[j] = t[i0];
      i0++;
    } else {
      b[j] = t[i1];
      i1++;
    }
  }
}

void topdownSplitMerge(color[] t, color[] b, int ibegin, int iend, float thr, int cnt) {
  if (iend-ibegin<2) return;
  if (sortRatio(t, cnt)>=thr) return;
  int imiddle = (iend+ibegin)/2;
  topdownSplitMerge(t, b, ibegin, imiddle, thr, cnt);
  topdownSplitMerge(t, b, imiddle, iend, thr, cnt);
  if (sortRatio(t, cnt)>=thr) return;
  topdownMerge(t, b, ibegin, imiddle, iend);
  arrayCopy(b, ibegin, t, ibegin, iend-ibegin);
}

void mergeSort(color[] t, int cnt, float thr) {
  color[] buf = new color[cnt];
  topdownSplitMerge(t, buf, 0, cnt, thr, cnt);
}

final static int[] shell_gaps = {
  701, 301, 132, 57, 23, 10, 4, 1
};

void shellSort(color[] t, int cnt, float thr) {
  for (int g=0; g<shell_gaps.length; g++) {
    int gap = shell_gaps[g];
    for (int i=gap; i<cnt; i++) {
      int tmp = t[i];
      int j=i;
      for (; j>=gap && t[j-gap] > tmp; j-=gap) {
        t[j] = t[j-gap];
      }
      t[j] = tmp;
      if (gap>=10 && sortRatio(t, cnt)>=thr) return;
    }
    if (gap<10 && sortRatio(t, cnt)>=thr) return;
  }
}

void heapify(color[] t, int cnt, float thr) {
  int start = floor((cnt - 2)/2.0);
  while (start>=0) {
    siftDown(t, start, cnt-1);
    start--;
    if (sortRatio(t, cnt)>=thr) return;
  }
}

void siftDown(color[] t, int start, int end) {
  int root = start;
  while ( (root*2+1)<=end) {
    int child = root*2+1;
    int sw = root;
    if (t[sw]<t[child]) sw = child;
    if ( (child+1)<=end && t[sw]<t[child+1]) sw = child + 1;
    if (sw == root) return;
    else {
      swap(t, root, sw);
      root = sw;
    }
  }
}

void heapSort(color[] t, int cnt, float thr) {
  if (sortRatio(t, cnt)>=thr) return;
  heapify(t, cnt, thr);
  int end = cnt - 1;
  while (end>0) {
    swap(t, end, 0);
    end--;
    siftDown(t, 0, end);
    if (sortRatio(t, cnt)>=thr) return;
  }
}

void selectionSort(color[] t, int cnt, float thr) {
  for (int j=0; j<cnt-1; j++) {
    int imin = j;
    for (int i=j+1; i<cnt; i++) {
      if (t[i]<t[imin]) imin = i;
    }
    if (imin != j) swap(t, j, imin);
    if (sortRatio(t, cnt)>=thr) return;
  }
}

void bubbleSort(color[] t, int cnt, float thr) {
  int n = cnt;
  do {
    int newn = 0;
    for (int i=1; i<n; i++) {
      if (t[i-1]>t[i]) {
        swap(t, i-1, i);
        newn = i;
      }
    }
    if (sortRatio(t, cnt)>=thr) return;
    n = newn;
  }
  while (n>0);
}

void insertionSort(color[] t, int cnt, float thr) {
  for (int i=1; i<cnt; i++) {
    color x = t[i];
    int j = i;
    while (j>0 && t[j-1]>x) {
      t[j] = t[j-1];
      j--;
    }
    t[j] = x;
    if (sortRatio(t, cnt)>=thr) return;
  }
}

// helpers

void swap(color[] t, int a, int b) {
  color tmp = t[a];
  t[a] = t[b];
  t[b] = tmp;
}

float sortRatio(color[] t, int cnt) {
  int n = 0;
  for (int i=1; i<cnt; i++) {
    if (t[i-1]<=t[i]) n++;
  }
  return n/(float)(cnt-1);
}


float getChannel(color c, int channel) {
  int ch = channel>6?channel-7:channel;
  float cc;

  switch(ch) {
  case RED:
    cc = red(c);
    break;
  case GREEN:
    cc = green(c);
    break;
  case BLUE:
    cc = blue(c);
    break;
  case HUE:
    cc = hue(c);
    break;
  case SATURATION:
    cc = saturation(c);
    break;
  case ALPHA:
    cc = alpha(c);
    break;
  default:
    cc= brightness(c);
    break;
  }

  return (channel>6?255-cc:cc);
}

// Configurator class
class Configurator {
  int sort;
  float amount;
  int flags;
  int direction;
  IEval evaluator;

  public Configurator(int s, float a, int f, int d, IEval e) {
    sort = s;
    amount = a;
    flags = f;
    direction = d;
    evaluator = e;
  }
}

// HUE ranges
final int hs(float ang) {
  return (int)map(ang, 0, 359, 0, 255);
}

// evaluator part

Configurator RECIPE(int s, float a, int f, int d, IEval e) {
  return new Configurator(s, a, f, d, e);
}

PVector RAND(float a, float b) {
  return new PVector(a, b);
}

IEval RANGE(int ch, float a, float b) {
  return new C_RANGE(ch, a, a, b, b);
}
IEval RANGE(int ch, PVector a, float b) {
  return new C_RANGE(ch, a.x, a.y, b, b);
}
IEval RANGE(int ch, float a, PVector b) {
  return new C_RANGE(ch, a, a, b.x, b.y);
}
IEval RANGE(int ch, PVector a, PVector b) {
  return new C_RANGE(ch, a.x, a.y, b.x, b.y);
}
IEval AND(IEval a, IEval b) {
  return new C_AND(a, b);
}
IEval OR(IEval a, IEval b) {
  return new C_OR(a, b);
}
IEval NOT(IEval a) {
  return new C_NOT(a);
}

color currentColor;

interface IEval {
  public boolean eval();
}

class C_TRUE implements IEval {
  public boolean eval() {
    return true;
  }
}

class C_AND implements IEval {
  IEval a, b;
  public C_AND(IEval aa, IEval bb) {
    a = aa;
    b = bb;
  }
  public boolean eval() {
    return a.eval() && b.eval();
  }
}

class C_OR extends C_AND {
  public C_OR(IEval aa, IEval bb) {
    super(aa, bb);
  }
  public boolean eval() {
    return a.eval() || b.eval();
  }
}

class C_NOT implements IEval {
  IEval a;
  public C_NOT(IEval aa) {
    a = aa;
  }
  public boolean eval() {
    return !a.eval();
  }
}

class C_RANGE implements IEval {
  int channel;
  float a, b;
  boolean ra = false;
  boolean rb = false;
  float a2, b2;
  public C_RANGE(int ch, float aa, float aa2, float bb, float bb2) {
    a = aa < 1.0 ? map(aa, 0, 1, 0, 256) : aa;
    b = bb < 1.0 ? map(bb, 0, 1, 0, 256) : bb;
    if (aa2 > aa) {
      ra = true;
      a2 = aa2 < 1.0 ? map(aa2, 0, 1, 0, 256) : aa2;
    }
    if (bb2 > bb) {
      rb = true;
      b2 = bb2 < 1.0 ? map(bb2, 0, 1, 0, 256) : bb2;
    }
    channel = ch;
  }
  public boolean eval() {
    float v = getChannel(currentColor, channel);
    float newa = ra ? random(a, a2) : a;
    float newb = rb ? random(b, b2) : b;
    return (v >= newa) && (v <= newb);
  }
}

// code for batch processing
void batchStep() {
  File n = batchList[batchIdx];
    String name = n.getAbsolutePath();
    if(name.endsWith(fileext)) {
      print(n.getName()+"... ");
      img = loadImage(name);
      buffer.image(img, 0, 0);
      batchCallback((float)batchIdx / batchFiles);
      processImage();
      save(foldername+batchUID+"/"+n.getName());
      println("saved");
    }
    batchIdx++;
    if(batchIdx >= batchList.length) {
      doBatch = false;
      println("results saved in "+ foldername+batchUID + " folder");
    }
}

File[] batchList;
int batchIdx = 0;
String batchUID;
boolean doBatch = false;
float batchFiles = 0;
void batchProcess() {
  batchUID = sessionid + hex((int)random(0xffff),4);
  File dir = new File(sketchPath()+'/'+foldername);
  batchList = dir.listFiles();
  batchIdx = 0;
  batchFiles = 0;
  for(File n : batchList) {
    if(n.getName().endsWith(fileext)) batchFiles=batchFiles+1.0;
  }
  println("Processing "+int(batchFiles)+" images from folder: " + foldername);
  doBatch = true;
}
