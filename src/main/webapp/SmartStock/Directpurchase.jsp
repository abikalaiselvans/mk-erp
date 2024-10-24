<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<html>
<head>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='STK' ")[0][0]%></title></title>
 
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

</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Stock/DirectPurchase.js"></script>
<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="DirectPurchaseAdd.jsp";
 	}
	

	function Edit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].Purchaseid
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
			if (document.forms[0].Purchaseid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="DirectPurchaseEdit.jsp";
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
		coffee1=document.forms[0].Purchaseid
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
			if (document.forms[0].Purchaseid.checked) { count=1;}
		}
		if(count==1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				var reason=prompt("Reason for delete :: ","For e.g - Value has to be change."); 
	  			if (reason!=null && reason!="")
  				{
					document.frm.action="../SmartLoginAuth?reason="+reason;
					return true;			
				}
				else
					return false	
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

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadDirectPurchase('0')">
<%@ include file="indexstock.jsp"%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
	  <td height="19">&nbsp;</td>
  </tr>
	<tr>
		<td height="19">&nbsp;</td>
	</tr>
	<tr>
	  <td height="19"><form  method="post" name="frm" id="frm">
        <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td><table width="100%" height="227" border="0" align="center"
			cellpadding="0" cellspacing="0"  
			 >
              <tr class="BackGround">
                <td height="31" class="BackGround"><div align="center"><span class="boldThirteen">Direct
                  Purchase </span></div></td>
              </tr>
              <tr class="BackGround">
                <td class="BackGround"><table width="600" border="0" align="center" cellpadding="2"
					cellspacing="2">
                    <tr>
                      <td width="18" class="boldThirteen">Division</td>
                      <td width="19" class="boldThirteen"><select name="division"
							class="formText135" id="division" tabindex="1"
							onChange="loadDirectPurchase('0')">
                          <option value='0'>All</option>
                          <jsp:include page="LoadDivision.jsp" />   
                      </select></td>
                      <td width="37" class="boldThirteen">Vendor</td>
                      <td width="37" class="boldThirteen"><select name="vendor"
							id="vendor" class="formText135"
							onChange="loadDirectPurchase('0')">
                          <option value="0">All</option>
                          <jsp:include page="LoadVendor.jsp" />            
                      </select></td>
                      <td width="74" class="boldThirteen">Month </td>
                      <td width="89"><select name="month" id="month"
							onBlur="loadDirectPurchase('0')">
							
                          <%@ include file="../JavaScript/common/month.jsp"%>
                      </select></td>
                      <td width="50" class="boldThirteen">Year </td>
                      <td width="88"><select name="year" id="year"
							onBlur="loadDirectPurchase('0')">
                          <%@ include file="../JavaScript/common/year.jsp"%>
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
              <tr class="BackGround">
                <td height="31" class="BackGround"><div align="center">
                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <tr class="BackGround">
                        <td class="bold1">S.No</td>
                        <td class="bold1"><div align="left">Purchase No</div></td>
                        <td class="bold1"><div align="left">Vendor Name</div></td>
                        <td class="bold1"><div align="left">Date</div></td>
                        <td class="bold1"><div align="left">Amount</div></td>
                        <td class="bold1">Payment</td>
                        <td class="bold1"><div align="left">View</div></td>
                      </tr>
                    </table>
                </div></td>
              </tr>
              <tr>
                <td height="127" valign="top" class="footermenu"> 
					  <div id="DirectPurchaseTable" style="OVERFLOW:auto;width:100%;height:250px" class="boldEleven" /> 
					  <br>
					  <div id="totRec"></div>
					  <br>                    </td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><table width="100%" border="0" align="center" cellpadding="1"
			cellspacing="1"  >
              <tr class="para">
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('0')">All</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('A')">A</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('B')">B</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('C')">C</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('D')">D</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('E')">E</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('F')">F</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('G')">G</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('H')">H</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('I')">I</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('J')">J</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('K')">K</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('L')">L</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('M')">M</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('N')">N</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('O')">O</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('P')">P</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('Q')">Q</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('R')">R</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('S')">S</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('T')">T</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('U')">U</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('V')">V</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('W')">W</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('X')">X</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('Y')">Y</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:loadDirectPurchase('Z')">Z</a></div></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><table width="296" border="0" align="center" cellpadding="1"
			cellspacing="1">
                <!--DWLayoutTable-->
                <tr>
                  <td width="56" valign="top"><input type="hidden" name="filename" value="DirectPurchase" />
                      <input type="hidden" name="actionS" value="STKDirectPurchaseDelete" /></td>
                  <td width="56" valign="top"><input type="submit"	class="buttonbold13" name="action1"  value="Add"   accesskey="s"   onClick="Add()" /></td>
                  <!--<td width="56" valign="top"><input type="submit"	class="buttonbold13" name="action1"   value="Edit"	onclick="return Edit()" /></td>-->
                  <%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
                  <td width="56" valign="top"><input type="submit"	class="buttonbold13" name="Submit"   value="Delete"		onclick="return Delete()" /></td>
                  <%
	   }
	   %>
                  <td width="56"><input type="button" class="buttonbold13"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect('StockMain.jsp')" /></td>
                </tr>
            </table></td>
          </tr>
        </table>
      </form></td>
  </tr>

	 
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</body>
</html>
