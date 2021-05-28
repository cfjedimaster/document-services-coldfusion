component {
	this.name = "pdf_embed_demo";

	public boolean function onApplicationStart() {
		application.pdfkey = "9861538238544ff39d37c6841344b78d";
		return true;
	}

	public boolean function onRequestStart(required string path) {
		if(url.keyExists('init')) {
			applicationStop();
			cflocation(url="./", addtoken="false");
		}
		return true;
	}
}