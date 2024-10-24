 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>File Upload</title>
</head>
 
<body  onpaste='return false;'>
    <h1>File Upload Form</h1>
    <hr/>
 
    <fieldset>
        <legend>Upload File</legend>
        <form action="../uploadservlet" method="post" enctype="multipart/form-data">
            <label for="filename_1">File: </label>
            <input id="filename_1" type="file" name="filename_1" size="50"/><br/>
            <label for="filename_2">File: </label>
            <input id="filename_2" type="file" name="filename_2" size="50"/><br/>
			<label for="filename_3">File: </label>
            <input id="filename_3" type="file" name="filename_3" size="50"/><br/>
			<label for="filename_4">File: </label>
            <input id="filename_4" type="file" name="filename_4" size="50"/><br/>
            <br/>
            <input type="submit" value="Upload File"/>
        </form>
    </fieldset>
</body>
</html>