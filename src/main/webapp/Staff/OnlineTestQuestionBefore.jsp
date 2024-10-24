<%@ page import="java.io.*,java.util.*" isErrorPage="false" 	errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<%
try
{
%>
<html>
 
<%@include file="Redirect.jsp" %>

<title>:: STAFF ::</title>

 
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
<script language="javascript"> 

function validate()
{
	return true;
}

</script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body  onpaste="return false;" >
 
 <br> <br> <br>
	  
	  <form  AUTOCOMPLETE = "off"   method="get" name='frm' onSubmit="return validate()" action="OnlineTestQuestion.jsp" >

	  
	  
	  <TABLE width=440 border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#dce4f9" class=BackGround>
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
String test = request.getParameter("test");
String sql ="";
sql ="  SELECT a.INT_TESTTYPEID,a.CHR_TESTNAME, COUNT(*),  a.INT_NO_OF_QUESTION,a.INT_DURATION,a.INT_PECENTAGE FROM  internal_training_m_testtype a,internal_training_m_testquestion b WHERE a.INT_TESTTYPEID =b.INT_TESTTYPEID AND a.INT_TESTTYPEID ="+test+" GROUP BY  a.INT_TESTTYPEID  ORDER BY a.CHR_TESTNAME ";
//out.println(sql);
String Data[][] = CommonFunctions.QueryExecute(sql);
String testids = test ; 
String attenquestion =Data[0][3]    ;
String timeduration = Data[0][4] ;  
String percentage = Data[0][5] ;
String pass[] = percentage.split(",");

session.setMaxInactiveInterval(7200); 
%>
                <input type="hidden" name="test"  id="test" value="<%=test%>">
                </div></td>
              </tr>
              <tr>
                <td class="bolddeepred"><div align="center">Hi <%=CommonFunctions.QueryExecute("SELECT CHR_STAFFNAME FROM com_m_staff WHERE CHR_EMPID='"+session.getAttribute("EMPID")+"'")[0][0]%> /<%=session.getAttribute("EMPID")%> - Please  read the instructions</div></td>
              </tr>
              <tr>
                <td class="boldEleven"> 
				
			 
				</td>
              </tr>
              <tr>
                <td class="boldEleven"> 
				<div align="left">
  <p><strong>Instruction:</strong></p>
  <p>Test Subject is  :<strong><%=Data[0][1]%></strong>.</p>
  <p>Total number of questions :<%=attenquestion%>.</p>
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
                      <td><input name="Close" type="button"   class="tMLAscreenHead" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('OnlineTest.jsp')"></td>
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
      </TABLE>
	  
	  </form>
	  
	 
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>


