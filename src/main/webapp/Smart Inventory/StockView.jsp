<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="../error/error.jsp"%>
<jsp:directive.page import="com.my.org.erp.SmartInventory.Product" />
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

<meta http-equiv="pragma" content="nocache">
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/Inventory/InvStockAjax.js"></script>
<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="StockAdd.jsp";
 	}

	function Edit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].itemId
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
			if (document.forms[0].itemId.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="StockEdit.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}	

 

 	 function SDelete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].itemId
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
			if (document.forms[0].itemId.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="StockDelete.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}	

  
</script>
<%
	ArrayList productList=(ArrayList)session.getAttribute("productList");
	int totalRecord=productList.size();
%>
<body    onLoad="loadItem('0')">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="get">
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
		<table height="195" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<tr  >
				<td height="31"  >
				<table width="100%" border="0" align="center" class="whiteMedium">
					<tr>
					  <td   height="16" colspan="9" align="center">STOCK</td>
				  </tr>
					<tr>
						<td   height="21" align="center">
					  <%
				String branchid=""+session.getAttribute("BRANCHID");
				String usertype=""+session.getAttribute("USRTYPE");
				String user= ""+session.getAttribute("USRID"); 
					
			%></td>
						<td>
					  <div align="right">Branch</div>						</td>
						<td  ><select name="Branch" class="formText135"
							id="Branch" tabindex="6" onChange="loadItem('0')" style="width:200">

							<%
								
				String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID ");
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
						</select> <script language="javascript">
						  	setOptionValue("Branch","<%=branchid%>") 
						  </script></td>
						<td  ><span class="boldThirteen">Division</span></td>
						<td  ><select name="division" class="formText135" id="division" tabindex="1" onChange="loadItem('0')" style="width:200">

							<%
						String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
						for(int u=0; u<division.length; u++)
							if(u==1)
								out.print("<option selected =selected value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							else
								out.print("<option  value='"+division[u][0]+"'>"+division[u][1]  +"</option>");	
							%>
					  </select></td>
						<td  >Type </td>
						<td  ><span class="boldThirteen"> 
						  <select
							name="type" id="type" onChange="loadItem('0')"  style="width:200">
							<option value="P">Product</option>
							<option value="I">Item</option>
					  </select> </span></td>
						<td >
						<div align="right">Search </div>						</td>
						<td  ><span class="boldThirteen"> <input
							type="text" name="search" id="search" maxlength="10" size="5"
							class="formText135" onKeyUp="loadItem('0')"> </span></td>
					</tr>
				</table>				</td>
			</tr>
			<tr  >
				<td height="31"  >
				<table width="100%" border="0" cellpadding="1" cellspacing="1" class="whiteMedium">
					<tr  >
						<td width="193"  ">
						<div align="left">Item / Product Name</div>						</td>
						<td width="174"  ">
						<div align="left">Average Cost (Rs.)</div>						</td>
						<td width="156"  ">
						<div align="left">Last Sale Date</div>						</td>
						<td width="179"  ">Stock In Hand(in Numbers)</td>
					</tr>
				</table>				</td>
			</tr>
			<tr class="MRow1">
				<td height="127" valign="top" class="footermenu">
				 
						<div id="ItemTable" style="OVERFLOW:auto;width:100%;height:250px" class="boldEleven"> </div>
						<br>
						<div align="center" id="totRec"></div>	
						<br>						 	</td>
		  </tr>
		</table>		</td>
	</tr>
	<tr>
		<td valign="top">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('0')">All</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('A')">A</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('B')">B</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('C')">C</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('D')">D</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('E')">E</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('F')">F</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('G')">G</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('H')">H</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('I')">I</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('J')">J</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('K')">K</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('L')">L</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('M')">M</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('N')">N</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('O')">O</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('P')">P</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('Q')">Q</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('R')">R</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('S')">S</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('T')">T</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('U')">U</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('V')">V</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('W')">W</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('X')">X</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('Y')">Y</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItem('Z')">Z</a></div>				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
	  <td><table width="56" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td>
		  <input type="button" class="ButtonHead"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')" />
		  </td>
        </tr>
      </table></td>
    </tr>
	<tr>
		<td><input type="hidden" name="filename" value="Item" /> <input
			type="hidden" name="actionS" value="INVItemDelete" /></td>
	</tr>
	<tr>
		<td>
		<table width="224" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<!--DWLayoutTable-->
			<tr>
				<%
	  /*String usertypes=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertypes))
	  {*/
	  %>
				<!-- <td width="56" valign="top"><input type="submit" class="buttonbold13" name="action1"  value="Add"   accesskey="s"   onclick= "Add()" /></td>
        <td width="56" valign="top"><input type="submit" class="buttonbold13" name="action1" id="btnEdit" value="Edit" onclick= "return Edit()" /></td>-->
				<!-- <td width="56" valign="top"><input type="submit" class="buttonbold13" name="Submit3" id="btnDelete" value="Delete" onclick= "return SDelete()" /></td>-->
				<%
	   out.print("<input type='hidden'  name='action1' id='btnEdit' >");
	   out.print("<input type='hidden'  name='action1' id='btnEdit' >");
	   out.print("<input type='hidden'  name='action1' id='btnDelete' >");
	   /*}
	   else
	   {
	   		
			out.print("<input type='hidden'  name='Submit3' id='btnEdit' >");
	   }*/
	   %>
				<!--<td width="56"><input type="button" class="buttonbold13" name="submit"  value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')" /></td>-->
			</tr>
		</table>		</td>
	</tr>
	<tr>
		<td height="20">&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>
