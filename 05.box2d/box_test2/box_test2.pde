import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;


int WIDTH  = 640;
int HEIGHT = 640;


ArrayList<Box> boxes;
ArrayList<Boundary> boundaries;

Box2DProcessing box2d;


void setup () {
	size(WIDTH, HEIGHT);
	smooth();
	frameRate(30);
	background(0x999999);
	boxes = new ArrayList<Box>();
	boundaries = new ArrayList<Boundary>();

	setupWorld();
	boundaries.add(new Boundary(width * 0.2, height - 100, width / 4, 20));
	boundaries.add(new Boundary(width/4,height-5,width/2-50,10));
	boundaries.add(new Boundary(3*width/4,height-50,width/2-50,10));
}

private void setupWorld() {
	box2d = new Box2DProcessing(this);
	box2d.createWorld();
	box2d.setGravity(0, -10);
}

void draw() {
	background(0);

	box2d.step();

	if (mousePressed) {
		Box p = new Box(mouseX, mouseY);
		boxes.add(p);
	}

	for (Box box : boxes) {
		box.display();
	}
	for (Boundary boundary : boundaries) {
		boundary.display();
	}

	for (int i = boxes.size()-1; i >= 0; i--) {
    Box b = boxes.get(i);
    if (b.done()) {
      boxes.remove(i);
    }
  }
}
