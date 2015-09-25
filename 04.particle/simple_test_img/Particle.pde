class Particle {
	PVector location;
	PVector velocity;
	PVector acceleration;
	float lifespan;
	float mass = 1;

	PImage img;

	public Particle (PVector l) {
		location = l.get();
		acceleration = new PVector(0, 0);
		velocity = new PVector(random(-2, 2), random(-2, 0));
		lifespan = 255.0;

		img = loadImage("../../img/1yen.png");
	}

	void update() {
		velocity.add(acceleration);
		location.add(velocity);
		acceleration.mult(0);
		lifespan -= 4.0;
	}
	void display() {
		imageMode(CENTER);
		// tint(255, lifespan);
		image(img, location.x, location.y, 50, 50);
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