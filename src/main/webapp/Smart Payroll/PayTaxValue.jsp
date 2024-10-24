<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 


<%
try
{
%>


<%@ include file="index.jsp"%>

 <html>
<head>

<title> :: PAYROLL ::</title>


 

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
   
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>

<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="javascript" src="../JavaScript/Payroll/PayTaxValue.js"></script>
<script language="javascript">

function  Edit()
{		
  var count=0;
 	    sel=document.forms[0].Paytaxvalueid;
 	    for(i=0;i<sel.length;i++)
 	    {
 	         if(sel[i].checked)
 	         count=count+1;  
 	    } 
 	    if(count==0)
 	    {
 	       alert("Select Record to Edit");
 	       return false;
 	    
 	    }
		if(count>1)
 	    {
 	       alert("Select One Record to Edit");
 	       return false;
 	    }
		
 	    if(count==1)
 	    {
			document.frm.action="PayTaxValueEdit.jsp";
			document.frm.submit();
			return true;
		}
 	}
 
	function Add()
 	{		
		document.frm.action="PayTaxValueAdd.jsp";
		
		//EmployeTransferAdd.jsp		
 	}
	
	
	function  Delete()
 	{		
		var count;
		count=0;
		c1=document.forms[0].Paytaxvalueid
		txt=""
		for (i=0;i<c1.length;++ i)
		{
			if (c1[i].checked)
			{
			count=count+1;
			}
		}
		if(count>=1)
		{			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
				document.frm.submit();
				return true;			
			}
		}
		else
		{
		    alert("Select Atleast One Value");
		    return false;
		}		
 	}
	
 	</script>
 
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="LoadPayTaxValue('0')">
<form  AUTOCOMPLETE = "off" method="post"   name="frm">
<table width="100%" height="285" align="center">
	<tr>
		<td height="151" align="center"><br>
		<table width="90%" height="120" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle" >
				<td height="28" class="whiteMedium">TAX DETAILS 
		      <input type="hidden" name="filename" value="PayTaxValue">                    <input type="hidden" name="actionS" value="PAYPayTaxValueDelete"></td>
			</tr>

			<tr  >
				<td height="31" align="left" valign="middle">
				<table width="100%" border="0" class="whiteMedium"
					>
					
					<tr>
					  <td colspan="8" align="center" ><table width="293" border="0" align="center" cellpadding="0" cellspacing="0" class="whiteMedium">
                        <tr>
                          <td>Tax name
                          <%
						  String sql="SELECT INT_ID,CHR_TAXNAME,CHR_DESC from pay_m_tax ORDER BY CHR_TAXNAME";
						  String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						 
						  %>                          </td>
                          <td class="boldEleven"><select name="Taxid" class="formText135" id="Taxid" onChange="LoadPayTaxValue('0')">
                              <option value="0">All</option>
                              <%
						   for(int u=0;u<data.length;u++)
						  	out.println("<option value='"+data[u][0]+"'>"+data[u][1]);
						  %>
                            </select>                          </td>
                        </tr>
                      </table></td>
				  </tr>
					 
				</table>			  </td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td height="28" valign="top">
				<div id="PayTaxvaluetable" style="OVERFLOW: auto;width:100%;height:200px"></div><br>
				<div id="totalrecord" align="center"></div>
          <br>
							  </td>
		</table>		</td>
	</tr>
	<tr>
	  <td height="23">&nbsp;</td>
    </tr>
	<tr>
		<td height="23"><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('0')">All</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('A')">A</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('B')">B</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('C')">C</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('D')">D</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('E')">E</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('F')">F</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('G')">G</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('H')">H</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('I')">I</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('J')">J</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('K')">K</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('L')">L</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('M')">M</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('N')">N</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('O')">O</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('P')">P</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('Q')">Q</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('R')">R</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('S')">S</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('T')">T</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('U')">U</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('V')">V</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('W')">W</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('X')">X</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('Y')">Y</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadPayTaxValue('Z')">Z</a></div>				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
	  <td height="17" align="center">    
    <tr>
		<td height="17" align="center">
		
		  <div align="center">
            <%
			out.println("<table   border='0' align='center' cellpadding='1' cellspacing='1'>");
			out.println("<tr>");
			 
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_ADD_PAY FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='Add()' name='action1' id='action1' value='Add'>");
			else	
				out.println("<input type='hidden' name='action1' id='action1' value='Add'>");
			out.println("</td>");
			
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_EDIT_PAY FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
			 out.println("<input class='ButtonHead' type='submit' onClick='return Edit()' name='action1' id='action1' value='Edit'>");
			else	
				out.println("<input type='hidden'  name='Edit' id='Edit' value='Edit'>");
			out.println("</td>");
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_DELETE_PAY FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='return  Delete()' name='Submit' id='Submit' value='Delete'>");
			else	
				out.println("<input type='hidden'  name='Delete' id='Delete' value='Delete'>");
			out.println("</td>");	
			
			out.println("<td ' valign='top'>");
			out.println("<input type='button' class='ButtonHead' name='Button' value='Close' onClick=\"redirect('Payrollmain.jsp')\" />");
			out.println("</td>");
			
			out.println("</tr>");	
			out.println("</table>");
			
			%>
          </div>
	<tr>
		<td height="20"><%@ include file="../footer.jsp"%></td>
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
	System.out.println(e.getMessage());
}
%>
