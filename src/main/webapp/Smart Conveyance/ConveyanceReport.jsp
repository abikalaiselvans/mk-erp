 <%@ page import="java.io.*,java.util.*"%>

<html>
<head>

<title> :: CONVEYANCE ::</title>

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
.style3 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;}
.style5 {font-weight: bold}
-->
 </style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 <script language="javascript" src="../JavaScript/Conveyance/conveyanceReport.js"></script> 
 <script language="javascript">
		
	function  LoadAll()
	{
			var name=confirm("Confirm to Load All Employee")
			if (name==true)
			 	loadConveyance();
			else
				document.getElementById('staffid').focus();
				 
	
	}
	
	
	function ConveyanceReportExport()
	{
		var mon=document.getElementById('month').value;
		var yea=document.getElementById('year').value;        
		var Status = document.getElementById('Status').value;  
		var day = document.getElementById('day').value; 
		var staffid = document.getElementById('staffid').value;  
		var url = "ConveyanceReportExport.jsp?month="+escape(mon)+"&year="+escape(yea)+"&Status="+Status+"&day="+day+"&staffid="+staffid;
		window.location = url;
	}
</script> 
<body  onpaste="return false;" onLoad="LoadAll() "  >
<%@ include file="index.jsp"%>

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
	  <td><table border="0" align="center" cellpadding="0"
	cellspacing="0">
        <tr>
          <td width="489">&nbsp;</td>
        </tr>
        <tr>
          <td><span class="tablehead"><span class="boldEleven"> </span></span></td>
        </tr>
        <tr>
          <td><table width="800" border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
              <tbody>
                <tr>
                  <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
                  <td width="222" height="1" class="BorderLine"><spacer
						height="1" width="1" type="block" /></td>
                  <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
                </tr>
                <tr>
                  <td height="6"><spacer height="1" width="1" type="block" /></td>
                </tr>
                <tr>
                  <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
                  <td width="6"><spacer height="1" width="1" type="block" /></td>
                  <td valign="top"><table width="800" border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td width="100%"><div align="center" class="boldEleven"><strong> </strong></div></td>
                      </tr>
                      <tr>
                        <td><div align="right"><span class="article style3">* </span><span
								class="changePos">Mandatory</span></div></td>
                      </tr>
                      <tr>
                        <td height="36">&nbsp;</td>
                      </tr>
                      <tr>
                        <td height="18"><table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                              <td class="bold1">Employee</td>
                              <td class="bold1"><select name="staffid"  id="staffid" onBlur="loadConveyance() " style="width:200">
							  <option value="0">All</option>
                                  <%
String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT  CHR_EMPID,CHR_STAFFNAME  FROM com_m_staff   WHERE  CHR_REPTO='"+session.getAttribute("EMPID")+"' AND  CHR_TYPE!='T' AND  CHR_HOLD!='Y'  ORDER BY CHR_STAFFNAME ");
for(int u=0;u<Data.length;u++)
	out.println("<option value='"+Data[u][0]+"'   >"+Data[u][0]+" / "+Data[u][1]+"</option>");

							  %>
                                </select>                              </td>
                              <td class="bold1">Month</td>
                              <td><span class="boldThirteen">
                                <select name="month"   class="formText135"  
							id="month"   onBlur="loadConveyance() ">
							<option value="0">All</option>
                                  <%@ include file="../JavaScript/months.jsp"%>
                                </select>
                              </span></td>
                              <td class="bold1">Year</td>
                              <td><span class="boldThirteen">
                                <select name="year" class="formText135"
							id="year"    onBlur="loadConveyance() ">
                                  <%@ include file="../JavaScript/years.jsp"%>
                                </select>
                                <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
                            </script>
                              </span></td>
                              <td class="bold1">Day</td>
                              <td><select name="day" id="day"  onBlur="loadConveyance() ">
                                  <option value="0">All</option>
                                  <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                                </select>                              </td>
                              <td class="bold1">Status</td>
                              <td><select name="Status" id="Status" onBlur="loadConveyance() ">
                                  <option value="0">All</option>
                                  <option value="N">PENDING</option>
                                  <option value="Y">ACCEPTED</option>
                                  <option value="R">REJECTED</option>
                              </select></td>
                              <td>Export </td>
                              <td><img src="../Image/report/pdf1.jpg" width="20" height="25" border="0" onClick="ConveyanceReportExport()"></td>
                            </tr>
                        </table></td>
                      </tr>
                      <tr>
                        <td height="18">&nbsp;</td>
                      </tr>
                      <tr>
                        <td height="18"><div id="ConveyanceReportTable" style="OVERFLOW: auto;width:100%;height:auto"> </div></td>
                      </tr>
                  </table></td>
                  <td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
                  <td width="1" class="BorderLine"><spacer height="1" width="1"
						type="block" /></td>
                </tr>
                <tr>
                  <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
                  <td height="6"><spacer height="1" width="1" type="block" /></td>
                  <td colspan="2" rowspan="2" valign="bottom"><div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div></td>
                </tr>
                <tr>
                  <td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
                </tr>
              </tbody>
          </table></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td><a href="javascript:window.print()">print</a></td>
        </tr>
        <tr>
          <td><table border="0" align="center" cellpadding="3" cellspacing="5">
              <tr>
                <td width="56"><input class="tMLAscreenHead" type="button"
					name="Button"  value="Close"   accesskey="c"  onClick="redirect('Conveyancemain.jsp')"></td>
              </tr>
          </table></td>
        </tr>
      </table>	</td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
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
