int WIDTH  = 640;
int HEIGHT = 640;

float theta = PI / 4;
float r = 10;


void setup () {
	size(WIDTH, HEIGHT);
	smooth();
	frameRate(30);
	background(0x999999);
}
void draw() {
	stroke(255);
	float x = r * cos(theta) + width / 2;
	float y = r * sin(theta) + height / 2;

	ellipse(x, y, 20, 20);
	theta += 0.1;
	r += .51;
}
