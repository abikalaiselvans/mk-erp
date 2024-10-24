<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>


<%
try
{
%>

<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
</style>
</head>
 
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/Inventory/Advance.js"></script>
<script language="JavaScript">
function Add()
{ 
	document.frm.action="AdvanceAdd.jsp";		
}



function Edit()
{		
	obj = findObj("advanceid"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}


	var count;
	count=0;
	coffee1=document.forms[0].advanceid
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
		if (document.forms[0].advanceid.checked) { count=1;}
	}
	if(count==1){			
		document.frm.action="AdvanceEdit.jsp";
		return true;
	}
	else
	{
		alert("Select Only one Value");
		return false;
	}
}	

function Delete()
{		
	obj = findObj("advanceid"); 
		if(obj == null)
		{
			alert("Delete not available");
			return false;
		}


	var count;
	count=0;
	coffee1=document.forms[0].advanceid;
	txt=""
	var id="";
	for (i=0;i<coffee1.length;++ i)
	{
		if (coffee1[i].checked)
		{
		count=count+1;
		id=i;
		}
	}
	if(count==0)
	{
		if (document.forms[0].advanceid.checked) { count=1;}
	}
	
	if(count>1)
	{
		alert("Kindly select one value");
		return false;
	}
	if(count==1)
	{			
		 
			
			var r=confirm("ARE YOU SURE YOU WANT TO DELETE THE ADVANCE  ..."+coffee1[id].value);
			if (r==true)
			{
				var reason=prompt("Reason for Delete :: ","For e.g - Value has to be change."); 
				var email=prompt("Kindly give the email id for sending informations for deleted Advance ","test@test.net"); 
				if (reason!=null && reason!="")
				{
					var d ="../SmartLoginAuth?advanceid="+coffee1[id].value+"&reason="+reason+"&email="+email;
					document.frm.action=d; 
					
				}	
			}			

	}
	else
	{
		alert("Select Atleast One Value");
		return false;
	}		
}
</script>
 
<body    onLoad="loadAdvanceAmount('0')">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	 
	<tr>
	  <td>	  </td>
	</tr>
	<tr>
		<td height="291"><table width="90%" height="307" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
          <tr  >
            <td height="31"  ><div align="center" class="whiteMedium">ADVANCE AMOUNT    &nbsp;&nbsp; &nbsp;&nbsp;   &nbsp;&nbsp;</div></td>
          </tr>
          <tr  >
            <td height="31"  ><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="whiteMedium">
             
              <tr>
                <td><strong>Branch
                  <%
				String branchid=""+session.getAttribute("BRANCHID");
				String usertype=""+session.getAttribute("USRTYPE");
				String user= ""+session.getAttribute("USRID"); 
				 
			%>
                </strong></td>
                <td><span class="boldThirteen">
                  <select name="Branch" class="formText135" style="width:200"
							id="Branch" tabindex="6"  onChange="loadAdvanceAmount('0')">
                    <%
								
				String shipids[][] = CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID ");
				if(usertype.equals("F"))
				{
				  for(int u=0; u<shipids.length; u++)
					out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
				}
				else
				{
					if(!"000021".equals(user))
					{
					 for(int u=0; u<shipids.length; u++)
						if(shipids[u][0].equals(branchid))
							out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
					}
					else
					{
					 for(int u=0; u<shipids.length; u++)
						out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
					}							
				}
						
							%>
                  </select>
                  <script language="javascript">
						  	setOptionValue("Branch","<%=branchid%>") 
						  </script>
                </span></td>
                <td><strong>Customer</strong></td>
                <td><span class="boldThirteen">
                  <select name="customer" style="width:200"
							id="customer" class="formText135"  onChange="loadAdvanceAmount('0')">
                    <option value="0">All</option>
                    <jsp:include page="LoadCustomer.jsp" />                  
