<html>
<head>
<title>:: INVENTORY ::</title></head>

<body >
<script language="javascript">
	var x = "<%= request.getParameter("addMore")%>"
	if (x=="Y"){
		z = confirm("Product Successfully added. Do you want to add one more record?");
		if (z==false)
			location="ProductListView.jsp";
		else
			location="ProductListAction.jsp?addMore=Y&action1=Add"
	}
</script>
</body>
</html>
