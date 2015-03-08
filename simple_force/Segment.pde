public interface ISegmentEngine {
	public PVector update(ArrayList<Segment> list, PVector position);
}

public class SegmentEngine1 implements ISegmentEngine {

	public SegmentEngine1 () {
		
	}

	public PVector update(ArrayList<Segment> list, PVector position) {
		PVector power = new PVector();
		for (Segment seg : list) {
			power.x += (seg.position.x - position.x) * 0.2;
			power.y += (seg.position.y - position.y) * 0.2;
		}
		return power;
	}
}

public class Segment {
	public PVector position;
	public PVector velocity;
	public PVector acceleration;
	public ArrayList<Segment> list;
	public ArrayList<PVector> posList;
	ISegmentEngine engine;


	public Segment () {
		position = new PVector();
		velocity = new PVector();
		acceleration = new PVector();
		list = new ArrayList<Segment>();
		posList = new ArrayList<PVector>();


		engine = new SegmentEngine1();
	}

	void addSegment(Segment seg) {
		list.add(seg);
		posList.add(seg.position);
	}

	void setPos(float x, float y) {
		position.x = x;
		position.y = y;
	}

	void updateMouse (float powerX, float powerY) {
		acceleration.x = powerX;
		acceleration.y = powerY;
		velocity.add(acceleration);
		position.add(velocity);
	}

	void update (float t) {
		PVector power = engine.update(list, position);

		acceleration = power;
		velocity.add(acceleration);
		position.add(velocity);

		velocity.div(1.5 + t);
		// position.add(power);
	}
}
