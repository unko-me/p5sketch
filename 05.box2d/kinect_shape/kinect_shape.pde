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

Capture video;
OpenCV cv;
PImage im, th;
ArrayList<Contour> contours;
PImage img;
Contour largest;
ArrayList<PVector> largestPoints;
int index = 0;

// A reference to our box2d world
Box2DProcessing box2d;



// An ArrayList of particles that will fall on the surface
ArrayList<Particle> particles;

// An object to store information about the uneven surface
Surface surface;

void setup() {
  size(640, 480);
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, -10);

  // Create the empty list
  particles = new ArrayList<Particle>();

  img = loadImage("depth.png");
  cv = new OpenCV(this,img);
  
  _findContours();
  _findLargest();
  // Create the surface
  surface = new Surface(largestPoints);
}

void draw() {
  // If the mouse is pressed, we make new particles
  if (mousePressed) {
    float sz = random(2,6);
    particles.add(new Particle(mouseX,mouseY,sz));
  }

  // We must always step through time!
  box2d.step();

  background(255);

  // Draw the surface
  surface.display();

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

  // _draw();
}

void _findContours() {
 cv.loadImage(img);
  
  cv.gray();
  cv.blur(8);
  int blurSize = 4;
  //org.opencv.imgproc.Imgproc.medianBlur(cv.matGray, cv.matGray, new Size(blurSize, blurSize));
  //cv.erode();

  cv.threshold(163);
  th = cv.getOutput();
  image(th, 0, 0);
  
  contours = cv.findContours(false, false); 
}

void _findLargest() {
 
 for (Contour contour : contours) {
    
    //ちっさいのは除外する
    if (contour.area() < 100) {
     continue;
    }
    if (largest == null) {
      largest = contour;
      continue;
    }
    if (largest.numPoints() < contour.numPoints()) {
      largest = contour; 
    }
  }
  println("largest: " + largest.area());
  
  largestPoints = largest.getPoints();
}

void _draw() {
  
  noFill();
  strokeWeight(1);

  stroke(random(128),random(128),128);
  //largest.draw();
  
  PVector point = largestPoints.get(index);
  ellipse(point.x, point.y, 24, 24);
  
  index++;
  if (index >= largest.numPoints()) {
    index = 0;
  }
  
  
}





