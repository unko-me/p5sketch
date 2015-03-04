int WIDTH  = 640;
int HEIGHT = 640;

Walker walker;
void setup() {
  size(WIDTH, HEIGHT);
  smooth();
  background(0);

  walker = new Walker();
}

void draw() {
	fillBg();
	walker.step();
	walker.display();
}

void fillBg() {
	noStroke();
	// fill(0x000000);
	fill(0, 1);
	rectMode(CORNER);
	rect(0, 0, width, height);
}