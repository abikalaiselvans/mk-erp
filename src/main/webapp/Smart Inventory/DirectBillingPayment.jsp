<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
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
 <link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 <script language="javascript" src="../JavaScript/Inventory/DirectBillingPayment.js"></script>
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
		document.frm.action="DirectBillingPaymentAdd.jsp";		
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
			document.frm.action="DirectBillingPaymentEdit.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}	

 	function Delete()
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

<body    onLoad="loadDirectBillingPayment('0')">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth">
<table width="100%">
<tr>
  <td>&nbsp;</td>
</tr>
<tr><td>

<table width="100%" border="0" align="center" cellpadding="1" cellspacing="1" class="TableDesign">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
	  <td><div align="center" class="whiteMedium">DIRECT BILLING PAYMENT </div></td>
    </tr>
	<tr>
	  <td align="center"><table width="81%" border="0" align="center" cellpadding="2" cellspacing="2" class="whiteMedium">
        <tr>
          <td>Branch
            <%
				String branchid=""+session.getAttribute("BRANCHID");
				String usertype=""+session.getAttribute("USRTYPE");
				String user= ""+session.getAttribute("USRID"); 
				 
			%>          </td>
          <td><span class="boldThirteen">
            <select name="Branch" class="formText135" style="width:200"
							id="Branch" tabindex="6"  onChange="loadDirectBillingPayment('0')">
              <%
								
				String shipids[][] =  CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID ");
				if(usertype.equals("F") && usertype.equals("B"))
				{
				  for(int u=0; u<shipids.length; u++)
					out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
				}
				else
				{ 
					 for(int u=0; u<shipids.length; u++)
						out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
					 							
				}
						
							%>
            </select>
            <script language="javascript">
						  	setOptionValue("Branch","<%=branchid%>") 
						  </script>
          </span></td>
          <td>Customer</td>
          <td><span class="boldThirteen">
            <select name="customer" style="width:200"
							id="customer" class="formText135"  onChange="loadDirectBillingPayment('0')">
              <option value="0">All</option>
              <jsp:include page="LoadCustomer.jsp" />      
            </select>
          </span></td>
          <td>Division</td>
          <td><span class="boldThirteen">
          <select name="divis"
							class="formText135" id="divis" tabindex="1"  onChange="loadDirectBillingPayment('0')"
							>
            <option value='0'>All</option>
            <%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
          </select>
          </span></td>
          <td>Status</td>
          <td><span class="boldThirteen">
          <select name="Payment" id="Payment"
							onChange="loadDirectBillingPayment('0')">
            <option value=0>All</option>
            <option value=1>Pending</option>
            <option value=2>completed</option>
            <option value=3>Partial</option>
          </select>
          </span></td>
        </tr>
        <tr>
           <td>Day</td>
                <td><select name="day" id="day"  onBlur="loadDirectBillingPayment('0') ">
                  <option value="0">All</option>
                  <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                </select></td>
                <td>Month</td>
                <td><select name="month" id="month" onChange="loadDirectBillingPayment('0')">
                  <option value="0">All</option>
                  <%@ include file="../JavaScript/Inventory/month.jsp"%>
                </select></td>
                <td>Year</td>
                <td><select name="year" id="year"
							 onChange="loadDirectBillingPayment('0')">
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
                      </script></td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </table></td>
    </tr>
	<tr>
	  <td><table width='100%' border='0'   cellpadding='0' cellspacing='0' class="whiteMedium">
        <tr>
          <td ><b>S.No</b></td>
          <td ><b>Invoice No</b></td>
          <td ><b>Invoice date</b></td>
          <td ><b>Customer Name</b></td>
          <td ><b>Sales Reference</b></td>
          <td ><b>Amount</b></td>
          <td ><b>Payment </b></td>
        </tr>
      </table></td>
    </tr>
	<tr bgcolor="#FFFFFF">
	  <td><div id="DirectBilling" style="OVERFLOW:auto;width:100%;height:240px" ></div> <br>
			<br>
	  <div id="totRec"></div><br></td>
    </tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	 
	<tr>
	  <td>	  </td>
	</tr>
	<tr>          </tr>
  </table>
  
  
</td>
	</tr>
	<tr>
	  <td><input name="filename" type="hidden" value="DirectBilling" />
        <input
			name="actionS" type="hidden" value="INVDirectBillingPaymentDelete" /></td>
    </tr>
	<tr>
	  <td align="center"><table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
        <tr class="para">
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('0')">All</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('A')">A</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('B')">B</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('C')">C</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('D')">D</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('E')">E</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('F')">F</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('G')">G</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('H')">H</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('I')">I</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('J')">J</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('K')">K</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('L')">L</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('M')">M</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('N')">N</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('O')">O</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('P')">P</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('Q')">Q</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('R')">R</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('S')">S</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('T')">T</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('U')">U</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('V')">V</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('W')">W</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('X')">X</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('Y')">Y</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadDirectBillingPayment('Z')">Z</a></div></td>
        </tr>
      </table></td>
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
				out.println("<input class='ButtonHead' type='submit' onClick='return  Delete()' name='Submit' id='Submit' value='Delete'>");
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
 </script> <%@ include file="../footer.jsp"%></form>
</body>
</html>
