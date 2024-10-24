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
		 && checkNullSelect( "source","Select source", "" ) 	
		 
		 &&  checkNull( "desc","Enter The description" )
		  )
		return true;
		 
	else  		
		return false;				
		
	
 } 	
 
  

</script>
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
                <td colspan="2" class="bold1"><div align="center"><span class="boldThirteen"> INCOME / RECEIPTS </span>
                    <%
							String action=request.getParameter("action1");
							String id="",name="",desc="",actionS="",value="";
							String sql="";
							String link="";
							String branch,date,type,income,source, paymentmode; 
							
							String taxValue="";
							if("Add".equals(action))
							{
								id="";name=""; desc=" ";
								actionS="MGTPettyCashIncomeAdd";
								value="Add";taxValue="";
								 branch="";date="";type="";income="0";
								link=" ";
								source="";
								paymentmode="";
							}
							 
							else
							{
								id="";name=""; 
								id=request.getParameter("rowid");source="";
								sql = "SELECT INT_INCOMEID,INT_BRANCHID,INT_CATEGORYID,DATE_FORMAT(DAT_INCOME,'%d-%m-%Y'),CHR_DESC,DOU_AMOUNT,INT_SOURCEID,INT_PAYMENTMODE  FROM mgt_t_pettycash_income WHERE INT_INCOMEID= "+id;
								String data[][]=CommonFunctions.QueryExecute(sql);
								id=data[0][0];branch=data[0][1];  type=data[0][2];  date=data[0][3];  desc=data[0][4];  income=data[0][5]; 
								 source=data[0][6]; 
								 paymentmode=data[0][7]; 
								actionS="MGTPettyCashIncomeEdit";
								value="Update";
								link=" onBlur=\"upperMe(this)\"";
							}
							
						%>			
                  
                </div></td>
                </tr>
              <tr>
                <td class="boldEleven">Branch</td>
                <td class="boldEleven"><select name="branch"
										class="formText135" id="branch" tabindex="6" style="width:200">
										<option value="">Select</option>
										<%
								
												
				 sql ="Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID  AND b.INT_ACTIVE =1";	
				 String branchdata[][] =  CommonFunctions.QueryExecute(sql);
								for(int u=0; u<branchdata.length; u++)
									out.print("<option value='"+branchdata[u][0]+"'>"+branchdata[u][2]+ "  @  " +branchdata[u][1] +"</option>");
							%>
									</select></td>
              </tr>
             
              <tr>
                <td width="43%" class="boldEleven">Date<span class="boldred"></span> </td>
                <td width="57%" class="boldEleven"> 
                <input tabindex="2" name="incomedate" type="text" class="formText135" id="incomedate" size="15" readonly   value='<%=date%>' />
                <script language="javascript">setCurrentDate('incomedate')</script>                </td>
              </tr>
               
              <tr>
                <td align="left" valign="top" class="boldEleven">Amount</td>
                <td align="left" valign="top" class="boldEleven"><input name="income" type="text" value="<%=income%>"
										class="formText135" id="income" onKeyPress="return numeric_priceonly(event,'income','15')" size="31" maxlength="8"/></td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">Payment Mode <span class="errormessage">*</span></td>
                <td align="left" valign="top" class="boldEleven"><select name="paymentmode" class="formText135" id="paymentmode" style="width:200">
                  <option value="">SELECT</option>
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
                <td align="left" valign="top" class="boldEleven">Source</td>
                <td align="left" valign="top" class="boldEleven">
              
                <select name="source" class="formText135" id="source">
                 <option value="">Select</option>
                <%
								
												
				 sql ="Select INT_CATEGORYID,UPPER(CHR_NAME)  from  mgt_m_pettycash  ORDER BY CHR_NAME";	
				 String sdata[][] =  CommonFunctions.QueryExecute(sql);
								for(int u=0; u<sdata.length; u++)
									out.print("<option value='"+sdata[u][0]+"'>"+ sdata[u][1] +"</option>");
							%>
                </select></td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">Description</td>
                <td align="left" valign="top" class="boldEleven"><textarea name="desc" cols="35" rows="5" class="formText135" id="desc" onKeyPress="textArea('desc','450')" ><%=desc%></textarea>
                
                <%
				if(!"Add".equals(action))
				{
				%>
					<script language="javascript">
                    	setOptionValue('branch','<%=branch%>');
                    	//setOptionValue('category','<%=type%>');
						setOptionValue('source','<%=source%>');
                    	document.getElementById('incomedate').value ="<%=date%>";
						
                    </script>
                 
                <%
				}
				%>                </td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input type="hidden" name="filename" value="PettyCashIncome" />
				<input type="hidden" name="actionS"  value="<%=actionS%>" />
				<input name="rowid" type="HIDDEN" id="rowid" value="<%=id%>">				 
				<input name="userid" type="hidden" id="userid" value="<%=""+session.getAttribute("USRID")%>">
				<input name="category" type="hidden" id="category" value="1"></td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" id="Submit" type="submit" 	class="buttonbold13" value="<%=value%>"></td>
                    <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('PettyCashIncome.jsp')"></td>
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
