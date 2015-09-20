class Pendulum {
	PVector location;
	PVector origin;
	float r;
	float angle;
	float aVelocity;
	float aAcceleration;
	float damping;

	Pendulum (PVector origin_, float r_) {
		origin = origin_.get();
		r = r_;

		location = new PVector();
		angle = PI / 4;
		aVelocity = 0.0;
		aAcceleration = 0.0;
		damping = 0.995;
	}

	void go() {
		update();
		display();
	}

	void update() {
		float gravity = 0.4;
		aAcceleration = (-1 * gravity / r) * sin(angle);
		aVelocity += aAcceleration;
		angle += aVelocity;
		aVelocity *= damping;
	}

	void display() {
		location.set(r * sin(angle), r * cos(angle), 0);
		location.add(origin);

		stroke(0);
		line(origin.x, origin.y, location.x, location.y);
		fill(175);
		ellipse(location.x, location.y, 20, 20);
	}

}