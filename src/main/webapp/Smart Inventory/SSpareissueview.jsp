<%@ page import="java.io.*,java.util.*,com.my.org.erp.common.*"%>
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
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Inventory/SSpareissue.js"></script>
 <script language="javascript">
 
 function Add()
	{ 
		document.frm.action="SSpareissueadd.jsp";
 	}

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
					document.frm.action="SSpareissueedit.jsp";
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
				document.frm.action="SSpareissueedit.jsp";
				return true;
			}
	}

function Delete()
{

	var chkbox=document.forms[0].id;
	var len=0;
	for(i=0;i<chkbox.length;i++)
	{
		if(chkbox[i].checked)
			len++;
	}
	if(!document.forms[0].id){
		alert("Select Any One Value");
		return false;
	}
	else if(len==0)
	{
		if(chkbox.checked)
		{
			document.frm.action="../SmartLoginAuth";
			return true;
		}
		else
		{
			alert("Select Any One Value");
			return false;
		}
	}
	else if(len>=1)
	{
		var name=confirm("Confirm to Delete?");
		if(name == true)
		{
				document.frm.action="../SmartLoginAuth";
				return true;
		}
		else
		{
			return false;
		}
	}	
}
</script>

<body  onLoad="loadspareissue('0')">
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
          <td><div align="center" class="whiteMedium"><strong>SPARE ISSUE </strong></div>
		  </td>
        </tr>
		<tr>
		<td>
		
		<table width="100%" border="0" cellpadding="2" cellspacing="2" class="whiteMedium">
            <tr>
			<td width="260"></td>
              <td    >Branch</td>
              <td    ><select name="Branch" class="formText135" id="Branch" tabindex="6" style="width:150"  onBlur="loadspareissue('0') ">
                  <option value='0'>All</option>
                  <%
								String branchid=""+session.getAttribute("BRANCHID");
								String sql ="Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID ";	
				if("N".equals(CommonFunctions.QueryExecute("SELECT  CHR_DISPLAYINACTIVECOMPANY FROM m_institution  WHERE INT_ID=1")[0][0]))			  
					sql = sql + " AND b.INT_ACTIVE =1 ";
								
				String shipids[][] =  CommonFunctions.QueryExecute(sql);
								for(int u=0; u<shipids.length; u++)
									out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+ "  @  " +shipids[u][1] +"</option>");
							%>
                </select>
              </td>
              <td width="64">SpareType</td>
              <td width="60">
			  <select name="sparetype" id="sparetype" onChange="loadspareissue('0')">
                  <option value="0">All</option>
				  <option value="C">Consumable</option>
				  <option value="S">Serial</option>
              </select>			  </td>
			  <td width="72" >Type </td>
			 <td width="57" class="boldEleven">
              <select name="type" class="formText135" id="type" onChange="loadspareissue('0')" >
				<option value="0">All</option>
				<option value="I">Item</option>
				<option value="P">Product</option>
			  </select>			</td>
              <td width="43" >Month</td>
              <td width="104">
			  <select name="month" class="formText135" id="month" onChange="loadspareissue('0')">
			  
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
              <td width="340"><select name="year" class="formText135" id="year" onChange="loadspareissue('0')">
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
						<td width="5%" align="center">S.No</td>
						<td width="14%" align="center">Issue No </td>
						<td width="14%" align="center">Demand No </td>
						<td width="14%" align="center">CustomerName</td>
						<td width="14%" align="center">Spare Type </td>
						<td width="14%" align="center">Type</td>
						<td width="14%" align="center">Product code</td>
						<td width="14%" align="center">SerialNo/Qty</td>
					</tr>
				</table>
			</td>
		</tr>
        <tr class="boldEleven">
          <td bgcolor="#FFFFFF"><div align="center">
            <div id="SpareTable" style="OVERFLOW:auto;width:100%;height:260px"class="boldEleven"> </div>
          </div><br><div id ="totRec" align="center"> </div><br><br><br>		
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
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('0')">All</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('A')">A</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('B')">B</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('C')">C</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('D')">D</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('E')">E</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('F')">F</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('G')">G</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('H')">H</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('I')">I</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('J')">J</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('K')">K</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('L')">L</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('M')">M</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('N')">N</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('O')">O</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('P')">P</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('Q')">Q</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('R')">R</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('S')">S</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('T')">T</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('U')">U</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('V')">V</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('W')">W</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('X')">X</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('Y')">Y</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadspareissue('Z')">Z</a></div></td>
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
					class="ButtonHead" name="action1"  value="Add"   accesskey="s"   onClick=" Add()" /></td>
          <td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1" value="Edit"
					onclick=" return Edit()" />	
					<input type="hidden" name="filename" value="SSpareIsssueitemproduct" />
		 			 <input type="hidden" name="actionS" value="INVSpareissueitemproductDelete" /> 
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
	out.println(e.getMessage());
}
%>