</select>
                </span></td>
                <td>Type</td>
                <td><select name="advanceto" class="formText135" id="advanceto"   onChange="loadAdvanceAmount('0')">
                  <option value="0">All</option>
                  <option value="D">Sales</option>
                  <option value="S">Service</option>
                </select></td>
                </tr>
                
                 <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td colspan="3">&nbsp;</td>
              </tr>
              <tr>
                <td height="31" colspan="6" align="center" valign="top"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="whiteMedium">
                  <tr>
                    <td height="31">Division</td>
                    <td  ><span class="boldThirteen">
                      <select name="divis"
							class="formText135" id="divis" tabindex="1"  onChange="loadAdvanceAmount('0')"
							>
                        <option value='0'>All</option>
                        <%
								String division[][] = CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                      </select>
                    </span></td>
                    <td>Day</td>
                <td><select name="day" id="day"  onChange="loadAdvanceAmount('0') ">
                  <option value="0">All</option>
                  <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                </select></td>
                    <td >Month</td>
                    <td  ><select name="month" id="month" onChange="loadAdvanceAmount('0')">
                      <%@ include file="../JavaScript/Inventory/month.jsp"%>
                    </select></td>
                    <td  >Year</td>
                    <td  ><select name="year" id="year"
							 onChange="loadAdvanceAmount('0')">
                      <%@ include file="../JavaScript/Inventory/year.jsp"%>
                    </select>
                    <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						var day=d.getDate();
						setOptionValue('day',day);	
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
                      </script></td>
                   <!-- <td  >Status</td>
                    <td  >
					<select name="status" id="">
					<option value="0">All</option>
					<option value="0">Closed</option>
					<option value="0">Not Closed</option>
					<option value="0">Deleted</option>
					</select></td>-->
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
 
          <tr class="MRow1">
            <td height="127" valign="top" class="footermenu">
			<div id="AdvanceAmount" style="OVERFLOW:auto;width:100%;height:300px" > </div>
			<br>
			<br>
			<div id="totalrecord"></div>			</td>
          </tr>
        </table></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
        <tr class="para">
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('0')">All</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('A')">A</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('B')">B</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('C')">C</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('D')">D</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('E')">E</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('F')">F</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('G')">G</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('H')">H</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('I')">I</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('J')">J</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('K')">K</a></div></td> 
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('L')">L</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('M')">M</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('N')">N</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('O')">O</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('P')">P</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('Q')">Q</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('R')">R</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('S')">S</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('T')">T</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('U')">U</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('V')">V</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('W')">W</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('X')">X</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('Y')">Y</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadAdvanceAmount('Z')">Z</a></div></td>
        </tr>
      </table></td>
    </tr>
	 
	<tr>
	  <td><input name="filename" type="hidden" value="Advance" />
        <input
			name="actionS" type="hidden" value="INVAdvanceDelete" /></td>
    </tr>
	<tr>
	  <td height="32"> <div align="center">
        <%
			out.println("<table   border='0' align='center' cellpadding='1' cellspacing='1'>");
			out.println("<tr>");
			 
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_ADD_INV FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='Add()' name='action1' id='action1' value='Add'>");
			else	
				out.println("<input type='hidden' name='action1' id='action1' value='Add'>");
			out.println("</td>");
			
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_EDIT_INV FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
			 out.println("<input class='ButtonHead' type='submit' onClick='return Edit()' name='action1' id='action1' value='Edit'>");
			else	
				out.println("<input type='hidden'  name='Edit' id='Edit' value='Edit'>");
			out.println("</td>");
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_DELETE_INV FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='return Delete()' name='Submit' id='Submit' value='Delete'>");
			else	
				out.println("<input type='hidden'  name='Delete' id='Delete' value='Delete'>");
			out.println("</td>");	
			
			out.println("<td ' valign='top'>");
			out.println("<input type='button' class='ButtonHead' name='Button' value='Close' onClick=\"redirect( 'InventoryMains.jsp')\" />");
			out.println("</td>");
			
			out.println("</tr>");	
			out.println("</table>");
			
			%>
      </div></td>
    </tr>
</table>


 <%@ include file="../footer.jsp"%></form>
</body>
</html>


<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>
