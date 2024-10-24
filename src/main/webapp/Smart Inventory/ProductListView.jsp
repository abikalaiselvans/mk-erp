<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
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
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Inventory/ProductList.js"></script>

<script language="JavaScript">
    function Add()
	{ 
		document.frm.action="ProductListAction.jsp";
 	}
 	  	
	function Edit()
 	{		
		obj = findObj("productId"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}


		var count;
		count=0;
		coffee1=document.forms[0].productId
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
			if (document.forms[0].productId.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="ProductListEdit.jsp";
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
		obj = findObj("productId"); 
		if(obj == null)
		{
			alert("Delete not available");
			return false;
		}


		var count;
		count=0;
		coffee1=document.forms[0].productId
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
			if (document.forms[0].productId.checked) { count=1;}
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
 <body  onLoad="callloaditems('0')">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td width="100%">&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="90%" height="220" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<tr  >
				<td height="31"  >
				<div align="center" class="whiteMedium">
				  <div align="center">PRODUCT LIST </div>
			  </div>				</td>
			</tr>
			<tr  >
			  <td height="31"  ><div align="center">
			    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="whiteMedium">
			      <tr>
			        <td>PRODUCT GROUP </td>
                    <td><select name="productgroup" class="formText135"  id="productgroup" onChange="callloaditem()">
                      <option value="0">All</option>
                      <%
				  String Data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_PRODUCTGROUPID,CHR_NAME FROM  inv_m_productgroup  ORDER BY CHR_NAME");
				  for(int u=0;u<Data.length;u++)
				  	out.println("<option value='"+Data[u][0]+"'>"+Data[u][1]+"</option>");
				  %>
                      </select>                  </td>
                     <td >Active</td>
                     <td >
					 <select name="active" id="active" onChange="callloaditem()">
                     <option value="-1">All</option>
					 <option value="1">Active</option>
					 <option value="0">Inactive</option>
					 </select>
                     </td>
                     <td >Type</td>
                     <td >
					 <select name="type" id="type" onChange="callloaditem()">
                     <option value="0">All</option>
					 <option value="F">Full Product</option>
					 <option value="C">Swap Product</option>
					 <option value="S">Consumables</option>
					 </select>
                     </td>
                     <td >Search</td>
                  <td><input type="text" name="search" id="search" maxlength="20" size="20" class="formText135" onKeyUp="callloaditem()" ></td> 
		          </tr>
		        </table>
		      </div></td>
		  </tr>
			 
			<tr class="MRow1">
				<td height="127" valign="top" class="footermenu">
				  <div id="divscroll" style="OVERFLOW:auto;width:100%;height:200px" 	class="boldEleven">
                  </div>
                  <br>
                      <div id ="totRec" align="center"> </div>
                  <br> 			
						
						
						</td>
		  </tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
	  <td><table border="0" align="center" cellpadding="1" cellspacing="1" class="TableDesign"  >
        <tr >
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('0')">All</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('A')">A</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('B')">B</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('C')">C</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('D')">D</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('E')">E</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('F')">F</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('G')">G</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('H')">H</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('I')">I</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('J')">J</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('K')">K</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('L')">L</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('M')">M</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('N')">N</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('O')">O</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('P')">P</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('Q')">Q</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('R')">R</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('S')">S</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('T')">T</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('U')">U</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('V')">V</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('W')">W</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('X')">X</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('Y')">Y</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:callloaditems('Z')">Z</a></div></td>
        </tr>
      </table></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><input type="hidden" name="filename" value="ProductList" />
		<input type="hidden" name="actionS" value="INVProductDelete" /></td>
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
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_DELETE_INV FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='return  Delete()' name='Submit' id='Submit' value='Delete'>");
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

<%
}
		catch(Exception e)
		{
			out.println(e.getMessage());
		}
%> <%@ include file="../footer.jsp"%></form>
</body>
</html>
