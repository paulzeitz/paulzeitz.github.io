boolean shooting = false;

float t = 0;
float dt = 0.01;
float dtheta = PI/180;  //one degree
float tick = 0.1; //tick size
float turretLength = .5;

//these values are for scaling "math" coords to screen coords
int xmag = 50;
int ymag = 50;
int xScreenCenter = 100;
int yScreenCenter = 500;
float xmin = 0;
float xright = 16;

float theta = PI/6; //start turret angle at 30 degrees
float g = 1;    //gravitational accel

//starting location and velocity
float vstart = 4; 
float v=vstart;
float vmax=vstart;
float x=0;
float y=0;
float ymax=y;
float xmax;

//velocity components
float vx;
float vy;






void setup() {
  size(1000, 600);
  background(100);
  textSize(24);
}

void draw() {

  background(220);
  stroke(0);
  fill(0);
  text("Use arrow keys to move turret and then hit and release spacebar to initialize and shoot", 100, 20);
  //draw control line for x-position
  
  for (float x=xmin+1; x<=xright; x=x+1) {
    line(myX(x), myY(0-tick), myX(x), myY(0+tick));
  }

  //draw x-axis line for y=0
  line(myX(xmin), myY(0), myX(xright), myY(0));
  text("x", myX(xright+tick), myY(0));
  /*draw y-axis
  line(myX(0), myY(0), myX(0), myY(ymax));
  text("x, v, a", myX(-1), myY(xmax*.7));
  //draw ticks
  for (int y=0; y<=xmax; y++) {
    line(myX(-tick), myY(y), myX(tick), myY(y));
  }
*/
  fill(#0000FF);
  text("time  "+ nf(t, 0, 2), 150, 550);
  text("theta  "+ nf(theta*180/PI, 0, 0), 50, 550);
  text("x  "+ nf(x, 0, 2), 300, 550);
  text("y  "+ nf(y, 0, 2), 400, 550);
    text("v  "+ nf(v, 0, 2), 500, 550);
    fill(#FF0000);
    text("xmax  "+ nf(xmax, 0, 2), 600, 550);
        text("ymax  "+ nf(ymax, 0, 2), 750, 550);
        

//draw turret circle with pointer at angle theta
    drawturret();
    
//check to see if spacebar has been pressed
    if (shooting) {
    
    //draw a ball in current position
    fill(#FF0000);  //red (uses RGB in hexadecimal; FF is the largest value of 255
    circle(myX(x), myY(y),8); //first two variables are location x and y; third is radius
    
    vx = vstart*cos(theta);  //this is constant, depending only on theta and starting velo, since gravity won't affect horiz 
    
    
    x  = x + vx*dt;
    y  = y + vy*dt;
    t += dt;
    vy = vy -g*dt;
    v=sqrt(vx*vx+vy*vy);
    
    //check for new max height and vel
    if(y>ymax){
      ymax = y;
    }
    
    
    //check for hitting ground; reset
    if (y<=0){
      xmax=x;
      t =0;
      x=0;
      y=0;
      vy=vstart*sin(theta);
    }
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

void drawturret(){
    fill(#0000FF,20);
    circle(myX(0), myY(0), 30);
    
    stroke(#FF0000);
    strokeWeight(4);
    fill(#FF0000);
    line(myX(0), myY(0),myX(turretLength*cos(theta)), myY(turretLength*sin(theta)));
    strokeWeight(1);
}
void keyPressed() {
  if (key == ' ') {
    shooting = !shooting;
  }
  if (keyCode == LEFT){
    theta += dtheta;
  }
  if (keyCode == RIGHT){
    theta += -dtheta;
  }
}
void keyReleased() {
  if (key == ' ') {//ready to start shooting!
    vy = vstart*sin(theta);
    xmax=0;
    ymax=0;
    x=0;
    y=0;
    vx = vstart*cos(theta);
    t=0;
  }
}
