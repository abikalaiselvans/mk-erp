<%@ page import="java.io.*,java.util.*" %>


<%!
	String stateName,stateId;
	String districtName,districtDes,districtId;
	String actionStu;
%>
<%@page import="com.my.org.erp.common.CommonInfo"%>
<html>
<head>

<title>:: HRM ::</title>


 
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="../JavaScript/HRM/HrmAjax.js"></script>
<script language="JavaScript">

function valid()
{
	try
	{
	
		if(checkNull("TxtName","Enter the Name")
		&& checkNull("TxtWork","Enter the Working Hours")
		&& checkNull("TxtPaid","Enter the Paid Holiday"))
		{
			var count;
			count=0;
			coffee1=document.forms[0].Benefits
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
				if (document.forms[0].Benefits.checked) { count=1;}
			}
			if(count>=1)
			{			
				return true;			
				
			}
			else
			{
				alert("Select Atleast One Benefit");
				return false;
			}	
		}
		else
			return false;	
			
	  }  
	  catch(err)
	  {
	  	alert(err)
		return false;
	  }
} 
</script>
 
<style type="text/css">
<!--
.style3 {color: #FF0000}
.style4 {color: #000000}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
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
<body  onpaste="return false;" onLoad="document.getElementById('TxtName').focus()">
<form  AUTOCOMPLETE = "off" method="get" name='frmDemand' action="../SmartLoginAuth" onSubmit="return valid()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><%@ include file="indexhrm.jsp"%>	</td>
  </tr>
  <tr>
    <td height="0">&nbsp;</td>
  </tr>
  <tr>
    <td>
	
      <table width="80%" border="0" align="center" cellpadding="1" cellspacing="1" class="TableDesign"    >
        
        <tr>
          <td width="100%" height="27"  ><div align="center" class="whiteHead"    >BENEFITS</div></td>
          </tr>
        
        <tr>
          <td valign="top"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF">
            <tr>
              <td valign="top"><table width="100%" border="0" align="left" cellpadding="5" cellspacing="5" bgcolor="#FFFFFF">
                <tr>
                  <td width="47%" height="27" class="boldEleven">
				    <div align="right"><strong>
				      <%
                
                
					String query="select count(*) from hrm_m_mission";
					String name="";
					String mission= "";
					String obj="";
					String whrs="";
					String paidhrs="";
					String benefits="";
					if(com.my.org.erp.common.CommonInfo.RecordExist(query))
					{
						String sql="select * from hrm_m_mission";
					 	String data[][]=com.my.org.erp.common.CommonInfo.KRecordSetArray(sql);                          	
						name=data[0][0];
						mission= data[0][1];
						obj=data[0][2];
						whrs=data[0][3];
						paidhrs=data[0][4];
						benefits=data[0][5];
						
					}	
					 
				
			    %>
			            NAME <span class="style3">* </span></strong></div></td>
                <td width="53%" colspan="4"><div align="left">
                  <input name="TxtName"  id="TxtName" type="text" class="formText135" onKeyPress="charOnly('TxtName','100')" value="<%=name%>" size="50">
                  </div></td>
                </tr>
                <tr>
                  <td height="27" valign="top" class="boldEleven"><div align="right"><strong>MISSION </strong></div></td>
                  <td colspan="4"><div align="left">
                    <textarea name="TxtMission"  id="TxtMission" cols="50" rows="5" class="formText135" onKeyPress="charOnly('TxtMission','250')"><%=mission%>
</textarea>
                    </div></td>
                </tr>
                <tr>
                  <td height="27" valign="top" class="boldEleven"><div align="right"><strong>OBJECTIVES </strong></div></td>
                  <td colspan="4"><div align="left">
                    <textarea name="TxtObjective"  id="TxtObjective" cols="50" rows="5" class="formText135" onKeyPress="charOnly('TxtObjective','250')"><%=obj%>
</textarea>
                    </div></td>
                </tr>
                <tr>
                  <td height="27" class="boldEleven"><div align="right"><strong>WORKING HOURS <span class="style3">* </span></strong></div></td>
                  <td colspan="4"><div align="left">
                    <input name="TxtWork"  id="TxtWork" type="text" class="formText135"  onkeypress="numericValue('TxtWork','10')" value="<%=whrs%>" size="20" onBlur="validateNumber(this,'12','The Working hours should not greather than 12')" maxlength="2">
                    </div></td>
                </tr>
                <tr>
                  <td height="27" class="boldEleven"><div align="right"><strong>PAID HOLIDAY  <span class="style3">* </span></strong></div></td>
                  <td colspan="4"><div align="left">
                    <input name="TxtPaid"  id="TxtPaid" type="text" class="formText135"  onkeypress="numericValue('TxtPaid','3')" value="<%=paidhrs%>" size="20" maxlength="3" onBlur="validateNumber(this,'15','The Paid holiday should not greather than 15')" >
                    </div></td>
                </tr>
                <tr>
                  <td height="27" colspan="5">
				  
				  <table width='95%' align="center"     cellpadding=2 cellspacing=1 bgcolor='#9900CC'  class='boldEleven'  id='myTable' >
                    <tr class="MRow1">
                      <td height="26" colspan="5" valign="middle"><table width="95" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                          <td><input name="all" type="checkbox" id="all" value="Y" onClick="checkAll('all')" ></td>
                          <td class="bold1">Check All						  </td>
                        </tr>
                      </table></td>
                      </tr>
                    <tr class="MRow1">
                      <td valign="middle" class="bold1"><div align="center">Extra Wages 
                          <%
						
						String  s = ""+benefits;
						String h[] = s.split("~");
						String chkvalue="";
						 
						
					%>                        
                      </div></td>
                      <td valign="middle" class="bold1"><div align="center">Employee Security </div></td>
                      <td valign="middle" class="bold1"><div align="center">Safety and Health </div></td>
                      <td valign="middle" class="bold1"><div align="center">Employee Welfare </div></td>
                      <td valign="middle" class="bold1"><div align="center"><span class="style4">Retirement Benefits </span></div></td>
                    </tr>
                    <tr class="MRow2">
                      <td valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="boldEleven">
                        <tr>
                          <td>
                            <%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
								if(h[uq].equals("1"))
									chkvalue = "Checked ";
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='1'  />");	
						  %>                            </td>
                            <td class="boldEleven">Shift Premium </td>
                          </tr>
                        <tr>
                          <td><%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("2"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='2'  />");	
						  %>  </td>
                            <td class="boldEleven">Holiday Pay </td>
                          </tr>
                        <tr>
                          <td><%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("3"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='3'  />");	
						  %>  </td>
                            <td class="boldEleven">Paid vacation </td>
                          </tr>
                        </table></td>
                      <td valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="bolddeepblue">
                        <tr>
                          <td>
                            <%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("4"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='4'  />");	
						  %>                            </td>
                            <td class="boldEleven">Retrenchment Compensation </td>
                          </tr>
                        <tr>
                          <td>
                            <%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("5"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='5'  />");	
						  %>                            </td>
                            <td class="boldEleven">Lay-off Compensation</td>
                          </tr>
                        </table></td>
                      <td valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="boldEleven">
                        <tr>
                          <td>
                            <%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("6"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='6'  />");	
						  %>                            </td>
                            <td class="boldEleven">Maternity Benefit </td>
                          </tr>
                        <tr>
                          <td>
                            <%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("7"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='7'  />");	
						  %>                            </td>
                            <td class="boldEleven">Disablement Benefit </td>
                          </tr>
                        <tr>
                          <td>
                            <%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("8"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='8'  />");	
						  %>                            </td>
                            <td class="boldEleven">Sickness Benefit </td>
                          </tr>
                        <tr>
                          <td>
                            <%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("9"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='9'  />");	
						  %>                            </td>
                            <td class="boldEleven">Dependents Benefit </td>
                          </tr>
                        <tr>
                          <td>
                            <%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("10"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='10'  />");	
						  %>                            </td>
                            <td class="boldEleven">Medical Benefit </td>
                          </tr>
                        <tr>
                          <td>
                            <%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("11"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='11'  />");	
						  %>                            </td>
                            <td class="boldEleven">Workmen's Compensation </td>
                          </tr>
                        </table></td>
                      <td valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="boldEleven">
                        <tr>
                          <td>
                            <%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("12"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='12'  />");	
						  %>                            </td>
                            <td class="boldEleven">Canteen</td>
                          </tr>
                        <tr>
                          <td>
                            <%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("13"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='13'  />");	
						  %>                            </td>
                            <td class="boldEleven">Consumer Societies </td>
                          </tr>
                        <tr>
                          <td>
                            <%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("14"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='14'  />");	
						  %>                            </td>
                            <td class="boldEleven">Housing</td>
                          </tr>
                        <tr>
                          <td>
                            <%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("15"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='15'  />");	
						  %>                            </td>
                            <td class="boldEleven">Parties and Picnic </td>
                          </tr>
                        <tr>
                          <td>
                            <%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("16"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='16'  />");	
						  %>                            </td>
                            <td class="boldEleven">Employee Counselling </td>
                          </tr>
                        <tr>
                          <td>
                            <%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("17"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='17'  />");	
						  %>                            </td>
                            <td class="boldEleven">Legal Aid </td>
                          </tr>
                        <tr>
                          <td>
                            <%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("18"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='18'  />");	
						  %>                            </td>
                            <td class="boldEleven">Holiday Homes </td>
                          </tr>
                        <tr>
                          <td>
                            <%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("19"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='19'  />");	
						  %>    </td>
                            <td class="boldEleven">Educational Facilities </td>
                          </tr>
                        <tr>
                          <td>
                            <%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("20"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='20'  />");	
						  %>                            </td>
                            <td class="boldEleven">Transportation</td>
                          </tr>
                        <tr>
                          <td>
                            <%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("21"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='21'  />");	
						  %>                            </td>
                            <td class="boldEleven">Performance awards </td>
                          </tr>
                        </table></td>
                      <td valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="boldEleven">
                        <tr>
                          <td> <%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("22"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='22'  />");	
						  %>            </td>
                            <td class="boldEleven">Pension</td>
                          </tr>
                        <tr>
                          <td>
                            <%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("23"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='23'  />");	
						  %>                            </td>
                            <td class="boldEleven">Medical Benefits for Retired Employees </td>
                          </tr>
                        <tr>
                          <td>
                            <%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("24"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='24'  />");	
						  %>                            </td>
                            <td class="boldEleven">Gratuity</td>
                          </tr>
                        <tr>
                          <td> <%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("25"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='25'  />");	
						  %>             </td>
                            <td class="boldEleven">Travelling Concession for Retired Employees </td>
                          </tr>
                        <tr>
                          <td>
                            <%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("26"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='26'  />");	
						  %>                            </td>
                            <td class="boldEleven">Old Age Assistance </td>
                          </tr>
                        <tr>
                          <td> <%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("27"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='27'  />");	
						  %>         </td>
                            <td class="boldEleven">Deferred Income Plans </td>
                          </tr>
                        <tr>
                          <td><%
						  	chkvalue="";
							for(int uq=0;uq<h.length;uq++)
							{
								if(h[uq].equals("28"))
									chkvalue = "Checked ";
							 }
							out.println("<input name='Benefits' type='checkbox' id='Benefits' " +chkvalue +" value='28'  />");	
						  %>        </td>
                            <td class="boldEleven">Provident Fund </td>
                          </tr>
                        </table></td>
                    </tr>
                    </table>
					<br><br>
					</td>
                  </tr>
                
                </table></td>
              </tr>
            </table></td>
          </tr>
      </table> 	  </td></tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
  <table width="247" align="center" cellpadding="1" cellspacing="1">
  <tr>
    <td width="56" align="center" valign="top"><input type="hidden" name="filename" value="Benefits">
      <input name="actionS" type="hidden" id="actionS" value="HRMbenefitsAdd"></td>
     <td width="56" align="center" valign="top"><input name="Submit" id="Submit" type="submit"  class="ButtonHead" value="SUBMIT" onClick="return valid();"></td>
     <td width="20" valign="top">&nbsp;</td>
     <td width="56" valign="top"><input class="ButtonHead" type="button" name="Submit2" value="CLOSE" onClick="redirect('HRMmain.jsp')"></td>	 
  </tr>   
  </table></td>
  </tr>

<tr><td><%@ include file="../footer.jsp"%></td></tr>
</table>
</form>
</body>
</html>
