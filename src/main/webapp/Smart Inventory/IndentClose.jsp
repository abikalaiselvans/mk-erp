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
<script language="javascript" src="../JavaScript/Inventory/IndentClose.js"></script>
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
		document.frm.action="IndentRaiseAdd.jsp";		
 	}

	function Edit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].indentid
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
			if (document.forms[0].indentid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="IndentRaiseUpdate.jsp";
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
		coffee1=document.forms[0].indentid;
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
			if (document.forms[0].indentid.checked) { count=1;}
		}
		
		if(count>1)
		{
			alert("Kindly select one value");
			return false;
		}
		if(count==1)
		{			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
				return true;			
			}
			else
				return false;
				
				/*var r=confirm("ARE YOU SURE YOU WANT TO DELETE THE INVOICE  ..."+coffee1[id].value);
				if (r==true)
	  			{
	  				var reason=prompt("Reason for Delete :: ","For e.g - Value has to be change."); 
	  				if (reason!=null && reason!="")
  					{
	  					var d ="../SmartLoginAuth?indentid="+coffee1[id].value+"&reason="+reason;
						document.frm.action=d; 
						
					}	
	  			}		*/	

		}
		else
		{
		    alert("Select Atleast One Value");
		    return false;
		}		
 	}
	
	
function adminDeletes(saleno,invoicenumber)
{
	try
	{
		var r=confirm("ARE YOU SURE YOU WANT TO DELETE THE INDENT NUMBER IS ..."+invoicenumber);
		if (r==true)
	  	{
	  		var reason=prompt("Reason for delete :: ","For e.g - Value has to be change."); 
	  		if (reason!=null && reason!="")
  			{
	  			var d =saleno+"&reason="+reason;
	  			document.frm.action=d; 
				document.frm.submit();  
			}	
	  	}
	}
	catch(err)	
	{
		alert(err.description)
	}	
}

</script>

<body    onLoad="loadIndentClose('0')">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class="bolddeepred">&nbsp;</td>
	</tr>
	 
	<tr>
	  <td>	  </td>
	</tr>
	<tr>
		<td height="291"><table width="811" height="307" border="0" align="center"
			cellpadding="0" cellspacing="0"  
			 >
          <tr class="BackGround">
            <td height="31" class="BackGround"><div align="center">INDENT CLOSE </div></td>
          </tr>
          <tr class="BackGround">
            <td height="31" class="BackGround"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="31" valign="top"><table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="68" height="31"><strong>
					<%
					String usertype=""+session.getAttribute("USRTYPE");
					String emp=""+session.getAttribute("EMPID");
					String depid =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_DEPARTID FROM com_m_staff WHERE CHR_EMPID='"+emp+"'")[0][0]; 
					%>
					Department</strong></td>
                    <td width="61"><select name="dept" class="formText135"	id="dept" tabindex="1"  onChange="loadIndentClose('0')" >
                      
                      <%
			String deptsql="SELECT INT_DEPARTID,CHR_DEPARTNAME FROM com_m_depart ORDER BY INT_DEPARTID";
			String deptdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(deptsql);
			if("F".equals(usertype))
			{
				for(int x=0;x<deptdata.length;x++)
					out.println("<option value='"+deptdata[x][0]+"'>"+deptdata[x][1]+"</option>");
			}
			else
			{
				for(int x=0;x<deptdata.length;x++)
					if(deptdata[x][0].equals(depid) )
						out.println("<option value='"+deptdata[x][0]+"'>"+deptdata[x][1]+"</option>");
			}
		
			%>
                    </select></td>
                    <td width="51"><span class="bold1">Month</span></td>
                    <td width="124"><select name="month" id="month" onChange="loadIndentClose('0')">
                      <%@ include file="../JavaScript/Inventory/month.jsp"%>
                    </select></td>
                    <td width="30"><span class="bold1">Year</span></td>
                    <td width="108"><select name="year" id="year"
							 onChange="loadIndentClose('0')">
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
                    <td width="108" class="bold1"> Status </td>
                    
                    <td width="108">
					<select name="status" class="formText135" id="status" onChange="loadIndentClose('0')">
						<option value="0">All</option>
						<option value="Y">Approved</option>
						<option value="N">Pending</option>
					</select>                    </td>
					<td width="108">Payment</td>
                    <td width="108">
					
					<select name="payment" class="formText135" id="payment" onChange="loadIndentClose('0')">
						<option value="0">All</option>
						<option value="Y">Paid</option>
						<option value="P">Partia Paid</option>
						<option value="N">Pending</option>
					</select> 
					</td>
					
                  </tr>
                </table></td>
                </tr>
            </table></td>
          </tr>

          <tr>
            <td height="18" valign="top"   class="footermenu">
			</td>
          </tr>
          <tr>
            <td height="127" valign="top" class="footermenu">
			<div id="divscroll" style="OVERFLOW:auto;width:100%;height:240px"
							class="boldEleven">
						<div id="PurchaseIndent"></div>
						</div>			</td>
          </tr>
        </table></td>
	</tr>
	<tr>
	  <td><table width="800" border="0" align="center" cellpadding="1"
			cellspacing="1"  >
        <tr class="para">
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('0')">All</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('A')">A</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('B')">B</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('C')">C</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('D')">D</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('E')">E</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('F')">F</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('G')">G</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('H')">H</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('I')">I</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('J')">J</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('K')">K</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('L')">L</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('M')">M</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('N')">N</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('O')">O</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('P')">P</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('Q')">Q</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('R')">R</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('S')">S</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('T')">T</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('U')">U</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('V')">V</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('W')">W</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('X')">X</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('Y')">Y</a></div></td>
          <td class="boldEleven"><div align="center"><a href="javascript:loadIndentClose('Z')">Z</a></div></td>
        </tr>
      </table></td>
    </tr>
	 
	<tr>
	  <td><input name="filename" type="hidden" value="PurchaseIndent" />
        <input
			name="actionS" type="hidden" value="INVPurchaseIndentCloseDelete" />
        <table width="174" border="0" align="center" cellpadding="01"
			cellspacing="0">
        <!--DWLayoutTable-->
        <tr>
          <td width="56" valign="top"><input type="submit"
					class="buttonbold13" name="action12" id="btnEdit" value="Edit"
					onclick="return Edit()" /></td>
          <%
	  //
	  if("F".equals(usertype))
	  {
	  %>
          <td width="56" valign="top"><input type="submit"
					class="buttonbold13" name="Submit3" id="btnDelete" value="Delete"
					onclick="return Delete()" /></td>
          <%}%>
          <td width="56"><input type="button" class="buttonbold13"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')" /></td>
        </tr>
      </table></td>
    </tr>
</table>
 <%@ include file="../footer.jsp"%></form>
</body>
</html>
