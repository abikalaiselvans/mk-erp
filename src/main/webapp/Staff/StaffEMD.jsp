 <%@ page import="java.io.*,java.util.*,com.my.org.erp.common.*"%>
<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 
<%@include file="Redirect.jsp" %>

<html>
<head>
<title><%= CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='INV' ")[0][0]%></title>
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
 <link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/staff/StaffEmd.js"></script>
<script language="javascript">
function Add()
{ 
	document.frm.action="SatffEmdAction.jsp";
}


 
	
function Edit()
	{	
		var chkbox=document.forms[0].Rowid;
		var len=0;
		var ch=0;
		for(i=0;i<chkbox.length;i++)
		{
			if(chkbox[i].checked)
			{
				len++;
			}
		}
			if(len>1)
			{
				alert("Select Only One Value");
				return false;
			}
			else if(len==0)
			{
				if(chkbox.checked)
				{
					 
					document.frm.action="SatffEmdActionEdit.jsp";
					return true;
				}
				else
				{
					alert("Select Any One Value");
					return false;
				}
			}
			else
			{
				document.frm.action="SatffEmdActionEdit.jsp";
				return true;
			}
	}
 </script>

<body  onLoad="loadEmd('0')">
 
<form  AUTOCOMPLETE = "off"   action="" method="post" name="frm"  >
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td><table width="600" align="center" cellpadding="0" cellspacing="0"   class="TableDesign">
        <tr>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td><div align="center" class="whiteMedium"><strong>DEPOSIT</strong></div>             </td>
        </tr>
        <tr>
          <td align="center"><table width="100%" border="0" align="center" cellpadding="5" cellspacing="0" class="whiteMedium">
            <tr>
              <td>Office</td>
              <td><select name="office" class="formText135 style3"	id="office" tabindex="1" onChange="loadEmd('0')">
                <option value="0">All</option>
                <%
					
	String OfficeData[][] =  CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b WHERE b.INT_OFFICEID IN("+ CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a WHERE a.CHR_USRNAME='"+session.getAttribute("USRID")+"' ")[0][0]+" )");
 if(OfficeData.length>0)
 	for(int u=0;u<OfficeData.length;u++)
		out.println("<option value='"+OfficeData[u][0]+"'>"+OfficeData[u][1]+"</option>");
 
			%>
              </select></td>
              <td>Accept</td>
              <td><select name="accept" id="accept"  class="formText135" onChange="loadEmd('0')">
                <option value="0">All</option>
                <option value="Y">Accept</option>
                <option value="R">Reject</option>
                <option value="N">Pending</option>
              </select></td>
              <td >Month</td>
              <td><select name="month" class="formText135" id="month"	onBlur="loadEmd('0')">
                <option value="0">All</option>
                <%@ include file="../JavaScript/Inventory/month.jsp"%>
              </select></td>
              </tr>
            <tr>
              <td>Type</td>
              <td><select name="EmdType" class="formText135 style5" id="EmdType" tabindex="1" onChange="loadEmd('0')">
                <option value="0">All</option>
                <option value="E">Earnest Money Deposit</option>
                <option value="B">Bank Guarantee</option>
                <option value="S">Security Deposit</option>
              </select></td>
              <td>Returned</td>
              <td><select name="returned" id="returned"  class="formText135" onChange="loadEmd('0')">
                <option value="0">All</option>
                <option value="Y">Received</option>
                <option value="N">Pending</option>
              </select></td>
             <td width="50" >Year </td>
						<td width="88"><select name="year" class="formText135" id="year"
							onBlur="loadEmd('0')">
							<%@ include file="../JavaScript/Inventory/year.jsp"%>
						</select>
						
						<%
						String currentdt[][] =CommonFunctions.QueryExecute("SELECT DAY(NOW()),if(MONTH(NOW())<10,CONCAT('0',MONTH(NOW())),MONTH(NOW())),YEAR(NOW())");
						%>
						 <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						var day=d.getDate();
						 	
						setOptionValue('month','<%=currentdt[0][1]%>');
						setOptionValue('year','<%=currentdt[0][2]%>');	
				//-->
          </script></td>
                </tr>
          </table></td>
        </tr>
		<tr>
			<td>
			<table width="100%"
					cellpadding="1" cellspacing="1" class="whiteMedium">
					<tr >
						<td width="36"><div align="center">S.No</div></td>
						<td  width="63"><div align="center">Type</div></td>
						<td  width="141" ><div align="center">Customer Name</div></td>
						<td  width="155" ><div align="center">Amount	</div></td>
						<td  width="147" > <div align="center">Tender Last Date </div></td>
						<td  width="178" > <div align="center">Accept</div></td>
						<td  width="178" > <div align="center">Status</div></td>
					</tr>
			  </table>			</td>
		</tr>
        <tr class="boldEleven">
          <td bgcolor="#FFFFFF"><div align="center">
            <div id="EmdTable" style="OVERFLOW:auto;width:100%;height:160px"class="boldEleven"> </div>
          </div><br>
		   <div id ="totRec" align="center"> </div>
                  <br>		  </td>
        </tr>
      </table></td>
    </tr>
	
	<tr>
	  <td valign="top">&nbsp;</td>
    </tr>
	<tr>
	  <td valign="top"><table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
        <tr class="para">
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('0')">All</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('A')">A</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('B')">B</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('C')">C</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('D')">D</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('E')">E</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('F')">F</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('G')">G</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('H')">H</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('I')">I</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('J')">J</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('K')">K</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('L')">L</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('M')">M</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('N')">N</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('O')">O</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('P')">P</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('Q')">Q</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('R')">R</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('S')">S</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('T')">T</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('U')">U</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('V')">V</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('W')">W</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('X')">X</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('Y')">Y</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadEmd('Z')">Z</a></div></td>
        </tr>
      </table></td>
    </tr>
	<tr>
	  <td valign="top">&nbsp;</td>
    </tr>
	<tr>
	  <td valign="top"><table border="0" align="center" cellpadding="1"
			cellspacing="1">
        <!--DWLayoutTable-->
        <tr>
          <td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1"  value="Add"   accesskey="s"   onClick=" Add()" /></td>
          <td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1" value="Edit"
					onclick=" return Edit()" /></td>
         <td width="56"><input name="Close" type="button"
					class="ButtonHead" id="Close"  value="Close"   accesskey="c" 
					onclick="redirect('InventoryMain.jsp')" /></td>
        </tr>
      </table></td>
    </tr>
	<tr>
		<td valign="top"><font size="1"><strong><font
										color="#000000"><font size="1"><strong><font
										color="#000000"><font size="1">
		  <input
										type="hidden" name="filename" value="StaffEmd" />
          <strong><font
										color="#000000"><font size="1">
          <input type="hidden" name="actionS" value="INVEmdAssignDELETE" />
          </font></font></strong></font></font></strong></font></font></strong></font></td>
	</tr>
</table> 
</form>
</body>
</html>
