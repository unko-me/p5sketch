import java.util.Random;

public class Walker {
	PVector pos = new PVector();
	PVector t = new PVector(0, 10000);
	Random generator;
	public Walker () {
		pos.x = width / 2;
		pos.y = height / 2;

		generator = new Random();
	}

	void display() {
		stroke(255);
		fill(127);
		ellipse(pos.x, pos.y, 16, 16);
	}

	void step() {
		noiseStep();
		// gaussianStep();

		checkEdge();
	}

	void noiseStep() {
		pos.x = map(noise(t.x), 0, 1, 0, width);
		pos.y = map(noise(t.y), 0, 1, 0, height);

		t.x += 0.02;
		t.y += 0.02;


	}

	void gaussianStep() {
		pos.x += (float)generator.nextGaussian() * 1.5;
		pos.y += (float)generator.nextGaussian() * 1.5;
	}

	void checkEdge() {
		if (pos.x > width) 
			pos.x = width;
		else if (pos.x < 0)
			pos.x = 0;

		if (pos.y > height)
			pos.y = height;
		else if (pos.y < 0)
			pos.y = 0;
	}


}