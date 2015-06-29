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
	}

	void noiseStep() {
		pos.x = map(noise(t.x), 0, 1, 0, width);
		pos.y = map(noise(t.y), 0, 1, 0, height);

		t.x += 0.01;
		t.y += 0.01;
	}

	void gaussianStep() {
		pos.x += (float)generator.nextGaussian() * 1.5;
		pos.y += (float)generator.nextGaussian() * 1.5;
	}

}