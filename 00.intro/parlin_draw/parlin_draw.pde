import java.util.Random;


int WIDTH  = 500;
int HEIGHT = 500;
Random generator;

float increment = 0.01;

float zoff = 0.0;  
float zincrement = 0.02; 

void setup () {
	size(WIDTH, HEIGHT);
	smooth();
	frameRate(30);
	background(0);
	generator = new Random();
}
void draw() {
	loadPixels();
	noiseStep();
	updatePixels();
  	zoff += zincrement;


	noStroke();
	fill(255, 10);
}

void noiseStep() {
	noiseDetail(8,0.65f);
	float tx = 0;
	
	for (int x = 0; x < width; ++x) {
		tx += increment;
		float ty = 0;
		for (int y = 0; y < height; ++y) {
			ty += increment;
			// float bright = random(255);
			// float bright = map(noise(tx, ty), 0, 1, 0, 255);
			float bright = noise(tx,ty,zoff)*255;
			pixels[x+y*width] = color(bright,bright,bright);
			// tx += increment;
			
		}
		// ty += increment;
		
	}
}
