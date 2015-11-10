class ImageSet {

	PImage img;
	JSONObject data;

	ImageSet (JSONObject data) {
		this.data = data;
		img = loadImage(data.getString("src"));
	}

}