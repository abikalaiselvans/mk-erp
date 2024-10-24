 <%@ page import="java.io.*,java.util.*" isErrorPage="false" 	errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<html>
 

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
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body  onpaste="return false;" >
<%@ include file="index.jsp"%>
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
	  <td>
	  
	  <form  AUTOCOMPLETE = "off"   method="get" name='frm' onSubmit="return validate()" action="OnlineTestQuestionBefore.jsp" >

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
                <td width="100%" class="bold1"><div align="center">ONLINE TEST </div></td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp; </td>
              </tr>
              <tr>
                <td class="boldEleven"> 
				
			
				
				</td>
              </tr>
              <tr>
                <td class="boldEleven"><div align="center">
		<%
 
String sql="";
sql ="  SELECT a.INT_TESTTYPEID,a.CHR_TESTNAME, COUNT(*),  a.INT_NO_OF_QUESTION,a.INT_DURATION,a.INT_PECENTAGE, ";
sql = sql+ "  (SELECT c.CHR_RESULT FROM internal_training_t_testemployeelist c WHERE c.INT_TESTTYPEID = a.INT_TESTTYPEID AND c.CHR_EMPID ='"+session.getAttribute("EMPID")+"'  )  ";
sql = sql+ "  FROM  internal_training_m_testtype a,internal_training_m_testquestion b WHERE a.INT_TESTTYPEID =b.INT_TESTTYPEID GROUP BY  a.INT_TESTTYPEID  ORDER BY a.CHR_TESTNAME ";
String Data[][] = CommonFunctions.QueryExecute(sql);
int nooftest=0;
if (Data.length > 0)
{
	nooftest = Data.length;
	out.println("<center>");
	out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	out.println("<tr class='MRow1'>");
	out.println("<td class='boldEleven' align='center'><b>S.No</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Test Name</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Available Questions</b></td>");
	out.println("<td class='boldEleven' align='center'><b>No of Question</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Duration (mts)</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Percentage (%)</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Test</b></td>");
	out.println("</tr>");
	for(int i=0;i<Data.length;i++)
	{ 
		if(i%2==0)
			out.println("<tr class='MRow1'>");
		else
			out.println("<tr class='MRow2'>");	
			
		out.println("<td class='boldEleven'  >"+(i+1)+"</td>");
		out.println("<td class='boldEleven'  >"+Data[i][1]+"</td>");
		out.println("<td class='boldEleven'  >"+Data[i][2]+"</td>");
		out.println("<td class='boldEleven'  >"+Data[i][3]+"</td>");
		out.println("<td class='boldEleven'  >"+Data[i][4]+"</td>");
		out.println("<td class='boldEleven'  >"+Data[i][5]+"</td>");
		if(!"P".equals(Data[i][6]))
		{
			out.println("<td class='boldEleven' ><input name='test' id='test"+(i+1)+"' type='radio' value='"+Data[i][0]+"'>");
			out.println("<input name='dbquetion' id='dbquetion"+(i+1)+"' type='hidden' value='"+Data[i][2]+"'>");
			out.println("<input name='quetion' id='quetion"+(i+1)+"' type='hidden' value='"+Data[i][3]+"'>");
			out.println("");
			out.println("</td>");
		}
		else
		{
			out.println("<td class='bolddeepred'>Already Passed...</td>");
		}			
		
		out.println("</tr>");	 
			
	}
	out.println("</table>");
	out.println("<center>");
}

 
	 
%>
	
	 <input type="hidden" name="nooftest" id="nooftest" value="<%=nooftest%>">
	 
	 
        <script language="javascript">
					function validate() 
					{
						try
						{
							var v= parseInt(document.getElementById('nooftest').value);
							var flag = "";
							var f = false;
							for( i=1 ;i<=v;i++)
							{
								if(document.getElementById(("test"+i)).checked)
								{
									flag =i;
									f =true;
								}	
							}
							
							if(f)
							{
								var a= parseInt(document.getElementById(("quetion"+flag)).value);
								var b= parseInt(document.getElementById(("dbquetion"+flag)).value);
								if(a>b)
								{
									alert("Do not exceeed the question no...");
									return false;
								}
								else
									return true;
									
								 
							}
							{
								alert("please select atleast one test...");
								return false;
							}	
						}
						catch(err)
						{
							alert(err);
							return false
						}
					}
			</script>            
               
                </div></td>
              </tr>
              <tr>
                <td class="boldEleven"><table width="112" border="0" align="center" cellpadding="3"
									cellspacing="2">
                    <tr>
                      <td>
					    
					  <input name="Submit"  id="Submit" type="submit" 	class="tMLAscreenHead" value="Submit"   accesskey="s"   ></td>
                      <td><input name="Close" type="button"   class="tMLAscreenHead" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('TrainingMain.jsp')"></td>
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
	  </td>
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



