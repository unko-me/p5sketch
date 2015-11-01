import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

import processing.video.*;
Capture camera; 

int WIDTH  = 640;
int HEIGHT = 480;


ArrayList<Box> boxes;
ArrayList<Boundary> boundaries;

Box2DProcessing box2d;

PImage img;
int[] pixelsCopy;

void setup () {
	size(200, 200, P3D);
	surface.setSize(WIDTH, HEIGHT);
	smooth();
	frameRate(30);

	camera = new Capture(this, width, height, 24); // Captureオブジェクトを生成

	boxes = new ArrayList<Box>();
	boundaries = new ArrayList<Boundary>();

	setupWorld();
	boundaries.add(new Boundary(width * 0.2, height - 100, width / 4, 20));
	boundaries.add(new Boundary(width/4,height-5,width/2-50,10));
	boundaries.add(new Boundary(3*width/4,height-50,width/2-50,10));

	background(255);
	
	camera.start();
	// img = loadImage("../../img/oj10A-R2_half.gif");
	// image(img, 0, 0, width, height);
	camera.loadPixels();


}

private void setupWorld() {
	box2d = new Box2DProcessing(this);
	box2d.createWorld();
	box2d.setGravity(0, -130); //-330
}

void draw() {
	// background(0);
	// tint(255, 255, 255, 4);
	// image(img, 0, 0, width, height);

	
	// image(camera, 0, 0);


	box2d.step();

	lights();
	addBoxes();
	drawElements();
	checkDone();
}

void drawElements() {
	if (camera.pixels.length > 0) {
		for (Box box : boxes) {
			box.display();
		}	
	}
	
	for (Boundary boundary : boundaries) {
		boundary.display();
	}
}

void addBoxes() {
	if (mousePressed) {
		for (int i = 0; i < 20; ++i) {
			Box p = new Box(mouseX, mouseY, random(8, 18), random(8, 18));
			boxes.add(p);
		}
	}
}

void checkDone() {
	for (int i = boxes.size()-1; i >= 0; i--) {
		Box b = boxes.get(i);
		if (b.done()) {
			boxes.remove(i);
		}

		// println("boxes.size(): "+boxes.size());
	}


}
void captureEvent(Capture camera) {
	camera.read();
	camera.loadPixels();
}
