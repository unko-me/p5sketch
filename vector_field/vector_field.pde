int WIDTH  = 640;
int HEIGHT = 640;
int COL = 20;
int ROW = 20;
int MARGIN = 6;
int NUM_PARTICLES = 1;

int mouseMax = 5;
int arrowMaxLength = WIDTH / COL - MARGIN;
int mouseListIndex = 0;

Particle[] particles;
FieldPoint[][] fieldPoints;
PVector[] mouseVectors;

void setup() {
  size(WIDTH, HEIGHT);
  smooth();
  background(0x999999);

  _createParticle();
  _createField();
  _createMouseVectors();

  PVector result = new PVector(1, 1);
  result.div(3);
  println("result", result);
}

void _createParticle() {
	particles = new Particle[NUM_PARTICLES];
	for (int i = 0; i < NUM_PARTICLES; ++i) {
		particles[i] = new Particle(random(0, WIDTH), random(0, HEIGHT));
	}
}

void _createMouseVectors() {
	mouseVectors = new PVector[mouseMax];
	for (int i = 0; i < mouseMax; ++i) {
		mouseVectors[i] = new PVector(mouseX, mouseY);
	}
}

void _updateMouseForce() {
	mouseVectors[mouseListIndex].set(mouseX, mouseY);
	mouseListIndex++;
	mouseListIndex %= mouseMax;
}

PVector _getMouseForce() {
	PVector result = new PVector();
	for (int i = 0; i < mouseMax; ++i) {
		result.add(mouseVectors[i]);
	}
	result.div(mouseMax);
	result.x -= mouseX;
	result.y -= mouseY;

	//そのままつかうと大きすぎる
	result.div(20);
	return result;
}

void _createField() {
	fieldPoints = new FieldPoint[ROW][COL];
	int xx = WIDTH / COL;
	int yy = HEIGHT / ROW;
	for (int y = 0; y < ROW; ++y) {
		for (int x = 0; x < COL; ++x) {
			FieldPoint point = new FieldPoint(x * xx, y * yy);
			fieldPoints[y][x] = point;
		}
	}
}
void _drawArrows() {
	for (int y = 0; y < ROW; ++y) {
		for (int x = 0; x < COL; ++x) {
			FieldPoint point = fieldPoints[y][x];
			drawArrow(int(point.position.x) - MARGIN + 10, int(point.position.y) - MARGIN + 10, point.length(), point.vector.heading());
		}
	}
}

void _updateForce() {
	PVector mouse = new PVector(mouseX, mouseY);
	PVector mouseForce = _getMouseForce();

	for (int y = 0; y < ROW; ++y) {
		for (int x = 0; x < COL; ++x) {
			FieldPoint point = fieldPoints[y][x];
			float dist = mouse.dist(point.position);
			// point.add(random(-0.1, 0.1), random(-0.1, 0.1));
			if (dist < 50) {
				
				point.add(-mouseForce.x / dist, -mouseForce.y / dist);
			}
			//random walker
			// point.add(random(-0.1, 0.1), random(-0.1, 0.1));
			point.update();
		}
	}
}

void _updateParticles() {

	for (Particle particle : particles) {

		FieldPoint force = _getForcePosition(particle.position);
		println("force: "+force.vector);
		// particle.update(force.position.x, force.position.y);
	}
}

FieldPoint _getForcePosition(PVector position) {
	float normalX = position.x / WIDTH;
	float normalY = position.y / HEIGHT;

	int x = int(normalX * COL);
	int y = int(normalY * ROW);
	return fieldPoints[y][x];
}


void draw() {
	fillBg();
	stroke(255);
	// drawArrow(30, 30, 30, 10);

	_updateMouseForce();
	_updateForce();
	_updateParticles();
	_drawArrows();
}

void fillBg() {
	noStroke();
	fill(0x000000);
	// fill(0x99, 10);
	rectMode(CORNER);
	rect(0, 0, width, height);
}

void drawArrow(int cx, int cy, float len, float angle){
	pushMatrix();
	translate(cx, cy);
	// rotate(radians(angle));
	rotate(angle);
	float hige = 8 * len;
	float fixedLen = arrowMaxLength * len;
	line(0,0,fixedLen, 0);
	line(fixedLen, 0, fixedLen - hige, -hige);
	line(fixedLen, 0, fixedLen - hige, hige);
	popMatrix();
}