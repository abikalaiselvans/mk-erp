<%@ page import="java.io.*,java.util.*" %>
<%@ page import="com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
 
<html>
<head>

<title>:: HRM ::</title>

<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript">
function valid()
  {
	if(checkNull("salary","Enter the salary")
  	&& checkNull("Attendance","Enter the Attendance in percentage")
	&& checkNull("description","Enter the description")
	&& checkNullSelect("authority","Select Authority person",'0')
	)
	 	return true;
	else
		return false;	
	
  } 
  //salary,Attendance,description ,rowid	
</script>
 <link href="../Styles/styles.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style3 {color: #FF0000}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
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
<body  onpaste="return false;" >
<form  AUTOCOMPLETE = "off" method="get" name='frm' action="../SmartLoginAuth" onSubmit="return valid()" >
<%@ include file="indexhrm.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>	</td>
  </tr>
  <tr>
    <td height="19">&nbsp;</td>
  </tr>
  <tr>
    <td height="19">&nbsp;</td>
  </tr>
  <tr>
    <td height="19">&nbsp;</td>
  </tr>
  
  <tr>
    <td>
	<TABLE width=80% border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#dce4f9" class=BackGround>
          <TBODY>
            <TR>
              <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/TLCorner.gif" width=7></TD>
              <TD class=BorderLine height=1><SPACER height="1" 
                        width="1" type="block" /></TD>
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
              <TD valign="top">
	<table width="100%" border="0" class="BackGround"   align="center" cellpadding="2" cellspacing="2"  >
	        <!--DWLayoutTable-->
        <tr align="center" valign="middle"> 
