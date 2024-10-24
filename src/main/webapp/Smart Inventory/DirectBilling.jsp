<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>


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
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/Inventory/DirectBilling.js"></script>
<script language="JavaScript">
	function getDBPath()
	{
		var pathname = window.location.pathname;
		var iPos = window.location.pathname.toString().toLowerCase().lastIndexOf('.nsf');
		if(iPos>0) return pathname.substring(0, iPos+4);
		alert(pathname);
		return pathname; 
	} 

    function Add()
	{ 
		document.frm.action="DirectBillingAdd.jsp";		
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
			document.frm.action="DirectBillingEdit.jsp";
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
		var id="";
		coffee1=document.forms[0].salesid;
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
				count=count+1;
				id=i;
			}
		}
		
		if(count==1)
		{
		
				var r=confirm("ARE YOU SURE YOU WANT TO DELETE THE INVOICE  ..."+coffee1[id].value);
				if (r==true)
	  			{
	  				var reason=prompt("Reason for Delete :: ","For e.g - Value has to be change."); 
	  				var email=prompt("Kindly give the email id for sending informations for deleted invoice ","test@test.net"); 
	  				
					if (reason!=null && reason!="")
  					{
	  					var d ="../SmartLoginAuth?saleno="+coffee1[id].value+"&reason="+reason+"&email="+email;
						document.frm.action=d; 
						
					}	
	  			}			

		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}		
 	} 	 	
	
	 
</script>

<body    onLoad="loadDirectBilling('0')">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
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
            <td height="31" ><div align="center">DIRECT BILLING  &nbsp;&nbsp; &nbsp;&nbsp; </div></td>
          </tr>
          <tr >
            <td height="31" ><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="whiteMedium">
              <tr>
                <td><strong>Branch
                  <%
				String branchid=""+session.getAttribute("BRANCHID");
				String usertype=""+session.getAttribute("USRTYPE");
				String user= ""+session.getAttribute("USRID"); 
				 
			%>
                </strong></td>
                <td><span  >
                  <select name="Branch" class="formText135" style="width:200"
							id="Branch" tabindex="6"  onChange="loadDirectBilling('0')">
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
                  </select>
                  <script language="javascript">
						  	setOptionValue("Branch","<%=branchid%>") 
						  </script>
                </span></td>
                <td><strong>Customer</strong></td>
                <td><span  >
                  <select name="customer" style="width:200"
							id="customer" class="formText135"  onChange="loadDirectBilling('0')">
                    <option value="0">All</option>
                    <jsp:include page="LoadCustomer.jsp" />                  
</select>
                </span></td>
                </tr>
              <tr>
                <td height="31" colspan="4" valign="top"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="whiteMedium">
                  <tr>
                    <td width="68" height="31"><strong>Division</strong></td>
                    <td width="61"><span  >
                      <select name="divis"
							class="formText135" id="divis" tabindex="1"  onChange="loadDirectBilling('0')"
							>
                        <option value='0'>All</option>
                        <%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                      </select>
                    </span></td>
                    <td width="51">Month</td>
                    <td width="124"><select name="month" id="month" onChange="loadDirectBilling('0')">
                      <%@ include file="../JavaScript/Inventory/month.jsp"%>
                    </select></td>
                    <td width="30">Year</td>
                    <td width="108"><select name="year" id="year"
							 onChange="loadDirectBilling('0')">
                      <%@ include file="../JavaScript/Inventory/year.jsp"%>
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
                      </script></td>
                  </tr>
                </table></td>
                </tr>
            </table></td>
          </tr>

          <tr>
            <td height="18" valign="top"   class="footermenu">
<table width='100%' border='0'    cellpadding='0' cellspacing='0' class="whiteMedium">
<tr><td  ><b>S.No</b></td>
<td  ><b>Invoice No</b></td>
<td  ><b>Invoice date</b></td>
<td  ><b>Customer Name</b></td>
<td  ><b>Sales Reference</b></td>
<td  ><b>Amount</b></td>
<td  ><b>Payment Status</b></td>
<td  ><strong>Payment Commitment </strong></td>
<td  ><strong>Entry By </strong></td>
</tr></table>			</td>
          </tr>
          <tr class="MRow1">
            <td height="127" valign="top" class="footermenu">
			<div id="DirectBilling" style="OVERFLOW:auto;width:100%;height:300px" class="boldEleven"> </div>
			<br>
			<div id="totRec"></div>			</td>
          </tr>
        </table></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >  
        <tr class="para">
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('0')">All</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('A')">A</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('B')">B</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('C')">C</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('D')">D</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('E')">E</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('F')">F</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('G')">G</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('H')">H</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('I')">I</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('J')">J</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('K')">K</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('L')">L</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('M')">M</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('N')">N</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('O')">O</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('P')">P</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('Q')">Q</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('R')">R</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('S')">S</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('T')">T</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('U')">U</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('V')">V</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('W')">W</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('X')">X</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('Y')">Y</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBilling('Z')">Z</a></div></td>
        </tr>
      </table></td>
    </tr>
	 
	<tr>
	  <td><input name="filename" type="hidden" value="DirectBilling" />
        <input
			name="actionS" type="hidden" value="INVDirectBillingDelete" /></td>
    </tr>
	<tr>
	  <td><div align="center">
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
	<tr>
	  <td>&nbsp;</td>
    </tr>
</table>
 <%@ include file="../footer.jsp"%></form>
</body>
</html>
