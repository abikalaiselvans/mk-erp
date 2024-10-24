 <%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%
try
{
%>
<html>
<head>

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


<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>

<script language="JavaScript">

function Validate()
{	
	 
	if(
			checkNullSelect('type','Select Test Type','0')
			&& checkNull('question','Enter Question..')
			&& checkNull('answer1','Enter Answer1..')
			&& checkNull('answer2','Enter Answer2..')
			&& checkNull('answer3','Enter Answer3..')
			&& checkNull('answer4','Enter Answer4..')
			&& checkCorrectAnswer()
		)
		  return true;
		else
			return false;
		
}

function checkCorrectAnswer()
{
	var f = false;
	var f1 = false;
	var f2 = false;
	var f3 = false;
	var f4 = false;
	f1 =document.getElementById('Correct1').checked;
	f2 =document.getElementById('Correct2').checked;
	f3 =document.getElementById('Correct3').checked;
	f4 =document.getElementById('Correct4').checked;
	 
	 if(f1 || f2 || f3 || f4)
	 	f = true;
	else
	{
	
		alert("Please Provide Correct Answer...");
		f= false;
	}
	return f;
}	 
</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="document.getElementById('type').focus()" >
<%@ include file="indexhrm.jsp"%>
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
                <td colspan="3" class="bold1"><div align="center"> TEST TYPE
				
				    <%
							String action=request.getParameter("action1");
							String id="",Name="",actionS="",value="";
							String sql="";
							String type=""; 
							String question=""; 
							String answer1=""; 
							String answer2=""; 
							String answer3=""; 
							String answer4=""; 
							String actualanswer="";
							String s1="";
							if("Add".equals(action))
							{
								id="";Name=""; 
								actionS="HRMTestTypeQuestionADD";
								value="Add"; 
								  type="0"; 
								  question=""; 
								  answer1=""; 
								  answer2=""; 
								  answer3=""; 
								  answer4=""; 
								  actualanswer="";
							}
							else
							{
								id="";Name=""; 
								id=request.getParameter("id");
								sql = " SELECT INT_EQUESTIONID,INT_TESTTYPEID,CHR_QUESTION,CHR_ANSWER1,CHR_ANSWER2,CHR_ANSWER3,CHR_ANSWER4,CHR_ACTUAL_ANSWER  FROM hrm_m_testquestion  WHERE INT_EQUESTIONID= "+id;
								String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								id=data[0][0]; 
								actionS="HRMTestTypeQuestionEdit";
								  type=data[0][1];
								  question=data[0][2];
								  answer1=data[0][3]; 
								  answer2=data[0][4];
								  answer3=data[0][5]; 
								  answer4=data[0][6];
								  actualanswer=data[0][7];
								  value="Update";
							}
							
						%>			
				
				</div></td>
                </tr>
              <tr>
                <td width="31%" class="boldEleven">Test Type <span class="boldred">* </span></td>
                <td width="69%" colspan="2" class="boldEleven"><select name="type" class="formText135" id="type">
                  <option value="0">Select</option>
                  <%
					  sql = " SELECT INT_TESTTYPEID,CHR_TESTNAME,CHR_DESC FROM hrm_m_testtype ORDER BY CHR_TESTNAME   " ;
				      String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					  for(int i=0;i<data.length;i++) 
                        out.println("<option value="+data[i][0]+">"+data[i][1]+"</option>");
					  %>
                </select>
				<script language="javascript">setOptionValue('type','<%=type%>')</script>
              <tr>
                <td valign="top" class="boldEleven">Description<span class="boldred">* </span></td>
                <td colspan="2" class="boldEleven"><textarea name="question" cols="100" rows="10" class="formText135" id="question" onKeyUp="textArea('question','3000')"><%=question%></textarea></td>
              </tr>
              <tr>
                <td class="boldEleven">Answer1<span class="boldred">* </span></td>
                <td colspan="2" class="boldEleven"><table width="100%" border="0" cellspacing="4" cellpadding="3">
                  <tr>
                    <td><input name="answer1" type="text" class="formText135" id="answer1" value="<%=answer1%>" size="80" maxlength="1000"></td>
                    <td class="boldEleven">
					<%
					s1="";
					if("1,".equals(actualanswer))
						s1=" checked='checked' ";
					%>
					<input name="Correct" type="radio" id="Correct1" value="1"   <%=s1%> ></td>
                    <td class="boldEleven"> 
                      Correct</td>
                  </tr>
                </table></td>
                </tr>
              <tr>
                <td class="boldEleven">Answer2<span class="boldred">* </span></td>
                <td colspan="2" class="boldEleven"><table width="100%" border="0" cellspacing="4" cellpadding="3">
                  <tr>
                    <td><input name="answer2" type="text" class="formText135" id="answer2" value="<%=answer2%>" size="80" maxlength="1000"></td>
                    <td class="boldEleven">
					<%
					s1="";
					if("2,".equals(actualanswer))
						s1=" checked='checked' ";
					%>
					<input name="Correct" type="radio" id="Correct2" value="2" <%=s1%>></td>
                    <td class="boldEleven">Correct</td>
                  </tr>
                </table></td>
                </tr>
              <tr>
                <td class="boldEleven">Answer3<span class="boldred">* </span></td>
                <td colspan="2" class="boldEleven"><table width="100%" border="0" cellspacing="4" cellpadding="3">
                  <tr>
                    <td><input name="answer3" type="text" class="formText135" id="answer3" value="<%=answer3%>" size="80" maxlength="1000"></td>
                    <td class="boldEleven">
					<%
					s1="";
					if("3,".equals(actualanswer))
						s1=" checked='checked' ";
					%>
					<input name="Correct" type="radio" id="Correct3" value="3" <%=s1%>></td>
                    <td class="boldEleven">Correct</td>
                  </tr>
                </table></td>
                </tr>
              <tr>
                <td class="boldEleven">Answer4<span class="boldred">* </span></td>
                <td colspan="2" class="boldEleven"><table width="100%" border="0" cellspacing="4" cellpadding="3">
                  <tr>
                    <td><input name="answer4" type="text" class="formText135" id="answer4" value="<%=answer4%>" size="80" maxlength="1000"></td>
                    <td class="boldEleven">
					<%
					s1="";
					if("4,".equals(actualanswer))
						s1=" checked='checked' ";
					%>
					<input name="Correct" type="radio" id="Correct4" value="4" <%=s1%>></td>
                    <td class="boldEleven">Correct</td>
                  </tr>
                </table></td>
                </tr>
               
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td colspan="2" class="boldEleven">
				<input type="hidden" name="filename" value="TestTypeQuestion" />
				<input type="hidden" name="actionS"  value="<%=actionS%>" />
								<input name="id" type="HIDDEN" id="id" value="<%=id%>"></td>
              </tr>
              <tr>
                <td colspan="3" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit"  id="Submit" type="submit" 	class="tMLAscreenHead" value="Submit"   accesskey="s"   ></td>
                    <td><input name="Close" type="button"   class="tMLAscreenHead" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('TestTypeQuestion.jsp')"></td>
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
