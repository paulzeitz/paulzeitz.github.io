boolean listening = false;
boolean vOn = false; //show vel or not
boolean aOn = false; //show accel or not
float t = 0;
float dt = 0.01;
float tick = 0.1; //tick size
int windowSize=500;//
int endIndex =windowSize;
int k =0 ; //index for points
int u = 10; // index sep for velocity
int av =5; //index average for smoothing: instead of plotting a value, you look at the past 5, say, values, and average them
float velocity_scale = .5; //change velocity vertical scale so it doesnt blow up
float accel_scale = .1; //change velocity vertical scale so it doesnt blow up
int nsteps=500;
int mouseXmin=200;
int mouseXmax=900;
int h=600;
int w =1000;
int xmag = 100;
int ymag = 40;
int xScreenCenter = 200;
int yScreenCenter = 300;

float xmin = -1;
float xmax = 6;
float xstart = 1;
float ycontrol =-5;
float[] tpoints  = new float[1];//storing positions
float[] xpoints = new float[1]; //storing positions
float[] vpoints = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}; //storing positions
float[] apoints = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}; //storing positions


void setup() {
  size(1000, 600);
  background(100);
  textSize(24);
  tpoints[0]=0;
  xpoints[0]=0;
}

void draw() {

  background(220);
  stroke(0);
  text("Hit spacebar to record and hit v, a to toggle velocity, acceleration", 100, 20);
  //draw control line for x-position
  line(myX(xmin), myY(ycontrol), myX(xmax), myY(ycontrol));
  for (float x=xmin; x<=xmax; x=x+1) {
    line(myX(x), myY(ycontrol-tick), myX(x), myY(ycontrol+tick));
  }

  //draw x-axis line for y=0
  line(myX(xmin), myY(0), myX(xmax), myY(0));
  text("t", myX(xmax+tick), myY(0));
  //draw y-axis
  line(myX(0), myY(-3), myX(0), myY(xmax));
  text("x, v, a", myX(-1), myY(xmax*.7));
  //draw ticks
  for (int y=-3; y<=xmax; y++) {
    line(myX(-tick), myY(y), myX(tick), myY(y));
  }

  text("time  "+ nf(t, 0, 3), 200, 550);

  //draw all points so far

  int offset =0;
  endIndex = tpoints.length;
  if (endIndex>windowSize) { 

    offset = endIndex-windowSize;
  }
  fill(0);
  text("vel  "+ nf(vpoints[k], 0, 3), 550, 550);
  fill(#00FF00,30);

  rect(680,525,150,35);
  fill(0);
  text("accel  "+ nf(apoints[k], 0, 3), 700, 550);

  for (int i = offset+1; i < endIndex; i++) {
    fill(#FF0000);
    stroke(#FF0000);
    circle(myX(tpoints[i-offset]), myY(average(3,i,xpoints)), 4);
    //fill(#00FF00);
    if (vOn) {//only draw velocity if v is toggled
      stroke(0);
      //line(myX(tpoints[i-offset-1]), myY(vpoints[i-1]), myX(tpoints[i-offset]), myY(vpoints[i]));
      circle(myX(tpoints[i-offset]), myY(average(5,i,vpoints)), 2);
    }
    if (aOn) {//only draw accel if a is toggled
      stroke(#00FF00);
      //line(myX(tpoints[i-offset-1]), myY(apoints[i-1]), myX(tpoints[i-offset]), myY(apoints[i]));
      circle(myX(tpoints[i-offset]), myY(average(8,i,apoints)), 4);
    }
  }

  //get mousex; draw slider object
  float xm = smX(mouseX);
  //only draw if mouse is within picture
  if (xm < xmin) {
    xm = xmin;
  }
  if (xm > xmax) {
    xm =xmax;
  }

  //report x value

  fill(#FF0000);
  text("x  "+ nf(xm, 0, 3), 400, 550);

  fill(#0000FF);
  circle(myX(xm), myY(ycontrol), 10);

  if (listening) {

    tpoints = append(tpoints, t);
    xpoints = append(xpoints, xm);
    k += 1;
    if (k> u) {

      vpoints = append(vpoints, velocity_scale*(xm-xpoints[k-u])/(u*dt));
      apoints = append(apoints, accel_scale*(vpoints[k]-vpoints[k-u])/(u*dt));
    }
    t += dt;
  }
}

float smX(float x) {//screen coords to math
  return (x-xScreenCenter)/xmag;
}

float smY(float y) {//screen coords to math
  return (yScreenCenter-y)/ymag;
}
float myX(float x) {//math to screen coords
  return xScreenCenter+xmag*x;
}

float myY(float y) {//math to screen
  return yScreenCenter-ymag*y;
}

void keyPressed() {
  if (key == ' ') {
    listening = !listening;
  }
  if (key == 'v') {
    vOn = !vOn;
  }
  if (key == 'a') {
    aOn = !aOn;
  }
}

float average(int av, int index, float[]x){
  float sum =0;
  int lookback = min(index, av);
  for (int i=index-lookback; i<index; i ++){
    sum += x[i];
  }
  return sum/lookback;
}
