// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// An uneven surface

import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.*;


import processing.video.*;
import gab.opencv.*;
import org.openkinect.freenect.*;
import org.openkinect.processing.*;


Kinect kinect;

Capture video;
OpenCV cv;
PImage im, th;
ArrayList<Contour> contours;
PImage img;
Contour largest;
ArrayList<Surface> surfacies;
ArrayList<PVector> largestPoints;
ArrayList<ArrayList<PVector>> contoursPointList;

int index = 0;

boolean colorDepth = false;

// A reference to our box2d world
Box2DProcessing box2d;



// An ArrayList of particles that will fall on the surface
ArrayList<Particle> particles;

// An object to store information about the uneven surface
Surface surface;

void setup() {
  size(640, 480);

  _initKinect();
  _initBox2d();
  frameRate(30);
  
}

void _initKinect() {
  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.initVideo();
  //kinect.enableIR(ir);
  kinect.enableColorDepth(colorDepth);
}

void _initBox2d() {
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -300);

  particles = new ArrayList<Particle>();

  // img = loadImage("depth.png");
  img = kinect.getDepthImage();
  cv = new OpenCV(this,img);
  
  _findContours();
  _findLargest();
}

void draw() {
  // background(255);
  updateCV();
  updateBox2d();
}

void updateBox2d() {
  if (surfacies != null) {
    for (Surface surface : surfacies) {
      surface.killBody();  
    }
  }

  surfacies = new ArrayList<Surface>();
  for (ArrayList<PVector> points : contoursPointList) {
      Surface surface = new Surface(points);
      surfacies.add(surface);
  } 

  // If the mouse is pressed, we make new particles
  if (mousePressed) {
    float sz = random(2,6);
    particles.add(new Particle(mouseX,mouseY,sz));
  }

  // We must always step through time!
  box2d.step();

  // background(255);

  // Draw the surface
  
  for (Surface surface : surfacies) {
      surface.display();
    }

  // Draw all particles
  for (Particle p: particles) {
    p.display();
  }

  // Particles that leave the screen, we delete them
  // (note they have to be deleted from both the box2d world and our list
  for (int i = particles.size()-1; i >= 0; i--) {
    Particle p = particles.get(i);
    if (p.done()) {
      particles.remove(i);
    }
  }
}

void _findContours() {
  cv.loadImage(img);
  cv.gray();
  cv.blur(8);
  int blurSize = 4;

  cv.threshold(163);
  th = cv.getOutput();
  image(th, 0, 0);
  
  contours = cv.findContours(false, false); 
}

void _findLargest() {
contoursPointList = new ArrayList<ArrayList<PVector>>();

 for (Contour contour : contours) {
    //ちっさいのは除外する
    if (contour.area() < 100) {
     continue;
    }
    contoursPointList.add(contour.getPoints());
  }
  // largestPoints = largest.getPoints();
}

void updateCV() {
  img = kinect.getDepthImage();
  if (cv == null) cv = new OpenCV(this,img);
  
  _findContours();
  _findLargest();

  
}





