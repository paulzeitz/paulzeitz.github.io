/**
 * Brachistochrone demonstration. 
 * 
 * Press indicated keys to build different 
 * curves connecting (0,1) with (1,0)
 *
 */


float xstart = 0.0;
float xfinish = 1;
int nsteps = 500;
float g = 1;
float dt=0.01;
float t = 0;
float maxt = 0;
float v=0; //tangential velocity
float vnow = v;
float vmax = v;
float xnow=xstart;
float ustart=0.005;
float unow = ustart;
float ufinish = 2.4120111439135252;
float a =0.5729170375317504;
String curveType="Line";


void setup() {
  size(1240, 760);
  background(60);
  textSize(24);
}

void draw() {
  
  background(0);
  stroke(100);
  line(myX(0),myY(0),myX(0), myY(1));
  line(myX(0),myY(0),myX(1), myY(0));
  text("Press a key to draw a curve.", 100, 50);
  text("p and q are parabolas; l is a  line.", 100,80);
  text("c is a  cycloid; 4 is 4th degree curve.", 100,110);
  text("Wait for the ball to drop twice to see how fast.", 100,140);
  drawTheCurve();
  float x=xnow;
  float y=1;
  float theta;
  float du;
  
  switch(key){
        case 'p':
           curveType="Parabola convex";
           theta  = atan(-2*unow);
           vnow = vnow-g*sin(theta)*dt;
           du = vnow*dt/sqrt(1+4*unow*unow);
           unow +=du;
           x = unow;
           y = 1- pow(unow,2);
          break;
        case 'l':
           curveType="Line";
           vnow = vnow+g*0.707*dt;
           du = vnow*dt/sqrt(2);
           unow  +=du;
           x= unow;  
           y = 1-x;
          break;
         case 'q':
           curveType="Parabola concave";
           theta  = atan(2*unow-2);
           vnow = vnow-g*sin(theta)*dt;
           du = vnow*dt/sqrt(5-8*unow+4*unow*unow);
           unow +=du;
           x = unow;
           y = pow(unow-1,2);
          break;
         case '4':
           curveType="4th degree concave";
           theta  = atan(4*pow(unow-1,3));
           vnow = vnow-g*sin(theta)*dt;
           du = vnow*dt/sqrt(1+16*pow(unow-1,6));
           unow +=du;
           x = unow;
           y = pow(unow-1,4);
          break;
         case 'c':
           curveType="Cycloid";
           theta = atan(-sin(unow)/(1-cos(unow)));
           vnow = vnow-g*sin(theta)*dt;
           du = vnow*dt/(a*sqrt((2-2*cos(unow))));
           unow +=du;
           x = a*(unow-sin(unow));
           y = -a*(1-cos(unow))+1;
          break;
      }
  
  xnow=x;
  
  t = t + dt;
  text("Curve:    " + curveType, 600, 50);
  text("Time:    " + nf(t,0,3), 600, 100);
  text("Velocity:    " + nf(vnow,0,3), 600, 150);
  text("Final velocity:    " + nf(vmax,0,3), 800, 150);
  text("Final time:   " + nf(maxt,0,3), 600,200);
  
  stroke(#FF0000);
  circle(myX(x), myY(y),8);
  if (xnow>xfinish){
  xnow = xstart;
  vmax = vnow;
  vnow=0;
  maxt = t;
  t=0;
  unow=ustart;
}
}

// other functions

void drawTheCurve(){
  stroke(100);
  //depends on which key is pressed
  
  for (int i = 0; i < nsteps; i++) {
      float x = xstart+(xfinish-xstart)*i/nsteps;
      float y = 1-x;
      float u = ustart+(ufinish-ustart)*i/nsteps;
      switch(key){
        case 'p':
           y = 1-pow(x,2);
          break;
        case 'l':
           y = 1-x;
          break;
         case 'q':
           y = pow(x-1,2);
          break;
         case '4':
           y = pow(x-1,4);
          break;
         case 'c':
           x = a*(u-sin(u));
           y = -a*(1-cos(u))+1;
          break;
        }
      circle(myX(x), myY(y),2);
    }
  }


float myX(float x){
  return 100+500*x;
}

float myY(float y){
  return 700-500*y;
}
