<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%
try
{
%>
<html>
<head>

<title> :: ATTENDANCE ::</title>


 
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
		<td width="401" height="40">&nbsp;</td>
		<td width="227">&nbsp;</td>
		<td width="372">&nbsp;</td>
	</tr>
	<tr>
		<td height="300" colspan="3">
		  <p>&nbsp;</p>
	      <table class="BackGround" cellspacing="0" cellpadding="0" width="600"
			align="center" border="0">
            <tbody>
              <tr>
                <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
                <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
                <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
              </tr>
              <tr>
                <td height="6"><spacer height="1" width="1" type="block" /></td>
              </tr>
              <tr>
                <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
                <td width="6"><spacer height="1" width="1" type="block" /></td>
                <td ><table width="600" align="center">
                    <tr>
                      <td><div align="center"><span class="bold1">UTILITY SOFTWARE </span></div>
                          <table width="600" border="0" align="center">
                            <tr>
                              <td height="26" align="left" valign="top"><div align="right"><a href="Upload_utilitySoftware.jsp"  >Upload</a></div></td>
                            </tr>
                            <tr>
                              <td height="26" align="left" valign="top"><table>
                                    <tr>
                                      <td></td>
                                    </tr>
                                  </table>
                                <div align="center">
                                  <% 
			
	 
File folder = new File(request.getRealPath("")+"/uploadfiles/Utility Software/");
File[] listOfFiles = folder.listFiles();
out.println("<table width='600' border='0' align='center' cellpadding='2' cellspacing='2'>");
out.println("<tr>");
//out.println("<td class='boldEleven'><b>S.No");
//out.println("<td class='boldEleven'><B>Document Name");
int u=0;
String extn="";
String fileName="";
for (int i = 0; i < listOfFiles.length; i++) 
	if (listOfFiles[i].isFile()) 
	{
		if(u%2==0)
			out.println("<tr>");
		extn="";
		out.println("<td class='boldEleven'>"+(u+1)+"." );
		out.println("<td class='boldEleven'><a target='_blank' href='../uploadfiles/Utility Software/"+listOfFiles[i].getName()+"'>");
		fileName = listOfFiles[i].getName();
		int mid= fileName.lastIndexOf(".");
  		fileName=fileName.substring(0,mid);
  		out.println(fileName.toUpperCase());
		out.println("</a>");
		u=u+1;
	}	
		 
out.println("</table>");		


		%>
                              </div></td>
                            </tr>
                        </table></td>
                    </tr>
                    <tr>
                      <td colspan="2" align="left" valign="middle" class=""><table align="center" cellpadding="3" cellspacing="3">
                          <tr align="center">
                            <td width="56"><input class="buttonbold" type="button"
										name="Submit"  value="Close"   accesskey="c"  onClick="redirect('AttendanceMain.jsp')">                            </td>
                          </tr>
                        </table>
                  </tr>
                </table></td>
                <td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
                <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
              </tr>
              <tr>
                <td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
                <td height="6"><spacer height="1" width="1" type="block" /></td>
                <td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
              </tr>
              <tr>
                <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
              </tr>
            </tbody>
          </table>	      <p>&nbsp; </p></td>
	</tr>
	<tr>
		<td height="44" colspan="3">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="3"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</body>
</html>
<%
}
catch(Exception e)
{
}
%>