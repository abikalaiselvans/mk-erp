<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 
<%@ include file="index.jsp"%>
<%!
String sl;
	ArrayList empdata = new ArrayList();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
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
 <script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="../JavaScript/Attendance/ProxymityAjax.js"></script>

<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="Proxymitycardissue.jsp";
 	}

	function Edit()
 	{		
		
        obj = findObj("staffid"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}

		var count;
		count=0;
		coffee1=document.forms[0].staffid
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].staffid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="ProxymitycardissueEdit.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}	

 	function  Delete()
 	{		
		
		
        obj = findObj("staffid"); 
		if(obj == null)
		{
			alert("Delete not available");
			return false;
		}


		var count;
		count=0;
		coffee1=document.forms[0].staffid
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].staffid.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
				return true;			
			}
			else
				return false;
		}
		else
		{
		    alert("Select Atleast One Value");
		    return false;
		}		
 	}
 	
</script>
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
   
  <body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadProxy('0')" >

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><form  method="post" name="frm" id="frm">
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td><table width="90%" height="200" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"
			 >
              <tr  >
                <td height="31"  > 
                    <table width="90%" border="0" align="center" cellpadding="1"
					cellspacing="1" >
                      <tr>
                        <td  ><strong class="whiteMedium">Office</strong></td>
                        <td  ><%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 
			  %>
                            <select name="Office" class="formText135" id="Office"
							tabindex="6"  onChange="loadProxy('0')">
                              <option value="0">All</option>
                              <%
								
		String sq=" select INT_OFFICEID,CHR_OFFICENAME from  com_m_office  order by CHR_OFFICENAME";

		String shipids[][] =  CommonFunctions.QueryExecute(sq);
		for(int u=0; u<shipids.length; u++)
			if(shipids[u][0].trim().equals(oficeid.trim()))
				out.print("<option selected = 'selected' value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
			else
				out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
							%>
                          </select></td>
                        <td  class="whiteMedium" >Issued</td>
                        <td  ><select name="issued" id="issued"  class="formText135" onChange="loadProxy('0')" >
                        	<option value="-1">All</option>
                        	<option value="1">Issued</option>
                            <option value="0">Not Issue</option>
                        </select></td>
                         <td  class="whiteMedium" >Status</td>
                         <td  >&nbsp;</td>
                        <td  ><select name="status" id="status"  class="formText135"  onChange="loadProxy('0')">
                        <option value="0">All</option>
                        	<option value="Y">Returned</option>
                            <option value="N">Not Returned</option>
                        </select></td>
                        <td   class="whiteMedium"  >Search by Id/Name</td>
                        <td  ><input type="text"  class="formText135"   name="search" id="search" onKeyUp="loadProxys(this)"></td>
                      </tr>
                    </table>                 </td>
              </tr>
              <tr  >
                <td height="31"  ><table width="100%" border="0" class="whiteMedium"
					  >
                    <tr>
                      <td width="140">Staff Id</td>
                      <td width="130">Staff Name</td>
                      <td width="140">Company</td>
                      <td width="130">Branch </td>
                      <td width="130"> Department</td>
                      <td width="140">Designation</td>
                      <td width="100">Status</td>
                    </tr>
                </table></td>
              </tr>
              
              <tr bgcolor="#FFFFFF">
                <td  valign="top" class="footermenu">
				<div id="Proxytable" style="OVERFLOW:auto;width:100%;height:250px" class="boldEleven"></div>
				<br>
				<div id='totalrecord' align="center"></div></td>
              </tr>
          </table></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign">
              <tr class="para">
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('0')">All</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('A')">A</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('B')">B</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('C')">C</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('D')">D</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('E')">E</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('F')">F</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('G')">G</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('H')">H</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('I')">I</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('J')">J</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('K')">K</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('L')">L</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('M')">M</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('N')">N</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('O')">O</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('P')">P</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('Q')">Q</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('R')">R</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('S')">S</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('T')">T</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('U')">U</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('V')">V</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('W')">W</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('X')">X</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('Y')">Y</a></div></td>
                <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:loadProxy('Z')">Z</a></div></td>
              </tr>
          </table></td>
        </tr>
        <tr>
          <td><span class="boldEleven">
            <input type="hidden" name="filename" value="ProxymityCard" />
            <input type="hidden" name="actionS" value="ATTProxymityCardDelete" />
          </span></td>
        </tr>
        <tr>
          <td><div align="center">
            <%
			out.println("<table   border='0' align='center' cellpadding='1' cellspacing='1'>");
			out.println("<tr>");
			 
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_ADD_ATT FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='Add()' name='action1' id='action1' value='Add'>");
			else	
				out.println("<input type='hidden' name='action1' id='action1' value='Add'>");
			out.println("</td>");
			
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_EDIT_ATT FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
			 out.println("<input class='ButtonHead' type='submit' onClick='return Edit()' name='action1' id='action1' value='Edit'>");
			else	
				out.println("<input type='hidden'  name='Edit' id='Edit' value='Edit'>");
			out.println("</td>");
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_DELETE_ATT FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='return  Delete()' name='Submit' id='Submit' value='Delete'>");
			else	
				out.println("<input type='hidden'  name='Delete' id='Delete' value='Delete'>");
			out.println("</td>");	
			
			out.println("<td ' valign='top'>");
			out.println("<input type='button' class='ButtonHead' name='Button' value='Close' onClick=\"redirect('AttendanceMain.jsp')\" />");
			out.println("</td>");
			
			out.println("</tr>");	
			out.println("</table>");
			
			%>
          </div></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
      </table>
    </form></td>
  </tr>
</table>

<%@ include file="../footer.jsp"%> 
</body>
</html>
