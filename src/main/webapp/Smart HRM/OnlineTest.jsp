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

</script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<form  AUTOCOMPLETE = "off"   method="get" name='frm' onSubmit="return validate()" action="OnlineTestQuestionBefore.jsp" >
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
                <td width="100%" class="bold1"><div align="center">ONLINE TEST </div></td>
              </tr>
              <tr>
                <td class="boldEleven"><table width="338" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td class="bold1">Applicant</td>
                    <td>
					<select name="appname"  id="appname" class="formText135" onBlur="makeGetRequest(this)" onChange="makeGetRequest(this)">
					<option value="0">Select</option>
					<%
					String AppData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT INT_APPID,CHR_APPCODE,CHR_APPNAME  FROM hrm_m_application WHERE CHR_ONLINETESTSTATUS='N'  AND INT_ONLINETEST='1' ");
					if(AppData.length>0)
						for(int i=0;i<AppData.length;i++)
							out.println("<option value='"+AppData[i][0]+"'>"+AppData[i][1]+"/"+AppData[i][2]+"</option>");
							
					%>
                    </select>                    </td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td class="boldEleven"><div id="loadonlineTest">
				
				</div>
				
			<script language="javascript">
					function validate() 
					{
						
							if(!checkNullSelect('appname','Kindly Select Applicant Name','0'))
								return false;
								
							var obj = findObj("nooftesttype");
							if(obj == null)
							{
								alert("object not available");
								return false;
							}	
													
							var v= parseInt(document.getElementById('nooftesttype').value);
				 			for( i=1 ;i<=v;i++)
							{
								var a= parseInt(document.getElementById(("quetion"+i)).value);
								var b= parseInt(document.getElementById(("dbquetion"+i)).value);
								if(a>b)
								{
									alert("Do not exceeed the question no...");
									document.getElementById(("quetion"+i)).focus();
									return false
								}
							}
							
							for( i=1 ;i<=v;i++)
								if(checkNull( ("quetion"+i),("Enter the Question"+i) ))
									d=1;
								else
									return false;
					}
			</script>
				
				</td>
              </tr>
              <tr>
                <td class="boldEleven"><div align="center">
                    <%
			 
			String sql="";
			
			/*sql = " SELECT b.CHR_TESTNAME, COUNT(*) FROM  hrm_m_testquestion  a,hrm_m_testtype b  WHERE a.INT_TESTTYPEID= b.INT_TESTTYPEID GROUP BY a.INT_TESTTYPEID  ORDER BY b.CHR_TESTNAME ";
			String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if (Data.length > 0)
			{
				out.println("<center>");
				out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
				out.println("<tr class='MRow1'>");
				out.println("<td class='boldEleven' align='center'><b>S.No</b></td>");
				out.println("<td class='boldEleven' align='center'><b>Test Name</b></td>");
				out.println("<td class='boldEleven' align='center'><b>No of Question</b></td>");
				out.println("<td class='boldEleven' align='center'><b>Available Questions</b></td>");
				out.println("</tr>");
				for(int i=0;i<Data.length;i++)
				{ 
					if(i%2==0)
						out.println("<tr class='MRow1'>");
					else
						out.println("<tr class='MRow2'>");	
						
					out.println("<td class='boldEleven'  >"+(i+1)+"</td>");
					out.println("<td class='boldEleven'  >"+Data[i][0]+"</td>");
					out.println("<td class='boldEleven'  ><input name='quetion"+(i+1)+"'  id='quetion"+(i+1)+"' type='text' class='formText135'  onKeyPress=\"numeric_only(event,'quetion"+(i+1)+"','3')\" onBlur=\"checkdbquestion('quetion"+(i+1)+"','dbquetion"+(i+1)+"')\" size=20 maxlength='3'  ><input name='dbquetion"+(i+1)+"'  id='dbquetion"+(i+1)+"' type='hidden' value='"+Data[i][1]+"' >   </td>"); 
					out.println("<td class='boldEleven'  >"+Data[i][1]+"</td>");
					out.println("</tr>");	 
						
				}
				out.println("</table>");
				out.println("<center>");
			}
			*/
			 
				 
	%>
                    
                </div></td>
              </tr>
              <tr>
                <td class="boldEleven"><table width="112" border="0" align="center" cellpadding="3"
									cellspacing="2">
                    <tr>
                      <td>
					    
					  <input name="Submit"  id="Submit" type="submit" 	class="tMLAscreenHead" value="Submit"   accesskey="s"   ></td>
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



