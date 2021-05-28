<cfset pdfs = directoryList(expandPath('./pdfs'))>

<html>

<head>
<title>PDF List</title>
</head>

<body>

<h2>PDF Directory</h2>

<ul>
<cfloop index="p" array="#pdfs#">
	<cfset fileName = listLast(p, "\")>
	<cfoutput>
	<li><a href="pdf.cfm?filename=#fileName#">#filename#</a></li>
	</cfoutput>
</cfloop>
</ul>

</body>
</html>