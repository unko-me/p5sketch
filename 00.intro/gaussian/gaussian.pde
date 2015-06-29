import java.util.Random;


int WIDTH  = 640;
int HEIGHT = 640;
Random generator;

void setup () {
	size(WIDTH, HEIGHT);
	smooth();
	frameRate(30);
	background(0);
	generator = new Random();
}
void draw() {

	float num = random(-1, 1);
	// float num = (float)generator.nextGaussian();
	float sd = 60;
	float mean = 320;

	float x = sd * num + mean;

	noStroke();
	fill(255, 10);
	ellipse(x, 180 + random(-10, 10), 16, 16);
}
