  <%@ page import="java.io.*,java.util.*" isErrorPage="false" 	errorPage="./error.jsp"%>

<html>
 

<title>:: HRM ::</title>

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

 

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/HRM/OnLineTest.js"></script>
<script language="javascript"> 
function checkdbquestion(ctr1,ctr2)
{
	var a= parseInt(document.getElementById(ctr1).value);
	var b= parseInt(document.getElementById(ctr2).value);
	if(a>b)
	{
		alert("Do not exceeed the question no...");
		document.getElementById(ctr1).focus();
	}
	 
		
	
}
function validate()
{
	return true;
}

</script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<form  AUTOCOMPLETE = "off"   method="get" name='frm' onSubmit="return validate()" action="OnlineTestQuestion.jsp" >
<body  onpaste="return false;" >
<%@ include file="indexhrm.jsp"%>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
		<td>&nbsp;</td>
	</tr>

	<tr>
	  <td><TABLE width=440 border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#dce4f9" class=BackGround>
        <TBODY>
          <TR>
            <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/TLCorner.gif" width=7></TD>
            <TD class=BorderLine height=1><SPACER height="1" width="1" type="block" /></TD>
            <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/TRCorner.gif" width=7></TD>
          </TR>
          <TR>
            <TD height=6><SPACER height="1" width="1" type="block"/></TD>
          </TR>
          <TR>
            <TD class=BorderLine width=1><SPACER height="1" 
                        width="1" type="block" /></TD>
            <TD width=6><SPACER height="1" width="1" type="block" 
                      /></TD>
            <TD width=425 valign="top"><table width="400" border="0" align="center" cellpadding="3" cellspacing="3">
              <tr>
                <td width="100%" class="bold1"><div align="center">ONLINE TEST 
<%
String applicantid = request.getParameter("applicantid");
String testids = request.getParameter("testids");
String attenquestion = request.getParameter("attenquestion");
String timeduration = request.getParameter("timeduration");
String nooftesttype = request.getParameter("nooftesttype");
String percentage = request.getParameter("percentage");
String pass[] = percentage.split(",");
String question = "";
int count = Integer.parseInt(nooftesttype);
int q=0;
for(int u=0;u<count;u++)
{
	question=question+request.getParameter("quetion"+(u+1))+",";
	q = q+Integer.parseInt(request.getParameter("quetion"+(u+1)));
}
String questionid[] = question.split(",");
session.setMaxInactiveInterval(7200); 
%>

<input name="applicantid"  id="applicantid" type="hidden" value="<%=applicantid%>">
<input name="testids"  id="testids" type="hidden" value="<%=testids%>">
<input name="attenquestion"  id="attenquestion" type="hidden" value="<%=attenquestion%>">
<input name="timeduration"  id="timeduration" type="hidden" value="<%=timeduration%>">
<input name="nooftesttype"  id="nooftesttype" type="hidden" value="<%=nooftesttype%>">

<input name="percentage"  id="percentage" type="hidden" value="<%=percentage%>">
<input name="question"  id="question" type="hidden" value="<%=question%>">

 

				</div></td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp; </td>
              </tr>
              <tr>
                <td class="boldEleven"> 
				
			 
				</td>
              </tr>
              <tr>
                <td class="boldEleven"> 
				<div align="left">
  <p><strong>Instruction:</strong></p>
  <p>Total number of questions : <strong><%=q%></strong>.</p>
  <p>Time alloted : <strong><%=timeduration%></strong> minutes.</p>
  <p>Each question carry 1 mark, no negative   marks.</p>
  <strong>Note :</strong><br>
  <ul>
  <li>Click the 'Submit Test' button given in the   bottom of this page to Submit your answers. </li>
  <li>Test will be submitted automatically if the time   expired. </li>
  <li>Don't refresh the page</li>
</ul>
</div>


				</td>
              </tr>
              <tr>
                <td class="boldEleven"><table width="112" border="0" align="center" cellpadding="3"
									cellspacing="2">
                    <tr>
                      <td>
					    
					  <input name="Submit"  id="Submit" type="submit" 	class="tMLAscreenHead" value="Start Test"></td>
                      <td><input name="Close" type="button"   class="tMLAscreenHead" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('HRMmain.jsp')"></td>
                    </tr>
                </table></td>
              </tr>
            </table></TD>
            <TD noWrap width=7><SPACER height="1" width="1" 
                        type="block" /></TD>
            <TD class=BorderLine width=1><SPACER height="1" width="1" type="block" /></TD>
          </TR>
          <TR>
            <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/BLCorner.gif" width=7></TD>
            <TD height=6><SPACER height="1" width="1" type="block"/></TD>
            <TD colSpan=2 rowSpan=2 valign="bottom"><div align="right"><IMG height=7 src="../Image/General/BRCorner.gif" width=7></div></TD>
          </TR>
          <TR>
            <TD class=BorderLine height=1><SPACER height="1" width="1" type="block" /></TD>
          </TR>
        </TBODY>
      </TABLE></td>
  </tr>
	<tr>
	  <td>&nbsp; </td>
  </tr>
	<tr>
		<td>&nbsp;		</td>
	</tr>
</table>



<%@ include file="../footer.jsp"%>

</body>
</html>



