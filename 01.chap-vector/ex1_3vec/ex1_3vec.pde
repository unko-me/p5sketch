PVector position = new PVector();
PVector velocity = new PVector(10, 10);

void setup() {
	size(640, 360);
	background(255);
}

void draw() {
	background(255);

	PVector mouse = new PVector(mouseX, mouseY);
	PVector center = new PVector(width / 2, height / 2);

	mouse.sub(center);
	// mouse.mult(3);
	// mouse.div(3);
	// mouse.normalize();
	// mouse.mult(100);
	
	translate(center.x, center.y);

	line(0, 0, mouse.x, mouse.y);
}