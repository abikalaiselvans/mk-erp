<%@ page import="java.io.*,java.util.*"%>
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
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/Inventory/DirectDeliveryChallan.js"></script>
<script language="JavaScript">
	 

    function Add()
	{ 
		document.frm.action="DirectDeliverychallanAdd.jsp";		
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
			document.frm.action="DirectDeliveryChallanEdit.jsp";
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
		obj = findObj("rowid"); 
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

<body    onLoad="loadDirectDeliveryChallan('0')">
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
            <td height="31" ><div align="center" class="whiteMedium">DELIVERY CHALLAN </div></td>
          </tr>
          <tr >
            <td height="31" align="center" valign="middle" ><div align="center">
              <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="whiteMedium">
                <tr>
                  <td><strong>Branch
                    <%
				String branchid=""+session.getAttribute("BRANCHID");
				String usertype=""+session.getAttribute("USRTYPE");
				String user= ""+session.getAttribute("USRID"); 
				 
			%>
                    </strong></td>
                    <td><span class="boldThirteen">
                      <select name="Branch" class="formText135" style="width:200"
							id="Branch" tabindex="6"  onChange="loadDirectDeliveryChallan('0')">
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
                      <select name="customer" style="width:200"
							id="customer" class="formText135"  onChange="loadDirectDeliveryChallan('0')">
                        <option value="0">All</option>
                        <jsp:include page="LoadCustomer.jsp" />                  
                      </select>
                    </span></td>
                  </tr>
                <tr>
                  <td height="31" colspan="4" valign="top"><table width="90%" border="0" align="center" cellpadding="0" cellspacing="0" class="whiteMedium">
                    <tr>
                      <td   height="31"  >DC Status </td>
                        <td  >
                          <select id="dcstatus" name="dcstatus" onChange="loadDirectDeliveryChallan('0')">
                            <option value="2">All</option>
                            <option value="1">Closed</option>
                            <option value="0">Not-Closed</option>
                          </select>					</td>
                        <td width="68"><strong>Division</strong></td>
                        <td width="61"><span class="boldThirteen">
                          <select name="divis"
							class="formText135" id="divis" tabindex="1"  onChange="loadDirectDeliveryChallan('0')"
							>
                            <option value='0'>All</option>
                            <%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                            </select>
                          </span></td>
                        <td width="51"><span  >Month</span></td>
                        <td width="124">
                          <select name="month" id="month" onChange="loadDirectDeliveryChallan('0')">
                            <option value="0">All</option>
                            <%@ include file="../JavaScript/Inventory/month.jsp"%>
                          </select></td>
                        <td width="30"><span  >Year</span></td>
                        <td width="108"><select name="year" id="year"
							 onChange="loadDirectDeliveryChallan('0')">
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
              </table>
            </div></td>
          </tr>

          <tr>
            <td height="18" valign="top"   >
<table width='100%' border='0'     cellpadding='0' cellspacing='0' class="whiteMedium">
<tr><td  ><div align="center">S.No</div></td>
<td  ><div align="center">DC No</div></td>
<td  ><div align="center">Invoice DC </div></td>
<td  ><div align="center">Customer Name</div></td>
<td  ><div align="center">DC Reference</div></td>
<td  ><div align="center">Print </div></td>
<td  ><div align="center">  Status</div></td>
<td  ><div align="center">Closed</div></td>
<td><div align="center">Value</div></td>
</tr></table>			</td>
          </tr>
          <tr class="MRow1">
            <td height="127" valign="top" class="footermenu">
			<div id="divscroll" style="OVERFLOW:auto;width:100%;height:300px" ><br>
						<div id="DC"></div><br>
						
						<br><div align="center" id="totRec"></div> <br>	
			  </div>			</td>
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
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('0')">All</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('A')">A</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('B')">B</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('C')">C</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('D')">D</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('E')">E</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('F')">F</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('G')">G</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('H')">H</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('I')">I</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('J')">J</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('K')">K</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('L')">L</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('M')">M</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('N')">N</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('O')">O</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('P')">P</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('Q')">Q</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('R')">R</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('S')">S</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('T')">T</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('U')">U</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('V')">V</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('W')">W</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('X')">X</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('Y')">Y</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:loadDirectDeliveryChallan('Z')">Z</a></div></td>
        </tr>
      </table></td>
    </tr>
	 
	<tr>
	  <td><input name="filename" type="hidden" value="DirectDeliveryChallan" />
        <input
			name="actionS" type="hidden" value="INVDirectDeliveryChallanDelete" /></td>
    </tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td><table width="224" border="0" align="center" cellpadding="01"
			cellspacing="0">
        <!--DWLayoutTable-->
        <tr>
          <td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1"  value="Add"   accesskey="s"   onClick="Add()" /></td>
        <!--<td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action12" id="btnEdit" value="Edit"
					onclick="return Edit()" /></td>-->
          
		  <%
	   
	  if("F".equals(usertype)|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	  {
	  %>
				<td width="56"><input type="button" class="ButtonHead"
					name="Delete" id="Delete" value="Delete"
					onClick="return RDelete()" /></td>
				<%
		}
		else
		{ 
			out.println("<input type='hidden'  name ='Delete' id='Delete'>");
		}


		%>


		  
          <td width="56"><input type="button" class="ButtonHead"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')" /></td>
        </tr>
      </table></td>
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
