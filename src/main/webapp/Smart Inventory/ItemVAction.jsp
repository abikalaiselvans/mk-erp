<html>
<head>
<title>:: INVENTORY ::</title></head>

<body >
<script language="javascript">
	var x = "<%= request.getParameter("addMore")%>"
	if (x=="Y"){
		z = confirm("Do You Want to Add One More Record?");
		if (z==false)
			location="ItemView.jsp";
		else
			location="ItemAction.jsp?action1=Add"
	}
</script>
</body>
</html>
