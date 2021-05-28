
<cfscript>
// input is a PDF that needs to be OCRed
input = expandPath('./pdf_that_needs_ocr.pdf');

//remove existing output if it's there
output = expandPath('./pdf_with_ocr.pdf');
if(fileExists(output)) fileDelete(output);

// create and setup credentials
cred = createObject('java','com.adobe.platform.operation.auth.Credentials');
jsonFile = expandPath('./pdftools-api-credentials.json');
credentials = cred.serviceAccountCredentialsBuilder().fromFile(jsonFile).build();

// this sets up what we want to do, create a pdf
ex = createObject('java','com.adobe.platform.operation.ExecutionContext').create(credentials);
ocrOp = createObject('java', 'com.adobe.platform.operation.pdfops.OCROperation').createNew();

// point to our source
source = createObject('java','com.adobe.platform.operation.io.FileRef').createFromLocalFile(input);
ocrOp.setInput(source);

// make it so!
result = ocrOp.execute(ex);

result.saveAs(output);
</cfscript>

<p>
I'm done creating your awesome PDF. Enjoy.
</p>