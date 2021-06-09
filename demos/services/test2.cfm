<!---
Same as test1, but createObject way...
--->
<cfscript>
//remove existing output if it's there
output = expandPath('./helloworld2.pdf');
if(fileExists(output)) fileDelete(output);

// create and setup credentials
cred = createObject('java','com.adobe.platform.operation.auth.Credentials');
jsonFile = expandPath('./pdftools-api-credentials.json');
credentials = cred.serviceAccountCredentialsBuilder().fromFile(jsonFile).build();

// this sets up what we want to do, create a pdf
ex = createObject('java','com.adobe.platform.operation.ExecutionContext').create(credentials);
pdfOp = createObject('java', 'com.adobe.platform.operation.pdfops.CreatePDFOperation').createNew();

// point to our source
source = createObject('java','com.adobe.platform.operation.io.FileRef').createFromLocalFile(expandPath("./helloworld.docx"));
pdfOp.setInput(source);

// make it so!
result = pdfOp.execute(ex);

result.saveAs(output);
</cfscript>

<p>
I'm done creating your awesome PDF. Enjoy.
</p>