<!--          <td height="28" colspan="2" class="BackGround"  >Demand</td> -->
         <td height="28" colspan="2" >EMPLOYEE VERIFICATION <span class="boldEleven">
           <input type="hidden" name="filename" value="EmployeeVerification">
           <input name="actionS" type="hidden" id="actionS" value="HRMEmployeeVerificationResponse">
         </span></td>
            </tr>
         <tr class="bolddeepblue">
           <td height="29" colspan="2" valign="middle" class="boldEleven"><%
		   	String sql="";
		 	String rowid = ""+request.getParameter("rowid");
			String empid = ""+request.getParameter("empid");
			String email = ""+request.getParameter("email");
			

		 	 
		 	sql = " SELECT b.CHR_STAFFNAME,b.CHR_EMPID ,b.CHR_STAFFFNAME, ";
			sql = sql + " c.CHR_DESIGNAME,d.CHR_DEPARTNAME,DATE_FORMAT(b.DT_DOJCOLLEGE,'%d%-%b-%Y'),DATE_FORMAT(e.DT_TERM_DATE,'%d%-%b-%Y'),e.CHR_REASON,b.CHR_REPTO ";
			sql = sql + " FROM com_m_employeeverification a,com_m_staff b ,com_m_desig c ,com_m_depart d,pay_m_emp_termination e ";
			sql = sql + " WHERE a.CHR_VERIFICATIONID = b.CHR_EMPID  ";
			sql = sql + " AND b.INT_DESIGID = c.INT_DESIGID ";
			sql = sql + " AND b.INT_DEPARTID = d.INT_DEPARTID ";
			sql = sql + " AND b.CHR_EMPID  = e.CHR_EMPID  ";
			sql = sql + " AND a.INT_VERIFICATIONID="+rowid;
			String readData[][] =CommonFunctions.QueryExecute(sql);
	     	
			%></td>
         </tr>
         <tr class="bolddeepblue">
           <td height="29" colspan="2" valign="middle" class="boldEleven">
		  <table width='87%' align="center"     cellpadding=2 cellspacing=2  class='boldEleven'  id='myTable' >
             <TBODY>
               <TR class="MRow1">
                 <TD vAlign="top"  ><p><strong>Fields of Information</strong></p></TD>
                 <TD vAlign="top"  ><p><strong>&nbsp;&nbsp;&nbsp; </strong><strong>As per HR   records</strong></p></TD>
               </TR>
               <TR class="MRow2">
                 <TD vAlign="top"  ><p>Candidate   Name</p></TD>
                 <TD vAlign="top"  ><p><%=readData[0][0]%>
                   <input name="rowid" type="hidden" id="rowid" value="<%=rowid%>">
                 </p></TD>
               </TR>
               <TR class="MRow1">
                 <TD vAlign="top"  ><p>Employee   Code</p></TD>
                 <TD vAlign="top"  ><p><%=readData[0][1]%></p></TD>
               </TR>
               <TR class="MRow2">
                 <TD vAlign="top"  ><p>Designation</p></TD>
                 <TD vAlign="top"  ><p><%=readData[0][3]%></p></TD>
               </TR>
               <TR class="MRow1">
                 <TD vAlign="top">Department</TD>
                 <TD vAlign="top"><%=readData[0][4]%></TD>
               </TR>
               <TR class="MRow2">
                 <TD vAlign="top"  ><p>Date of   Joining</p></TD>
                 <TD vAlign="top"  ><p><%=readData[0][5]%></p></TD>
               </TR>
               <TR class="MRow1">
                 <TD vAlign="top"  ><p>Date of Leaving </p></TD>
                 <TD vAlign="top"  ><p><%=readData[0][6]%></p></TD>
               </TR>
               <TR class="MRow2">
                 <TD vAlign="top"  ><p>Supervisor&rsquo;s Name and   Designation</p></TD>
                 <TD vAlign="top"  ><p><%=CommonFunctions.QueryExecute("SELECT b.CHR_STAFFNAME,c.CHR_DESIGNAME   FROM com_m_staff b ,com_m_desig c  WHERE b.INT_DESIGID = c.INT_DESIGID AND b.CHR_EMPID  = '"+readData[0][8]+"'")[0][0]%>&nbsp;/&nbsp;<%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT b.CHR_STAFFNAME,c.CHR_DESIGNAME   FROM com_m_staff b ,com_m_desig c  WHERE b.INT_DESIGID = c.INT_DESIGID AND b.CHR_EMPID  = '"+readData[0][8]+"'")[0][1]%></p></TD>
               </TR>
               <TR class="MRow1">
                 <TD vAlign="top"  ><p>Remuneration </p></TD>
                 <TD vAlign="top"  ><p>
				 <%
				 
				 String salarydata[][] = CommonFunctions.QueryExecute("SELECT DOU_MONTHSAL FROM  pay_t_salary   WHERE  CHR_EMPID='"+empid+"'   ORDER BY DT_UPDATEDATE DESC LIMIT 1,1 ");
				 String netsal="";
				 if(salarydata.length>0)
				 	netsal=salarydata[0][0];
				 %>
                   <input name="salary" type="text" class="formText135" id="salary" maxlength="10"  onkeypress="return numeric_only(event,'salary','10')" value="<%=netsal%>"  >
                   <span class="errormessage">( see payslip INR 8500/-)</span></p></TD>
               </TR>
               <TR class="MRow1">
                 <TD vAlign="top"  ><p>Reason for Leaving </p></TD>
                 <TD vAlign="top"  ><p><%=readData[0][7]%></p></TD>
               </TR>
               <TR class="MRow2">
                 <TD vAlign="top"  ><p>Attendance</p></TD>
                 <TD vAlign="top"  ><p>
                   <input name="Attendance" type="text" class="formText135" id="Attendance" onKeyPress="numericValue('Attendance','2')"  maxlength="10" value="95%">
                   <span class="errormessage">                 ( 90% )</span></p></TD>
               </TR>
               <TR class="MRow1">
                 <TD vAlign="top"  ><p>Eligibility to Rehire </p></TD>
                 <TD vAlign="top"  ><table width="95" border="0" cellspacing="0" cellpadding="0">
                   <tr>
                     <td class="boldEleven"><input name="Status" type="radio" value="Y" checked></td>
                     <td class="boldEleven">Yes</td>
                     <td class="boldEleven"><input name="Status" type="radio" value="N"></td>
                     <td class="boldEleven">NO</td>
                   </tr>
                 </table>                   </TD>
               </TR>
               <TR class="MRow2">
                 <TD vAlign="top"  ><p>Additional Comments </p></TD>
                 <TD vAlign="top"  ><p>
                   <textarea name="description" cols="60" rows="10" id="description">its fine for testing purpose</textarea>
                 </p></TD>
               </TR>
               <TR class="MRow1">
                 <TD vAlign="top"  ><p>Verifier&rsquo;s Name and   Designation</p></TD>
                 <TD vAlign="top"  ><p> 
				 <select   name="authority"  id="authority"  size="1" class="formText135" tabindex="11">
                                      <option value="0" selected="selected">Select Report</option>
									<%
		 
		String auData[][]=CommonFunctions.QueryExecute(" SELECT CHR_EMPID,CHR_STAFFNAME  FROM com_m_staff WHERE CHR_REP='Y' AND CHR_TYPE !='Y' AND CHR_HOLD!='Y'  ORDER BY CHR_STAFFNAME ");
	for(int i=0;i<auData.length;i++) 
			out.println("<option value='"+auData[i][0]+"'>"+auData[i][1]+" / " +auData[i][0]+"</option>");		
			 
	%></select>
				 
				 </p>                     </TD>
               </TR>
             </TBODY>
           </TABLE></td>
         </tr>
         <tr class="bolddeepblue"> 
          <td height="29" colspan="2" valign="middle" class="boldEleven"> <font color='red'>&nbsp;</font> </td>
                </tr>        
       
          
         <tr class="bolddeepblue"> 
          <td colspan="2" valign="middle" class="bolddeepblue">&nbsp;         
		  <table align="center" cellpadding="3" cellspacing="3">
            <tr>
              <td width="56" align="center" valign="top"><input name="Submit" id="submit" type="submit"  class="tMLAscreenHead" value="Submit"   accesskey="s"     ></td>
              <td width="56" valign="top"><input class="tMLAscreenHead" type="button" name="Submit"  value="Close"   accesskey="c"  onClick="redirect('HRMmain.jsp')"></td>
            </tr>
          </table></td>
          </tr>
        </table>		</TD>
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
        </TABLE>	  </td>
  </tr>
  
  <tr>
    <td>&nbsp; </td>
  </tr>
  <tr>
     <td>&nbsp;</td>
  </tr>
<tr><td height="40">&nbsp;</td>
</tr>
<tr><td><%@ include file="../footer.jsp"%></td></tr>
</table>
<p>&nbsp;</p>
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