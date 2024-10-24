<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="com.my.org.erp.Hibernate.test.*"%>
 <%
 try
 {
 %>
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
 
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/Inventory/SalesAnalysis.js"></script>
<body    onLoad="loadSalesAnalysisGroup('0')">
<%@ include file="indexinv.jsp"%>

<table width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td> </td>
  </tr>
  <tr>
	  <td><table width="100" border="0" align="center" cellpadding="0" cellspacing="0" class="TableDesign"   >
        <tr>
          <td><div align="center"><strong>SALES ANALYSIS </strong></div></td>
        </tr>
        <tr >
          <td><table width="100%" border="0" align="center" cellpadding="5" cellspacing="0" class="whiteMedium">
              <tr>
                <td>Branch</td>
                <td><select name="Branch" id="Branch" onChange="loadSalesAnalysisGroup('0')"  onBlur="loadSalesAnalysisGroup('0')" style="width:200"   >
                  <option value="0">All</option>
                  <%
			   	  
				 String branchid=""+session.getAttribute("BRANCHID");
				String usertype=""+session.getAttribute("USRTYPE");
				String user= ""+session.getAttribute("USRID"); 
								
								
				String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID ");
				if(usertype.equals("F") || usertype.equals("B"))
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
                </select></td>
                <td>Period</td>
                <td><span class="boldEleven">
                  <select name="period" class="formText135" id="period"  onChange="loadSalesAnalysisGroup('0')" onBlur="loadSalesAnalysisGroup('0')"   style="width:200" >
                    <option value="1" selected="selected">I Quarter</option>
                    <option value="2">II Quarter</option>
                    <option value="3">III Quarter</option>
                    <option value="4">IV Quarter</option>
                    <option value="5" >All</option>
                  </select>
                </span></td>
                <td>Year</td>
                <td class="boldEleven"> <select name="year" class="formText135" id="year"   onChange="loadSalesAnalysisGroup('0')"  onBlur="loadSalesAnalysisGroup('0')"   style="width:100"  >
                      <jsp:include page="../JavaScript/accountyears.jsp" flush="true" />
                  </select>
                  <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('year',year1);							
				//-->
                  </script></td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>Division </td>
                <td><select name="division"
							class="formText135" id="division" tabindex="1"  onChange="loadSalesAnalysisGroup('0')"  onBlur="loadSalesAnalysisGroup('0')"   style="width:200" >
                  <option value="0">All</option>
                  <%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                </select></td>
                <td>Billing Type </td>
                <td><select name="payType" id="payType"   onChange="loadSalesAnalysisGroup('0')"   onBlur="loadSalesAnalysisGroup('0')" style="width:200"  >
                  <option value="CustomerSales">Customer Sales Billing</option>
                  <option value="DirectBilling">Direct Billing Payment</option>
                  <option value="ServiceBilling">Service Billing Payment</option>
                </select></td>
                <td>&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
               
          </table></td>
        </tr>
        <tr class="boldEleven">
          <td bgcolor="#FFFFFF"><div align="center">
              <div id="TargetTable" style="OVERFLOW:auto;width:100%;height:260px"class="boldEleven"> </div>
          </div><br> <br> <div id="totRec"></div>
			  <br><br></td>
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
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('0')">All</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('A')">A</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('B')">B</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('C')">C</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('D')">D</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('E')">E</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('F')">F</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('G')">G</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('H')">H</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('I')">I</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('J')">J</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('K')">K</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('L')">L</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('M')">M</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('N')">N</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('O')">O</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('P')">P</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('Q')">Q</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('R')">R</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('S')">S</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('T')">T</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('U')">U</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('V')">V</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('W')">W</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('X')">X</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('Y')">Y</a></div></td>
        <td  ><div align="center"><a class="whiteMedium" href="javascript:loadSalesAnalysisGroup('Z')">Z</a></div></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
	  <td><div align="center">
	    <input name="Submit2" type="button"
			class="tMLAscreenHead" value="  Close  "
			onClick="redirect( 'InventoryMains.jsp')" />
	    </div></td>
  </tr>
  <tr>
	  <td>
 <%
 
 	
%>	  </td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
</html>
<%
}
catch(Exception  e)
{
	out.println(e.getMessage());
}
%>
