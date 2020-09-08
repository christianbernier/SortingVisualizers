int bars = 5;
int[] arr = new int[bars];
int[] hlVals;
int bWidth;
boolean done = false;

String currSort = "Bogo Sort";
int comp = 0;
int acc = 0;

PFont mono;

//SELECTION
int low, lowI, i, at;

void setup() {
  frameRate(10);
  size(1000, 600);
  mono = createFont("Monospaced-14.vlw", 14);
  hlVals = new int[bars];
  for (int i = 0; i < hlVals.length; i++) {
    hlVals[i] = -1;
  }
  for (int i = 0; i < bars; i++) {
    //arr[i] = (int) random(0, height);
    arr[i] = (i + 1) * (height / bars);
  }
  randomize(arr);
  bWidth = (int) width / bars;


  drawBars(hlVals);
}

void draw() {
  //BOGO
  randomize(arr);
  drawBars(hlVals);
  if(sorted(arr)){
    allHighlight();
    noLoop();
  }
}

boolean sorted(int[] arr){
  boolean sorted = true;
  for(int i = 0; i < arr.length - 1; i++){
    if(!(arr[i] < arr[i + 1])){
      sorted = false;
    }
  }
  return sorted;
}

void allHighlight(){
  for(int i = 0; i < bars; i++){
    hlVals[i] = i;
  }
  drawBars(hlVals);
}

void swap(int a, int b) {
  resetHLs();
  hlVals[a] = a;
  hlVals[b] = b;
  drawBars(hlVals);
  int temp = arr[a];
  arr[a] = arr[b];
  arr[b] = temp;
  acc+=3;
}

void resetHLs() {
  for (int i = 0; i < hlVals.length; i++) {
    hlVals[i] = -1;
  }
}

void drawBars(int[] highlight) {
  stroke(0);
  background(51);
  for (int i = 0; i < bars; i++) {
    boolean hl = false;
    for (int e : highlight) {
      if (e == i) {
        hl = true;
      }
    }
    if (hl) {
      fill(0, 255, 0);
    } else {
      fill(255);
    }
    rect(i * bWidth, height - arr[i], bWidth, arr[i]);
  }
  drawStats();
}

void randomize(int[] a) {
  for (int i=0; i<a.length; i++) {
    int randomPosition = (int) random(a.length);
    int temp = a[i];
    a[i] = a[randomPosition];
    a[randomPosition] = temp;
  }
}

void drawStats() {
  fill(0, 0, 0, 70);
  noStroke();
  //rect(0, 0, 400, 30);
  rect(0, 0, 400, 30);
  fill(255);
  textFont(mono);
  //text(currSort + " - " + comp + " comparisons, " + acc + " array accesses", 10, 20);
  text(currSort + " - " + bars + " elements, frame rate: " + (float)((int)(frameRate * 100))/100 + " fps", 10, 20);
}
