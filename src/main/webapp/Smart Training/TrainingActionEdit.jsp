<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

<%
try
{
//String action=request.getParameter("action1");
%>
<html>
<head>

<title> :: TRAINNING ::</title>

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
<script language="JavaScript" src="../JavaScript/comfunction.js" type="text/javascript"></script>
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/jquery/jquery-1.7.1.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.core.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.widget.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js" type="text/javascript"></script>
<script language="JavaScript">

$(function() {
		var dates = $( "#fromdate, #todate" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			numberOfMonths: 2,
			showOn: "button",
			buttonImageOnly: true,
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			onSelect: function( selectedDate ) {
				var option = this.id == "fromdate" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(
						instance.settings.dateFormat ||
						$.datepicker._defaults.dateFormat,
						selectedDate, instance.settings );
				dates.not( this ).datepicker( "option", option, date );
			}
		});
	});

function Validate()
  {
	
 
	if(  checkNullSelect( "type","Select Test Type" ,'0' ) 
		 && checkNull( "fromdate","Select Fromdate" )
		 && checkNull( "todate","Select Todate" )
		 && checkNullSelect( "conductedby","Select Test Conducted By" ,'0' ) 
		 && checkNull( "desc","Enter Description" ) 
		)
		return true;
	else
		return false;				
		
	 
 } 	
</script>

<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />

<%
String id="",Name="",actionS="",value="";
String sql1="";
String desc=""; 
String link="";
String type="",from="",to="",conductedby="",test="";
String empname="";
String testchecked1="";
String testchecked2="";	
%>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
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
		 
		    <table width="86%" border="0" align="center" cellpadding="3" cellspacing="3">
              <tr>
                <td colspan="2" class="bold1"><div align="center">TRAINING
                    <%
								id="";Name=""; type="";from="";to="";conductedby="";test="";link="";
								id=request.getParameter("id");
sql1 = " SELECT INT_TRAINIGID,INT_TESTTYPEID,CHR_EMPID,DATE_FORMAT(DAT_FROM,'%d-%m-%Y'),DATE_FORMAT(DAT_TO,'%d-%m-%Y'),CHR_CONDUCTEDBY,CHR_TESTREQUIRED,CHR_DESCRIPTION,FIND_A_EMPLOYEE_ID_NAME(CHR_EMPID)  FROM internal_training_m_traningdetails WHERE INT_TRAINIGID=" +id; 

								String data[][]=CommonFunctions.QueryExecute(sql1);
								testchecked1="";
								testchecked2="";	
								id=data[0][0];
								type=data[0][1];
								Name=data[0][2]; 
								from=data[0][3];
								to=data[0][4];
								conductedby=data[0][5];
								test=data[0][6];
								desc=data[0][7];
								actionS="TRATrainingEdit";
								value="Update";
								empname = data[0][8];
								if("Y".equals(test))
									testchecked1 = " checked= 'checked'";
								else
									testchecked2 = " checked= 'checked'";
							
						%>			
				
				</div></td>
                </tr>
              <tr >
                <td class="boldEleven">Test Type <span class="boldred"> * </span></td>
                <td><select name="type" class="formText135" id="type" onChange="loadTestTypeQuestion()" style="width:100px">
                    <option value="0">SelectTestType</option>
                    <%
					 String datatype[][]=CommonFunctions.QueryExecute("SELECT INT_TESTTYPEID,CHR_TESTNAME FROM internal_training_m_testtype ORDER BY CHR_TESTNAME ");
					 for(int i=0;i<datatype.length;i++) 
                        out.println("<option value="+datatype[i][0]+">"+datatype[i][1]+"</option>");
					%>
                </select>
				<script language="javascript">setOptionValue('type','<%=type%>')</script>				</td>
              </tr>
              <tr>
                <td class="boldEleven">From Date <span class="boldred"> * </span></td>
                <td class="boldEleven"><input name="fromdate" type="text" id="fromdate" value="<%=from%>" maxlength="12" readonly="readonly"/></td>
              </tr>
              <tr>
                <td class="boldEleven">To Date <span class="boldred"> * </span></td>
                <td class="boldEleven"><input name="todate" type="text" id="todate" value="<%=to%>" maxlength="12" readonly="readonly"/></td>
              </tr>
              <tr>
                <td class="boldEleven">Training Conducted By <span class="boldred"> * </span></td>
                <td class="boldEleven"><select name="conductedby" class="formText135" id="conductedby" onChange="loadTestTypeQuestion()" style="width:100px">
                  <option value="0">Select Training Conducted By </option>
                  <%
					 String repdata[][]=CommonFunctions.QueryExecute("SELECT CHR_EMPID,CHR_STAFFNAME FROM com_m_staff WHERE CHR_REP ='Y' ORDER BY CHR_STAFFNAME ");
					 for(int i=0;i<repdata.length;i++) 
                        out.println("<option value="+repdata[i][0]+">"+repdata[i][1]+"</option>");
					%>
                </select>
				<script language="javascript">setOptionValue('conductedby','<%=conductedby%>')</script>				</td>
              </tr>
              <tr>
                <td class="boldEleven">Test Required </td>
                <td class="boldEleven"><table width="100" border="0" cellspacing="5" cellpadding="5">
                  <tr>
                    <td class="boldEleven"><input name="test" type="radio" value="Y" <%=testchecked1%>></td>
                    <td class="boldEleven">Yes</td>
                    <td class="boldEleven"><input name="test" type="radio" value="N" <%=testchecked2%>></td>
                    <td class="boldEleven">NO</td>
                  </tr>
                </table></td>
              </tr>
              
              
              <tr>
                <td valign="top" class="boldEleven">Description<span class="boldred"> * </span></td>
                <td class="boldEleven"><textarea name="desc" cols="30" rows="5" class="formText135" id="desc" onKeyUp="textArea('desc','1900')"><%=desc%></textarea></td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input type="hidden" name="filename" value="Training" />
				<input type="hidden" name="actionS"  value="<%=actionS%>" />
				<input name="id" type="HIDDEN" id="id" value="<%=id%>">				</td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit"  id="Submit" type="submit" class="tMLAscreenHead" value="<%=value%>"></td>
                    <td><input name="Close" type="button"  class="tMLAscreenHead" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('Training.jsp')"></td>
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
}
%>
</body>
</html>
