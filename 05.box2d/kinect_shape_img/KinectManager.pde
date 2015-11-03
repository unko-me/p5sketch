import org.openkinect.freenect.*;
import org.openkinect.processing.*;



class KinectManager {
	Kinect kinect;
	boolean colorDepth = false;

	KinectManager(PApplet p) {
		initKinect(p);
	}

	private void initKinect(PApplet p) {
		kinect = new Kinect(p);
		kinect.enableMirror(true);
		kinect.initDepth();
		kinect.initVideo();
  		//kinect.enableIR(ir);
  		kinect.enableColorDepth(colorDepth);
	}

}