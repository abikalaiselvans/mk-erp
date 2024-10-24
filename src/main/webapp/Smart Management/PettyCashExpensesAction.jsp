    <%@ page import="java.sql.*,java.util.*,java.io.*"%>
 <%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html>
<head>
<title>:: MANAGEMENT ::</title> 
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id,payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
  
$(function() {
		$( "#incomedate" ).datepicker({
			changeMonth: true,
			changeYear: true,
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true,
			//minDate: "-10D", maxDate: "+0D"
		});
	}); 
	

 function textClear()
 {
	 try
	 {
		 document.getElementById('othersid').value = "";
		 
	 }
	 catch(err)
	 {
		 alert(err);
	 }
 }

	</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">



<script language="JavaScript">

function Validate()
  {
	
   
	if(  checkNullSelect( "branch","Select Branch", "" ) 
		 && checkNullSelect( "category","Select Account Head", "" ) 	
	     &&  checkNull( "incomedate","Enter The Date" )
		 &&  checkNull( "income","Enter The Amount" )
		 && checkNullSelect( "paymentmode","Payment Mode", "" ) 
		 &&  checkNull( "othersid","Enter The Employee id/name" )
		 &&  checkNull( "desc","Enter The description" )
		  )
		  
		return true;
		 
	else  		
		return false;				
		
	
 } 	
 </script>
 
 

<script type="text/javascript">
function lookupbefore(othersid) 
{
		var type = document.getElementById('radio1').checked;
		if( type)
			lookup(othersid) 
}

function lookup(othersid) 
{
	try
	{
		
			if(othersid.length == 0) 
			{
				$('#suggestions').hide();
			} 
			else 
			{
				$.post("getEmployeeid.jsp", {queryString: ""+othersid+""}, function(data)
				{
					if(data.length >0) 
					{
						$('#suggestions').show();
						$('#autoSuggestionsList').html(data);
					}
				});
			}
		 
	}
	catch(err)
	{
		alert(err);
	}
}
function fill(thisValue) 
{
	var type = document.getElementById('radio1').checked;
	if( type)
	{		
		document.getElementById('othersid').value=thisValue;
		$('#othersid').val(thisValue);
		//$('#suggestions').hide();
		setTimeout("$('#suggestions').hide();", 1000);
	}
}
</script>
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");

body {
font-family: Helvetica;
font-size: 13px;
color: #000;
}
h3 {
margin: 0px;
padding: 0px;
}


.suggestionsBox 
{
	position: relative;
	margin: 0px 0px 0px 0px;
	width: 200px;
	background-color: #ffffff;
	-moz-border-radius: 7px;
	-webkit-border-radius: 7px;
	border: 1px solid #000;
	color: #000;
}
.suggestionList 
{
	margin: 0px;
	padding: 0px;
}
.suggestionList li 
{
	margin: 0px 0px 3px 0px;
	padding: 1px;
	cursor: pointer;
}

.suggestionList li:hover {
background-color: #99cc99;
}
</style>




