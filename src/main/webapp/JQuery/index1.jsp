<html>
<head>
	<title>Simple jQuery and JSP example</title>
	<script src="jquery-1.4.2.js" type="text/javascript"></script>
	<script src="script.js" type="text/javascript"></script>
</head>
<body  onpaste='return false;'>
<form id="form" action="calculate.jsp" method="post">
	Enter number:
	<input id="number" type="text" name="number" />

	<input id="submit" type="submit" value="Calculate Square Root" name="submit"/>
</form>
<p id="result"></p>
</body>
</html>