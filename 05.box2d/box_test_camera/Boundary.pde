import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

class Boundary  {
	Body body;
	float x, y;
	float w, h;
	public Boundary (float x_, float y_, float w_, float h_) {
		x = x_;
		y = y_;
		w = w_;
		h = h_;

		BodyDef bd = new BodyDef();
		bd.type = BodyType.STATIC;
		bd.position.set(box2d.coordPixelsToWorld(x, y));
		body = box2d.createBody(bd);

		PolygonShape ps = new PolygonShape();

		float box2dDw = box2d.scalarPixelsToWorld(w/2);
		float box2dDh = box2d.scalarPixelsToWorld(h/2);
		ps.setAsBox(box2dDw, box2dDh);


		body.createFixture(ps, 1);

	}

	void display () {
		fill(175);

		rectMode(CENTER);
		rect(x, y, w, h);

	}

	void killBody() {
		box2d.destroyBody(body);
	}


}