public class FlowField  {
	PVector [][] field;
	int cols, rows;
	int resolution;

	FlowField () {
		resolution = 10;
		cols = width / resolution;
		rows = height / resolution;
		field = new PVector[cols][rows];
	}

}