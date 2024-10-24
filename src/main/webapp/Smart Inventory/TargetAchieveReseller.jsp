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
<script language="javascript" src="../JavaScript/Inventory/TargetAssign.js"></script>
<body >
<%@ include file="indexinv.jsp"%>

<table width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td><table width="90%" align="center" cellpadding="0" cellspacing="0"   class="TableDesign">
        <tr>
          <td><div align="center"><strong>Analysis</strong></div></td>
        </tr>
        <tr>
          <td><table width="80%" border="0" align="center" cellpadding="3" cellspacing="0" class="whiteMedium">
              <tr>
                <td  >Branch</td>
                <td  ><%
				String branchid=""+session.getAttribute("BRANCHID");
				String usertype=""+session.getAttribute("USRTYPE");
				%>
                  <select name="Branch" class="formText135" id="Branch" tabindex="6"  style="width:200"  onChange="loadTargetAssignCGroup()">
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
				<select name="division" id="division"  onChange="loadTargetAssignCGroup()">
				<option value="0">All</option>
				<%
					for(int u=0;u<divisiondata.length;u++)
						out.println("<option value='"+divisiondata[u][0]+"'>"+divisiondata[u][1]+"</option>");
				%>
				</select>				</td>
                <td  ><strong>Period</strong></td>
                <td  ><select name="period" class="formText135" id="period"   onChange="loadTargetAssignCGroup()">
                  <option value="1">I Quarter</option>
                  <option value="2">II Quarter</option>
                  <option value="3">III Quarter</option>
                  <option value="4">IV Quarter</option>
                  <option value="5" selected="selected">All</option>
                </select></td>
                <td  ><strong>Year</strong></td>
                <td  ><strong>
                  <select name="year" class="formText135" id="year"  onChange="loadTargetAssignCGroup()">
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
			
			setOptionValue('year',year1);							
				//-->
                  </script>
                </strong></td>
              </tr>
          </table></td>
        </tr>
        <tr   class="MRow1">
          <td align="center"> 
              <div id="TargetTable" style="OVERFLOW:auto;width:100%;height:260px"class="MRow1"> </div><br>
			  <br> <div id="totRec"></div>
			  <br>
           </td>
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
	  <td><div align="center">
	    <input name="Submit" type="button"
			class="ButtonHead" id="Submit"
			onClick="javascript:window.close()" value="  Close  " />
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
