import controlP5.*;


ParticleSystem ps;
PVector lastMouse = new PVector();
float force1 = 0.0;
ControlP5 cp5;

void setup () {
	//普通のcanvasだと3840で死ぬ
	size(640, 640, P2D);
	smooth();
	frameRate(30);
	background(0x999999);

	// p = new Particle(new PVector(width / 2, 10));
	ps = new ParticleSystem(new PVector(width / 2, 10), 100);

	cp5 = new ControlP5(this);
	cp5.addSlider("force1")
		.setPosition(10, 10)
		.setSize(100, 15)
		.setRange(-4.0, 4.0);
}
void draw() {
	blendMode(ADD);
	background(0);
	
	ps.applyForce(new PVector(0, 1));

	ps.applyForce(new PVector(force1, 0));

	for (int i = 0; i < 50; ++i) {
		ps.addParticle();
		ps.origin.set(mouseX + random(lastMouse.x - mouseX), mouseY + random(lastMouse.y - mouseY));
	}
	ps.update();

	lastMouse.set(mouseX, mouseY);
}
