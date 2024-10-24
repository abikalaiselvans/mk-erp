 <%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%
try
{
%>
<html>
<head>

<title> :: COMMON ::</title>


 
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
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
 
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
 <body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>      <table class="BackGround1" cellspacing="0" cellpadding="0" width="500"
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
                  <td colspan="5" class="boldEleven"><div align="center" class="bold1">
                    <div align="center">STAFF REPORTS </div>
                  </div></td>
                </tr>
                <tr>
                  <td width="7%" class="boldEleven">1.</td>
                  <td width="2%" class="boldEleven">&nbsp;</td>
                  <td width="38%" class="boldEleven"><a href="Rept_StaffPersonalInfo.jsp" target="_blank">Personal Informations</a></td>
                  <td width="6%" class="boldEleven">2.</td>
                  <td width="47%" class="boldEleven"><a href="Rept_StaffSummaryDepart.jsp" target="_blank">Department Wise Employee summary </a></td>
                </tr>
                <tr>
                  <td class="boldEleven">3.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_StaffOfficialInfo.jsp" target="_blank">Official Informations </a></td>
                  <td class="boldEleven">4.</td>
                  <td class="boldEleven"><a href="Rept_StaffSummaryDesignation.jsp" target="_blank">Designation</a><a href="Rept_StaffSummaryDepart.jsp">Wise Employee summary</a></td>
                </tr>
                <tr>
                  <td class="boldEleven">5.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_StaffAddressInfo.jsp" target="_blank">Address Informations </a></td>
                  <td class="boldEleven">6.</td>
                  <td class="boldEleven"><a href="Rept_StaffSummaryAll.jsp" target="_blank">Employee Summary </a></td>
                </tr>
                <tr>
                  <td class="boldEleven">7.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_Photonotavailable.jsp" target="_blank">Photo Not Available </a></td>
                  <td class="boldEleven">8.</td>
                  <td class="boldEleven"><a href="ReportingTosummary.jsp" target="_blank">Reporting to summary</a></td>
                </tr>
                <tr>
                  <td class="boldEleven">9.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_Profilenotavailable.jsp" target="_blank">Profile Not Available </a></td>
                  <td class="boldEleven">10.</td>
                  <td class="boldEleven"><a href="Officewiseemployeesummary.jsp" target="_blank">Office wise to Employee summary</a></td>
                </tr>
                <tr>
                  <td class="boldEleven">11.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="StaffPFNumberInfo.jsp" target="_blank">PF Information  </a></td>
                  <td class="boldEleven">12.</td>
                  <td class="boldEleven"><a href="Rept_JonningList.jsp" target="_blank">Joining  List </a></td>
                </tr>
                <tr>
                  <td class="boldEleven">13.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="StaffPFNumberInfo.jsp" target="_blank"></a>   <a href="Rept_DOB.jsp" target="_blank">Date of Birth </a></td>
                  <td class="boldEleven">14.</td>
                  <td class="boldEleven"><a href="Rept_Reportingto.jsp" target="_blank">Reporting To </a></td>
                </tr>
                <tr>
                  <td class="boldEleven">15.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_Wddingdate.jsp" target="_blank">Wedding Date</a></td>
                  <td class="boldEleven">16.</td>
                  <td class="boldEleven">
                  <%
				  if("F".equals(session.getAttribute("USRTYPE")) || "A".equals(session.getAttribute("USRTYPE")))
				  		out.println("<a href='Rept_StaffAll.jsp' target='_blank'>All Informations </a>" );
				  else
				  		out.println("<a href='#' target='_blank'>All Informations </a>" );
				  %>                  </td>
                </tr>
                <tr>
                  <td class="boldEleven">17.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_Blood.jsp" target="_blank">Blood Group </a></td>
                  <td class="boldEleven">18.</td>
                  <td class="boldEleven">
                  
                  <%
				  if("F".equals(session.getAttribute("USRTYPE"))  || "A".equals(session.getAttribute("USRTYPE")))
				  		out.println("<a href='Rept_ServiceCard.jsp' target='_blank'>Service Card</a>" );
				  else
				  		out.println("<a href='#' target='_blank'>Service Card </a>" );
				  %>                   </td>
                </tr>
                <tr>
                  <td class="boldEleven">19.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_Qualificationwise.jsp" target="_blank">Qualification</a></td>
                  <td class="boldEleven">20.</td>
                  <td class="boldEleven"><a href="CompanyExplore.jsp" target="_blank">Explorer</a></td>
                </tr>
                <tr>
                  <td class="boldEleven">21.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_Employeelist.jsp" target="_blank">Employee List</a></td>
                  <td class="boldEleven">22.</td>
                  <td class="boldEleven"><a href="Rept_Wddingdate.jsp" target="_blank"></a> <a href="GrossPay.jsp" target="_blank">Gross</a> &nbsp;&nbsp;/&nbsp;&nbsp; <a href='Rept_StaffCTCInfo.jsp' target="_blank">CTC</a></td>
                </tr>
                <tr>
                  <td class="boldEleven">23. </td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_Mailids.jsp" target="_blank">Mail Ids </a></td>
                  <td class="boldEleven">24.</td>
                  <td class="boldEleven"><a href="Rept_Pannumber.jsp" target="_blank">PAN </a></td>
                </tr>
                 
                <tr>
                  <td class="boldEleven">25. </td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_Expereience.jsp" target="_blank">Experience </a> </td>
                  <td class="boldEleven">26.</td>
                  <td class="boldEleven"><a href="Rept_DrivingLicense.jsp" target="_blank">Driving License </a></td>
                </tr>
                <tr>
                  <td class="boldEleven">27.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_ResignnerList.jsp" target="_blank">Resigned List </a></td>
                  <td class="boldEleven">28.</td>
                  <td class="boldEleven"><a href="Rept_Passport.jsp" target="_blank">Passport</a></td>
                </tr>
                <tr>
                  <td class="boldEleven">29.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Poor recruitment.jsp" target="_blank">Abort Cases </a></td>
                  <td class="boldEleven">30.</td>
                  <td class="boldEleven"><a href="" target="_blank">Mail to DOB</a></td> <!--Rept_MailDOB.jsp -->
                </tr>
                <tr>
                  <td class="boldEleven">31.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_CertificationCompleted.jsp" target="_blank">Certification Completed</a></td>
                  <td class="boldEleven">32.</td>
                  <td class="boldEleven">Mail to Anniversary</td><!--Rept_MailAnniversary.jsp-->
                </tr>
                <tr>
                  <td class="boldEleven">33.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_StaffBankInformations.jsp" target="_blank">Bank Informations</a></td>
                  <td class="boldEleven">34</td>
                  <td class="boldEleven"><a href="Rept_JoinnerResignner.jsp" target="_blank">Abort Cases </a></td>
                </tr>
                <tr>
                  <td class="boldEleven">35.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_Rejoinnerlist.jsp" target="_blank">Rejoinner List </a></td>
                  <td class="boldEleven">36</td>
                  <td class="boldEleven"><a href="Rept_CertificationNotCompleted.jsp" target="_blank">Certification not Completed</a></td>
                </tr>
                <tr>
                  <td class="boldEleven">37. </td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_StaffBankInformations.jsp" target="_blank">Category wise to Employee summary</a>  </td>
                  <td class="boldEleven">38. </td>
                  <td class="boldEleven"><a href="StaffPFandESI.jsp" target="_blank">PF & ESI </a></td>
                </tr>
                <tr>
                  <td class="boldEleven">39. </td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_RegularEmployee.jsp" target="_blank">Regular Employee </a></td>
                  <td class="boldEleven">40. </td>
                  <td class="boldEleven"><a href="Rept_NonRegularEmployee.jsp" target="_blank">Non Regular Employee </a></td>
                </tr>
                <tr>
                  <td class="boldEleven">41. </td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_WaitingforApprovalEmployee.jsp" target="_blank">Waiting for Approval </a></td>
                  <td class="boldEleven">42. </td>
                  <td class="boldEleven"><a href="Rept_JonningDateWiseList.jsp" target="_blank">Joining  List Date wise</a></td>
                </tr>
                <tr>
                  <td class="boldEleven">43.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_Accountinformations.jsp" target="_blank">Account Number </a></td>
                  <td class="boldEleven">44.</td>
                  <td class="boldEleven"><a href="Rept_Mobileinformations.jsp" target="_blank">Mobile Number </a></td>
                </tr>
                <tr>
                  <td class="boldEleven">45. </td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_getCurrentRevisionlist.jsp" target="_blank">Revision List </a></td>
                  <td class="boldEleven">46.</td>
                  <td class="boldEleven"><a href="Rept_EmployeeTransferList.jsp" target="_blank">Transfer List All</a></td>
                </tr>
                <tr>
                  <td class="boldEleven">47.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_Transfer.jsp" target="_blank">Transfer List Employee wise</a></td>
                  <td class="boldEleven">48.</td>
                  <td class="boldEleven"><a href="Rept_Servicecardcount.jsp" target="_blank">Service card count</a></td>
                </tr>
                <tr>
                  <td class="boldEleven">49.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="EmployeeTrack.jsp" target="_blank">Employee Track</a></td>
                  <td class="boldEleven">50.</td>
                  <td class="boldEleven"><a href="Rept_PF_Claims.jsp" target="_blank">PF Claim </a></td>
                </tr>
                <tr>
                  <td class="boldEleven">51.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href='Rept_StaffPFForm-9.jsp' target="_blank"> PF-Form-9</a></td>
                  <td class="boldEleven">52.</td>
                  <td class="boldEleven"><a href="Rept_Aadhar.jsp" target="_blank">AADHAR</a></td>
                </tr>
                
                
                <tr>
                  <td colspan="5" class="boldEleven"><table width="56" border="0" align="center" cellpadding="1"
									cellspacing="1">
                    <tr>
                      <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('commonmain.jsp')"></td>
                    </tr>
                  </table></td>
                </tr>
            </table>		   </td>
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
      </table></td></tr>
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
