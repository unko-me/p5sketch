
import java.util.Iterator;

class ParticleSystem  {	

	ArrayList<Particle> plist;
	PVector origin;

	public ParticleSystem (PVector origin_, int total) {
		origin = origin_.get();
		plist = new ArrayList<Particle>();
		for (int i = 0; i < total; ++i) {
			plist.add(new Particle(origin));
		}
	}

	void addParticle() {
		plist.add(new Particle(origin));
	}

	void addParticle(float x, float y) {
		plist.add(new Particle(new PVector(x, y)));
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