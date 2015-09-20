class Wave  {

	float x, y, w, amp, period;
	float xspacing = 8;
	float theta = 0.0;
	float r = 40.0;
	float circleRadius = 30.0;

	Wave (float x_, float y_, float w_, float amp_, float p_) {
		x = x_;
		y = y_;
		w = w_;
		amp = amp_;
		period = p_;
	}

	void update() {
		theta += 0.12;

	}

	void display() {

		float i = 0.0;
		for (float start = x; start < x + w; start += xspacing) {
			// float xx = cos(theta + i) * r + start;
			float yy = sin(theta + i) * amp + y;
			ellipse(start, yy, circleRadius, circleRadius);
			i += 0.31;
		}
		
	}

}