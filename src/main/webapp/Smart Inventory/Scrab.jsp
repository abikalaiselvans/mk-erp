<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 


<%
try
{
%>


<html>
<head>
<title>:: INVENTORY ::</title><style type="text/css">
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

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 
<script language="javascript" src="../JavaScript/Inventory/Scrab.js"></script>
<script language="JavaScript">
	 

    function Add()
	{ 
		document.frm.action="ScrabAdd.jsp";		
 	}

	function Edit()
 	{		
		obj = findObj("salesid"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}
		
		var count;
		count=0;
		coffee1=document.forms[0].salesid
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
			if (document.forms[0].salesid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="DeliverychallanSerialNumber.jsp?";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}	

 	function RDelete()
 	{		
		obj = findObj("salesid"); 
		if(obj == null)
		{
			alert("Delete not available");
			return false;
		}

		var count;
		count=0;
		coffee1=document.forms[0].salesid;
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
			if (document.forms[0].salesid.checked) { count=1;}
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
</script>

<body    onLoad="loadScrab('0')">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	 
	<tr>
	  <td>	  </td>
	</tr>
	<tr>
		<td height="291"><table height="307" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
          <tr >
            <td height="31" ><div align="center" class="whiteMedium">SCRAB</div></td>
          </tr>
          <tr >
            <td height="31" align="center" valign="middle" ><div align="center">
              <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="whiteMedium">
                 
                <tr>
                  <td height="31" colspan="4" align="center" valign="top"><table width="88%" border="0" align="center" cellpadding="2" cellspacing="2" class="whiteMedium">
                    <tr>
                      <td width="90"   height="31"  ><strong>Branch
                          <%
				String branchid=""+session.getAttribute("BRANCHID");
				String usertype=""+session.getAttribute("USRTYPE");
				String user= ""+session.getAttribute("USRID");
			%>
                      </strong></td>
                      <td width="156"  ><span class="boldThirteen">
                        <select name="Branch" class="formText135" style="width:150"
							id="Branch" tabindex="6"  onChange="loadScrab('0')">
                          <%
								
				String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID ");
				if(usertype.equals("F"))
				{
				  for(int u=0; u<shipids.length; u++)
					out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
				}
				else
				{
					if(!"000021".equals(user))
					{
					 for(int u=0; u<shipids.length; u++)
						if(shipids[u][0].equals(branchid))
							out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
					}
					else
					{
					 for(int u=0; u<shipids.length; u++)
						out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
					}							
				}
						
							%>
                        </select><script language="javascript">
						  	setOptionValue("Branch","<%=branchid%>") 
						  </script>
                      </span></td>
                      <td><strong>Customer</strong></td>
                      <td><span class="boldThirteen">
                        <select name="customer"  style="width:150"
							id="customer" class="formText135"  onChange="loadScrab('0')">
                          <option value="0">All</option>
                          <jsp:include page="LoadCustomer.jsp" />                        
</select>
                      </span></td>
                      <td><strong>Division</strong></td>
                      <td><span class="boldThirteen">
                        <select name="divis" style="width:150"
							class="formText135" id="divis" tabindex="1"  onChange="loadScrab('0')"
							>
                          <option value='0'>All</option>
                          <%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                        </select>
                      </span></td>
                      <td>Search by Invoice/Customer</td>
                      <td><input name="search" type="text" class="formText135" id="search" maxlength="10" onKeyUp="loadScrabs(this)" ></td>
                      </tr>
                    <tr>
                      <td   height="31"  > Status </td>
                        <td  >
                          <select id="dcstatus" name="dcstatus" onChange="loadScrab('0')" style="width:150">
                            <option value="2">All</option>
                            <option value="Y">Closed</option>
                            <option value="N">Not-Closed</option>
                          </select>					</td>
                        <td>Day</td>
                        <td><select name="day" id="day"  onBlur="loadScrab('0') ">
                            <option value="0">All</option>
                            <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                        </select></td>
                        <td width="92">Month</td>
                        <td width="150"><select name="month" id="month" onChange="loadScrab('0')" style="width:150">
                          <option value="0">All</option>
                          <%@ include file="../JavaScript/Inventory/month.jsp"%>
                        </select></td>
                        <td width="150">Year</td>
                        <td width="150">
                          
                          <select name="year" id="year"
							 onChange="loadScrab('0')" style="width:150">
                            <%@ include file="../JavaScript/Inventory/year.jsp"%>
                            </select>
                          <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						var day=d.getDate();
						setOptionValue('day',day);	
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
                      </script>                        </td>
                        </tr>
                    </table></td>
                  </tr>
              </table>
            </div></td>
          </tr>

          <tr>
            <td height="18" valign="top"   >
<table width='100%' border='0'     cellpadding='0' cellspacing='0' class="whiteMedium">
<tr><td  ><div align="center">S.No</div></td>
<td  ><div align="center">Scrab No</div></td>
<td  ><div align="center">Invoice DC </div></td>
<td  ><div align="center">Customer Name</div></td>
<td  ><div align="center">DC Reference</div></td>
<td  ><div align="center">Print </div></td>
<td  ><div align="center">  Status</div></td>
<td  ><div align="center">Closed</div></td>

</tr></table>			</td>
          </tr>
          <tr class="MRow1">
            <td height="127" valign="top" >
			 
			<div id="DC" style="OVERFLOW:auto;width:100%;height:300px" ></div><br>
			
			<br><div align="center" id="totRec"></div> <br>	

			</td>
          </tr>
        </table></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td><table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
        <tr class="para">
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('0')">All</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('A')">A</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('B')">B</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('C')">C</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('D')">D</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('E')">E</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('F')">F</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('G')">G</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('H')">H</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('I')">I</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('J')">J</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('K')">K</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('L')">L</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('M')">M</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('N')">N</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('O')">O</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('P')">P</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('Q')">Q</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('R')">R</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('S')">S</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('T')">T</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('U')">U</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('V')">V</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('W')">W</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('X')">X</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('Y')">Y</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadScrab('Z')">Z</a></div></td>
        </tr>
      </table></td>
    </tr>
	 
	<tr>
	  <td><input name="filename" type="hidden" value="Scrab" />
      <input
			name="actionS" type="hidden" value="INVScrabDelete" /></td>
    </tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td> <div align="center">
        <%
			out.println("<table   border='0' align='center' cellpadding='1' cellspacing='1'>");
			out.println("<tr>");
			 
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_ADD_INV FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='Add()' name='action1' id='action1' value='Add'>");
			else	
				out.println("<input type='hidden' name='action1' id='action1' value='Add'>");
			out.println("</td>");
			
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_EDIT_INV FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
			 out.println("<input class='ButtonHead' type='submit' onClick='return Edit()' name='action1' id='action1' value='Edit'>");
			else	
				out.println("<input type='hidden'  name='Edit' id='Edit' value='Edit'>");
			out.println("</td>");
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_DELETE_INV FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='return  RDelete()' name='Submit' id='Submit' value='Delete'>");
			else	
				out.println("<input type='hidden'  name='Delete' id='Delete' value='Delete'>");
			out.println("</td>");	
			
			out.println("<td ' valign='top'>");
			out.println("<input type='button' class='ButtonHead' name='Button' value='Close' onClick=\"redirect( 'InventoryMains.jsp')\" />");
			out.println("</td>");
			
			out.println("</tr>");	
			out.println("</table>");
			
			%>
      </div></td>
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
