import toxi.geom.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;


ArrayList<Particle> particles;
Attractor attractor;

VerletPhysics2D physics;

int WIDTH  = 640;
int HEIGHT = 640;

void setup () {
	size(100, 100, P2D);
	surface.setSize(WIDTH, HEIGHT);
	smooth();
	frameRate(30);
	physics = new VerletPhysics2D();
	physics.setDrag(0.01);

	particles = new ArrayList<Particle>();
	for (int i = 0; i < 100; ++i) {
		particles.add(new Particle(new Vec2D(random(width),random(height))));
	}

	attractor = new Attractor(new Vec2D(width/4, height/4));
}

void draw() {
	background(255, 10);
	physics.update();

	// attractor.display();

	Particle lastP = null;
	
	for (Particle p : particles) {
		p.display();
	}
	stroke (127, 50);
	strokeWeight(1);
	// beginShape();
	for (int i = 0; i < particles.size(); ++i) {
		Particle p1 = particles.get(i);
		// vertex(p1.x, p1.y);
		for (int j = i + 1; j < particles.size(); ++j) {
			Particle p2 = particles.get(j);
			
			
			// vertex(p2.x, p2.y);
			line(p1.x, p1.y, p2.x, p2.y);
		}
	}
	endShape();

	// if (mousePressed) {
		attractor.lock();
		attractor.set(mouseX, mouseY);
	// } else {
	// 	attractor.unlock();
	// }
}
