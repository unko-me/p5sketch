import java.util.Random;
Random generator;


class Attractor {
	float mass;
	PVector location;
	PVector target;
	float G = 2.4;

	Attractor(float mass_) {
		location = new PVector(width/2, height/2);
		mass = mass_;
		target = location.get();
	}

	void move() {
		target.x += (float)generator.nextGaussian() * 10.5;
		target.y += (float)generator.nextGaussian() * 10.5;

		location.x += (target.x - location.x) * 0.2;
		location.y += (target.y - location.y) * 0.2;
		checkEdge();
	}

	void checkEdge() {
		if ((location.x > width + mass)) {
			location.x = 0 - mass;
			target.x = 0 - mass;
		} else if (location.x < 0 - mass) {
			location.x = width + mass;
			target.x = width + mass;
		}
		if (location.y > height + mass) {
			location.y = 0 - mass;
			target.y = 0 - mass;
		} else if (location.y < 0 - mass) {
			location.y = height + mass;
			target.y = height + mass;
		}
	}

	void display() {
		stroke(0);
		fill(175, 200);
		ellipse(location.x, location.y, mass * 2, mass * 2);
	}

	PVector attract(Mover m) {
		PVector force = PVector.sub(location, m.location);
		float distance = force.mag();
		distance = constrain(distance, 0.9, 25);

		force.normalize();
		float strength = (G * mass * m.mass) / (distance * distance);
		force.mult(strength);
		// force.mult(5);
		return force;
	}
}