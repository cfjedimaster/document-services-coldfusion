
<cfscript>
// our Word doc
input = expandPath('./PlanetaryScienceDecadalSurvey.pdf');

outputPath = expandPath('./outputdynamic');
if(directoryExists(outputPath)) directoryDelete(outputPath, true);

// create and setup credentials
cred = createObject('java','com.adobe.pdfservices.operation.auth.Credentials');

jsonFile = expandPath('./pdfservices-api-credentials.json');
credentials = cred.serviceAccountCredentialsBuilder().fromFile(jsonFile).build();

ex = createObject('java','com.adobe.pdfservices.operation.ExecutionContext').create(credentials);
extractPDFOperation = createObject('java','com.adobe.pdfservices.operation.pdfops.ExtractPDFOperation').createNew();

source = createObject('java','com.adobe.pdfservices.operation.io.FileRef').createFromLocalFile(input);
extractPDFOperation.setInputFile(source);

// from Tony
java_ExtractElementType = createObject("java", "com.adobe.pdfservices.operation.pdfops.options.extractpdf.ExtractElementType");

java_Arrays = createObject("java", "java.util.Arrays");
extractElementList = variables.java_Arrays.asList([
		variables.java_ExtractElementType.TEXT,
		variables.java_ExtractElementType.TABLES
]);

extractOptions = createObject('java', 'com.adobe.pdfservices.operation.pdfops.options.extractpdf.ExtractPDFOptions')
.extractPdfOptionsBuilder()
.addElementsToExtract(extractElementList)
.build();

extractPDFOperation.setOptions(extractOptions);

result = extractPDFOperation.execute(ex);

outputZip = outputPath & "/info.zip";
result.saveAs(outputZip);

// unpack the result
cfzip(action="unzip", destination=outputPath, file=outputZip, recurse=true);

// and now read any tables
tables = directoryList(outputPath & "/tables", false, 'path');

tables.each((element, index) => {
	data = spreadsheetRead(element);
	colCount = spreadsheetGetColumnCount(data, 1);
	writeoutput("<h2>Table #element#</h2>");
	writeoutput("<table border='1'>");
	writeoutput("<tr>");
	for(k=1;k<=colCount;k++) {
		writeoutput("<td>#spreadsheetGetCellValue(data, 1, k)#</td>");
	}
	writeoutput("</tr>");
	for(i=2; i<= data.rowcount; i++) {
		writeoutput("<tr>");
		for(k=1;k<=colCount;k++) {
			writeoutput("<td>#spreadsheetGetCellValue(data, i, k)#</td>");
		}
		writeoutput("</tr>");
	}
	writeoutput("</table>");
});

</cfscript>

<p>
I'm done extracting your awesome PDF. Enjoy.
</p>