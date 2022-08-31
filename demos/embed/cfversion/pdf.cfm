<cfparam name="url.filename" default="">
<!--- Some basic validation, could be better! --->
<cfif url.filename is "" or listLast(url.filename, ".") is not "pdf" or not fileExists(expandPath('./pdfs/#url.filename#'))>
	<cflocation url="index.cfm" addtoken="false">
</cfif>

<html>
<head>
	<title>PDF Test</title>
	<style>
	body {
		background-color: blanchedalmond;
		font-family: Arial, Helvetica, sans-serif;
	}

	#pdfView {
		width: 75%;
		height: 600px;
	}
	</style>
</head>

<body>

<h1>PDF Display</h1>

<p>
Here is your requested document. Enjoy.
</p>

<div id="pdfView"></div>



<script src="https://documentcloud.adobe.com/view-sdk/viewer.js"></script>
<script>
<cfoutput>
const ADOBE_KEY = '#application.pdfkey#';
</cfoutput>

if (window.AdobeDC) displayPDF();
else {
  document.addEventListener("adobe_dc_view_sdk.ready", () => displayPDF());
}

function displayPDF() {

	let adobeDCView = new AdobeDC.View({clientId: ADOBE_KEY, divId: 'pdfView' });
	adobeDCView.previewFile({
	<cfoutput>
	content:{location: {url: './pdfs/#url.filename#'}},
	metaData:{fileName: '#url.filename#'}
	</cfoutput>
	});

}
</script>
</body>
</html>