import gab.opencv.*;

class LineAnim {
  int index = 0;
  int lineOffset = 10;
  int speed = 10;
  
  LineAnim (int startIndex, int lineOffset, int speed) {
    index = startIndex;
    this.lineOffset = lineOffset;
    this.speed = speed;
  }
  
  void update(ArrayList<PVector> points) {
    index %= points.size();
    draw(points);
    
    int spd = Math.min(speed, points.size() - 1);
    index += spd;
  }
  
  void draw(ArrayList<PVector> points) {
    PVector lastPoint = null;
    PVector point = null;
    int numPoints = points.size();
    
    noFill();
    beginShape();
    int offset = Math.min(lineOffset, numPoints - 1);
    for (int idx = index; idx < index + offset; idx++){
      int i_ = idx % numPoints;
      point = points.get(i_);
      if (point == null) {
        println(i_);
        continue;
      }
      
      lastPoint = point;
      
      
      vertex(point.x, point.y);
    }
    endShape(); 
  }
  
}