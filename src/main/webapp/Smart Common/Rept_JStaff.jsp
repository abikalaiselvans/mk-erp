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

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
<script language="javascript" src="../JavaScript/comfunction.js"></script>



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
                  <td colspan="5" class="bold1"><div align="center">STAFF REPORTS </div></td>
                </tr>
                <tr>
                  <td width="7%" class="boldEleven">1.</td>
                  <td width="2%" class="boldEleven">&nbsp;</td>
                  <td width="38%" class="boldEleven"><a href="Rept_JStaffPersonalInfo.jsp" target="_blank">Personal Informations</a></td>
                  <td width="6%" class="boldEleven">2.</td>
                  <td width="47%" class="boldEleven"><a href="Rept_JStaffSummaryDepart.jsp" target="_blank">Department Wise Employee summary </a></td>
                </tr>
                <tr>
                  <td class="boldEleven">3.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_JStaffOfficialInfo.jsp" target="_blank">Official Informations </a></td>
                  <td class="boldEleven">4.</td>
                  <td class="boldEleven"><a href="Rept_JStaffSummaryDesignation.jsp" target="_blank">Designation Wise Employee summary</a></td>
                </tr>
                <tr>
                  <td class="boldEleven">5.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_JStaffAddressInfo.jsp" target="_blank">Address Informations </a></td>
                  <td class="boldEleven">6.</td>
                  <td class="boldEleven"><a href="Rept_JStaffSummaryAll.jsp" target="_blank">Employee Summary </a></td>
                </tr>
                <tr>
                  <td class="boldEleven">7.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_JStaffPFNumberInfo.jsp" target="_blank">PF Information</a> </td>
                  <td class="boldEleven">8.</td>
                  <td class="boldEleven"><a href="Rept_JStaffJonningInfo.jsp" target="_blank">Joining List </a></td>
                </tr>
                <tr>
                  <td class="boldEleven">9.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_JStaffPhotonotavailableInfo.jsp" target="_blank">Photo Not Available </a></td>
                  <td class="boldEleven">10.</td>
                  <td class="boldEleven">
                  <%
				  if("F".equals(session.getAttribute("USRTYPE")) || "A".equals(session.getAttribute("USRTYPE")))
				  		out.println("<a href='Rept_JStaffAllInfo.jsp' target='_blank'>All Informations </a>" );
				  else
				  		out.println("<a href='#' target='_blank'>All Informations </a>" );
				  %>                  </td>
                </tr>
                <tr>
                  <td class="boldEleven">11.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_JStaffProfilenotavailableInfo.jsp" target="_blank">Profile Not Available </a></td>
                  <td class="boldEleven">12.</td>
                  <td class="boldEleven">
                  
                  <%
				  if("F".equals(session.getAttribute("USRTYPE"))  || "A".equals(session.getAttribute("USRTYPE")))
				  		out.println("<a href='Rept_JServiceCard.jsp' target='_blank'>Service Card</a>" );
				  else
				  		out.println("<a href='#' target='_blank'>Service Card </a>" );
				  %>                   </td>
                </tr>
                <tr>
                  <td class="boldEleven">13.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_JStaffReportingtoInfo.jsp" target="_blank">Reporting To </a></td>
                  <td class="boldEleven">14.</td>
                  <td class="boldEleven"><a href="CompanyExplore.jsp" target="_blank">Explorer</a></td>
                </tr>
                <tr>
                  <td class="boldEleven">15.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven">  <a href="Rept_JStaffDOBInfo.jsp" target="_blank">Date of Birth </a></td>
                  <td class="boldEleven">16.</td>
                  <td class="boldEleven"><a href="Rept_JStaffWddingdateInfo.jsp" target="_blank">Wedding Date</a> </td>
                </tr>
                <tr>
                  <td class="boldEleven">17. </td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_JStaffBloodGroupInfo.jsp" target="_blank">Blood Group </a></td>
                  <td class="boldEleven">17.</td>
                  <td class="boldEleven"><a href="Rept_JStaffPanNumberInfo.jsp" target="_blank">PAN </a></td>
                </tr>
                 
                <tr>
                  <td class="boldEleven">18. </td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_JStaffQualificationwiseInfo.jsp" target="_blank">Qualification</a></td>
                  <td class="boldEleven">19.</td>
                  <td class="boldEleven"><a href="Rept_JStaffDrivingLicenseInfo.jsp" target="_blank">Driving License </a></td>
                </tr>
                <tr>
                  <td class="boldEleven">20.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_JStaffMailidsInfo.jsp" target="_blank">Mail Ids </a></td>
                  <td class="boldEleven">21.</td>
                  <td class="boldEleven"><a href="Rept_JStaffPassportInfo.jsp" target="_blank">Passport</a></td>
                </tr>
                <tr>
                  <td class="boldEleven">22.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_JStaffExpereienceInfo.jsp" target="_blank">Experience </a></td>
                  <td class="boldEleven">23.</td>
                  <td class="boldEleven"><a href="Rept_JStaffCTCInfo.jsp" target="_blank">CTC</a></td>
                </tr>
                <tr>
                  <td class="boldEleven">23.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_JResignedStaffListInfo.jsp" target="_blank">Resigned List </a></td>
                  <td class="boldEleven">24.</td>
                  <td class="boldEleven"><a href="../SmartLoginAuth?actionS=RPTRept_JStaffAddrEnvelope&filename=Rept_JStaffAddrEnvelope&rptfilename=Rept_JEmpImgAndAddrList&reportType=pdf" target="_blank">Address informations </a></td>
                </tr>
                <tr>
                  <td class="boldEleven">24.</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><a href="Rept_JServiceCard.jsp" target="_blank">Service Card Remainder </a></td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven">&nbsp;</td>
                </tr>
                
                
                <tr>
                  <td colspan="5" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
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
