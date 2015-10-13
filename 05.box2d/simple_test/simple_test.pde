import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;


int WIDTH  = 640;
int HEIGHT = 640;

Box2DProcessing box2d;

void setup () {
	size(640, 640);
	smooth();
	frameRate(30);
	background(0x999999);

	setupWorld();
	setupBody();

}
void draw() {
	stroke(255);
}

private void setupWorld() {
	box2d = new Box2DProcessing(this);
	box2d.createWorld();
	box2d.setGravity(0, -10);
}

private void setupBody() {
	BodyDef bd = new BodyDef();
	Vec2 center = box2d.coordPixelsToWorld(width / 2, height / 2);
	bd.position.set(center);
	bd.fixedRotation = true;
	bd.linearDamping = 0.89;
	bd.angularDamping = 0.89;
	bd.bullet = true;

	Body body = box2d.createBody(bd);
	body.setLinearVelocity(new Vec2(0, 3));
	body.setAngularVelocity(1.2);

	PolygonShape ps = new PolygonShape();

	float box2dDw = box2d.scalarPixelsToWorld(150);
	float box2dDh = box2d.scalarPixelsToWorld(100);

	ps.setAsBox(box2dDw, box2dDh);

	FixtureDef fd = new FixtureDef();
	fd.shape = ps;
	fd.density = 1; //密度
	fd.friction = 0.3; //摩擦
	fd.restitution = 0.5; //弾力性

	body.createFixture(fd);

}
