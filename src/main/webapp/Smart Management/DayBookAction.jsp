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
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
  
$(function() {
		$( "#fromdate" ).datepicker({
			changeMonth: true,
			changeYear: true,
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true,
			minDate: "-10D", maxDate: "+0D"
		});
	}); 
	

 

	</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">


<script language="JavaScript">

function Validate()
  {
	
   
	if(  checkNullSelect( "category","Select category ", "" ) 
		 && checkNull( "fromdate","Enter The Date" )
		 && checkNull( "amount","Enter The amount" ) 
		 && checkNullSelect( "paymentmode","Payment Mode", "" ) 
	     &&  checkNull( "desc","Enter The description" )
		  )
		return true;
	else
		return false;				
		
	
 } 	
 
  

</script>
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="document.getElementById('name').focus()" >
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
	<table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
			align="center" border="0">
      <tbody>
        <tr>
          <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
          <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
          <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
        </tr>
        <tr>
          <td height="6"><spacer height="1" width="1" type="block" /></td>
        </tr>
        <tr>
          <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
          <td width="6"><spacer height="1" width="1" type="block" /></td>
          <td width="412" valign="top">
		 
		    <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3">
              <tr>
                <td colspan="2" class="bold1"><div align="center"><span class="boldThirteen">PETTY CASH CATEGORY</span>
                    <%
							String action=request.getParameter("action1");
							String id="",name="",desc="",actionS="",value="";
							String sql="";
							String link="";
							 String category="";
							String fromdate="";
							String amount ="";
							String type="";
							String s1 = "",s2="",paymentmode=""; 
							if("Add".equals(action))
							{
								id="";name=""; desc="";
								actionS="MGTDayBookActionAdd";
								value="Add";type="";
								s1  = " checked = 'checked' ";
								category ="0"; paymentmode="";
							}
							 
							else
							{
								id="";name=""; 
								s1 = "";
								s2=""; 
								id=request.getParameter("rowid");
								sql = "SELECT INT_ROWID,INT_CATEGORYID,DATE_FORMAT(DT_DATE,'%d-%m-%Y'),CHR_TYPE, IF(CHR_TYPE='C',INT_CREDITAMOUNT,INT_DEBITAMOUNT ), CHR_DESC,INT_PAYMENTMODE  FROM mgt_t_daybook WHERE INT_ROWID = "+id;
								String data[][]=CommonFunctions.QueryExecute(sql);
								id=data[0][0];
								category=data[0][1];  
								fromdate=data[0][2]; 
								if("C".equals(data[0][3]))
								{
									s1  = " checked = 'checked' ";
									s2="";
								}
								else
								{
									s2  = " checked = 'checked' ";
									s1="";
								}
								desc=data[0][5]; 
								amount=data[0][4]; 
								paymentmode=data[0][6]; 
								actionS="MGTDayBookActionEdit";
								value="Update";
								link=" onBlur=\"upperMe(this)\"";
							}
							
						%>			
                  
                </div></td>
                </tr>
              <tr>
                <td width="43%" class="boldEleven">Category  <span class="boldred"> *</span> </td>
                <td width="57%" class="boldEleven"><select name="category"
										class="formText135" id="category" tabindex="6" style="width:200">
                  <option value="">Select</option>
                  <%
						
												
				 sql ="SELECT INT_CATEGORYID,CHR_NAME   FROM mgt_m_pettycash ORDER BY CHR_NAME";	
				 String categorydata[][] =  CommonFunctions.QueryExecute(sql);
								for(int u=0; u<categorydata.length; u++)
									out.print("<option value='"+categorydata[u][0]+"'>"+ categorydata[u][1] +"</option>");
							%>
                </select>
                <script language="javascript">setOptionValue('category','<%=category%>')</script>
                
                                  <div id='divunitname'></div>											</td>
              </tr>
               
              <tr>
                <td width="43%" class="boldEleven">Date<span class="boldred"></span></td>
                <td width="57%" class="boldEleven"><input tabindex="2" name="fromdate" type="text" class="formText135" id="fromdate" size="15" readonly   value='<%=fromdate%>' />
                <%
				if("Add".equals(action))
				{
				%>
                  <script language="javascript">setCurrentDate('fromdate')</script>
                 <%
				}
				 %>                  </td>
                </tr> 
                <tr>
                <td align="left" valign="top" class="boldEleven">Type</td>
                <td align="left" valign="top" class="boldEleven"><table width="100" border="0" cellpadding="0" cellspacing="0" class="boldEleven">
                  <tr>
                    <td><input type="radio" name="type" id="radio"  <%=s1%> value="C"></td>
                    <td>Credit</td>
                    <td><input type="radio" name="type" id="radio2"   <%=s2%>  value="D"></td>
                    <td>Debit</td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">Amount</td>
                <td align="left" valign="top" class="boldEleven"><input name="amount" type="text" value="<%=amount%>"
										class="formText135" id="amount" onKeyPress="return numeric_only(event,'amount','15')" size="31" maxlength="8"/></td>
                </tr>
             
              <tr>
                <td align="left" valign="top" class="boldEleven">Payment Mode <span class="errormessage">*</span></td>
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
                <td align="left" valign="top" class="boldEleven">Description</td>
                <td align="left" valign="top" class="boldEleven"><textarea name="desc" cols="35" rows="5" class="formText135" id="desc" onKeyPress="textArea('desc','450')" ><%=desc%></textarea></td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input type="hidden" name="filename" value="DayBookAction" />
				<input type="hidden" name="actionS"  value="<%=actionS%>" />
				<input name="rowid" type="HIDDEN" id="rowid" value="<%=id%>">				 
				<input name="userid" type="hidden" id="userid" value="<%=""+session.getAttribute("USRID")%>"></td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" id="Submit" type="submit" 	class="buttonbold13" value="<%=value%>"></td>
                    <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('DayBook.jsp')"></td>
                  </tr>
                </table></td>
                </tr>
            </table>
		 </td>
          <td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
          <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
        </tr>
        <tr>
          <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
          <td height="6"><spacer height="1" width="1" type="block" /></td>
          <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
        </tr>
        <tr>
          <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
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
	System.out.println(e.getMessage());
}
%>
</body>
</html>
