int WIDTH  = 640;
int HEIGHT = 640;

Wave wave1;
Wave wave2;

void setup () {
	size(WIDTH, HEIGHT);
	smooth();
	frameRate(30);
	background(0x999999);

	wave1 = new Wave(100, 100, 300, 30, 120);
	wave2 = new Wave(100, 300, 500, 10, 100);
}
void draw() {
	fill(0, 100);
	rectMode(CORNER);
	rect(0, 0, width, height);

	
	stroke(255);
	fill(255,50);
	wave1.update();
	wave1.display();

	wave2.update();
	wave2.display();
}
