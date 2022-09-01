


<cfscript>
// our Word doc
input = expandPath('./catTemplate_done.docx');

// our data (could be API, cfquery, etc)
data = fileRead(expandPath('./catowner.json'));
jsonData = createObject('java', 'org.json.JSONObject').init(data);

//remove existing output if it's there
output = expandPath('./cat.pdf');
if(fileExists(output)) fileDelete(output);

// create and setup credentials
cred = createObject('java','com.adobe.pdfservices.operation.auth.Credentials');

jsonFile = expandPath('./pdfservices-api-credentials.json');
credentials = cred.serviceAccountCredentialsBuilder().fromFile(jsonFile).build();

pdfOutput = createObject('java', 'com.adobe.pdfservices.operation.pdfops.options.documentmerge.OutputFormat').PDF;
documentMergeOptions = 
	createObject('java', 'com.adobe.pdfservices.operation.pdfops.options.documentmerge.DocumentMergeOptions').init(jsonData, pdfOutput);


// this sets up what we want to do, create a pdf
ex = createObject('java','com.adobe.pdfservices.operation.ExecutionContext').create(credentials);
docOp = createObject('java', 'com.adobe.pdfservices.operation.pdfops.DocumentMergeOperation').createNew(documentMergeOptions);

// point to our source
source = createObject('java','com.adobe.pdfservices.operation.io.FileRef').createFromLocalFile(input);
docOp.setInput(source);

// make it so!
result = docOp.execute(ex);

result.saveAs(output);
</cfscript>

<p>
I'm done creating your awesome PDF. Enjoy.
</p>