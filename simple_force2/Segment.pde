public interface ISegmentEngine {
	public PVector update(ArrayList<PVector> list, PVector position);
}

public class SegmentEngine1 implements ISegmentEngine {

	public SegmentEngine1 () {
		
	}

	public PVector update(ArrayList<PVector> list, PVector position) {
		PVector power = new PVector();
		for (PVector target : list) {
			power.x += target.x;
			power.y += target.y;
			// power.x += (target.x - position.x) * 0.2;
			// power.y += (target.y - position.y) * 0.2;
		}
		return power;
	}
}

public class Segment {
	public PVector position;
	public PVector velocity;
	public PVector acceleration;
	public ArrayList<Segment> list;
	public ArrayList<PVector> vectorList;
	public ArrayList<PVector> posList;
	ISegmentEngine engine;


	public Segment () {
		position = new PVector();
		velocity = new PVector();
		acceleration = new PVector();
		list = new ArrayList<Segment>();
		vectorList = new ArrayList<PVector>();
		posList = new ArrayList<PVector>();


		engine = new SegmentEngine1();
	}

	void addSegment(Segment seg) {
		list.add(seg);
		vectorList.add(PVector.sub(seg.position, position));
		// posList.add(seg.position);
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

		PVector targetPosition = new PVector();
		int i = 0;
		for (PVector target : vectorList) {
			Segment seg = list.get(i);
			targetPosition.x -= target.x;
			targetPosition.y -= target.y;

			targetPosition.x += seg.position.x;
			targetPosition.y += seg.position.y;
		}


		// PVector power = engine.update(vectorList, position);

		PVector power = new PVector();
		power.x = (targetPosition.x - position.x) * 0.2;
		power.y = (targetPosition.y - position.y) * 0.2;

		acceleration = power;
		velocity.add(acceleration);
		position.add(velocity);

		velocity.div(1.5 + t);
		position.add(power);
		// position = power;
	}
}
