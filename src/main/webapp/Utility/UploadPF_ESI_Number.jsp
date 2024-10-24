<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html>
<head>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>
<%@include file="Redirect.jsp" %>
<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />
<title> :: UTILITY :: </title>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
</head>
 
<body  onpaste='return false;'>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" onSubmit="return valid()" action="../SmartLoginAuth" >
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><div align="center"><img src="../Image/report/msexcel-mysql1.jpg" width="60" height="60" title="Upload Excel File" border="0" ><a href="PFAccountNumberExcel Upload.jsp" target="_self" >Upload</a> Excel File </div></td>
  </tr>
  <tr>
    <td class="bolddeepred"><div align="center">
      <p>&nbsp;</p>
      <p>The excel file contains the data in the following format as well as the file in .xls(sheet1) format </p>
      <p>and removed the column names like <strong>Emp Id</strong>,<strong>Staff Name</strong></p>
      <p>&nbsp;</p>
    </div></td>
  </tr>
  <tr>
    <td><table width='60%' align="center"     cellpadding=2 cellspacing=1 bgcolor='#00008B'  class='formText135'  id='myTable' >
      <tr class="MRow1">
        <td width="147"><strong>Emp Id</strong></td>
        <td width="118"><strong>Staff Name</strong></td>
        <td width="118"><strong>PF JOIN DATE </strong></td>
        <td width="85"><strong>PF NUMBER</strong></td>
        </tr>
      <tr class="MRow1">
        <td>CISJUN2003000319</td>
        <td>ETHIRAJ S </td>
        <td>2011-12-23</td>
        <td><div align="right">70</div></td>
        </tr>
      <tr class="MRow1">
        <td>CISJAN2007001347</td>
        <td>SIVA SANKAR A </td>
        <td>2011-12-24</td>
        <td><div align="right">101</div></td>
        </tr>
       
    </table>    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
<br>

<%
		Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
		String path=request.getRealPath("/")+"Utility/PFACCOUTNUMBER.xls";
		File f = new File(path);
		int i=0;
		if(f.exists())
		{
			String myDB ="jdbc:odbc:Driver={Microsoft Excel Driver (*.xls)};DBQ="+path+";DriverID=22;";
			Connection cona = DriverManager.getConnection(myDB,"","");
			Statement sts = cona.createStatement();
			ResultSet rss = sts.executeQuery("SELECT * FROM [Sheet1$]");
			out.println("<table width='60%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' align='center'>");
			out.println("<tr class='MRow2'>");	
			out.println("<td class='boldEleven'><b>S.NO</td>");
			out.println("<td class='boldEleven'><b>Emp Id</td>");
			out.println("<td class='boldEleven'><b>Staff Name</td>");
			out.println("<td class='boldEleven'><b>PF Date of Joining</td>");
			out.println("<td class='boldEleven'><b>PF NUMBER</td>");
			out.println("<td class='boldEleven'><b><label><input id='Astatus' name='status' type='checkbox' value='A' onClick=\"Acceptall('Astatus')\" ></label>Check All</td>");
			
			String s="";
			String empid="";
			String empname="";
			String doj="";
			while(rss.next())
			{
				if(i%2==0)
					out.println("<tr class='MRow1'>");
				else
					out.println("<tr class='MRow2'>");	
				out.println("<td class='boldEleven'>"+(i+1)+".</td>");
				empid=rss.getString(1);
				empname=rss.getString(2);
				out.println("<td class='boldEleven'>"+empid+"</td>");
				out.println("<td class='boldEleven'>"+empname+"</td>");
				doj=rss.getString(3);
				out.println("<td class='boldEleven'>"+doj+"</td>");
				
				s= rss.getString(4);
				out.println("<td class='boldEleven'>"+s+"</td>");
				out.println("<td class='boldEleven'> <input type='hidden' id='empid"+i+"'  value='"+empid+"' name='empid"+i+"'><input type='hidden' id='doj"+i+"'  value='"+doj+"' name='doj"+i+"'>");
				out.println("<input type='hidden' id='pfnumber"+i+"'  value='"+s+"' name='pfnumber"+i+"'><input type='checkbox' id='accept"+i+"' name='accept"+i+"' vlue='Y'>");
				i= i+1;
			}	
			out.println("</table>");
			cona.close();
		}
		else
		{
			out.println("File not found, Please upload the file");
		}
%>

 <input name='dec' type='hidden' class='formText135'  id='dec' size='15' maxlength='100' value=<%=i%>> 
 <script language="javascript">
  
  	function Acceptall(ctr)
	{
		
		var len=document.getElementById("dec").value;
		if(document.getElementById(ctr).checked)
		{
			 
			for(var i=0;i<len;i++)
			{
		  		var fline="accept"+i;
				document.getElementById(fline).style.visibility="visible";
		  		document.getElementById(fline).checked=true;
	    	}
		}
		else
		{
			for(var i=0;i<len;i++)
			{
		  		var fline="accept"+i;
				document.getElementById(fline).style.visibility="visible";
		  		document.getElementById(fline).checked=false;
	    	}
		}
	}
	
	 
	
	
function valid()
{
	var len=document.getElementById("dec").value;
	var acount=0;
	for(var i=0;i<len;i++)
	 if(document.getElementById("accept"+i).checked)	  	
	 	acount=acount+1;
	if((acount<=0))
	{
		alert("Select Atleast One  ");
		return false;
	}	
	else
	{
		return true;
	}	
}	
	
</script>
				  
				  <input name="filename" type="hidden" value="UserRights" />
                  <input name="actionS"  type="hidden" value="UTIEmployeePFUpdate" />
                  <input name="invoicenumber" type="hidden" id="invoicenumber"> 
				  
				  <br>
				  <table width="152" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
									<td width="110"><input name="Update" type="submit"
											class="buttonbold13" id="Update" value="Update PF Numer"
											 ></td>
											
										<td  width="56"><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('Userframe.jsp')"></td>
									</tr>
  </table>
		
</form>
</body>
 </html>
<%
}
catch(Exception e)
{
out.println(e.getMessage());
}
%>
