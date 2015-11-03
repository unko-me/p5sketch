
import java.util.Iterator;

class ParticleSystem  {	

	ArrayList<Particle> plist;
	PVector origin;
	PImage img;

	public ParticleSystem (PVector origin_, int total, PImage img_) {
		origin = origin_.get();
		plist = new ArrayList<Particle>();
		img = img_;
		for (int i = 0; i < total; ++i) {
			plist.add(new Particle(origin, img));
		}
	}

	void addParticle() {
		plist.add(new Particle(origin, img));
	}

	void addParticle(float x, float y) {
		plist.add(new Particle(new PVector(x, y), img));
	}

    void applyForce(PVector force) {
        for (Particle p : plist) {
            p.applyForce(force);
        }
    }

	void update() {
        println(plist.size());
        Iterator<Particle> it = plist.iterator();
        while (it.hasNext()) {
            Particle p = it.next();
            p.run();
            if (p.isDead()) {
                it.remove();
            }
        }

	}

}