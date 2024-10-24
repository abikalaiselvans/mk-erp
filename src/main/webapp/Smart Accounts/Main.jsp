<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>
<%
try
{
	CommonFunctions.autoUpdate(request,""+application.getInitParameter("Auto"));
%>
<html>
<head>

<title>:: ACCOUNTS ::</title>

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
</head>

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Account/branches.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="javascript">
  function Validate()
  {
  	if(	checkNullSelect("acccompany","Select Company","0"))
		return true;	
	else
		return false;			
  } 
 
 
 

</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><%@ include file="index.jsp"%></td>
  </tr>
  <tr>
    <td height="500">
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
            <td width="412" valign="top"><form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="get" name="frm" id="frm"
						onSubmit="return Validate()">
                <table width="391"  border="0" align="center" cellpadding="5"
						cellspacing="5">
                  <tr>
                    <td colspan="2" valign="top" class="paramenu"></td>
                  </tr>
                  <tr>
                    <td height="79" colspan="2"   valign="top" class="paramenu"><table width="282" border="0" align="center" cellpadding="3" cellspacing="4">
                      <tr>
                    <td   valign="top" class="paramenu">From Date </td>
                    <td   valign="top" class="paramenu">
					
					<input name="frmdate" type="text" class="formText135"
										id="frmdate" onKeyPress="dateOnly('frmdate')" size="15">
									<a href="javascript:cal1.popup();"> <img
										src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" alt="Click Here to Pick up the date">					</td>
                  </tr>
                  <tr>
                    <td   valign="top" class="paramenu">To Date </td>
                    <td   valign="top" class="paramenu">
					
					<input name="todate" type="text" class="formText135"
										id="todate" onKeyPress="dateOnly('todate')" size="15">
									<a href="javascript:call2.popup();"> <img
										src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" alt="Click Here to Pick up the date"></a> <script
										language="JavaScript">			
<!--
			var cal1 = new calendar1(document.forms['frm'].elements['frmdate']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			var call2 = new calendar1(document.forms['frm'].elements['todate']);
			call2.year_scroll = true;
			call2.time_comp = false;		
			setCurrentDate('frmdate');
			setCurrentDate('todate');			
			
//-->	
                          </script>					</td>
                  </tr>
                    </table></td>
                  </tr>
                  
                  <tr>
                    <td  valign="top" class="paramenu"><div align="right">
                      <input type="hidden" name="filename"
								value="AccountControl" />
                        <input type="hidden" name="actionS"
								value="ACCControlAssign" />
                    <span class="bold1">Company</span></div></td>
                    <td   valign="top" class="paramenu"><%
				 	String usertype=""+session.getAttribute("USRTYPE");
					String officename= ""+session.getAttribute("OFFICENAME");
					String officeid= ""+session.getAttribute("OFFICEID");
					String user= ""+session.getAttribute("USRID"); 
					String branch= ""+session.getAttribute("BRANCHID");
					
					
					user=user.trim();
					
				 %>
                        <select name="acccompany" class="boldEleven" id="acccompany"
								onChange="LoadAccBranches()">
                          <option value="0">Select</option>
                          <%                  
     				if("F".equals(usertype)) 
					{
						String queryoffice="SELECT INT_COMPANYID,CHR_COMPANYNAME FROM com_m_company ";
     					String	officedata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(queryoffice);
     					for(int i=0;i<officedata.length;i++)
 	 						out.println("<option value='"+officedata[i][0]+"'>"+officedata[i][1]+"</option>");
					}
					
					if(("A".equals(usertype))) 
					{
						 
						String queryoffice="SELECT INT_COMPANYID,CHR_COMPANYNAME FROM com_m_company WHERE INT_COMPANYID=(SELECT INT_COMPANYID FROM com_m_branch WHERE INT_BRANCHID="+branch+") ";
     					String	officedata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(queryoffice);
     					for(int i=0;i<officedata.length;i++)
 	 						out.println("<option value='"+officedata[i][0]+"'>"+officedata[i][1]+"</option>");
						 
					}
					
					
					
 			    	%>
                      </select></td>
                  </tr>
                  <tr>
                    <td colspan="2" valign="top" class="paramenu">
					<div id='branchTable'  class="boldEleven"></div>
					</td>
                  </tr>
                  <tr>
                    <td colspan="2" class="paramenu"><table   border="0" align="center" cellpadding="0"
								cellspacing="5">
                        <tr>
                          <td width="56"><input name="Submit"  id="Submit" type="submit"
										class="buttonbold13" value="Submit"   accesskey="s"   ></td>
                          <td width="56">
<input name="Close" type="Button" class="buttonbold13" id="Close"  value="Close"   accesskey="c"  onClick="redirect('../Mainscreen.jsp')"></td>
                        </tr>
                    </table></td>
                  </tr>
                </table>
            </form></td>
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
      </table>
	</td>
  </tr>
  <tr>
    <td><%@ include file="../footer.jsp"%></td>
  </tr>
</table>


 
</body>
</html>
 <%
}
catch(Exception e)
{

}
%>
