<!---
First demo converts a DOCX file to PDF.
--->
Let's try it!<p>

<cfscript>
pdfInstance = java {

	import org.slf4j.Logger;
	import org.slf4j.LoggerFactory;

	import com.adobe.pdfservices.operation.ExecutionContext;
	import com.adobe.pdfservices.operation.auth.Credentials;
	import com.adobe.pdfservices.operation.exception.SdkException;
	import com.adobe.pdfservices.operation.exception.ServiceApiException;
	import com.adobe.pdfservices.operation.exception.ServiceUsageException;
	import com.adobe.pdfservices.operation.io.FileRef;
	import com.adobe.pdfservices.operation.pdfops.CreatePDFOperation;
	import java.io.IOException;

	import java.io.*;

	public class CreatePDFFromDOCX {

		// Initialize the logger.
		private static final Logger LOGGER = LoggerFactory.getLogger(CreatePDFFromDOCX.class);

		public void execute(String inputCreds, String inputDoc, String outputDoc) {
				
			try { 
				
				Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
				.fromFile(inputCreds)
				.build();
				
				ExecutionContext executionContext = ExecutionContext.create(credentials);
				CreatePDFOperation createPdfOperation = CreatePDFOperation.createNew();
				
				FileRef source = FileRef.createFromLocalFile(inputDoc);
				createPdfOperation.setInput(source);

				// Execute the operation.
				FileRef result = createPdfOperation.execute(executionContext);

				// Save the result to the specified location.
				result.saveAs(outputDoc);		

			} catch(IOException | SdkException | ServiceApiException | ServiceUsageException ex) {
				// handle error later, haha sure i will
				System.out.println("ray here");
				System.out.println(ex);
			}


		}
	}

}

creds = expandPath('./pdfservices-api-credentials.json');

input = expandPath('./helloworld.docx');
output = expandPath('./helloworld.pdf');

try {
	pdfInstance.execute(creds, input, output);
} catch(any e) {
	writeoutput('cf error');
	writedump(e);
}
writeoutput("<p>");
writeoutput('Done at ' & now());
</cfscript>