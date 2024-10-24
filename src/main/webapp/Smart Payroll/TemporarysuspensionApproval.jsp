 <%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<%@ include file="index.jsp"%>
<%
try
{
%>
 <html>
<head>

<title> :: PAYROLL ::</title>

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

 
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="javascript" src="../JavaScript/Payroll/TemporarysuspensionApproval.js"></script> 
<script language="javascript">

  
		
	function Add()
 	{		
		document.frm.action="SalaryHold.jsp";		
 	}		
	
	
	
	function Delete()
 	{		
		var count;
		count=0;
		c1=document.forms[0].rowid
		txt=""
		for (i=0;i<c1.length;++ i)
		{
			if (c1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].rowid.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
				document.frm.submit();
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
 
 <jsp:include page="../JavaScript/dynamicStylesheet.jsp" flush="true" />
 
 <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
 </style>
 </head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadTemporarysuspension('0')">

<form  AUTOCOMPLETE = "off"   method="get" name="frm">


<table width="100%" height="285" align="center">


	<tr>
		<td height="151" align="center"><br>
		<table width="90%" height="120" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign" 
			 >
			 
			<tr>
				<td   class="bolddeepred">
				<div align="center">
				 
				</div>			  </td>
			</tr>
			<tr align="center" valign="middle"  >
				<td height="28"    
					class="tablehead"><span class="whiteMedium">Temporary suspension </span></td>
			</tr>

			<tr  >
				<td height="31" align="center" valign="middle" class="boldEleven"><table width="70%" border="0" align="center" cellpadding="1"
					cellspacing="1" class="whiteMedium">
                  <tr>
                    <td   >Office</td>
                    <td   ><%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 String usertype=""+session.getAttribute("USRTYPE"); 
			  %>
                        <select name="office" class="formText135" id="office" tabindex="6" onBlur="loadTemporarysuspension('0')"  onChange="loadStaffName() " >
                          <option value="0">All</option>
                          <%
	String OfficeData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b WHERE b.INT_OFFICEID IN("+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a WHERE a.CHR_USRNAME='"+""+session.getAttribute("USRID")+"' ")[0][0]+" )");
 if(OfficeData.length>0)
 	for(int u=0;u<OfficeData.length;u++)
		out.println("<option value='"+OfficeData[u][0]+"'>"+OfficeData[u][1]+"</option>");
 %>
                        </select>                    </td>
                    <td  >Month </td>
                    <td  ><select name="month"
							id="month" onChange="loadTemporarysuspension('0')">
							<option value="0">All</option>
                        <%@ include file="../JavaScript/months.jsp"%>
                      </select>                    </td>
                    <td  > Year </td>
                    <td  ><select name="year"
							id="year" onChange="loadTemporarysuspension('0')">
                        <%@ include file="../JavaScript/years.jsp"%>
                      </select>
                        <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						var day1=d.getDay();
						var day=d.getDate()
						if(day<10) day="0"+day;
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);	
						 						
				//-->
                        </script>                    </td>
                    <td  >  NDC    Status</td>
                                     
                    <td  ><select name="ndc" class="formText135" id="ndc" tabindex="6" onBlur="loadTemporarysuspension('0')"  onChange="loadStaffName() " >
                      <option value="0">All</option>
                        <option value="Y">COMPLETED</option>
						 <option value="N">PENDING</option>
                    </select></td>
                  </tr>
                </table>				</td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td height="28" valign="top">
				<div id="StaffHoldTable" style="OVERFLOW: auto;width:100%;height:300px"></div><br>	
				<br>
				<div id="totalrecord" align="center"></div>
				<br> 
							</td>
		</table>		</td>
	</tr>
	<tr>
		<td height="17"><input name="filename" type="hidden"
			id="filename" value="SalaryHold"> 
		<input name="actionS"
			type="hidden" id="actionS" value="PAYSalaryHoldDelete"></td>
	</tr>
	<tr>
		<td height="17">
		<table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('0')">All</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('A')">A</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('B')">B</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('C')">C</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('D')">D</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('E')">E</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('F')">F</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('G')">G</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('H')">H</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('I')">I</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('J')">J</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('K')">K</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('L')">L</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('M')">M</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('N')">N</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('O')">O</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('P')">P</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('Q')">Q</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('R')">R</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('S')">S</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('T')">T</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('U')">U</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('V')">V</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('W')">W</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('X')">X</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('Y')">Y</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadTemporarysuspension('Z')">Z</a></div>				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
	  <td height="17" align="center">    
  <tr>
	  <td height="17" align="center">
		<center>
		<table border="0" cellspacing="1" cellpadding="1">
			<tr>
				<%
	  usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype)|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	  {
	  %>
				<%
		}
		else
		{
			out.println("<input type='hidden'  name ='Delete' id='Delete'>");
		}
		%>
		 
				
				<td width="56"><input class="ButtonHead" type="Button"
					name="Button"  value="Close"   accesskey="c"  onClick="redirect('Payrollmain.jsp')"></td>
			</tr>
		</table>
  <tr>
	  <td height="20"><%@ include file="../footer.jsp"%></td>
  </tr>
</table></form>
 </body>

</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
