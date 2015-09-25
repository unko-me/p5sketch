import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

class Box  {

	Body body;
	float x, y;
	float w, h;

	public Box (float x_, float y_) {
		x = x_;
		y = y_;
		w = 16;
		h = 16;

		BodyDef bd = new BodyDef();
		bd.type = BodyType.DYNAMIC;
		bd.position.set(box2d.coordPixelsToWorld(mouseX, mouseY));
		body = box2d.createBody(bd);

		PolygonShape ps = new PolygonShape();

		float box2dDw = box2d.scalarPixelsToWorld(w/2);
		float box2dDh = box2d.scalarPixelsToWorld(h/2);
		ps.setAsBox(box2dDw, box2dDh);

		FixtureDef fd = new FixtureDef();
		fd.shape = ps;
		fd.density = 1; //密度
		fd.friction = 0.3; //摩擦
		fd.restitution = 0.5; //弾力性

		body.createFixture(fd);
	}

	void display () {
		fill(175);
		stroke(255);

		Vec2 pos = box2d.getBodyPixelCoord(body);
		float a = body.getAngle();

		pushMatrix();
		translate(pos.x, pos.y);
		rotate(-a);
		rectMode(CENTER);
		rect(0, 0, w, h);
		popMatrix();
	}

	void killBody() {
		box2d.destroyBody(body);
	}

	boolean done() {
    /~se;
  }

}