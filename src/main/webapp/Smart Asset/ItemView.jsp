<%@ page import="java.io.*,java.util.*" isErrorPage="false"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 


<%
try
{
%>


<%!
	String batchName;
    int batchId,companyId;
%>
<html>
<head>
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

<script language="javascript" src="../JavaScript/Asset/Item.js"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<title>:: ASSET ::</title>


<script language="javascript">    
	function BDelete()
 	{		
 	    
		
		var count;	
		count=0;
		coffee1=document.forms[0].id;
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
			if (document.forms[0].id.checked) { count=1;}
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
 	function BEdit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].id
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
			if (document.forms[0].id.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="ItemAction.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}		
 	
	function Add()
 	{				
		document.frm.action="ItemAction.jsp";		
 	}
 	 
</script>

 


 
 

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<body  onpaste="return false;"   onLoad="loadItemData('0')">

<form  AUTOCOMPLETE = "off"   method="get" name='frm'>
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
	  <td>
		<table width="90%" height="385" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"
			 >
			<tr  >
				<td height="18"  >
				<div align="center" class="whiteMedium">ITEM INFORMATIONS 
				   
			  </div>				</td>
			</tr>
			<tr  >
				<td  height="26"  >
				 
				  <table border="0" align="center" cellpadding="2" cellspacing="2">
                    <tr>
                      <td class="whiteMedium">GROUP</td>
                      <td>
		<select name="itemgroup" id="itemgroup" onChange="loadItemData('0')" class='formText135'>
	  <option value="0">All</option>
                        <%  			
        String sql="SELECT INT_ITEMGROUPID,CHR_GROUPNAME FROM  asset_m_itemgroup  ORDER BY CHR_GROUPNAME ";
        String	company[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
        for(int i=0;i<company.length;i++)
    	 out.println("<option value='"+company[i][0]+"'>"+company[i][1]+"</option>");	
		%>
                      </select></td>
                       
                    </tr>
              </table>	  		  </td>
			</tr>
			<tr  >
				<td height="31"  >
				<div align="center">
				<table width="100%" border="0" cellspacing="1" cellpadding="1">
					<tr class="whiteMedium"  >
						<td    width='10%'><div align="center">S.No</div></td>
						<td   width='20%'><div align="center">GROUP</div></td>
						<td   width='30%'><div align="center">ITEM</div></td>
						<td   width='30%'><div align="center">DESCRIPTION</div></td>
						<td   width='15%'><div align="center">ACTIVE</div></td>
						<td   width='15%'><div align="center">RETURNABLE</div></td>
						 
					</tr>
				</table>
				</div>				</td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td height="127" valign="top" class="footermenu">
				<table width="100%">
					 
					<tr>
						<td>
						<div id="divscroll" style="OVERFLOW:auto;width:100%;height:300px" class="boldEleven">
						<div id="ItemTable"></div>
						</div>	
						<br>
						<div align="center" id="totRec"></div>					  </td>
					</tr>
			  </table>				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
		<td>
		<table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1"   class="TableDesign">
			<tr class="para">
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('0')">All</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('A')">A</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('B')">B</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('C')">C</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('D')">D</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('E')">E</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('F')">F</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('G')">G</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('H')">H</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('I')">I</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('J')">J</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('K')">K</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('L')">L</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('M')">M</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('N')">N</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('O')">O</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('P')">P</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('Q')">Q</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('R')">R</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('S')">S</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('T')">T</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('U')">U</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('V')">V</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('W')">W</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('X')">X</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('Y')">Y</a></div>				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadItemData('Z')">Z</a></div>				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
		<td><input type="hidden" name="filename" value="Item">
		<input type="hidden" name="actionS" value="ASSItemDelete"> </td>
	</tr>

	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
		<td>
		<table width="275" border="0" align="center" cellpadding="1" cellspacing="1">
			<tr>


				<td width="56"><input type="submit" class="ButtonHead"
					onClick="Add()" name="action1" value="Add"></td>
				<td width="56"><input type="submit" class="ButtonHead"
					onClick="return BEdit()" name="action1" value="Edit"></td>
				
				
				
<%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype)|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	  {
	  %>
				<td width="56"><input type="submit" class="ButtonHead"
					name="Delete" id="Delete" value="Delete"
					onClick="return BDelete()" /></td>
				<%
		}
		else
		{ 
			out.println("<input type='hidden'  name ='Delete' id='Delete'>");
		}


		%>




				 

				<td width="56"><input type="button" class="ButtonHead"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect('commonmain.jsp')"></td>
			</tr>
		</table>		</td>
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