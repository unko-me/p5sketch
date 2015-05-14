class Mover  {
	PVector location;
	PVector velocity;
	PVector acceleration;
	float topSpeed = 30;

	//for parlin
	PVector t = new PVector(0, 10000);

	public Mover () {
		location = new PVector(random(width), random(height));
		// acceleration = new PVector(-0.1, 0.1);
		acceleration = PVector.random2D();
		velocity = new PVector(0, 0);
	}

	void update() {
		// acceleration = PVector.random2D();
		acceleration.x = map(noise(t.x), 0, 1, -0.1, 0.1);
		acceleration.y = map(noise(t.y), 0, 1, -0.1, 0.1);
		t.x += 0.01;
		t.y += 0.01;

		velocity.add(acceleration);
		velocity.limit(topSpeed);
		location.add(velocity);
	}

	void display() {
		stroke(255);
		fill(175);
		ellipse(location.x, location.y, 16, 16);
	}
	void checkEdge() {
		if ((location.x > width) || location.x < 0) {
			velocity.x *= -1;
			acceleration.x *= -1;
		}
		if ((location.y > height) || location.y < 0) {
			velocity.y *= -1;
			acceleration.y *= -1;
		}
	}

}