boolean reset = false;
boolean showNums = true;
boolean showCircles = false;

float pTime = 300;//pause 300 milliseconds each frame
float dp = 100;
float t = 0;
float dt = 0.2;
float dtheta = PI/360;  //one half degree
float theta = 2*PI/3;   //starting turn angle

//these values are for scaling "math" coords to screen coords
int xmag = 50;
int ymag = 50;
int xScreenCenter = 500;
int yScreenCenter = 300;


float c = 20;
float r = 6;    //radius
float r2= 1; //small rad
int count = 0;

float radius = 10;

 
void setup() {
  colorMode(HSB);
  size(1000, 600);
  background(100);
  textSize(24);
  
}

void draw() {
  
  text("use Up/Down ", 20, 290); 
  text("for speed", 20, 320);
  text("use Left/Right ", 20, 350); 
  text("for turn angle", 20, 380);
  text("keys C, N toggle",   20, 410);
  text("circle and number",   20, 440);
  text("spacebar resets",   20, 470);
  
  fill(100);
  rect(800,500,900,600);
  fill(0);
  text("turn angle  "+ nf(theta*180/PI, 0, 1), 810, 550);
 
 
  r = c*sqrt(count);
  float t = count*theta;
  if (r<height/2) {
    radius =16+.08*r;
    fill(count%256, 100, 300);
    if (showCircles){
      circle(r*cos(t)+width/2, r*sin(t)+height/2, radius);}
      
    fill(0);
    if (showNums){
      text(count, r*cos(t)+width/2, r*sin(t)+height/2);
    }
    
  }
  
  count ++;
  pause(max(pTime,0));
}

//other functions 

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
    reset = !reset;
  }
  if (key == 'n'){
    showNums = !showNums;
  }
  if (key == 'c'){
    showCircles = !showCircles;
  }
  if (keyCode == LEFT) {
    theta += -dtheta;
  }
  if (keyCode == RIGHT) {
    theta += +dtheta;
  }
  if (keyCode == UP) {
    pTime += -dp;
  }
  if (keyCode == DOWN) {
    pTime += dp;
  }
}

void keyReleased() {
  if (key == ' '   ) {//ready to start over!
    count =0;
    background(100);
  }
}
void pause(float t) {
  // like delay(); pause for t millisecs
  float timeNow=millis();
  while (millis()<timeNow+t) {
  }
}
