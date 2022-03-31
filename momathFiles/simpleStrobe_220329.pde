

float t = 0;  //starting angle
float theta = PI/6; //start value of "speed"
float dtheta = PI/360;  //one half degree


//these values are for scaling "math" coords to screen coords
int xmag = 50;
int ymag = 50;
int xScreenCenter = 500;
int yScreenCenter = 300;



float r = 6;    //radius
float r2= 1; //small rad
int count = 0;


void setup() {
  size(1000, 600);
  background(100);
  textSize(24);
}

void draw() {

  background(220);

  //draw circle
  stroke(#0000FF);
  fill(#FFFFFF);
  circle (myX(0), myY(0), r*xmag+10);
  fill(#FF0000);
  circle (myX(0), myY(0), 2);
  
  line(myX(0), myY(0), myX(r*cos(t)/2), myY(r*sin(t)/2));
  circle(myX(r*cos(t)/2), myY(r*sin(t)/2), r2*xmag);
 
  text("use arrow keys to adjust perceived angle", 100, 550);
  text("theta  "+ nf(theta*180/PI, 0, 1), 850, 550);
  
  t  += theta;
  count ++;
   
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
  
  if (keyCode == LEFT) {
    theta += -dtheta;
  }
  if (keyCode == RIGHT) {
    theta += dtheta;
  }
}


void pause(float t) {
  // like delay(); pause for t millisecs
  float timeNow=millis();
  while (millis()<timeNow+t) {
  }
}
