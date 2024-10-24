<!doctype html>
<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="../error/error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 


<%
try
{
%>


<html>
<head>
<title>:: INVENTORY ::</title>
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>


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

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Inventory/payments.js"></script>
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
		document.frm.action="SalesPaymentAction.jsp";		
 	}

	
	function  multi()
	{ 
		document.frm.action="MultiPayments.jsp";
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
			document.frm.action="SalesPaymentActionEdit.jsp";
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

<body    onLoad="SalesPayment('0')">
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
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table height="227" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<tr >
				<td height="31" >
				<div align="center" class="whiteMedium"><span  >Sales
				Payment Details <%
									String branchid=""+session.getAttribute("BRANCHID");
				String usertype=""+session.getAttribute("USRTYPE");
				String user= ""+session.getAttribute("USRID"); 
									%> </span></div>
				</td>
			</tr>
			<tr >
				<td height="31" align="center" >
				<table width="90%" border="0" align="center" cellpadding="2"
					cellspacing="2" class="whiteMedium">
					<tr>
					  <td height="28"  >Division</td>
					  <td  ><select name="divis"
							class="formText135" id="divis" tabindex="1"
							onChange="SalesPayment('0')"   style="width:150px;">
                        <option value='0'>All</option>
                        <%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                      </select></td>
					  <td  >Customer</td>
					  <td><select name="customer"  
							id="customer" class="formText135" onChange="SalesPayment('0')" style="width:150px;">
                        <option value="0">All</option>
                        <jsp:include page="LoadCustomer.jsp" />                      
                      </select></td>
					  <td>Day<input name="payType" id="payType"  type="hidden" value="Direct"></td>
					  <td><select name="day" id="day"  onBlur="SalesPayment('0') ">
                        <option value="0">All</option>
                        <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                      </select></td>
					  <td>Search by invoice /Customer</td>
					  <td><input name="search" type="text" class="formText135" id="search" maxlength="25" onKeyUp="SalesPayments(this)" ></td>
				  </tr>
					<tr>
						<td height="28"  >Status</td>
						<td  ><select name="Payment" id="Payment"
							onChange="SalesPayment('0')" style="width:150">
                          <option value=0>All</option>
                          <option value=1>Pending</option>
                          <option value=2>completed</option>
                          <option value=3>Partial</option>
						  <option value=4>Negative Amount</option>
                        </select></td>
						<td  >Month </td>
						<td><select name="month" id="month" onBlur="SalesPayment('0')"  style="width:150" >
							<option value=0>All</option>
						  <%@ include file="../JavaScript/Inventory/month.jsp" %>
						  </select>                      </td>
					  <td  >Year</td>
						<td  >
                        <select name="year" id="year" onBlur="SalesPayment('0')" style="width:150">
                            <%@ include file="../JavaScript/Inventory/year.jsp" %>
                          </select>
						   <script language='JavaScript' type="text/javascript">
				 		
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				 
          </script>                        </td>
						<td  >Company</td>
						<td  >
						
						<div align="left">
							    <select name="Branch" class="formText135"
							id="Branch" tabindex="6" style="width:200px"  onBlur="SalesPayment('0')"  >
							       
							      <%
								
				String sql ="Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID ";	
				if("N".equals(CommonFunctions.QueryExecute("SELECT  CHR_DISPLAYINACTIVECOMPANY FROM m_institution  WHERE INT_ID=1")[0][0]))			  
					sql = sql + " AND b.INT_ACTIVE =1 ";
								
				String shipids[][] =  CommonFunctions.QueryExecute(sql);
				if(usertype.equals("F") || usertype.equals("B"))
				{
				  out.print("<option value='0'>All</option>");	
				  for(int u=0; u<shipids.length; u++)
					out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
				}
				else
				{
					for(int u=0; u<shipids.length; u++)
						if(shipids[u][0].equals(branchid))
							out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
												
				}
						
							%>
				                </select> 
							    <script language="javascript">
						  	setOptionValue("Branch","<%=branchid%>") 
						      </script>
					      </div>						</td>
					</tr>
				</table>
			  </td>
			</tr>
			<tr >
				<td height="31" >
				<div align="center">
				<table width="100%"
					cellpadding="1" cellspacing="1" class="whiteMedium">
					<tr >
						<td   width="133">
						<div align="center">Invoice/CaseID</div>
						</td>
						<td   width="144">
						<div align="center">Date</div>
						</td>
						<td   width="118">
						<div align="center">Customer Name</div>
						</td>
						<td   width="149">
						<div align="center">Total Amount</div>
						</td>
						<td   width="132">
						<div align="center">Paid Amount</div>
						</td>
						<td   width="133">
						<div align="center">Balance Amount</div>
						</td>
						<td   width="153">
						<div align="center">Status</div>
						</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<tr class="MRow1">
				<td height="127" valign="top" class="footermenu">
				 
				<div id="SalesPaymentTables" style="OVERFLOW:auto;width:100%;height:300px">
				</div>
				<br>
				<div id ="totRec"></div>
						 
				</td>
		  </tr>

		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('0')">All</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('A')">A</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('B')">B</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('C')">C</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('D')">D</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('E')">E</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('F')">F</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('G')">G</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('H')">H</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('I')">I</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('J')">J</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('K')">K</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('L')">L</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('M')">M</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('N')">N</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('O')">O</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('P')">P</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('Q')">Q</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('R')">R</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('S')">S</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('T')">T</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('U')">U</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('V')">V</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('W')">W</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('X')">X</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('Y')">Y</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:SalesPayment('Z')">Z</a></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<p><input name="filename" type="hidden" value="SalesPayment" /> <input
			name="actionS" type="hidden" value="INVSalesDelete" />
		</td>
	</tr>
	<tr>
		<td>
		  <div align="center">
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
			out.println("<input class='ButtonHead' type='submit' onClick='return multi()' name='action1' id='action1' value='Multipayment'>");
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
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
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
