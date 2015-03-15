import javax.media.opengl.*;
import processing.opengl.*;
 
PGraphicsOpenGL pgl;
GL gl;
 
void setup() {
  size(200, 200, OPENGL);
  pgl = (PGraphicsOpenGL)g;
}
 
void draw() {
  background(0);
  fill(128, 96, 64, 127);
 
  gl = pgl.beginGL();
 
  //  色の合成方法を加算合成にする
  gl.glBlendFunc(gl.GL_SRC_ALPHA,gl.GL_ONE);
 
  for (int y = 0; y < height * 2; y += 100) {
    for (int x = 0; x < width * 2; x += 100) {
      ellipse(x, y, 250, 250);
    }
  }
 
  pgl.endGL();
}