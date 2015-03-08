int WIDTH  = 640;
int HEIGHT = 640;

Segment[] _segmentList;
int NUM_SEGMENTS = 30;

boolean _mouseDown;

void setup () {
	size(WIDTH, HEIGHT);
	smooth();
	frameRate(30);
	background(0x999999);

	_init();
}

void _init()   {
	_segmentList = new Segment[NUM_SEGMENTS];
	Segment prevSeg = null;
	Segment seg;
	for (int i = 0; i < NUM_SEGMENTS; ++i) {
		seg = new Segment();
		_segmentList[i] = seg;
		seg.position.x = random(-50.1f, 50.1f) + WIDTH / 2;
		seg.position.y = random(-50.1f, 50.1f) + HEIGHT / 2;
		if (prevSeg != null) { 
			// prevSeg.addSegment(seg);
			seg.addSegment(prevSeg);
		}
		prevSeg = seg;
	}
}

void draw() {
	fillBg();
	stroke(255);
	_updateSeg1();
	_updateSegments();
}

void _updateSeg1() {
	Segment seg = _segmentList[0];

	seg.updateMouse((mouseX - seg.position.x) * 0.31, (mouseY- seg.position.y) * 0.31);
}

void fillBg() {
	noStroke();
	// fill(0x000000);
	fill(0, 100);
	rectMode(CORNER);
	rect(0, 0, width, height);
}


void _updateSegments() {
	int i = 0;
	Segment prevSeg = null;
 	for (Segment seg : _segmentList) {
 		float power = i * 0.05;
 		power = min(power , 0.5);
 		seg.update(power);
 		if (i == 0)
 			fill(255);
 		else
 			fill(0);

 		i++;
 		ellipse(seg.position.x, seg.position.y, 10 + sin(i) * 10, 10 + sin(i) * 10);

 		// drawLine
 		if (prevSeg != null)
 			line(prevSeg.position.x, prevSeg.position.y, seg.position.x, seg.position.y);
 		prevSeg = seg;
 	}
 }