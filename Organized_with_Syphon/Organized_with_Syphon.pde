import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.math.noise.*;
import toxi.processing.*;

ToxiclibsSupport gfx;

import peasy.*;
PeasyCam cam;

int maxMode = 3;
int mode = 0;

int lastCheck = 0;
int delay = 20000;
int angle = 0;

//float angle = 0;

Lorenz_attractor l;
Spherical s;
Bezier_patch b;
Terrain_noise t;
Supershapes su;




//-------Syphon
import codeanticode.syphon.*;
SyphonServer server;

void settings() {
  size(1920, 720, P3D);
  PJOGL.profile=1;
}


void setup() {
  cam = new PeasyCam(this, 500);
  gfx = new ToxiclibsSupport(this);

  l = new Lorenz_attractor();
  s = new Spherical();
  //su = new Supershapes();
  b = new Bezier_patch();
  t = new Terrain_noise();


  cam.setActive(false);
  stroke(255);

  //----Syphon
  //create our syphon server to send output
  //name it Processing to Syphon
  server = new SyphonServer(this, "Toxiclibs to Syphon");
}

//void mousePressed() {
//  mode++;
//  if (mode>maxMode) {
//    mode = 0;
//  }
//}

float rotateX = 0; 
float rotateY = 0; 
int distance = 500;

float opacity = 255;
float aimOpacity = 255;


void draw() {

  //rotate the camera
  //translate(width/2, height/2, -200);                         
  //rotateY(angle +=0.005);
  //translate(-width/2, -height/2, 200);    

  distance = 500 + int(450 * sin(rotateX));

  cam = new PeasyCam(this, distance);
  rotateX += (PI/240) * (mouseX/1280.0f);
  rotateY += PI/420 * (mouseX/600.0f);

  if (rotateX >= 2*PI ) {
    rotateX -= 2*PI;
  }
  if (rotateY >= 2*PI ) {
    rotateY -= 2*PI;
  }

  cam.rotateX(rotateX);
  cam.rotateY(rotateY);

  if ( millis() - lastCheck >= delay) {
    delay = 9000;
    aimOpacity = 255;
    mode++;
    lastCheck = millis();
    if (mode>maxMode) {
      mode = 3;
    }
  }

  if (millis() - lastCheck >= delay * 0.8) {
    aimOpacity = 0;
  }

  if (abs(opacity - aimOpacity)>1) {
    opacity += 0.05 * (aimOpacity-opacity);
  }

  stroke(opacity);

  if (mode==0) {
    l.display();
    l.update();
  }

  if (mode==1) {
    s.display();
    s.update();
  }

  if (mode==2) {
    b.display();
    b.updateMesh();
  }

  if (mode==3) {
    t.display();
    t.update();
  }

  server.sendScreen();
}