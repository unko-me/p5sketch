int WIDTH  = 640;
int HEIGHT = 640;

Pendulum p;

void setup () {
	size(WIDTH, HEIGHT);
	smooth();
	frameRate(30);
	background(0x999999);

	p = new Pendulum(new PVector(width / 2, 10), 125);
}
void draw() {
	fill(0, 100);
	rectMode(CORNER);
	rect(0, 0, width, height);
	p.go();
}
