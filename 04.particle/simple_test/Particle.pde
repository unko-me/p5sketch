class Particle {
	PVector location;
	PVector velocity;
	PVector acceleration;
	float lifespan;
	float mass = 1;

	public Particle (PVector l) {
		location = l.get();
		acceleration = new PVector(0, 0);
		velocity = new PVector(random(-2, 2), random(-2, 0));
		lifespan = 255.0;
	}

	void update() {
		velocity.add(acceleration);
		location.add(velocity);
		acceleration.mult(0);
		lifespan -= 4.0;
	}
	void display() {
		// stroke(0, lifespan);
		fill(175, lifespan);
		ellipse(location.x,	location.y, 8, 8);
	}
	void run() {
		update();
		display();
	}

	void applyForce(PVector force) {
		PVector f = force.get();
		f.div(mass);
		acceleration.add(f);
	}

	boolean isDead() {
		return lifespan < 0;
	}

}