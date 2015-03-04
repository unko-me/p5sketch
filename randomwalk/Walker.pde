public class Walker {
	int x;
	int y;
	public Walker () {
		x = width / 2;
		y = height / 2;
		
	}

	void display() {
		stroke(255);
		point(x, y);
	}

	void step() {
		x += int(random(3)) - 1;
		y += int(random(3)) - 1;
	}

}