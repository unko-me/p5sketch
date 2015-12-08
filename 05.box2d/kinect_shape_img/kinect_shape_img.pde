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


KinectManager kinectManager;

OpenCV cv;
ArrayList<Contour> contours;
PImage img;
// Contour largest;
ArrayList<Surface> surfacies;
ArrayList<PVector> largestPoints;
ArrayList<ArrayList<PVector>> contoursPointList;

int index = 0;

boolean isFill = false;

ImageService imgService;

Box2DProcessing box2d;

ArrayList<Particle> particles;
Surface surface;

void setup() {
  // fullScreen();
  // size(640, 480, P2D);
  size(1280, 960, P2D);
  imgService = new ImageService(loadJSONArray("./imagelist.json"));

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
  image(kinectManager.kinect.getVideoImage(), 0, 0, width, height);
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
  // if (mousePressed) {
  if (true) {
    float sz = random(15,30);
    ImageSet imgSet = imgService.getRandomImgSet();
    particles.add(new Particle(mouseX,mouseY, sz, imgSet.img));
    // particles.add(new Particle(mouseX,mouseY,sz, particleImg));
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

  cv.threshold(40);
  contours = cv.findContours(false, false); 
}

void _filterContours() {
contoursPointList = new ArrayList<ArrayList<PVector>>();

  int maxY = height - 10;
 for (Contour contour : contours) {
    //ちっさいのは除外する
    if (contour.area() < 100) {
     continue;
    }
    ArrayList<PVector> points = contour.getPoints();
    contoursPointList.add(points);
    //底辺にpointがあるときはさらに下のほうにもってく。じゃないと、底辺にたまってしまう
    // for (PVector point : points) {
    //   if (point.y > maxY) point.y = height + 10;
    // }
    //そのまま使うと多すぎるので消す
    ArrayList<PVector> tmp = new ArrayList<PVector>();
    // → Vertices of chain shape are too close togetherというエラーがでる…。近くねーだろ。
    // ArrayList<PVector> points = contour.getPoints();
    // for (int i = 0, n = points.size(); i < n; i+=2) {
    //   tmp.add(points.get(i));
    // }
    // if (tmp.size() > 100) contoursPointList.add(tmp);
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





