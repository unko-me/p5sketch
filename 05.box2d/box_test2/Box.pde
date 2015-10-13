import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

class Box  {

	Body body;
	float x, y;
	float w, h;
	// static final color BLACK = color(0, 0, 0);

	public Box (float x_, float y_, float w_, float h_) {
		x = x_;
		y = y_;
		w = w_;
		h = h_;

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
		Vec2 pos = box2d.getBodyPixelCoord(body);
		float a = body.getAngle();

		color c;
		// if (pos.x < 0 || pos.y < 0) {
		if (pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height) {
			c = color(255);
		}
		else {
			int cIndex = int(pos.y) * width + int(pos.x);


			if (cIndex >= pixels.length) {
				c = color(255);
			}
			else {
				c = pixels[cIndex];
				// int r = c >> 16 & 0xFF;  // Faster way of getting red(argb)
				// int g = c >> 8 & 0xFF;   // Faster way of getting green(argb)
				// int b = c & 0xFF;
				// int xx = int(pos.x);
				// int yy = int(pos.y);
				// println("--" + r  + ", " + g  + ", " + b + ", " + xx + ", " + yy);
			}
			
		}
		fill(c);
		// stroke(255, 127);
		stroke(0, 127);
		// fill(175);
		// stroke(255);

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
	// Let's find the screen position of the particle
	Vec2 pos = box2d.getBodyPixelCoord(body);
	// Is it off the bottom of the screen?
	if (pos.y > height+w*h) {
	  killBody();
	  return true;
	}
	return false;
  }

}