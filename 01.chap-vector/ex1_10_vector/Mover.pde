
String[] _COLORS = new String[5];

class Mover  {
	PVector location;
	PVector velocity;
	PVector acceleration;
	float topSpeed = 100;
	float accelerationFriction = 0.1;
	float velocityFriction = 0.9;
	float _baseRadius = 16;
	int _color;

	float _colorAngle = 0.0;


	//for parlin
	PVector t = new PVector(0, 10000);

	public Mover (float x, float y) {
		location = new PVector(random(width), random(height));
		// acceleration = new PVector(-0.1, 0.1);
		acceleration = PVector.random2D();
		velocity = new PVector(x, y);

		accelerationFriction = random(0.1) + 0.1;
		velocityFriction = random(0.25) + 0.7;
		_baseRadius = random(16, 32);

		_COLORS[0] = "FFE60033";
		_COLORS[1] = "FF670017";
		_COLORS[2] = "FFEA466B";
		_COLORS[3] = "FF671F2F";
		_COLORS[4] = "FFB30028";
		_color = unhex(_COLORS[int(random(5))]);
	}

	void update(PVector target) {
		// acceleration = PVector.random2D();
		acceleration = PVector.sub(mouse, location);
		acceleration.mult(accelerationFriction);

		velocity.add(acceleration);
		velocity.limit(topSpeed);
		velocity.mult(velocityFriction);
		location.add(velocity);
	}

	void display() {
		// stroke(255);
		float c = sin(_colorAngle+=0.01) * 100;
		int addColor = floor(random(-c, c));
		fill(_color + addColor);
		// float radius = acceleration.x * 2 + 16;
		float radius = pow(acceleration.x, 1.4)  + _baseRadius;
		ellipse(location.x, location.y, radius, radius);
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