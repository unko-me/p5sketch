#!/bin/zsh

prjName=$1

mkdir -p $prjName

items=`cat <<EOT
int WIDTH  = 640;
int HEIGHT = 640;

void setup () {
	size(WIDTH, HEIGHT);
	smooth();
	background(0x999999);
}
void draw() {
	stroke(255);
	rect(0, 0, 100, 100);
}
EOT
`

echo "$items" > ./$prjName/$prjName.pde