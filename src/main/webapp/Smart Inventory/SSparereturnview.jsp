<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="java.util.Date"%>
<%
try
{
%>
<html>
<head>
<title><%= CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='INV' ")[0][0]%></title>
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
@import url("../JavaScript/SmartStyles.css");
</style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Inventory/SSparereturn.js"></script>
<script language="javascript">


	function Edit()
	{	
		var chkbox=document.forms[0].id;
		var len=0;
		var ch=0;
		for(i=0;i<chkbox.length;i++)
		{
			if(chkbox[i].checked)
			{
				len++;
			}
		}
			if(len>1)
			{
				alert("Select Only One Value");
				return false;
			}
			else if(len==0)
			{
				if(chkbox.checked)
				{
					document.frm.action="SSparereturnedit.jsp";
					return true;
				}
				else
				{
					alert("Select Any One Value");
					return false;
				}
			}
			else
			{
				document.frm.action="SSparereturnedit.jsp";
				return true;
			}
	}

function Delete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].id;
		txt="";
		var id1="";
		for (i=0;i<coffee1.length;++i)
		{
			if (coffee1[i].checked)
			{
				count=count+1;
				
				id1=i;
			}
		}
		if(count==0)
		{
			if (document.forms[0].id.checked) { count=1;}
		}
		if(count==1)
		{			
				var r=confirm("ARE YOU SURE YOU WANT TO DELETE..."+coffee1[id1].value);
				if (r==true)
	  			{
	  					document.frm.action="../SmartLoginAuth";
						return true;
	  			}
				else{
			return false;
			}			
		}
		else
		{
		    alert("Select Atleast One Value");
		    return false;
		}		
 	} 	 	

</script>

<body  onLoad="loadsparereturn('0')">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   action="" method="get" name="frm"  >
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td><%
    String fooParameter = request.getParameter( "message" );
    if ( fooParameter == null )
    	{fooParameter="  ";
	%>
 		<%out.println(""+fooParameter);%>
	<%
    	}else{
	%>
	<p><center><span class="bolddeepred"><%out.println(""+fooParameter);%></span></center></p>
	<%}%></td>
    </tr>
	<tr>
	  <td>
	  <table align="center" cellpadding="0" cellspacing="0"   class="TableDesign">
        <tr>
          <td><div align="center" class="whiteMedium"><strong>SPARE RETURN </strong></div>
		  </td>
        </tr>
		<tr>
		<td>
		
		<table width="100%" border="0" cellpadding="2" cellspacing="2" class="whiteMedium">
            <tr>
			<td width="260"></td>
              <td width="64">SpareType</td>
              <td width="60">
			  <select name="sparetype" id="sparetype" onChange="loadsparereturn('0')">
                  <option value="0">All</option>
				  <option value="C">Consumable</option>
				  <option value="S">Serial</option>
              </select>
			  </td>
			  <td width="72" >Type </td>
			 <td width="57" class="boldEleven">
              <select name="type" class="formText135" id="type" onChange="loadsparereturn('0')" >
				<option value="0">All</option>
				<option value="I">Item</option>
				<option value="P">Product</option>
			  </select> 
			</td>
              <td width="43" >Month</td>
              <td width="104">
			  <select name="month" class="formText135" id="month" onChange="loadsparereturn('0')">
			  
                  <%
java.util.Date dt = new java.util.Date();
int m = dt.getMonth();
%>


<option value="0">All</option>
<option value="01">January</option>
<option value="02">February</option>
<option value="03">March</option>
<option value="04">April</option>
<option value="05">May</option>
<option value="06">June</option>
<option value="07">July</option>
<option value="08">August</option>
<option value="09">September</option>
<option value="10">October</option>
<option value="11">November</option>
<option value="12">December</option>
              </select></td>
              <td width="34" >Year </td>
              <td width="340"><select name="year" class="formText135" id="year" onChange="loadsparereturn('0')">
                  <%
java.util.Date dts = new java.util.Date();
int ms = dts.getYear();
%>
<option value="1999" selected="selected">1999</option>
<%
      for(int i=2000;i<=2050;i++)
      {
       out.println("<option value="+i+">"+i+"</option>");
      }
  %>

                </select>
                  <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						var day=d.getDate();
						//setOptionValue('day',day);	
						setOptionValue('month',month1);
						setOptionValue('year',year1);	
				//-->
            </script></td>
            </tr>
          </table>
		
		
		
		</td>
		</tr>
		<tr>
			<td>
			<table width="100%" cellpadding="1" cellspacing="1" class="whiteMedium">
					<tr>
						<td width="4%" align="center">S.No</td>
						<td width="10%" align="center">Issue No </td>
						<td width="10%" align="center">Demand No </td>
						<td width="10%" align="center">CustomerName</td>
						<td width="10%" align="center">Spare Type </td>
						<td width="10%" align="center">Type</td>
						<td width="10%" align="center">Product code</td>
						<td width="10%" align="right">SerialNo/Qty</td>
						<td width="3%" align="right">RQty</td>
						<td width="3%" align="center">UsdQty</td>
						<td width="5%" align="center">Status</td>
					</tr>
				</table>
			</td>
		</tr>
        <tr class="boldEleven">
          <td bgcolor="#FFFFFF"><div align="center">
            <div id="SparereturnTable" style="OVERFLOW:auto;width:100%;height:260px"class="boldEleven"> </div>
          </div><br><div id ="totRec" align="center"> </div><br>		
		  </td>
        </tr>
      </table></td>
    </tr>
	<tr>
	  <td valign="top">&nbsp;</td>
    </tr>
	<tr>
	  <td valign="top"><table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
        <tr class="para">
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('0')">All</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('A')">A</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('B')">B</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('C')">C</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('D')">D</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('E')">E</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('F')">F</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('G')">G</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('H')">H</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('I')">I</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('J')">J</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('K')">K</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('L')">L</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('M')">M</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('N')">N</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('O')">O</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('P')">P</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('Q')">Q</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('R')">R</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('S')">S</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('T')">T</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('U')">U</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('V')">V</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('W')">W</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('X')">X</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('Y')">Y</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadsparereturn('Z')">Z</a></div></td>
        </tr>
      </table></td>
    </tr>
	<tr>
	  <td valign="top"></td>
    </tr>
	<tr>
	  <td valign="top"><table width="224" border="0" align="center" cellpadding="1"
			cellspacing="1">
        <!--DWLayoutTable-->
        <tr>
          <td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1" value="Return"
					onclick=" return Edit()" />	
					<input type="hidden" name="filename" value="SSpareReturnitemproduct" />
		 			 <input type="hidden" name="actionS" value="INVSparereturnitemproductdelete" /> 
</td>
          <%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
          <td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="Submit" value="Delete"
					onclick=" return Delete()" /></td>
          <% }%>
          <td width="56"><input name="Close" type="button"
					class="ButtonHead" id="Close"  value="Close"   accesskey="c" 
					onclick="redirect( 'InventoryMains.jsp')" /><%%></td>
        </tr>
      </table></td>
    </tr>
	<tr>
		<td valign="top"><font size="1"><strong><font
										color="#000000"><font size="1"><strong><font
										color="#000000"><font size="1">
          <strong><font color="#000000"><font size="1">
          
          </font></font></strong></font></font></strong></font></font></strong></font></td>
	</tr>
</table>
 <%@ include file="../footer.jsp"%></form>
</body>
</html>
<%
}
catch(Exception e)
{
}

%>