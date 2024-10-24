<%@ page import="java.sql.*,java.io.*,java.util.*,java.lang.String"%>
<%@ include file="index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>
<%!	
	String userid,staffid,str;
    Connection con=null;
    Statement stm=null;
    ResultSet rst=null;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
	
	function validateFields()
    {
   	 if(checkNull('name','Enter Staff Name')&& checkNullSelect('off','Select Office Name','Select')&& checkNullSelect('depart','Select Department Name','Select')
   	 && checkNullSelect('desig','Select Designation Name','Select'))
   	 {   	 	
   	 	   return true;
   	 }
   	 else
   	 {
   	   return false;	  
   	 }
    }
    function LoadImage()
    {
		var fname=document.getElementById("file").value;
    	document.getElementById("Image1").src=fname;    
    }	
 <%
	String empId=request.getParameter("staffid");		
	String path=request.getRealPath("")+"/Image/StaffImage/"+empId+".gif";
	File file=new File(path);
	if(file.exists()){
		out.println("document.getElementById('Image1').src="+path+";");
	}else
		out.println("document.getElementById('Image1').src='"+path+"';");
%> 
</script>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='COM' ")[0][0]%></title>

<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright"
	content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords"
	content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<style type="text/css">
<!--
.style8 {
	font-family: Verdana;
	font-size: 12px;
}

.style26 {
	font-size: 12px;
	font-weight: bold;
	font-family: Verdana;
}

a:visited {
	color: #663366;
}

a:hover {
	color: #FF0000;
}

a:active {
	color: #0000FF;
}
-->
</style>
</head>
<body onpaste='return false;'>
<P align="center">Photo UpLoad</P>
<form AUTOCOMPLETE="off" name="uploadForm" action="upload.jsp"
	enctype="multipart/form-data" method="post">
<table align="center">
	<tr>
		<td align="center"><input type="file" id="file" name="file"
			onchange="LoadImage()" /> <input TYPE=Button name='Upload'
			Value='Upload'
			onClick="uploadForm.Upload.value='Uploading...';document.uploadForm.action='upload.jsp';document.uploadForm.submit()">
		<p><input border="0" src="" id="Image1" name="Image1" width="330"
			height="296" type="image">
</table>
<input type="hidden" name="empId" value="<%= empId %>"></form>
<%@ include file="../footer.jsp"%>
</body>
</html>
