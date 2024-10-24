<%@ page import="java.util.*,java.io.*,java.net.*,com.my.org.erp.common.*" errorPage="error.jsp"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.alert.*"%>
<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.setHeader("Cache-Control", "no-store");
 
try
{
	
	if("1".equals(CommonFunctions.QueryExecute("SELECT FUN_WEDDINGDATE(FIND_WEDDINGDATE())")[0][0]))
		response.sendRedirect("Logout.jsp");

	
%>
<html>
<head>

<title>HOME</title>

<%@ include file="JavaScript/dynamicStylesheet.jsp" %>


<script language="javascript" src="JavaScript/comfunction.js"></script>
<script language="javascript" src="JavaScript/Servercheck.js"></script>
<script language="javascript">loadServer()</script>




<script language="javascript">
function valid(){
<%
	
	 
	String userid=""+session.getAttribute("USRID"); 
	String userpass=""+session.getAttribute("USRPWD"); 
	String empid=""+session.getAttribute("EMPID"); 
	
	
	if(userid.equals("null") || userpass.equalsIgnoreCase("null")) {
		response.sendRedirect("Login.jsp?loginmsg=Login Expired");
	}
	String userType=""+session.getAttribute("USERTYPE");
	String url="<a href='Utility/Utilitymain.jsp'><img src='images/erp/erp_utility.gif'   border='0'></a>";	
	if(userType.equalsIgnoreCase("F") || userType.equalsIgnoreCase("A")  || userType.equalsIgnoreCase("B"))
	   url="<a href='Utility/Utilitymain.jsp'><img src='images/erp/utility.png' border='0' name='utility'  id='utility'  onmouseover=\"utility.src= 'images/erp/utility.png' \"  width='140' height='130'  onmouseout=\" utility.src= 'images/erp/utility1.png'\"></a>";	
	else
	   url="<img src='images/erp/utility1.png' width='140' height='130'   border='0'  id='utility' name='utility'   onmouseover=\"utility.src= 'images/erp/utility.png' \"  onmouseout=\" utility.src= 'images/erp/utility1.png'\">";		
	
	
%>
}</script>
<link rel="icon" type="image/ico" href="images/ERP.ico"></link>
<link rel="shortcut icon" href="images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<link href="JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">


</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="valid()">


<table width="100%" height="655" border="0" align="center" cellpadding="0" cellspacing="0">
	
	<tr>
			  <td  align="center" valign="middle"><%@ include file="header.jsp"%></td>
	</tr>
	<tr>
		<td  align="center" valign="top">
		 	  </td>
	</tr>
	<tr>
	  <td height="21" valign="middle" class="copyright"><div align="right">Last Login Time :: <%=CommonFunctions.QueryExecute("SELECT DATE_FORMAT(DAT_LOGINDATEANDTIME,'%d-%b-%Y %h:%i:%s : %p') FROM m_user WHERE CHR_USRNAME='"+session.getAttribute("USRID")+"'")[0][0]%> &nbsp;&nbsp;&nbsp;&nbsp; </div></td>
  </tr>
	<tr>
	  <td height="21" valign="middle" class="copyright"><table width="100%" height="570" border="0" align="center" cellpadding="0" cellspacing="0" >
         
        <tr>
          <td valign="bottom"><div align="center"><a href="Smart Common/commonmain.jsp"><img src="images/erp/common1.png" width="140" height="130" border="0" name='common'  id='common'  onmouseover="common.src= 'images/erp/common.png'"  onmouseout=" common.src= 'images/erp/common1.png'"/></a></div></td>
          <td valign="bottom"><div align="center"><a href="Smart HRM/HRMmain.jsp"><img src="images/erp/HRM1.png" width="140" height="130" border="0" id='HRM' name='HRM'   onmouseover="HRM.src= 'images/erp/HRM.png'"  onmouseout=" HRM.src= 'images/erp/HRM1.png'"/></a></div></td>
          <td valign="bottom"><div align="center"><a href="Smart Attendance/AttendanceMain.jsp"><img src="images/erp/Attendance1.png" width="140" height="130" border="0" id='Attendance' name='Attendance'   onmouseover="Attendance.src= 'images/erp/Attendance.png'"  onmouseout=" Attendance.src= 'images/erp/Attendance1.png'"/></a></div></td>
          <td valign="bottom"><div align="center"><a href="Smart Payroll/Payrollmain.jsp"><img src="images/erp/Payroll1.png" width="140" height="130" border="0"  id='Payroll1' name='Payroll1'   onmouseover="Payroll1.src= 'images/erp/Payroll.png'"  onmouseout=" Payroll1.src= 'images/erp/Payroll1.png'"/></a></div></td>
          <td valign="bottom"><div align="center"><a href="Smart Inventory/Main.jsp"><img src="images/erp/Inventory1.png" width="140" height="130" border="0"  id='Inventory' name='Inventory'   onmouseover="Inventory.src= 'images/erp/Inventory.png'"  onmouseout=" Inventory.src= 'images/erp/Inventory1.png'"/></a></div></td>
        </tr>
        <tr>
          <td valign="bottom"><div align="center"><a href="Smart Accounts/Main.jsp"><img src="images/erp/Accounts1.png" width="140" height="130" border="0"  id='Accounts' name='Accounts'   onmouseover="Accounts.src= 'images/erp/Accounts.png'"  onmouseout=" Accounts.src= 'images/erp/Accounts1.png'"/></a></div></td>
          <td valign="bottom"><div align="center"><a href="Smart Asset/Assetmain.jsp"><img src="images/erp/Asset1.png" width="140" height="130" border="0"  id='Asset' name='Asset'   onmouseover="Asset.src= 'images/erp/Asset.png'"  onmouseout=" Asset.src= 'images/erp/Asset1.png'"/></a></div></td>
          <td valign="bottom"><div align="center"><a href="Smart Conveyance/Conveyancemain.jsp"><img src="images/erp/Conveyance1.png" width="140" height="130" border="0"  id='Conveyance' name='Conveyance'   onmouseover="Conveyance.src= 'images/erp/Conveyance.png'"  onmouseout=" Conveyance.src= 'images/erp/Conveyance1.png'"/></a></div></td>
          <td valign="bottom"><div align="center"><a href="Help/frame1.html" target="_blank"><img src="images/erp/Help1.png" width="140" height="130" border="0"  id='Help' name='Help'   onmouseover="Help.src= 'images/erp/Help.png'"  onmouseout=" Help.src= 'images/erp/Help1.png'"/></a></div></td>
          <td valign="bottom"><div align="center"><a href="Smart Marketing/MarketingMain.jsp"><img src="images/erp/Marketing1.png" width="140" height="130" border="0"  id='Marketing' name='Marketing'   onmouseover="Marketing.src= 'images/erp/Marketing.png'"  onmouseout=" Marketing.src= 'images/erp/Marketing1.png'"/></a></div></td>
        </tr>
        <tr>
          <td valign="bottom"><div align="center"><a href="Smart Management/ManagementMain.jsp"><img src="images/erp/Management1.png" width="140" height="130" border="0"  id='Management' name='Management'   onmouseover="Management.src= 'images/erp/Management.png'"  onmouseout=" Management.src= 'images/erp/Management1.png'"/></a></div></td>
          <td valign="bottom"><div align="center"><a href="Smart AMC/Main.jsp"><img src="images/erp/crm1.png" width="140" height="130" border="0"  id='crm' name='crm'   onmouseover="crm.src= 'images/erp/crm.png'"  onmouseout=" crm.src= 'images/erp/crm1.png'"/></a></div></td>
          <td valign="bottom"><div align="center"><a href="Smart SMS/Smsmain.jsp"><img src="images/erp/sms1.png" width="140" height="130" border="0" / id='sms' name='sms'   onmouseover="sms.src= 'images/erp/sms.png'"  onmouseout=" sms.src= 'images/erp/sms1.png'"></a></div></td>
          <td valign="bottom"><div align="center"><a href="Smart Transport/Transportmain.jsp"><img src="images/erp/Transport1.png" width="140" height="130" border="0"  id='Transport' name='Transport'   onmouseover="Transport.src= 'images/erp/Transport.png'"  onmouseout=" Transport.src= 'images/erp/Transport1.png'"/></a></div></td>
          <td valign="bottom"><div align="center"><%=url%></div></td>
        </tr>
        <tr>
          <td valign="bottom"><div align="center"><a href="Smart Servicereport/ServiceReportmain.jsp"><img src="images/erp/Sevicereport1.png" width="140" height="130" border="0"  id='Sevicereport' name='Sevicereport'   onmouseover="Sevicereport.src= 'images/erp/Sevicereport.png'"  onmouseout=" Sevicereport.src= 'images/erp/Sevicereport1.png'"/></a></div></td>
          <td valign="bottom"><div align="center"><a href="Smart Debug/Debugmain.jsp"><img src="images/erp/debug1.png" width="140" height="130" border="0"  id='debug' name='debug'   onmouseover="debug.src= 'images/erp/debug.png'"  onmouseout=" debug.src= 'images/erp/debug1.png'"/></a></div></td>
          <td valign="bottom"><div align="center"><a href="Smart UploadDownload/uploadMain.jsp"><img src="images/erp/fileupload1.png" width="140" height="130" border="0" id='fileupload' name='fileupload'   onmouseover="fileupload.src= 'images/erp/fileupload.png'"  onmouseout=" fileupload.src= 'images/erp/fileupload1.png'"></a></div></td>
          <td valign="bottom"><div align="center"><a href="Smart Training/TrainingMain.jsp"><img src="images/erp/training1.png" width="140" height="130" border="0" id='trainning' name='trainning'   onmouseover="trainning.src= 'images/erp/training.png'"  onmouseout=" trainning.src= 'images/erp/training1.png'"></a></div></td>
          <td valign="bottom"><div align="center"><a href="Logout.jsp"><img src="images/erp/Logout1.png" width="140" height="130" border="0"  id='Logout' name='Logout'   onmouseover="Logout.src= 'images/erp/Logout.png'"  onmouseout=" Logout.src= 'images/erp/Logout1.png'"/></a></div></td>
        </tr>
        
      </table></td>
  </tr>
	<tr>
	  <td height="21" valign="middle" class="copyright">&nbsp;</td>
  </tr>
	<tr>
		<td height="21" valign="middle" class="copyright">
	  <%
		String message= "";
		message=AlertFuntion.ScrollingMessage();
		double target= MEAlertFuntion.METargetAlert(empid);
		double achieve= MEAlertFuntion.METargetCollection(empid) ;
		if(target >0.0)
		{
		%>
		<script language="javascript">
			alert(" THIS MONTH TARGET -><%=target%>(In Lakhs) AND  ACHIEVE FOR THE MONTH -> <%=achieve%>");
		</script>
		<%
	 		out.println("<center><font class='bolddeepred'>");
			out.println("TARGET FOR THE MONTH  : "+ MEAlertFuntion.METargetAlert(empid)+"(In lakhs)");
			out.println("ACHIEVE FOR THE MONTH : "+achieve+"");
			out.println("</font> </center>");
		}	
	%>   <%
	  	/*double money = 100550000.1543545;
        NumberFormat formatter = new DecimalFormat("#0.000");
        //System.out.println(formatter.format(money));*/
		////System.out.println(com.my.org.erp.General.General.FixDigitFormat(123.456 ));
		
		 	  %>
			  
			  
			  <%
	  /*Enumeration enums = session.getAttributeNames();
      while (enums.hasMoreElements()) 
	  {
      	String attributes = (String) enums.nextElement();
        out.println(""+attributes+"="+
        session.getAttribute(attributes)+"<BR>");
      }
      session.setAttribute("lastVisit",thisVisit);*/
    %>	  </td>
	</tr>
	<tr>
	  <td height="21" valign="middle" class="copyright">&nbsp;</td>
  </tr>
	<tr>
	  <td height="21" valign="middle" class="copyright"> 
      
       <div style="width:100%" align="center">
	  <marquee id="marquee1" class="copyright"> <%=message%> </marquee>  
	  </div> </td>
  </tr>
	<tr>
	  <td height="21" valign="middle" class="copyright">&nbsp;</td>
  </tr>
	<tr>
	  <td height="21" valign="middle" class="copyright"><%
	  message= AlertFuntion.YearCompletionList();
	  %>
	    <div style="width:100%" align="center">
	  <marquee id="marquee2" class="copyright"> <%=message%> </marquee>  
	  </div>  </td>
  </tr>
	<tr>
	  <td height="21" valign="middle" class="copyright"><%@ include file="footer1.jsp"%></td>
  </tr>
</table>
<br><br> 
<%
String pdatas[][] = CommonFunctions.QueryExecute("SELECT  DATEDIFF(now(),DAT_LASTPASSWORDCHANGE),( DATEDIFF(now(),DAT_LASTPASSWORDCHANGE)>180)  FROM m_user WHERE CHR_EMPID='"+session.getAttribute("USRID")+"'");
String  mes="";
if(pdatas.length>0)
	if("1".equals(pdatas[0][1] ))
		{
			mes =" Your login password "+pdatas[0][0]+"days old...";
			%>
			<script language="javascript">alert('<%=mes%>')</script>
			<%
		}
		
		
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>
<script language="javascript">
document.getElementById("marquee1").width=screen.width ;
document.getElementById("marquee2").width=screen.width ;
</script>
</body>
</html>
