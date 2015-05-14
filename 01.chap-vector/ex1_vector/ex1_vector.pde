PVector position = new PVector();
PVector velocity = new PVector(10, 10);

void setup() {
	size(640, 360);
	background(255);
}

void draw() {
	background(255);

	// position.x += velocity.x;
	// position.y += velocity.y;
	position.add(velocity);

	if ((position.x > width) || position.x < 0) {
		velocity.x *= -1;
	}
	if ((position.y > height) || position.y < 0) {
		velocity.y *= -1;
	}

	stroke(0);
	fill(165);
	ellipse(position.x, position.y, 16, 16);
}