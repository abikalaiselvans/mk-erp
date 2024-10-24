<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>

<html>
<head>
<title>:: INVENTORY ::</title><style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
 }
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
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/Inventory/TargetAssignAvgCollection.js"></script>

<body onLoad="loadTargetAssignAvgCollection('0')" >
<%@ include file="indexinv.jsp"%>

<table width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td><table width="90%" align="center" cellpadding="0" cellspacing="0" class="TableDesign"    >
        <tr>
          <td><div align="center"><strong>Average Collection </strong></div></td>
        </tr>
        <tr  >
          <td><table width="80%" border="0" align="center" cellpadding="3" cellspacing="0" class="whiteMedium">
              <tr>
                <td  ><strong>Branch</strong></td>
                <td  ><%
				String branchid=""+session.getAttribute("BRANCHID");
				String usertype=""+session.getAttribute("USRTYPE");
				%>
                  <select name="Branch"  style="width:200" class="formText135" id="Branch" tabindex="6"   onChange="loadTargetAssignAvgCollection('0')">
                    <%
								
								String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID ");
								if(usertype.equals("F"))
								{
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
						  </script></td>
                <td  ><strong>Division</strong></td>
                <td  >
				<%
				String divisiondata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_DIVIID,CHR_DIVICODE FROM inv_m_division ORDER BY INT_DIVIID");
				%>
				<select name="division" id="division"  onChange="loadTargetAssignAvgCollection('0')">
				<option value="0">All</option>
				<%
					for(int u=0;u<divisiondata.length;u++)
						out.println("<option value='"+divisiondata[u][0]+"'>"+divisiondata[u][1]+"</option>");
				%>
				</select>				</td>
                <td  ><strong>Month</strong></td>
                <td  ><select name="month" id="month"  onChange="loadTargetAssignAvgCollection('0')" >
                  <%@ include file="../JavaScript/Inventory/month.jsp"%>
                </select></td>
                <td  ><strong>Year</strong></td>
                <td  ><strong>
                  <select name="year" class="formText135" id="year"  onChange="loadTargetAssignAvgCollection('0')">
                    <jsp:include page="../JavaScript/accountyears.jsp" flush="true" />
                  </select>
                  <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date();
			var month1=parseInt(d.getMonth() + 1);
			var year1=parseInt(d.getFullYear());
			var m="";
			if(month1<4)
				year1 = year1-1;
			if(month1<10) 
				m="0"+month1;
			setOptionValue('month',month1);
			setOptionValue('year',year1);					
				//-->
                  </script>
                </strong></td>
                <td  ><a href="javascript:pdfChart('Bar')" class="whiteMedium">Bar Chart</a></td>
                <td  ><a href="javascript:pdfChart('Pie')" class="whiteMedium">Pie Chart</a>
				<script language="javascript">
				
				function pdfChart(ctr)
				{
					
					var Branch=document.getElementById('Branch').value;   
					var division=document.getElementById('division').value;   
					var month=document.getElementById('month').value;   
					var yea=document.getElementById('year').value; 
					var url = "../SmartLoginAuth?filename=PDFTargetAssignPie&actionS=INVPDFTargetAssignPieChart&year="+escape(yea)+"&Branch="+Branch+"&division="+division+"&month="+month+"&type="+ctr;     
   					 
					var width="800", height="400";
					var left = (screen.width/2) - width/2;
					var top = (screen.height/2) - height/2;
					var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
					newWindow = window.open(url,"subWind",styleStr);
					newWindow.focus( );
				}
				
				 
				
				</script>				</td>
              </tr>
          </table></td>
        </tr>
        <tr class="MRow1">
          <td><div align="center">
              <div id="TargetTable" style="OVERFLOW:auto;width:100%;height:300px" > </div>
			  <br> <div id="totRec"></div>
			  <br>
          </div></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td>    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
      <tr class="para">
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('0')">All</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('A')">A</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('B')">B</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('C')">C</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('D')">D</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('E')">E</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('F')">F</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('G')">G</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('H')">H</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('I')">I</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('J')">J</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('K')">K</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('L')">L</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('M')">M</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('N')">N</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('O')">O</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('P')">P</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('Q')">Q</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('R')">R</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('S')">S</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('T')">T</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('U')">U</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('V')">V</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('W')">W</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('X')">X</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('Y')">Y</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadTargetAssignAvgCollection('Z')">Z</a></div></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
	  <td><div align="center">
	   <input name="Submit1" type="button"
			class="ButtonHead" value="  Close  " onClick="javascript:window.close()"
			/>
	    </div></td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
</html>
