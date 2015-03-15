float rotation = 0.0;

void setup(){
  size(400, 400, P3D);    //P3Dと書くことによって、3D空間であることを明示する
}
 
void draw(){
  background(0);
 
  translate(width/2, height/2);    //立体の中心を画面中央に移動
  rotateY(radians(rotation++));    //Y軸に対して60度回転
  box(150, 150, 150);    //150 x 150 x 150pxの立方体を描画
}