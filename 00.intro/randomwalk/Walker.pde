import java.util.Random;

public class Walker {
	float x;
	float y;
	Random generator;
	public Walker () {
		x = width / 2;
		y = height / 2;
		generator = new Random();
	}

	void display() {
		stroke(255);
		// point(x, y);
		ellipse(x, y, 16, 16);
	}

	void step() {
		x += (float)generator.nextGaussian() * 1.5;
		y += (float)generator.nextGaussian() * 1.5;
		// x += int(random(3)) - 1;
		// y += int(random(3)) - 1;
	}

}