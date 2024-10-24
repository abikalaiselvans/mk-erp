<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*" %>
<%@ page import="com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
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
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/Trainning/OnlineTestView.js" ></script>


<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad=" document.getElementById('month').focus()">
<form  AUTOCOMPLETE = "off"  method="get" name="frm" action="" > 
<%@ include file="index.jsp"%>	
<table width="100%" height="398" align="center"  >
  <!--DWLayoutTable-->
  <tr>
    <td height="269" colspan="6" align="center">    
        <br><table width="90%" height="157" align="center" cellpadding="0" cellspacing="0" class="TableDesign">
          <!--DWLayoutTable-->
          <tr align="center" valign="middle"  >
            <td height="28" class="whiteMedium"><div align="center">ONLINE TEST </div></td>
          </tr>
            <tr>
       		 <td height="31" ><table width="100%" border="0" align="center" cellpadding="1" cellspacing="1" class="boldEleven">
         		 <tr>
         		   <td class="whiteMedium">TEST TYPE </td>
            		<td class="whiteMedium"><select name="type" class="formText135" id="type" onChange="loadOnlineTestDetails('0')" style="width:100px">
                      <option value="0">All</option>
                      <%
					 String data[][]=CommonFunctions.QueryExecute("SELECT INT_TESTTYPEID,CHR_TESTNAME FROM internal_training_m_testtype ORDER BY CHR_TESTNAME ");
					 for(int i=0;i<data.length;i++) 
                        out.println("<option value="+data[i][0]+">"+data[i][1]+"</option>");
					%>
                    </select></td>
            		
            		<td class="whiteMedium">MONTH</td>
            		<td class="whiteMedium"><span class="boldThirteen">
              			<select name="month" id="month" onChange="loadOnlineTestDetails('0')"  >
               				<option value="0">All</option>
							<%@ include file="../JavaScript/months.jsp" %>
              			</select>
       			   </span>            		</td>
            		<td class="whiteMedium">YEAR  </td>
            		<td class="whiteMedium"><span class="boldThirteen">
              			<select name="year" id="year" onChange="loadOnlineTestDetails('0')" >
                			
                			<%@ include file="../JavaScript/years.jsp" %>
              			</select>
           			   <script language='JavaScript' type="text/javascript">
							<!--			
								var d=new Date()
								var month1=d.getMonth() + 1
								var day=d.getDate()
						if(day<10) day="0"+day;
								if(month1<10) month1="0"+month1;
								var year1=d.getFullYear();
								setOptionValue('month',month1);
								setOptionValue('year',year1);	
								 					
							//-->
         			  </script>
				   </span>				  </td>
					  
					  <td class="whiteMedium"><span class="boldThirteen">RESULT  </span></td>
					  <td class="whiteMedium"><span class="boldThirteen">
					    <select name="result" id="result"  onChange="loadOnlineTestDetails('0')">
                          <option value="0">All</option>
                          <option value="F">Fail</option>
                          <option value="P">Pass</option>
                        </select>
				   </span></td>
          </tr>
        </table>        </td>
      </tr>                
          
          <tr bgcolor="#FFFFFF">
          <td height="21" valign="top">          
		   <div id="applicationTable" style="OVERFLOW:auto;width:100%;height:250px" ></div> <br>
		   <div id="totrec"></div><br>
      </table>        
    <tr>
      <td colspan="6"><!--DWLayoutEmptyCell-->&nbsp;</td>
    </tr>
    <tr>
      <td colspan="6">
	  <table  width="90%" border="0" align="center" cellpadding="1" cellspacing="1"   class="TableDesign">
        <tr class="para">
          <td height="22" ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('0')">ALL</a></div></td>	
		  <td ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('A')">A</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('B')">B</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('C')">C</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('D')">D</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('E')">E</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('F')">F</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('G')">G</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('H')">H</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('I')">I</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('J')">J</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('K')">K</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('L')">L</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('M')">M</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('N')">N</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('O')">O</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('P')">P</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('Q')">Q</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('R')">R</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('S')">S</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('T')">T</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('U')">U</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('V')">V</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('W')">W</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('X')">X</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('Y')">Y</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadOnlineTestDetails('Z')">Z</a></div></td>
        </tr>
      </table>      </td>
    </tr>
    <tr>
      <td height="17" colspan="6">    
    <tr>
      <td height="17" colspan="6"><table  border="0" align="center" cellpadding="2" cellspacing="2">
        <tr>
          <td  width="56"><input class="ButtonHead" type="button" name="Button"  value="Close"   accesskey="c"  onClick="redirect('TrainingMain.jsp')"></td>
        
        </tr>
      </table>    
    <tr>
        <td colspan="6"><center>
       
          <%@ include file="../footer.jsp"%>
        </center>
</table>
</form>
</body>
</html>