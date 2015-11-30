// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// An uneven surface

import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;


import processing.video.*;
import gab.opencv.*;


KinectManager kinectManager;

// Capture video;
OpenCV cv;
// PImage im, th;
ArrayList<Contour> contours;
PImage img;
// Contour largest;
ArrayList<Surface> surfacies;
ArrayList<PVector> largestPoints;
ArrayList<ArrayList<PVector>> contoursPointList;

int index = 0;

boolean isFill = false;
Box2DProcessing box2d;


ArrayList<Particle> particles;
Surface surface;

void setup() {
  // fullScreen();
  size(640, 480, P2D);

  _initKinect();
  _initBox2d();
  frameRate(30);
  
}

void _initKinect() {
  kinectManager = new KinectManager(this);
}

void _initBox2d() {
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -300);

  particles = new ArrayList<Particle>();

  // img = loadImage("depth.png");
  img = kinectManager.kinect.getDepthImage();
  cv = new OpenCV(this,img);
  
  _findContours();
  _filterContours();
}

void draw() {
  // background(255);
  updateCV();
  image(kinectManager.kinect.getVideoImage(), 0, 0);
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
    float sz = random(6,12);
    particles.add(new Particle(mouseX,mouseY,sz));
  }

  // We must always step through time!
  box2d.step();
  // Draw the surface
  for (Surface surface : surfacies) {
      surface.display(isFill);
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
  // th = cv.getOutput();
  
  contours = cv.findContours(false, false); 
}

void _filterContours() {
contoursPointList = new ArrayList<ArrayList<PVector>>();
 for (Contour contour : contours) {
    //ちっさいのは除外する
    if (contour.area() < 100) {
     continue;
    }
    contoursPointList.add(contour.getPoints());
  }
}

void updateCV() {
  img = kinectManager.kinect.getDepthImage();
  if (cv == null) cv = new OpenCV(this,img);
  
  _findContours();
  _filterContours();
}

void keyPressed() {
  if (key == 'n') {
    isFill = !isFill;
  }
}





