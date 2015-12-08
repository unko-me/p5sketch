int WIDTH  = 640;
int HEIGHT = 640;

void setup () {
	size(100, 100, P2D);
	surface.setSize(WIDTH, HEIGHT);
	smooth();
	frameRate(30);
	background(0x999999);
}
void draw() {
	stroke(255);
	rect(0, 0, 100, 100);
}
