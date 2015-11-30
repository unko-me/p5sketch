class ImageService {

	ArrayList<ArrayList<ImageSet>> imageLists;
	ArrayList<ImageSet> currentList;
	JSONArray json;

	ImageService (JSONArray json) {
		this.json = json;
		imageLists = new ArrayList<ArrayList<ImageSet>>();
		for(int i = 0; i < json.size(); i++){
			JSONObject obj = json.getJSONObject(i);
			createSetList(obj);
		}
		currentList = imageLists.get(2);
	}

	void createSetList(JSONObject obj) {
		ArrayList<ImageSet> setList = new ArrayList<ImageSet>();
		imageLists.add(setList);
		JSONArray images = obj.getJSONArray("images");

		for(int i = 0; i < images.size(); i++){
			JSONObject data = images.getJSONObject(i);
			setList.add(new ImageSet(data));
		} 
	}

	ImageSet getRandomImgSet() {
		return currentList.get(0);
	}

}