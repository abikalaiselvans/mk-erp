<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="../error/error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<%
try
{
String sql = "";
%>
<html>
<head>
<title>:: MARKETING ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
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
 <script language="javascript" src="../JavaScript/Marketing/MarketingQuotationCPO.js"></script>
 <script language="javascript">
	function QuotationPrint(query)
		{
			var width="800", height="400";
			var left = (screen.width/2) - width/2;
			var top = (screen.height/2) - height/2;
			var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbar=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
	
			var f ="QuotationOrderPrint.jsp?quotationnumber="+query;
			newWindow = window.open(f,"subWind",styleStr);
			newWindow.focus( );
	}
	
</script>

 
<body onselectstart="return false" onpaste="return false;" onCopy="return false"     onLoad="loadQuotationCPO('0')">
<%@ include file="index.jsp"%>
 
<form  AUTOCOMPLETE = "off"   method="get" name='frm' action="../SmartLoginAuth" >
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td>
       <%
			out.println("<table   border='0' align='center' cellpadding='3' cellspacing='3'>");
			out.println("<tr>");
			 
			out.println("<td ' valign='top'>");
			out.println("<input type='button' class='ButtonHead' name='Button' value='Close' onClick=\"redirect( 'MarketingMain.jsp')\" />");
			out.println("</td>");
			
			out.println("</tr>");	
			out.println("</table>");
			
			%>	
      </td>
    </tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	 
	<tr>
		<td>
		<table height="231" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  >
			<tr >
				<td height="23" >
				<div align="center"><span class="boldThirteen">MOVE TO CPO</span>  </div>				</td>
			</tr>
			<tr >
				<td height="28" >
				<div align="center">
				  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="whiteMedium">
                    <tr>
                      <td height="19" >Division</td>
                      <td ><select
							name="division" class="formText135" id="division" tabindex="1"
							onChange="loadQuotationCPO('0')" style="width:200">
                          <option value='0'>All</option>
                           <%
						    String deptname= CommonFunctions.QueryExecute("SELECT FIND_A_DEPARTMENT("+session.getAttribute("DEPARTID")+")")[0][0];
							String division[][] =  CommonFunctions.QueryExecute("Select INT_DIVIID,UPPER(CHR_DIVICODE),CHR_DIVISHORTCODE from inv_m_division   WHERE INT_DIVIID >0 ORDER BY CHR_DIVICODE"); 
							for(int u=0; u<division.length; u++)
								if(deptname.equals(division[u][2]))
									out.print("<option selected='selected' value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
								else
									out.print("<option   value='"+division[u][0]+"'>"+division[u][1]  +"</option>");	
                         %>   
                      </select></td>
                      <td >Customer</td>
                      <td ><select
							name="customer" id="customer" class="formText135"
							onChange="loadQuotationCPO('0')" style="width:200">
                          <option value="0">All</option>
                          <jsp:include page="LoadCustomer.jsp" />                    
                      </select></td>
					  <td>Day</td>
                <td><select name="day" id="day"  onBlur="loadQuotationCPO('0') " style="width:50">
                  <option value="0" selected>All</option>
                  <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                </select></td>
                      <td >Month</td>
                      <td ><select name="month" id="month" onChange="loadQuotationCPO('0')">
                        <option value="0">All</option>
						<%@ include file="../JavaScript/Inventory/month.jsp"%>
                      </select></td>
                      <td >Year</td>
                      <td ><select name="year" id="year"
					onChange="loadQuotationCPO('0')">
                        <%@ include file="../JavaScript/Inventory/year.jsp"%>
                      </select>
			  <script language='JavaScript' type="text/javascript">
						 	
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						var day=d.getDate();
						//setOptionValue('day',day);	
						setOptionValue('month',month1);
						setOptionValue('year',year1);	
				</script>					  </td>
                    </tr>
                  </table>
				  </div>				</td>
			</tr>
			
			<tr class="MRow1">
				<td height="127" valign="top" class="footermenu">
				 
						<div id="divscroll" style="OVERFLOW:auto;width:100%;height:300px" >
						<div id="QuotationTable"></div>
						</div> 
						<br>
							<div align="center" id="totRec"></div>
						<br>				</td>
		  </tr>
		</table>		</td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
		<td>
		<table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('0')">All</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('A')">A</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('B')">B</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('C')">C</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('D')">D</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('E')">E</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('F')">F</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('G')">G</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('H')">H</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('I')">I</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('J')">J</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('K')">K</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('L')">L</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('M')">M</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('N')">N</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('O')">O</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('P')">P</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('Q')">Q</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('R')">R</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('S')">S</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('T')">T</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('U')">U</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('V')">V</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('W')">W</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('X')">X</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('Y')">Y</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadQuotationCPO('Z')">Z</a></div>				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
		<td><input name="filename" type="hidden" value="MarketingQuotation" />
		<input name="actionS" type="hidden" value="MKTQuotationDelete" /></td>
	</tr>
	<tr>
		<td>
			</td>
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
}
%>