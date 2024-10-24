<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html>
<head>
<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">
<meta http-equiv="refresh" content="10;url=ErrorLogDocumentation.jsp">
 
<title><%=CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='DEB' ")[0][0]%></title>
<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<script language="javascript" src="../JavaScript/Debug/LogfileAJAX.js"  ></script>
<%
		  			java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("yyyy-MM-dd");
					java.util.Date date = new java.util.Date(); 
					String updatedate = "" + datetime.format(date);
					
	    %>

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form id ="frm" method="post" action="../SmartLoginAuth">
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><%@ include file="index.jsp"%> </td>
  </tr>
  <tr>
    <td align="center">&nbsp;</td>
  </tr>
  <tr>
    <td  align="center">&nbsp;</td>
  </tr>
  <tr>
    <td  align="center"><table width="90%"  border="0" align="center"
			cellpadding="2" cellspacing="2" class="TableDesign"  
			 >
      <tr  >
        <td height="31"  ><div align="center" class="whiteMedium">ERROR LOG - <%=updatedate%></div></td>
      </tr>
      <tr class="MRow1">
        <td align="left" valign="top" > 
         
                
        <div id="table" style="OVERFLOW:auto;width:100%;height:500px"  >  
		<%
				DataInputStream dis = new DataInputStream(new BufferedInputStream(new FileInputStream(request.getRealPath("")+"/log/"+updatedate+".txt")));
				String line;
				while ((line = dis.readLine()) != null) 
				{
					out.println(line+"<br><br>");
				}
				dis.close();
				out.println("<br><br><br><br><input type='hidden' name='lastl' autofocus/>");
		%>
        </div>
        
                
        
          <br></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td  align="center">&nbsp;</td>
  </tr>
  <tr>
    <td  align="center">&nbsp;</td>
  </tr>
  <tr>
    <td  align="center">&nbsp;</td>
  </tr>
  <tr>
    <td align="center"><p>&nbsp;</p>
      <table   border="0" align="center" cellpadding="1" cellspacing="1">
        <tr>
          <td width="56"><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('Debugmain.jsp')"  >
		  
		  </td>
        </tr>
      </table>      
	  </td>
  </tr>
  <tr>
    <td><%@ include file="../footer.jsp"%> </td>
  </tr>
</table>
 
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
</form>
</body>
</html>

 


