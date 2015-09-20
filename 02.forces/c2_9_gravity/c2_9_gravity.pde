
Mover[] movers = new Mover[10];
Attractor a;

int WIDTH  = 640;
int HEIGHT = 640;


void setup () {
	size(WIDTH, HEIGHT);
	smooth();
	frameRate(30);
	background(0x999999);

	generator = new Random();

	for (int i = 0; i < movers.length; ++i) {
		movers[i] = new Mover(random(2, 4), random(0, width), random(0, height));
	}
	a = new Attractor(50);

}

void draw() {
	fill(0, 100);
	rectMode(CORNER);
	rect(0, 0, width, height);

	a.move();

	a.display();
	for (int i = 0; i < movers.length; ++i) {
		Mover mover = movers[i];
		PVector f = a.attract(mover);
		mover.applyForce(f);

		mover.update();
		mover.display();
	}
	
}
