boolean shooting = false;

float t = 0;
float dt = PI/360;
float dtheta = PI/360;  //one half degree
float tick = 0.1; //tick size
float turretLength = .5;

//these values are for scaling "math" coords to screen coords
int xmag = 50;
int ymag = 50;
int xScreenCenter = 500;
int yScreenCenter = 300;
float xmin = 0;
float xright = 16;

float theta = (3-sqrt(5))*PI; //start
float r = 6;    //radius
float r2= 1; //small rad
int count = 0;
int frametime=0;
int startTime;
int endTime;
float frRate;
PImage photo;
PImage photo1;
PImage photo2;
PImage photo3;
int xc1=195;
int yc1=195;
int xc2=219;
int yc2=207;
int xc3=201;
int yc3=210;
int xc=xc1;
int yc=yc1;

void setup() {
  size(1000, 600);
  background(100);
  textSize(24);
  photo1 = loadImage("/Users/zeitzp/Documents/Processing/strobe_220323/spirals-g2.png");
  photo3 = loadImage("/Users/zeitzp/Documents/Processing/strobe_220323/blooms2.png");
  photo2 = loadImage("/Users/zeitzp/Documents/Processing/strobe_220323/edmarkTile2.png");
  photo=photo1;
}

void draw() {
  startTime=millis();
  background(220);
  //stroke(0);
  //fill(0);
  //
  //photo = photo1;
  //image(photo,0,0);
  //print(mouseX+"x ", mouseY+"y  ");
  
  //draw circle
  stroke(#0000FF);
  fill(#0000FF);
  text("Hit 1,2,3 to switch image; Left/Right to change speed",100,50);
  //circle (myX(0),myY(0),r*xmag+100);
  //fill(#FF0000);
  //circle (myX(0),myY(0),2);
  noFill();
  pushMatrix();
  //
  
  translate(500,300);
  //translate(100,0);
  
  rotate(t);
  translate(-xc,-yc);
  image(photo,0,0);
  //fill(#FF0000);

  popMatrix();
  
  
  text("theta  "+ nf(theta*180/PI, 0, 1), 850, 550);
  pause(50);
  t = t+theta;
  count ++;
  //frRate= 1000*count/millis();
  //text(frRate, 400,400);
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
    shooting = !shooting;
  }
  if (key == '1') {
    xc=xc1;
    yc=yc1;
    photo=photo1;
  }
  if (key == '2') {
    xc=xc2;
    yc=yc2;
    photo=photo2;
  }
  if (key == '3') {
    xc=xc3;
    yc=yc3;
    photo=photo3;
  }
  if (keyCode == LEFT){
    theta += -dtheta;
  }
  if (keyCode == RIGHT){
    theta += dtheta;
  }
}

void keyReleased() {
  if (key == ' ') {//ready to start shooting!
    /*vy = vstart*sin(theta);
    xmax=0;
    ymax=0;
    x=0;
    y=0;
    vx = vstart*cos(theta);
    t=0;
    */
  }
}
void pause(float t) {
  // like delay(); pause for t millisecs
  float timeNow=millis();
  while (millis()<timeNow+t) {
  }
}
