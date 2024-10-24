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
<script language="javascript" src="../JavaScript/Stock/DirectSale.js"></script>
<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="DirectSaleAdd.jsp";
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
		
		
		//form 37 - attck 
		//mambalam
		
		//employee continuous form
		
		//80pages note book;
		
		if(count==0)
		{
			if (document.forms[0].salesid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="DirectSaleEdit.jsp";
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
		coffee1=document.forms[0].Salesid
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
			if (document.forms[0].Salesid.checked) { count=1;}
		}
		if(count==1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				
				
				var reason=prompt("Reason for Delete :: ","For e.g - Value has to be change."); 
	  			if (reason!=null && reason!="")
  				{
					document.frm.action="../SmartLoginAuth?reason="+reason;
					return true;			
				}
				else
					return false;	
							
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
 	
	
	
	function  Print(salno)
		{
			var width="800", height="400";
			var left = (screen.width/2) - width/2;
			var top = (screen.height/2) - height/2;
			var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=no,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
			var f ="DirectSalesPrint.jsp?salno="+salno  ;
			newWindow = window.open(f,"subWind",styleStr);
			newWindow.focus( );
	}
	
</script>

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="LoadDirectSale('0')">
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
                  Sales </span></div></td>
              </tr>
              <tr class="BackGround">
                <td class="BackGround"><table width="653" border="0" align="center" cellpadding="2"
					cellspacing="2">
                    <tr>
                      <td width="18" class="boldThirteen">Division</td>
                      <td width="19" class="boldThirteen"><select name="division"
							class="formText135" id="division" tabindex="1"
							onChange="LoadDirectSale('0')">
                          <option value='0'>All</option>
                          <jsp:include page="LoadDivision.jsp" />   
                      </select></td>
                      <td width="37" class="boldThirteen">Customer</td>
                      <td width="37" class="boldThirteen"><select name="customer"
							id="customer" class="formText135"
							onChange="LoadDirectSale('0')">
                          <option value="0">All</option>
                          <jsp:include page="LoadCustomer.jsp" />            
                      </select></td>
                      <td width="74" class="boldThirteen">Month </td>
                      <td width="89"><select name="month" id="month"
							onBlur="LoadDirectSale('0')">
							
                          <%@ include file="../JavaScript/common/month.jsp"%>
                      </select></td>
                      <td width="50" class="boldThirteen">Year </td>
                      <td width="88"><select name="year" id="year"
							onBlur="LoadDirectSale('0')">
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
                    <table width="100%"   border="0" cellpadding="0" cellspacing="0">
                      <tr class="BackGround">
                        <td class="bold1"  ><div align="left">S. No</div></td>
                        <td class="bold1"  ><div align="left">SalesNumber</div></td>
						
                        <td class="bold1"  ><div align="left">Cutomer Name</div></td>
						<td class="bold1"  ><div align="left">Date</div></td>
						<td class="bold1"  ><div align="left">Amount</div></td>
                        <td class="bold1"  ><div align="left">Status</div></td>
                        <td class="bold1"  >View</td>
                        
                      </tr>
                    </table>
                </div></td>
              </tr>
              <tr>
                <td height="127" valign="top" class="footermenu"> 
					  <div id="DirectSaleTable" style="OVERFLOW:auto;width:100%;height:250px" class="boldEleven" /> <br>  
					     <div align="center" id="totalrecord"></div>   <br>           </td>
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
					href="javascript:LoadDirectSale('0')">All</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDirectSale('A')">A</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDirectSale('B')">B</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDirectSale('C')">C</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDirectSale('D')">D</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDirectSale('E')">E</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDirectSale('F')">F</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDirectSale('G')">G</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDirectSale('H')">H</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDirectSale('I')">I</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDirectSale('J')">J</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDirectSale('K')">K</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDirectSale('L')">L</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDirectSale('M')">M</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDirectSale('N')">N</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDirectSale('O')">O</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDirectSale('P')">P</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDirectSale('Q')">Q</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDirectSale('R')">R</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDirectSale('S')">S</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDirectSale('T')">T</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDirectSale('U')">U</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDirectSale('V')">V</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDirectSale('W')">W</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDirectSale('X')">X</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDirectSale('Y')">Y</a></div></td>
                <td class="boldEleven"><div align="center"><a
					href="javascript:LoadDirectSale('Z')">Z</a></div></td>
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
                  <td width="56" valign="top"><input type="hidden" name="filename" value="DirectSale" />
                      <input type="hidden" name="actionS" value="STKDirectSaleDelete" /></td>
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
