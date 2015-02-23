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

		vector.x += (0 - vector.x) * 0.01;
		vector.y += (0 - vector.y) * 0.01;

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