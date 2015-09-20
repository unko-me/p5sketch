class Liquid {
	float x,y,w,h;
	float c;

	Liquid (float x_, float y_, float w_, float h_, float c_) {
		x = x_;
		y = y_;
		w = w_;
		h = h_;
		c = c_;
	}

	void display() {
		noStroke();
		fill(175);
		rect(x, y, w, h);
	}

	boolean contains(Mover m) {
		PVector l = m.location;
		return x < l.x  && l.x < x + w && y < l.y && l.y < y + h;
	}
	
	PVector drag(Mover m) {
		// Magnitude is coefficient * speed squared
		float speed = m.velocity.mag();
		float dragMagnitude = c * speed * speed;

		// Direction is inverse of velocity
		PVector dragForce = m.velocity.get();
		dragForce.mult(-1);

		// Scale according to magnitude
		// dragForce.setMag(dragMagnitude);
		dragForce.normalize();
		dragForce.mult(dragMagnitude);
		return dragForce;
  }

}