<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
	 <form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">
	<table class="BackGround1" cellspacing="0" cellpadding="0" width="500"
			align="center" border="0">
      <tbody>
        <tr>
          <td colspan="2" rowspan="2" valign="top"><span class="boldEleven"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></span></td>
          <td class="BorderLine" height="0"><span class="boldEleven">
            <spacer height="1" width="1"
						type="block" />
          </span></td>
          <td colspan="2" rowspan="2" valign="top"><span class="boldEleven"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></span></td>
        </tr>
        <tr>
          <td height="6"><span class="boldEleven">
            <spacer height="1" width="1" type="block" />
          </span></td>
        </tr>
        <tr>
          <td class="BorderLine" width="1"><span class="boldEleven">
            <spacer height="1" width="1"
						type="block" />
          </span></td>
          <td width="6"><span class="boldEleven">
            <spacer height="1" width="1" type="block" />
          </span></td>
          <td width="412" valign="top">
		 
		    <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3">
              <tr>
                <td colspan="2" class="bold1"><div align="center"><span class="boldEleven"><span class="boldThirteen">EXPENSES / PAYMENTS </span>
                      <%
							String action=request.getParameter("action1");
							String id="",name="",desc="",actionS="",value="";
							String sql="";
							String link="";
							String branch,date,type,income; 
							String s1="",s2="";
							String emp="";
							String authorised="";
							String taxValue="";
							String  paymentmode="";
							
							if("Add".equals(action))
							{
								id="";name=""; desc=" ";
								actionS="MGTPettyCashExpensesAdd";
								value="Add";taxValue="";
								branch="";date="";type="";income="0";
								link=" ";emp="";
								s1=""; s2=" checked = 'checked' ";
								authorised=""; paymentmode="";
							}
							 
							else
							{
								id="";name=""; 
								id=request.getParameter("rowid");
								sql = "SELECT INT_EXPENSESID,INT_BRANCHID,INT_CATEGORYID,DATE_FORMAT(DAT_EXPENSE,'%d-%m-%Y'),CHR_DESC,DOU_AMOUNT ,CHR_TYPE,CHR_EMPID,CHR_AUTHORAISEDBY ,INT_PAYMENTMODE  FROM mgt_t_pettycash_expenses WHERE INT_EXPENSESID= "+id;
								String data[][]=CommonFunctions.QueryExecute(sql);
								id=data[0][0];branch=data[0][1];  type=data[0][2];  date=data[0][3];  desc=data[0][4];  income=data[0][5]; 
								emp=data[0][7]; 
								authorised=data[0][8]; 
								  paymentmode=data[0][9]; 
								if(data[0][6].equals("E") )
									s1=" checked = 'checked' "; 
								else
									s2=" checked = 'checked' "; 
								 
								actionS="MGTPettyCashExpensesEdit";
								value="Update";
								link=" onBlur=\"upperMe(this)\"";
								 
							}
							
						%>			
                  	
                </span></div></td>
                </tr>
              <tr>
                <td class="boldEleven">Branch <span class="errormessage">*</span></td>
                <td class="boldEleven"><select name="branch"
										class="formText135" id="branch" tabindex="6" style="width:200">
                  <option value="">Select</option>
                  <%
								
												
				 sql ="Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID  AND b.INT_ACTIVE =1  ";
				 //sql = sql + " AND  a.INT_BRANCHID ="+session.getAttribute("BRANCHID");	
				 String branchdata[][] =  CommonFunctions.QueryExecute(sql);
								for(int u=0; u<branchdata.length; u++)
									out.print("<option value='"+branchdata[u][0]+"'>"+branchdata[u][2]+ "  @  " +branchdata[u][1] +"</option>");
							%>
                </select></td>
              </tr>
              <tr>
                <td class="boldEleven">Category <span class="errormessage">*</span></td>
                <td class="boldEleven"><select name="category"
										class="formText135" id="category" tabindex="6" style="width:200">
                  <option value="">Select</option>
                  <%
						
												
				 sql ="SELECT INT_CATEGORYID,CHR_NAME   FROM mgt_m_pettycash ORDER BY CHR_NAME";	
				 String categorydata[][] =  CommonFunctions.QueryExecute(sql);
								for(int u=0; u<categorydata.length; u++)
									out.print("<option value='"+categorydata[u][0]+"'>"+ categorydata[u][1] +"</option>");
							%>
                </select></td>
              </tr>
              <tr>
                <td width="43%" class="boldEleven">Date <span class="errormessage">*</span></td>
                <td width="57%" class="boldEleven"><input tabindex="2" name="incomedate" type="text" class="formText135" id="incomedate" size="15" readonly   value='<%=date%>' />                  <script language="javascript">setCurrentDate('incomedate')</script></td>
              </tr>
               
              <tr>
                <td align="left" valign="top" class="boldEleven">Amount <span class="errormessage">*</span></td>
                <td align="left" valign="top" class="boldEleven"><input name="income" type="text" value="<%=income%>"
										class="formText135" id="income" onKeyPress="return numeric_priceonly(event,'income','15')" size="31" maxlength="8"/></td>
              </tr> 
              <tr>
                <td align="left" valign="top" class="boldEleven">Payment Mode  <span class="errormessage">*</span></td>
                <td align="left" valign="top" class="boldEleven"><select name="paymentmode" class="formText135" id="paymentmode" style="width:200">
                  <option value="">Select</option>
                  <%
					   sql = "SELECT INT_DEPOSITID, CHR_DEPOSITNAME FROM com_m_deposit_to WHERE CHR_STATUS !='N' ORDER BY CHR_DEPOSITNAME";
					   String deposit[][] = CommonFunctions.QueryExecute(sql);
					  for(int u=0; u<deposit.length;u++)
					  		out.println("<option value='"+deposit[u][0]+"'>"+deposit[u][1]+"</option>");
					  %>
                </select>
				<script language="javascript">setOptionValue('paymentmode','<%=paymentmode%>')</script> 
				</td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">Type <span class="errormessage">*</span></td>
                <td align="left" valign="top" class="boldEleven"><table width="100" border="0" cellspacing="0" cellpadding="0">
                  <tr class="boldEleven">
                    <td><input name="whom" type="radio" id="radio1" value="E" onClick="textClear()" <%=s1%> ></td>
                    <td class="boldEleven">Employee </td>
                    <td><input name="whom" type="radio" id="radio2" value="O"    onClick="textClear()" <%=s2%>></td>
                    <td class="boldgreen"><span class="boldEleven">Others</span></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">Employee / Others Id <span class="errormessage">*</span></td>
                <td align="left" valign="top" class="boldEleven">
                <input name="othersid" type="text" class="formText135" id="othersid" size="30" maxlength="30"  onBlur="fill();"   onkeyup="upperMe(this),lookupbefore(this.value);" value="<%=emp%>" >
                <div class="suggestionsBox" id="suggestions" style="display: none;">
					<div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:100px" ></div>
				 </div>                </td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">Authorised by</td>
                <td align="left" valign="top" class="boldEleven"><jsp:include page="../JavaScript/authorisedby.jsp" /></td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">Description <span class="errormessage">*</span></td>
                <td align="left" valign="top" class="boldEleven"><textarea name="desc" cols="35" rows="5" class="formText135" id="desc" onKeyPress="textArea('desc','450')" ><%=desc%></textarea>
                 
                <%
				if(!"Add".equals(action))
				{
				%>
					<script language="javascript">
                    	setOptionValue('branch','<%=branch%>');
                    	setOptionValue('category','<%=type%>');
						setOptionValue('authorised','<%=authorised%>');
                    	document.getElementById('incomedate').value ="<%=date%>";
                    </script>
                 
                <%
				}
				%></td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven"><input type="hidden" name="filename" value="PettyCashExpenses" />
				<input type="hidden" name="actionS"  value="<%=actionS%>" />
				<input name="rowid" type="HIDDEN" id="rowid" value="<%=id%>">				<input name="userid" type="hidden" id="userid" value="<%=""+session.getAttribute("USRID")%>"></td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><span class="boldEleven">
                      <input name="Submit" id="Submit" type="submit" 	class="buttonbold13" value="<%=value%>">
                    </span></td>
                    <td><span class="boldEleven">
                      <input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('PettyCashExpenses.jsp')">
                    </span></td>
                  </tr>
                </table></td>
                </tr>
            </table>
		 </td>
          <td nowrap="nowrap" width="4"><span class="boldEleven">
            <spacer height="1" width="1"
						type="block" />
          </span></td>
          <td class="BorderLine" width="1"><span class="boldEleven">
            <spacer height="1" width="1"
						type="block" />
          </span></td>
        </tr>
        <tr>
          <td colspan="2" rowspan="2"><span class="boldEleven"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></span></td>
          <td height="6"><span class="boldEleven">
            <spacer height="1" width="1" type="block" />
          </span></td>
          <td colspan="2" rowspan="2"><span class="boldEleven"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></span></td>
        </tr>
        <tr>
          <td class="BorderLine" height="0"><span class="boldEleven">
            <spacer height="1" width="1"
						type="block" />
          </span></td>
        </tr>
      </tbody>
    </table> </form></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
<%@ include file="../footer.jsp"%>

 <%	
 
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>
</body>
</html>
