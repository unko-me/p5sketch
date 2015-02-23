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

		vector.x *= 0.8;
		vector.y *= 0.8;

	}
	public String toString() {
		return "[Particle] x" + position.x + ", y:" + position.y;
	}

}