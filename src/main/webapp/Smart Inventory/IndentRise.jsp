<%@ page import="java.io.*,java.util.*"%>

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
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/Inventory/IndentRise.js"></script>
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
		document.frm.action="ServiceBillingAdd.jsp";		
 	}

	function Edit()
 	{		
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
			document.frm.action="ServiceBillingEdit.jsp";
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
		var count;
		count=0;
		coffee1=document.forms[0].salesid;
		txt=""
		var id="";
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
			count=count+1;
			id=i;
			}
		}
		if(count==0)
		{
			if (document.forms[0].salesid.checked) { count=1;}
		}
		
		if(count>1)
		{
			alert("Kindly select one value");
			return false;
		}
		if(count==1)
		{			
			/*var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
				return true;			
			}
			else
				return false;*/
				
				var r=confirm("ARE YOU SURE YOU WANT TO DELETE THE INVOICE  ..."+coffee1[id].value);
				if (r==true)
	  			{
	  				var reason=prompt("Reason for Delete :: ","For e.g - Value has to be change."); 
	  				if (reason!=null && reason!="")
  					{
	  					var d ="../SmartLoginAuth?saleno="+coffee1[id].value+"&reason="+reason;
						document.frm.action=d; 
						
					}	
	  			}			

		}
		else
		{
		    alert("Select Atleast One Value");
		    return false;
		}		
 	}
</script>

<body    onLoad="loadServiceBilling('0')">
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
		<td height="291"><table width="811" height="307" border="0" align="center"
			cellpadding="0" cellspacing="0"  
			 >
          <tr class="BackGround">
            <td height="31" class="BackGround"><div align="center">PURCHASE INDENT </div></td>
          </tr>
          <tr class="BackGround">
            <td height="31" class="BackGround"><table width="549" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td><strong>Branch
                  <%
				String branchid=""+session.getAttribute("BRANCHID");
				String usertype=""+session.getAttribute("USRTYPE");
				String user= ""+session.getAttribute("USRID"); 
				 
			%>
                </strong></td>
                <td><span class="boldThirteen">
                  <select name="Branch" class="formText135"
							id="Branch" tabindex="6"  onChange="loadServiceBilling('0')">
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
                <td><span class="boldThirteen">
                  <select name="customer"
							id="customer" class="formText135"  onChange="loadServiceBilling('0')">
                    <option value="0">All</option>
                    <jsp:include page="LoadCustomer.jsp" />                  
</select>
                </span></td>
                </tr>
              <tr>
                <td height="31" colspan="4" valign="top"><table width="502" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="68" height="31"><strong>Division</strong></td>
                    <td width="61"><span class="boldThirteen">
                      <select name="divis"
							class="formText135" id="divis" tabindex="1"  onChange="loadServiceBilling('0')"
							>
                        <option value='0'>All</option>
                        <%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                      </select>
                    </span></td>
                    <td width="51"><span class="bold1">Month</span></td>
                    <td width="124"><select name="month" id="month" onChange="loadServiceBilling('0')">
                      <%@ include file="../JavaScript/Inventory/month.jsp"%>
                    </select></td>
                    <td width="30"><span class="bold1">Year</span></td>
                    <td width="108"><select name="year" id="year"
							 onChange="loadServiceBilling('0')">
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
<table width='100%' border='0' bgcolor='#DCE4F9'  class='boldEleven' cellpadding='0' cellspacing='0'>
<tr><td class='boldEleven'><b>S.No</b></td>
<td class='boldEleven'><b>Invoice No</b></td>
<td class='boldEleven'><b>Invoice date</b></td>
<td class='boldEleven'><b>Customer Name</b></td>
<td class='boldEleven'><b>Sales Reference</b></td>
<td class='boldEleven'><b>Amount</b></td>
<td class='boldEleven'><b>Payment Status</b></td>
</tr></table>			</td>
          </tr>
          <tr>
            <td height="127" valign="top" class="footermenu">
			<div id="divscroll" style="OVERFLOW:auto;width:100%;height:240px"
							class="boldEleven">
						<div id="ServiceBilling"></div>
						</div>			</td>
          </tr>
        </table></td>
	</tr>
	<tr>
	  <td><table width="800" border="0" align="center" cellpadding="1"
			cellspacing="1"  >
        <tr class="para">
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('0')">All</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('A')">A</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('B')">B</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('C')">C</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('D')">D</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('E')">E</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('F')">F</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('G')">G</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('H')">H</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('I')">I</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('J')">J</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('K')">K</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('L')">L</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('M')">M</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('N')">N</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('O')">O</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('P')">P</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('Q')">Q</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('R')">R</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('S')">S</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('T')">T</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('U')">U</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('V')">V</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('W')">W</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('X')">X</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('Y')">Y</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadServiceBilling('Z')">Z</a></div></td>
        </tr>
      </table></td>
    </tr>
	 
	<tr>
	  <td><input name="filename" type="hidden" value="ServiceBilling" />
        <input
			name="actionS" type="hidden" value="INVServiceBillingDelete" />
        <table width="224" border="0" align="center" cellpadding="01"
			cellspacing="0">
        <!--DWLayoutTable-->
        <tr>
          <td width="56" valign="top"><input type="submit"
					class="buttonbold13" name="action1"  value="Add"   accesskey="s"   onClick="Add()" /></td>
          <td width="56" valign="top"><input type="submit"
					class="buttonbold13" name="action12" id="btnEdit" value="Edit"
					onclick="return Edit()" /></td>
          <%
	  //String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
          <td width="56" valign="top"><input type="submit"
					class="buttonbold13" name="Submit3" id="btnDelete" value="Delete"
					onclick="return Delete()" /></td>
          <%}%>
          <td width="56"><input type="button" class="buttonbold13"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect('ServiceBillings.jsp')" /></td>
        </tr>
      </table></td>
    </tr>
</table>
 <%@ include file="../footer.jsp"%></form>
</body>
</html>
