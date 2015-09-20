class Mover  {
	PVector location;
	PVector velocity;
	PVector acceleration;

	Float mass;


	public Mover (float mass_, float x, float y) {
		location = new PVector(x, y);
		acceleration = PVector.random2D();
		velocity = new PVector(0, 0);

		mass = mass_;
	}

	void update() {
		velocity.add(acceleration);
		location.add(velocity);
		acceleration.mult(0);

		// checkEdge();
	}

	void display() {
		stroke(255);
		float radius = 10.0 * mass;
		ellipse(location.x, location.y, radius, radius);
	}

	void applyForce(PVector force) {
		PVector f = PVector.div(force, mass);
		acceleration.add(f);
	}

	void checkEdge() {
		if ((location.x > width)) {
			velocity.x *= -1;
			location.x = width;
		} else if (location.x < 0) {
			velocity.x *= -1;
			location.x = 0;
		}
		if (location.y > height) {
			velocity.y *= -1;
			location.y = height;
		} else if (location.y < 0) {
			velocity.y *= -1;
			location.y = 0;
		}
	}

}