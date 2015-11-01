import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;


int WIDTH  = 404 / 2;
int HEIGHT = 1350 / 2;


ArrayList<Box> boxes;
ArrayList<Boundary> boundaries;

Box2DProcessing box2d;

PImage img;
int[] pixelsCopy;

void setup () {
	size(202, 675);
	smooth();
	frameRate(30);
	background(0);
	boxes = new ArrayList<Box>();
	boundaries = new ArrayList<Boundary>();

	setupWorld();
	boundaries.add(new Boundary(width * 0.2, height - 100, width / 4, 20));
	boundaries.add(new Boundary(width/4,height-5,width/2-50,10));
	boundaries.add(new Boundary(3*width/4,height-50,width/2-50,10));

	img = loadImage("../../img/oj10A-R2_half.gif");
	image(img, 0, 0, width, height);
	loadPixels();
	pixelsCopy = pixels;

	background(255);

}

private void setupWorld() {
	box2d = new Box2DProcessing(this);
	box2d.createWorld();
	box2d.setGravity(0, -330); //-330
}

void draw() {
	background(0);
	// tint(255, 255, 255, 4);
	// image(img, 0, 0, width, height);

	// color c = pixels[mouseY * width + mouseX];
	// int a = c >> 24 & 0xFF;
// int r = c >> 16 & 0xFF;  // Faster way of getting red(argb)
	// int g = c >> 8 & 0xFF;   // Faster way of getting green(argb)
	// int b = c & 0xFF;  
	// println("  " + r  + ", " + g  + ", " + b + ", " + mouseX + ", " + mouseY);

	
	box2d.step();

	addBoxes();
	drawElements();
	checkDone();
  }

  void drawElements() {
  	for (Box box : boxes) {
		box.display();
	}
	for (Boundary boundary : boundaries) {
		boundary.display();
	}
  }

  void addBoxes() {
  	if (mousePressed) {
  		for (int i = 0; i < 20; ++i) {
  			Box p = new Box(mouseX, mouseY, random(2, 8), random(2, 8));
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
