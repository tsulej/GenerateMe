import java.util.concurrent.*;

ExecutorService executor = Executors.newCachedThreadPool();

class CalculatePart implements Callable<Boolean> {
  int minx, maxx, miny, maxy, nth;
  int[][] source, target;
  int[] tmp;

  public CalculatePart(int[][] source, int[][] target, int minx, int maxx, int miny, int maxy, int nth) {
    this.minx = minx;
    this.maxx = maxx;
    this.miny = miny;
    this.maxy = maxy;
    this.source = source;
    this.target = target;
    this.nth = nth;
    tmp = new int[9];
  }

  void SWAP(int a, int b) {
    if (tmp[a]>tmp[b]) {
      int t = tmp[a];
      tmp[a]=tmp[b];
      tmp[b]=t;
    }
  }

   void sort() {
    SWAP(0, 1);
    SWAP(3, 4);
    SWAP(6, 7);
    SWAP(1, 2);
    SWAP(4, 5);
    SWAP(7, 8);
    SWAP(0, 1);
    SWAP(3, 4);
    SWAP(6, 7);
    SWAP(0, 3);
    SWAP(3, 6);
    SWAP(0, 3);
    SWAP(1, 4);
    SWAP(4, 7);
    SWAP(1, 4);
    SWAP(2, 5);
    SWAP(5, 8);
    SWAP(2, 5);
    SWAP(1, 3);
    SWAP(5, 7);
    SWAP(2, 6);
    SWAP(4, 6);
    SWAP(2, 4);
    SWAP(2, 3);
    SWAP(5, 6);
  }

  public Boolean call() {
    for (int x=minx; x<maxx; x++) {
      for (int y=miny; y<maxy; y++) {
        tmp[0] = source[x-1][y-1];
        tmp[1] = source[x][y-1];
        tmp[2] = source[x+1][y-1];

        tmp[3] = source[x-1][y];
        tmp[4] = source[x][y];
        tmp[5] = source[x+1][y];

        tmp[6] = source[x-1][y+1];
        tmp[7] = source[x][y+1];
        tmp[8] = source[x+1][y+1];

        sort();
        target[x][y] = tmp[nth];
      }
    }

    return true;
  }
}

void run_and_wait(int[][] source, int[][] target, int nth) throws InterruptedException,ExecutionException {
  int cores = (int)(1.5*Runtime.getRuntime().availableProcessors());
  int range = img.width/cores;
  
  Future<Boolean>[] futures = new Future[cores+1];
  
  int i=1;
  int iter=0;
  while((i+range)<(img.width-1)) {
    futures[iter] = executor.submit(new CalculatePart(source, target, i, i+range,1,img.height-1,nth));
    i+=range;
    iter++;
  }
  
  if(i<img.width-1) {
    futures[iter] = executor.submit(new CalculatePart(source, target, i, img.width-1,1,img.height-1,nth));
  }
   
  for(Future f : futures) {
    if(f != null) {
      f.get();
    }
  } 
}
