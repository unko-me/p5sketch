import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class vector_field extends PApplet {

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

public void setup() {
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

public void _createParticle() {
	particles = new Particle[NUM_PARTICLES];
	for (int i = 0; i < NUM_PARTICLES; ++i) {
		particles[i] = new Particle(random(0, WIDTH), random(0, HEIGHT));
	}
}

public void _createMouseVectors() {
	mouseVectors = new PVector[mouseMax];
	for (int i = 0; i < mouseMax; ++i) {
		mouseVectors[i] = new PVector(mouseX, mouseY);
	}
}

public void _updateMouseForce() {
	mouseVectors[mouseListIndex].set(mouseX, mouseY);
	mouseListIndex++;
	mouseListIndex %= mouseMax;
}

public PVector _getMouseForce() {
	PVector result = new PVector();
	for (int i = 0; i < mouseMax; ++i) {
		result.add(mouseVectors[i]);
	}
	result.div(mouseMax);
	result.x -= mouseX;
	result.y -= mouseY;

	//\u305d\u306e\u307e\u307e\u3064\u304b\u3046\u3068\u5927\u304d\u3059\u304e\u308b
	result.div(20);
	return result;
}

public void _createField() {
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
public void _drawArrows() {
	for (int y = 0; y < ROW; ++y) {
		for (int x = 0; x < COL; ++x) {
			FieldPoint point = fieldPoints[y][x];
			drawArrow(PApplet.parseInt(point.position.x) - MARGIN + 10, PApplet.parseInt(point.position.y) - MARGIN + 10, point.length(), point.vector.heading());
		}
	}
}

public void _updateForce() {
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

public void _updateParticles() {

	for (Particle particle : particles) {

		FieldPoint force = _getForcePosition(particle.position);
		println("force: "+force.vector);
		// particle.update(force.position.x, force.position.y);
	}
}

public FieldPoint _getForcePosition(PVector position) {
	float normalX = position.x / WIDTH;
	float normalY = position.y / HEIGHT;

	int x = PApplet.parseInt(normalX * COL);
	int y = PApplet.parseInt(normalY * ROW);
	return fieldPoints[y][x];
}


public void draw() {
	fillBg();
	stroke(255);
	// drawArrow(30, 30, 30, 10);

	_updateMouseForce();
	_updateForce();
	_updateParticles();
	_drawArrows();
}

public void fillBg() {
	noStroke();
	fill(0x000000);
	// fill(0x99, 10);
	rectMode(CORNER);
	rect(0, 0, width, height);
}

public void drawArrow(int cx, int cy, float len, float angle){
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
public class FieldPoint {
	public int x;
	public int y;
	public PVector vector;
	public PVector position;
	public FieldPoint (int x, int y) {
		position = new PVector(x, y);
		vector = new PVector();
	}


	public void set(float vecX, float vecY) {
		vector.set(vecX, vecY);
	}

	public void add(float vecX, float vecY) {
		vector.x += vecX;
		vector.y += vecY;
	}

	public void update() {

		vector.x += (0 - vector.x) * 0.01f;
		vector.y += (0 - vector.y) * 0.01f;

		if (vector.x > 1)
			vector.x = 1;
		else if (vector.x < -1)
			vector.x = -1;
		if (vector.y > 1)
			vector.y = 1;
		else if (vector.y < -1)
			vector.y = -1;
	}

	public float length() {
		return vector.mag();
	}


}
public class FlowField  {
	PVector [][] field;
	int cols, rows;
	int resolution;

	FlowField () {
		resolution = 10;
		cols = width / resolution;
		rows = height / resolution;
		field = new PVector[cols][rows];
	}

}
public class Particle  {

	PVector position;
	PVector vector;

	public Particle (float x, float y) {
		position = new PVector(x, y);

	}

	public void update(float x, float y) {
		vector.x += x;
		vector.y += y;

		position.x += vector.x;
		position.y += vector.y;

		vector.x *= 0.8f;
		vector.y *= 0.8f;

	}
	public String toString() {
		return "[Particle] x" + position.x + ", y:" + position.y;
	}

}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "vector_field" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
