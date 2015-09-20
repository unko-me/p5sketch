import java.util.Random;

int WIDTH  = 640;
int HEIGHT = 640;

Mover[] movers = new Mover[40];
PVector wind = new PVector(0.1, 0);
PVector gravity = new PVector(0, 10.0);

Liquid liquid;

Random generator;
PVector t = new PVector(0, 10000);


void setup () {
	size(WIDTH, HEIGHT);
	smooth();
	frameRate(30);
	background(0);

	liquid = new Liquid(0, height / 2, width, height / 2, 0.1);
	generator = new Random();

	for (int i = 0; i < movers.length; ++i) {
		movers[i] = new Mover(random(1.6, 10), random(0, width), 0);
	}
}


void draw() {
	fill(0, 100);
	rectMode(CORNER);
	rect(0, 0, width, height);

	liquid.display();

	// float xx = (float)generator.nextGaussian();
	// float xx = (noise(t.x) - 0.5) * 3;
	// wind.x = xx;

	
	float c = 0.9;
	PVector g = new PVector(gravity.x, gravity.y);

	for (int i = 0; i < movers.length; ++i) {
		Mover mover = movers[i];
		PVector friction =  mover.velocity.get();
		friction.mult(-1);
		friction.normalize();
		friction.mult(c);

		if (liquid.contains(mover)) {
			PVector dragForce = liquid.drag(mover);
			mover.applyForce(dragForce);
		}
		else {
			mover.applyForce(wind);
			mover.applyForce(friction);
		}

		

		g.y = gravity.y * mover.mass * 0.1;
		if (g.y < 3) {
			g.y = 3;
		}
		mover.applyForce(g);

		

		mover.update();
		mover.display();
	}
	

	noiseStep();
}

void noiseStep() {
	t.x += 0.1;
	t.y += 0.01;
}
