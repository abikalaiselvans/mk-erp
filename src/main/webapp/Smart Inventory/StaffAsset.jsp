<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="../error/error.jsp"%>
<%@ page import="java.io.*,java.util.*,com.my.org.erp.common.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
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
<script language="javascript" src="../JavaScript/Inventory/Asset.js"></script>

 
 <script language="javascript">
 function Add()
	{ 
		document.frm.action="StaffAssetAction.jsp";
 	}

	function Edit()
	{	
		obj = findObj("Rowid"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}



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
					document.frm.action="StaffAssetActionEdit.jsp";
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
				document.frm.action="StaffAssetActionEdit.jsp";
				return true;
			}
	}

function Delete()
{

	obj = findObj("Rowid"); 
		if(obj == null)
		{
			alert("Delete not available");
			return false;
		}


	var chkbox=document.forms[0].Rowid;
	var len=0;
	for(i=0;i<chkbox.length;i++)
	{
		if(chkbox[i].checked)
			len++;
	}
	if(!document.forms[0].Rowid){
		alert("Select Any One Value");
		return false;
	}
	else if(len==0)
	{
		if(chkbox.checked)
		{
			var name=confirm("ARE YOU SURE YOU WANT TO DELETE?");
			if(name == true)
			{
				document.frm.action="../SmartLoginAuth";
				return true;
			}
			return false;	
		}
		else
		{
			alert("Select Any One Value");
			return false;
		}
	}
	else if(len>=1)
	{
		var name=confirm("ARE YOU SURE YOU WANT TO DELETE?");
		
		if(name == true)
		{
				document.frm.action="../SmartLoginAuth";
				return true;
		}
		else
		{
			return false;
		}
	}	
}
 	

  
 	
</script>

<body  onLoad="loadStaffAsset('0')">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   action="" method="get" name="frm"  >
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td><table align="center" cellpadding="0" cellspacing="0"   class="TableDesign">
        <tr>
          <td><div align="center" class="whiteMedium"><strong>STAFF ASSET </strong></div><%//if(request.getAttribute("error")!='null'){out.println("You have selected: ");  }%><%!String alert;%><%
    if(session.getAttribute("alertStatus")!=null)//changed to session
        {
    alert=(String) session.getAttribute("alertStatus");//changed to session
    out.println(""+alert);
     session.removeAttribute("alert");
	 
    }
    %></td>
        </tr>
        <tr>
          <td align="center"><table width="100" border="0" align="center" cellpadding="5" cellspacing="0" class="whiteMedium">
            <tr>
              <td>Status</td>
              <td>
              <select name="status" id="status"  onChange="loadStaffAsset('0')">
              <option value="0">All</option>
              <option value="Y">Returned</option>
              <option value="N">Not Return</option>
              </select></td>
              <td>Office</td>
              <td><select name="office" class="formText135 style3"	id="office" tabindex="1" onChange="loadStaffAsset('0')">
                 <option value="0">All</option>
				  <%
					
	String OfficeData[][] =  CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b WHERE b.INT_OFFICEID IN("+ CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a WHERE a.CHR_USRNAME='"+session.getAttribute("USRID")+"' ")[0][0]+" )");
 if(OfficeData.length>0)
 	for(int u=0;u<OfficeData.length;u++)
		out.println("<option value='"+OfficeData[u][0]+"'>"+OfficeData[u][1]+"</option>");
 
			%>
                </select>              </td>
              <td>Department</td>
              <td><select name="dept" class="formText135 style5"	id="dept" tabindex="1" onChange="loadStaffAsset('0')">
                  <option value="0">All</option>
				  <%
			String deptsql="SELECT INT_DEPARTID,CHR_DEPARTNAME FROM com_m_depart ORDER BY INT_DEPARTID";
			String deptdata[][]= CommonFunctions.QueryExecute(deptsql);
			for(int x=0;x<deptdata.length;x++)
				out.println("<option value='"+deptdata[x][0]+"'>"+deptdata[x][1]+"</option>");
			%>
                </select>              </td>
             <td width="87" >Month</td>
						<td width="76">
						<select name="month" class="formText135" id="month"	onBlur="loadStaffAsset('0')">
						<option value="0">All</option>
							<%@ include file="../JavaScript/Inventory/month.jsp"%>
						</select></td>
						<td width="50" >Year </td>
						<td width="88"><select name="year" class="formText135" id="year"
							onBlur="loadStaffAsset('0')">
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
					  <td width="105" align="center">S.No</td>
						<td width="105" align="center">
						EmpID						</td>
						<td width="109" align="center">
						EmpName	</td>
						<td   width="152" align="center"> Item Type </td>
						<td   width="152" align="center">
						Item Name</td>
						<td  width="118" align="center">
						SerialNo						</td>
						<td   width="89" align="center">
						Issue Date						</td>
						<td   width="133" align="center">
						Status						</td>
					    <td   width="133" align="center">Received</td>
					</tr>
				</table>
				
			</td>
		</tr>
        <tr class="boldEleven">
          <td bgcolor="#FFFFFF"><div align="center">
            <div id="AssetTable" style="OVERFLOW:auto;width:100%;height:260px"class="boldEleven"> </div>
          </div><br>
		   <div id ="totRec" align="center"> </div>
                  <br>		
		  </td>
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
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('0')">All</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('A')">A</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('B')">B</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('C')">C</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('D')">D</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('E')">E</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('F')">F</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('G')">G</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('H')">H</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('I')">I</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('J')">J</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('K')">K</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('L')">L</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('M')">M</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('N')">N</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('O')">O</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('P')">P</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('Q')">Q</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('R')">R</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('S')">S</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('T')">T</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('U')">U</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('V')">V</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('W')">W</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('X')">X</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('Y')">Y</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadStaffAsset('Z')">Z</a></div></td>
        </tr>
      </table></td>
    </tr>
	<tr>
	  <td valign="top">&nbsp;</td>
    </tr>
	<tr>
	  <td valign="top"><table width="224" border="0" align="center" cellpadding="1"
			cellspacing="1">
        <!--DWLayoutTable-->
        <tr>
          <td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1"  value="Add"   accesskey="s"   onClick=" Add()" /></td>
          <td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1" value="Edit"
					onclick=" return Edit()" /></td>
		<%			
					
					 String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype)|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	  {
	  %>
				<td width="56"><input type="submit" class="ButtonHead"
					name="Submit3" id="btnDelete" value="Delete"
					onClick="return Delete()" /></td>
				<%
		}
		else
		{
			out.println("<input type='hidden'  name ='Delete' id='Delete'>");
		}
		%>
	 
          <td width="56"><input name="Close" type="button"
					class="ButtonHead" id="Close"  value="Close"   accesskey="c" 
					onclick="redirect( 'InventoryMains.jsp')" /><%%></td>
        </tr>
      </table></td>
    </tr>
	<tr>
		<td valign="top"><font size="1"><strong><font
										color="#000000"><font size="1"><strong><font
										color="#000000"><font size="1">
		  <input
										type="hidden" name="filename" value="StaffAsset" />
          <strong><font
										color="#000000"><font size="1">
          <input
										type="hidden" name="actionS" value="INVStaffAssetDELETE" />
          </font></font></strong></font></font></strong></font></font></strong></font></td>
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
