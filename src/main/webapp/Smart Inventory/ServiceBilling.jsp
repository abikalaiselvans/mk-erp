<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>

<%@ page import="sun.net.smtp.SmtpClient"%>

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
<!--
@import url("../JavaScript/SmartStyles.css");
-->
 </style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Inventory/ServiceBilling.js"></script>

<script language="JavaScript">
	function getDBPath()
	{
		var pathname = window.location.pathname;
		var iPos = window.location.pathname.toString().toLowerCase().lastIndexOf('.nsf');
		if(iPos>0) return pathname.substring(0, iPos+4);
		alert(pathname);
		return pathname; 
	} 

    function Add()
	{ 
		document.frm.action="ServiceBillingAdd.jsp";		
 	}

	function Edit()
 	{		
		obj = findObj("salesid"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}


		var count;
		count=0;
		coffee1=document.forms[0].salesid
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
			if (document.forms[0].salesid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="ServiceBillingEdit.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}	

 	function RDelete()
 	{		
		obj = findObj("salesid"); 
		if(obj == null)
		{
			alert("Delete not available");
			return false;
		}


		var count;
		count=0;
		coffee1=document.forms[0].salesid;
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
			if (document.forms[0].salesid.checked) { count=1;}
		}
		
		if(count>1)
		{
			alert("Kindly select one value");
			return false;
		}
		if(count==1)
		{			
			 
				
				var r=confirm("ARE YOU SURE YOU WANT TO DELETE THE INVOICE  ..."+coffee1[id].value);
				if (r==true)
	  			{
	  				var reason=prompt("Reason for Delete :: ","For e.g - Value has to be change."); 
					var email=prompt("Kindly give the email id for sending informations for deleted invoice ","test@test.net"); 
	  				if (reason!=null && reason!="")
  					{
	  					var d ="../SmartLoginAuth?saleno="+coffee1[id].value+"&reason="+reason+"&email="+email;
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

<body    onLoad="loadServiceBilling('0')">
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
            <td height="31"  ><div align="center" class="whiteMedium">SERVICE BILLING   &nbsp;&nbsp; &nbsp;&nbsp;   &nbsp;&nbsp;</div></td>
          </tr>
          <tr  >
            <td height="31"  ><table width="100%" border="0" cellpadding="3" cellspacing="3" class="whiteMedium">
              <tr>
                <td>Branch
                    <%
				String branchid=""+session.getAttribute("BRANCHID");
				String usertype=""+session.getAttribute("USRTYPE");
				String user= ""+session.getAttribute("USRID"); 
				 
			%>                </td>
                <td>
                <select name="Branch" class="formText135" style="width:200"
							id="Branch" tabindex="6"  onChange="loadServiceBilling('0')">
                  <%
								
				String shipids[][] =  CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID ");
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
                </select>                <script language="javascript">
						  	setOptionValue("Branch","<%=branchid%>") 
						  </script>                </td>
                <td>Customer</td>
                <td>                  <select name="customer" style="width:200"
							id="customer" class="formText135"  onChange="loadServiceBilling('0')">
                    <option value="0">All</option>
                    <jsp:include page="LoadCustomer.jsp" />                
                  </select>                </td>
                <td>Division</td>
                <td> 
                <select name="divis"
							class="formText135" id="divis" tabindex="1"  onChange="loadServiceBilling('0')"
							>
                  <option value='0'>All</option>
                  <%
								String division[][] =  CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                </select>
                 </td>
              </tr>
              <tr>
                <td>Day</td>
                <td><select name="day" id="day"  onBlur="loadServiceBilling('0') ">
                  <option value="0">All</option>
                  <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                </select></td>
                <td>Month</td>
                <td><select name="month" id="month" onChange="loadServiceBilling('0')">
                  <option value="0">All</option>
                  <%@ include file="../JavaScript/Inventory/month.jsp"%>
                </select></td>
                <td>Year</td>
                <td><select name="year" id="year"
							 onChange="loadServiceBilling('0')">
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
              </tr>
            </table></td>
          </tr>
          <tr  >
            <td height="31"  ><table width="553" height="18" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td class="whiteMedium">Search by Invoice/Customer</td>
                <td class="whiteMedium"><input name="search" type="text" class="formText135" id="search" maxlength="10" onKeyUp="loadServiceBillings(this)" ></td>
              </tr>
            </table></td>
          </tr>
           

           
          <tr class="MRow1">
            <td height="127" valign="top" class="footermenu">
			<div id="ServiceBilling" style="OVERFLOW:auto;width:100%;height:300px" > </div>	
			<br><div align="center" id="totRec"></div> <br>			</td>
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
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('0')">All</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('A')">A</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('B')">B</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('C')">C</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('D')">D</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('E')">E</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('F')">F</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('G')">G</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('H')">H</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('I')">I</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('J')">J</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('K')">K</a></div></td> 
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('L')">L</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('M')">M</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('N')">N</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('O')">O</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('P')">P</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('Q')">Q</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('R')">R</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('S')">S</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('T')">T</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('U')">U</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('V')">V</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('W')">W</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('X')">X</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('Y')">Y</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadServiceBilling('Z')">Z</a></div></td>
        </tr>
      </table></td>
    </tr>
	 
	<tr>
	  <td><input name="filename" type="hidden" value="ServiceBilling" />
        <input
			name="actionS" type="hidden" value="INVServiceBillingDelete" /></td>
    </tr>
	<tr>
	  <td height="32"><div align="center">
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
				out.println("<input class='ButtonHead' type='submit' onClick='return  RDelete()' name='Submit' id='Submit' value='Delete'>");
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
