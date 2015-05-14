Mover[] movers = new Mover[30];

PVector mouse = new PVector(width / 2, height / 2);
void setup() {
	size(1280, 720);
	background(0);
	for (int i = 0; i < movers.length; ++i) {
		movers[i] = new Mover(random(width), random(height));
	}
}

void draw() {
	// background(0, 0.1);
	fill(0, 2);
	rectMode(CORNER);
	rect(0, 0, width, height);

	mouse.x = mouseX;
	mouse.y = mouseY;

	for (int i = 0; i < movers.length; ++i) {
		Mover mover = movers[i];
		mover.update(mouse);
		mover.display();
	}
	
	// mover.checkEdge();
}