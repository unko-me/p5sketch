// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// An uneven surface boundary

class Surface {
  // We'll keep track of all of the surface points
  ArrayList<Vec2> surface;
  ArrayList<PVector> contoursPoints;
  Body body;

  Surface(ArrayList<PVector> contoursPoints) {
    this.contoursPoints = contoursPoints;
    surface = new ArrayList<Vec2>();

    // This is what box2d uses to put the surface in its world
    ChainShape chain = new ChainShape();

    float theta = 0;
    
    // This has to go backwards so that the objects  bounce off the top of the surface
    // This "edgechain" will only work in one direction!
    for (PVector point : contoursPoints) {
      surface.add(new Vec2(point.x, point.y));
    }

    // Build an array of vertices in Box2D coordinates
    // from the ArrayList we made
    Vec2[] vertices = new Vec2[surface.size()];
    for (int i = 0; i < vertices.length; i++) {
      Vec2 edge = box2d.coordPixelsToWorld(surface.get(i));
      vertices[i] = edge;
    }
    
    // Create the chain!
    chain.createChain(vertices,vertices.length);

    // The edge chain is now attached to a body via a fixture
    BodyDef bd = new BodyDef();
    bd.position.set(0.0f,0.0f);
    body = box2d.createBody(bd);
    // Shortcut, we could define a fixture if we
    // want to specify frictions, restitution, etc.
    body.createFixture(chain,1);

  }

  // A simple function to just draw the edge chain as a series of vertex points
  void display(Boolean isFill) {
    
    // noFill();
    if (isFill) {
      strokeWeight(2);
      stroke(200, 0, 0);
      fill(200, 0, 0);
    }
    else {
noStroke();
      noFill();
    }
    beginShape();
    for (Vec2 v: surface) {
      vertex(v.x,v.y);
    }
    endShape();
  }

  void killBody() {
    box2d.destroyBody(body);
  }

}


