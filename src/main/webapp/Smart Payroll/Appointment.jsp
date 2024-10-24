<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>
<%
try
{
%>
<html>
<head>

<title> :: PAYROLL ::</title>


 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<script language="javascript">
function validateFields()
    {
   	 if(checkNull('Transferdate','Enter Transfer Date') && checkNull('releavingdate','Enter Releaving Date')
   	 && checkNull('reason','Enter Reason') && checkNullSelect('Todistrict','Select District','Select'))
   	  {   	 	
   	 	   return true;
   	   }
   	 else{
   	   return false;	  
   	 }
	 }
</script>
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

<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
.style8 {COLOR: #000000; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;}
.style11 {COLOR: #000000; font-weight: normal; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;}
.style15 {COLOR: #000000; font-weight: bold; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px; }
-->
</style>
</head>

<body  onpaste='return false;'>
<form action="../SmartLoginAuth"   name="EmployeTransfer" class="boldEleven" onSubmit="return validateFields()"  AUTOCOMPLETE = "off">
  <table width="70%" border="0" align="center" cellpadding="2"
	cellspacing="2">
	<tr>
		<td><%
		String staffid=""+request.getParameter("ename");
		String grade=""+request.getParameter("intial");
		String pf="",esi="";
		String sql="select A.CHR_STAFFNAME,A.DT_DOJCOLLEGE,A.CHR_SADD1,A.CHR_SADD2,A.CHR_SCITY,A.CHR_SSTATE,A.CHR_SPIN, ";
		sql=sql+"B.CHR_DESIGNAME,C.CHR_COMPANYNAME,A.CHR_GENDER,A.CHR_MARITALSTATUS , RIGHT(CHR_EMPID,6),A.CHR_PERMAILID ,D.CHR_DEPARTNAME,E.CHR_OFFICENAME,A.CHR_PF,A.CHR_ESI  ";
		sql=sql+"from com_m_staff A, com_m_desig B,com_m_company C,com_m_depart D,  com_m_office  E  ";
		sql=sql+" where A.CHR_EMPID='"+staffid+"' AND A.INT_DESIGID=B.INT_DESIGID ";
		sql=sql+" AND A.INT_COMPANYID=C.INT_COMPANYID   AND A.INT_DEPARTID = D.INT_DEPARTID AND A.INT_OFFICEID = E.INT_OFFICEID ";
		
		String staffdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		String appointed=DateUtil.FormateDateSys(staffdata[0][1]);
		String app=com.my.org.erp.common.CommonFunctions.Appointmentyear(appointed);
		String id[]=app.split("~");
		String intial=com.my.org.erp.common.CommonFunctions.nameIntial(staffid);
		String apdate=DateUtil.FormateDateSys(DateUtil.getCurrentDBDate());
		String dateid[]=apdate.split("-");
		String appdate=dateid[0]+" "+ DateUtil.getMonth(Integer.parseInt(dateid[1]))+" "+dateid[2]; 
		 pf=staffdata[0][15];esi=staffdata[0][16];
		 
		 
		 
String institutionData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  INT_PFAMT,INT_ESIAMT,INT_ESILIMIT,INT_PFLIMIT,INT_PFLIMITMINIMUM ,INT_CPY_ESIAMT FROM m_institution WHERE INT_ID=1");
double pfpercentage = Double.parseDouble( institutionData[0][0]);
double esipercentage = Double.parseDouble( institutionData[0][1]);
double esilimitamount = Double.parseDouble( institutionData[0][2]);
double pfmaximumlimit = Double.parseDouble( institutionData[0][3]);
double pfminimumlimit = Double.parseDouble( institutionData[0][4]);
double esicomapnypercentage = Double.parseDouble( institutionData[0][5]);


		%></td>
	</tr>

	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="54">
		<table width="720" border="0" align="center" cellpadding="0" cellspacing="0">
          
          <tr>
            <td width="100%" height="20" colspan="2"><div align="center"><span class="style15">Appointment Order </span></div></td>
          </tr>
          <tr>
            <td colspan="2"><div align="right"></div></td>
          </tr>
          <tr>
            <td colspan="2"></td>
          </tr>
          <tr>
            <td colspan="2"></td>
          </tr>
          <tr>
            <td height="19" colspan="2"><table width="720" border="0" cellspacing="1" cellpadding="1">
                <tr>
                  <th width="720" height="21" scope="col"><div align="left"><span class="style11">
				  <b>Mythra/APPT-<%=staffdata[0][11]%>/TN-Chennai/ <%= id[0] %><br/><%= appdate%></b>
                  </span></div></th>
                </tr>
                <tr>
                  <th scope="col">&nbsp;</th>
                </tr>
                <tr>
                  <th scope="col"><div align="left">
                    <span class="style11">
                      <%= intial%>
                      <strong><%= staffdata[0][0] %></strong>
                      <br/>
                      <%= staffdata[0][2] %>,<br/>
                      <%= staffdata[0][3] %>,<br/>
                      <%= staffdata[0][4] %>,<br/>
                      <%= com.my.org.erp.common.CommonInfo.stringGetAnySelectField("select CHR_STATENAME from com_m_state where int_stateid="+staffdata[0][5],"CHR_STATENAME") %> - <%= staffdata[0][6] %>.                      </span></div></th>
                </tr>
                <tr>
                  <th scope="col">&nbsp;</th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style11"> Dear.
                    <%= intial%>
                    <%= staffdata[0][0] %>
                    <br/>
  &nbsp;&nbsp;&nbsp;&nbsp; With Reference to your application and the subsequent interview, we have pleasure in offering you an appointment as
  <strong><%= staffdata[0][7] %></strong>
                    in management Grade
                    "<%= grade %>"
                  in the terms and conditions of your appointment are as follows: </span></div></th>
                </tr>
                <tr>
                  <th scope="col">&nbsp;</th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style15">1. APPOINTMENTS' AND COMPENSATION :- </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="justify"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp; 1.1 Your Date of joining is
                    <%= id[1] %>
                  , the terms and conditions of appointment shall be effective from your date of joining. </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp; 1.2 Your Annual Cost to Company is Rs.
                    
                  .For details refer to Annexure 'A'.</span></div></th>
                </tr>
                <tr>
                  <th scope="col">&nbsp;</th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style15">2.EMOLUMENTS AND TAXES:- </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp; 2.1 You will be paid remuneration as per the details provided in 
                  Annexure 'A' annexed hereto. </span></div></th>
                </tr>
                <tr>
                  <th scope="col">                    <div align="justify"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp;2.2 You shall be solely responsible for paying any taxes, direct or indirect, state or local whether payable in India or elsewhere, which may result from your remuneration. The company shall be entitled to deduct from your remuneration, income tax, other taxes and levies that it is liable to deduct at source. </span></div></th>
                </tr>
                <tr>
                  <th scope="col">&nbsp;</th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style15">3.PROBATION:-</span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="justify"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp; 3.1 You shall initially be on probation for a period of One year from the date of joining the Company. The same may however, be extended if so deemed necessary by the Management if the Company It is the sole discretionary power of the Management in fixing up the probation Period. </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="justify"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp; 3.2 On Completion of probation period, either initial or extended, as the case may be, the Management may in its sole discretion confirm your employment with a company, by issuing a letter to the said effect. You will be deemed to be on probation till your confirmation from the management. </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp;</span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style15">4. TERMINATION :-</span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="justify"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp; 4.1 During the period, the Management after giving one day notice and without assigning any reason therefore may terminate your services. After your confirmation, the management may terminate your employment, by giving one month's written notice or basic salary in lieu thereof without assigning any reason. Similarly you can leave the services of the company by giving Thirty days notice prior confirmation, and two month's notice in writing or basic in lieu thereof after your confirmation. </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp; 4.2 Your employment shall stand terminated for with on the happening of the following:<br/>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  i. If You are held guilty of any offence involving moral turpitude; or <br/>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  ii. If You do not join with in the stipulated date, unless extended in writing. </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="justify"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp; 4.3 Upon termination of your employment, you (or your legal her is as the case may be) shall immediately return to the Company, any and all documents, manual Documented Confidential information (with out making any copies thereof and / or extracts there from), Kits and other property belonging to the company that may be entrusted to and or placed in Your possession by virtue of and/or during the course of your employment with the company. You (or your legal her is as the case may be) shall also deliver to the Company immediately all notes, analyses, summaries and working papers relating thereto. </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style11">&nbsp;&nbsp;&nbsp;</span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style15">5. INTIAL POSTING AND TRANSFER:- </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="justify"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp; 5.1 Your initial place of posting shall be at Chennai. However, you will be transferred to the base location within three months of posting. No salary increase/revision will be considered during the transfer. </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="justify"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp; 5.2 However, at the sole discretion of the Management, you will be liable to be transferred/Deputed from one place to another any where in India or abroad and/or from one department to another or from one establishment to another and/or to any other concern including to any of Company's affiliates, associates, group companies and/or entities in which the company may be having interest whether existing or which may be set up in future. </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="justify"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp; 5.3 You will also work, if required, for the Company's affiliates/group companies. The salary and emoluments mentioned herein cover your service for Mythra Group of companies, as well as for any of its affiliates/associates/group companies. </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp;</span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style15">6. GENERAL EMPLOYMENT OBLIGATIONS:- </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="justify"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp; 6.1 During your employment with us, you shall not be engaged, concerned or interested Directly or indirectly in any other occupation, business or employment whatsoever (either for remuneration or on a honorary basis) and shall devote your whole time, attention and abilities exclusively to the performance of your duties and shall faithfully serve the Company and use your best endeavor to promote the interest and business thereof. </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="justify"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp; 6.2 You shall be governed by the service rules and regulation of the Company, as Amended by the Management, from time to time including the Code of Conduct, the terms of which are hereby incorporated by reference. You shall abide by and carry out operational instructions/procedures as contained in the company's guidelines and other administrative instructions as may be issued by the Management from time to time. </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="justify"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp; 6.3 The work product generated by you while performing the services during the term of Your employment, training materials and other materials developed or prepared by you, shall be the sole and exclusive property of the Company without limiting the generality of the foregoing, the Company will own all intellectual property rights in any work, invention, discovery, improvement or design, which you make or conceive:<br/>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  I. While employed the Company and in connection with business  of the Company or a related body corporate; or <br/>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  II. By using the resources, facilities, or confidential information of the Company or its affiliates/associates/group companies. </span></div></th>
                </tr>
                <tr>
                  <th scope="col">&nbsp;</th>
                </tr>
                <tr>
                  <th scope="col"><div align="justify"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp; For the purpose of this clause, intellectual  property rights include, but are not limited to, rights in relation to or arising from patents, design registrations trademarks and copyrights. You undertake to execute necessary documents and do all such acts, at the request of the Company that may be required  to give effect to this provision. You shall return to the Company at any time during the term of your employment. </span></div></th>
                </tr>
                
                <tr>
                  <th scope="col"><div align="justify"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp; You will be responsible  for the safe custody of all documents, manuals and kits and other property belonging to the Company that may be entrusted to and/or during the Course of your employment with the Company. </span></div></th>
                </tr>
                
                <tr>
                  <th scope="col"><div align="justify"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp; You shall keep the Management informed for your latest postal address at all time and Intimate in writing in case of change of address. Any communication sent to you by the management on your last known address (as intimate by you) shall be deemed to have been duly served not withstanding  the fact that you have changed your address. </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style11">&nbsp;&nbsp;&nbsp;</span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style15">7. CONFIDENTIALITY:- </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="justify"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp; 7.1 You shall not, except as authorized or required  by your obligations in terms hereof, reveal  to any person or entity any of the trade secrets, secrets or confidential information, information contained in any manuals or dealing or any information concerning the organization, business, finance, transaction  or affairs of the Company and /or be imparted to you b the Company during his employment here under. You shall hold in strict confidence, all such confidential  information. This restriction  shall be derive  termination of your employment with the Company without limit in point of time but shall cease to apply to information or knowledge  which may come into the public domain without any of fault on your part. </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="justify"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp; 7.2 You shall not during the term of your employment or at any time thereafter, use or permit To be used, an information, note or memoranda relation to the business and/or transactions of the Company and/or its affiliates/associates/group companies which may come to your knowledge  and/or possession by virtue of his employment with the Company for any purpose other  than for the benefit of the Company. </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="justify"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp; 7.3 You acknowledge that the violation of any of the provisions of Clause 7 hereof will cause Irreparable loss and harm to the Company which cannot be reasonably or adequately compensated by damages in an action at law, and accordingly, the Company will be entitled, to injunctive and other equipped relief to prevent or cure any breach or threatened  breach thereof, but no action for any such relief shall be deemed to waive the right of the Company to an action for dam. </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style11">&nbsp;&nbsp;</span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style15">8. LEAVES AND OTHER SERVICE BENEFITS:- </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="justify"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp; 8.1 You will be entitled  to leave, holidays and other service benefits as per the rules of the Company as amended from time to time. After confirmation, you will be entitled to Holiday and other services benefits as per the rules of the managements frame from time and applicable to your cared  office /establishments /department in which you are for the time being posted. </span></div></th>
                </tr>
                <tr>
                  <th scope="col">&nbsp;</th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style15">9. RETIREMENT:- </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="justify"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp; 9.1 You shall retire on the attainment of 58 years unless specially by the Company in writing  to continue in service beyond this age. Your employment shall stand terminated on the date of your retirement. </span></div></th>
                </tr>
                <tr>
                  <th scope="col">&nbsp;</th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><strong><span class="style8"> 10. CONTINUATION OF EMPLOYMENT:- </span></strong></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="justify"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp;10.1 It is understood that this employment is being offered to you on basis of the particulars Submitted by you with the Company at the time of recruitment process. However, if at any time it should emerge that the particulars furnished by you are false/incorrect or if any materials or relevant information has been suppressed or concealed this appointment will be considered ineffective and irregular and would be liable to be terminated by the management for  without notice. This will be without prejudice to the rights of the management to take disciplinary action against you for the same. </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="justify"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp; 10.2 Your appointment and its continuation  is subject to your being medically fit and the Management reserves its right to ask you to undergo medical examination, as and when deemed necessary. </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style11">&nbsp;&nbsp;</span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><strong><span class="style8">11. GOVERNING LAW AND JURISDICTION:- </span></strong></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="justify"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp; 11.1 This appointment letter shall be governed and construed in accordance with the laws of India. It is agreed that any dispute of whatsoever nature between you a management will be subject to exclusive jurisdiction of courts of Chennai whether they be civil courts, Labor courts, industrial tribunals or any other courts or authority of whatsoever  nature in Case this offer of employment is acceptable to you, please sign duplicate  copy of this letter and return to us as atoken of your acceptance of the terms and conditions of Employment offered to you. You are also requested to indicate the date on which you are willing to join the Company. </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style11">&nbsp;&nbsp;&nbsp;</span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style11">12. Your Employee ID is 
                    <strong><%= staffid%></strong>
                  </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp;</span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp;Yours faithfully, </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp;</span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style11">&nbsp;&nbsp;
                       <strong><%= staffdata[0][8] %></strong>
                  </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp;</span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp;</span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style15">&nbsp;&nbsp;&nbsp;&nbsp; Authorized  Signatory </span></div></th>
                </tr>
                <tr>
                  <th scope="col">&nbsp;</th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp;I have gone through the aforesaid terms and conditions/ terms of appointment  and have fully understood the same. </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="boldEleven">&nbsp;&nbsp;&nbsp;&nbsp;I hereby accept the above appointment on the terms and conditions stated herein above. </span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp;</span></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left" class="style11"></div></th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp;Date :: <%= appdate%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="formText135">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Signature________________________________</span></div></th>
                </tr>
                
                

                
                <tr>
                  <th scope="col"><div align="left"><span class="style11">&nbsp;&nbsp;&nbsp;&nbsp;</span></div></th>
                </tr>
            </table></td>
          </tr>
        </table>		 </td>
	</tr>
	<tr>
	  <td height="54">&nbsp;</td>
    </tr>
	<tr>
	  <td height="54"><table width="720" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000000">
        <tr>
          <td><TABLE width="650" border="0" align="center" cellPadding="4" cellSpacing="4">
            <TBODY>
              <TR>
                <TD vAlign="bottom" noWrap colSpan="7" align="center"><h1>Annexure</h1></TD>
                </TR>
              <TR>
                <TD vAlign="bottom" noWrap width="568" colSpan="2"><p><strong>Name&nbsp;&nbsp; </strong><strong><%= staffdata[0][0] %></p>
                    <p><strong>&nbsp;</strong></p></TD>
                <TD vAlign="bottom" noWrap width="64"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="222"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="39"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="77"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="29"><p>&nbsp;</p></TD>
              </TR>
              <TR>
                <TD vAlign="bottom" noWrap width="568" colSpan="2"><p>Designation -<strong> </strong><strong><%=staffdata[0][7]%></strong></p></TD>
                <TD vAlign="bottom" noWrap width="64"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="222" colSpan="2"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="77"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="29"><p>&nbsp;</p></TD>
              </TR>
              <TR>
                <TD vAlign="bottom" noWrap width="568" colSpan="2"><p>GRADE - <strong><%=grade%></strong></p></TD>
                <TD vAlign="bottom" noWrap width="64"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="222"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="39"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="77"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="29"><p>&nbsp;</p></TD>
              </TR>
              <TR>
                <TD vAlign="bottom" noWrap width="568" colSpan="2"><p>Location -<strong><%=staffdata[0][14]%></strong></p></TD>
                <TD vAlign="bottom" noWrap width="64"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="222"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="39"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="77"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="29"><p>&nbsp;</p></TD>
              </TR>
              <TR>
                <TD vAlign="bottom" noWrap width="568" colSpan="2"><p>Department   -<strong><%=staffdata[0][13]%></strong></p></TD>
                <TD vAlign="bottom" noWrap width="64"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="222"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="39"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="77"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="29"><p>&nbsp;</p></TD>
              </TR>
              <TR>
                <TD vAlign="bottom" noWrap width="568" colSpan="2"><p>Date of Joining   -<%= id[1] %></p></TD>
                <TD vAlign="bottom" noWrap width="64"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="222"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="39"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="77"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="29"><p>&nbsp;</p></TD>
              </TR>
              <TR>
                <TD vAlign="bottom" noWrap width="568" colSpan="2"><p><strong>Salary   Component</strong></p></TD>
                <TD vAlign="bottom" noWrap width="64"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="222"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="39"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="77"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="29"><p>&nbsp;</p></TD>
              </TR>
              <TR bgcolor="#666666"   >
                <TD vAlign="bottom" noWrap width="568" colSpan="2"><p><strong>Particulars</strong></p></TD>
                <TD vAlign="bottom" noWrap width="64"><p><strong>&nbsp;</strong></p></TD>
                <TD vAlign="bottom" noWrap width="222"><p><strong>Amount</strong><strong>(P   M)</strong></p>                    </TD>
                <TD vAlign="bottom" noWrap width="39"><p><strong>&nbsp;</strong></p></TD>
                <TD vAlign="bottom" noWrap width="77"><p><strong>Amount   (PA)</strong></p></TD>
                <TD vAlign="bottom" noWrap width="29"><p><strong>&nbsp;</strong></p></TD>
              </TR>
              
			  <%
				
				String AllowanceData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME  FROM pay_m_allowance WHERE CHR_FLAG='Y' ORDER BY INT_ALLOWANCEID");
				String salaryband="   ";
				String grossband="";
				for(int u=0; u<AllowanceData.length;u++)
				{
					salaryband = salaryband+"  b."+AllowanceData[u][0]+",( b."+AllowanceData[u][0]+" *12) ,"; 
					grossband = grossband+"  b."+AllowanceData[u][0]+"+";
				}	
				salaryband=salaryband.trim();
				salaryband = salaryband.substring(0,salaryband.length()-1);		
				
				grossband=grossband.trim();
				grossband = grossband.substring(0,grossband.length()-1);		
				
				sql = " SELECT ROUND(a.INT_SALARY),ROUND(INT_SALARY*12),"+salaryband+" ,ROUND(a.INT_SALARY+("+grossband+")),ROUND( (a.INT_SALARY+("+grossband+"))*12 ),ROUND(a.INT_SALARY*12/100) ,ROUND((a.INT_SALARY*12/100)*12),ROUND( (a.INT_SALARY+("+grossband+"))  + (a.INT_SALARY*12/100) ) , ROUND(( (a.INT_SALARY+("+grossband+"))  + (a.INT_SALARY*12/100) )*12),ROUND( (a.INT_SALARY+("+grossband+")) - (a.INT_SALARY*12/100) )  FROM com_m_staff a,pay_t_allowance b ";
				sql = sql +" 	WHERE a.CHR_EMPID = b.CHR_EMPID AND a.CHR_EMPID='"+staffid+"' ";
				 
				String payData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				double monthbasic=0;
				double monthgross=0;
				double monthpf=0;
				double monthesi=0;
				double monthctc=0;
				
				double staffpf=0;
				double staffesi=0;
				double takehome=0;
				
				if(payData.length>0)
				{
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom' noWrap width='398' colSpan='2'><p>Basic</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='64'><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='107' align='right'><p>"+payData[0][0]+"</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='39'><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='77' align='right'><p>"+payData[0][1]+"</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='29'><p>&nbsp;</p></TD>");
					 out.println("</TR>");
					 int g=1;
					 int v=1;
					 for(int u=0; u<AllowanceData.length;u++)
					 {
						 
						  g = g+2;
						 out.println("<TR bgcolor='CCCCCC'>");
						 out.println("<TD vAlign='bottom' noWrap width='398' colSpan='2'><p> "+AllowanceData[u][1]+"</p></TD>");
						 out.println("<TD vAlign='bottom' noWrap width='64'><p>&nbsp;</p></TD>");
						  v=v+1;
						 out.println("<TD vAlign='bottom' noWrap width='107' align='right'><p> "+payData[0][v]+"</p></TD>");
						 out.println("<TD vAlign='bottom' noWrap width='39'><p>&nbsp;</p></TD>");
						  v=v+1;
						 out.println("<TD vAlign='bottom' noWrap width='77' align='right'><p> "+payData[0][v]+"</p></TD>");
						 out.println("<TD vAlign='bottom' noWrap width='29'><p>&nbsp;</p></TD>");
						 out.println("</TR>");
						
						 
						
					 }
					monthbasic=Double.parseDouble(payData[0][0]);
					monthgross=Double.parseDouble(payData[0][(g+1)]);
					
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom' noWrap width='398' colSpan='2'><p>GROSS</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='64'><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='107' align='right'><p>"+Math.round(monthgross)+"</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='39'><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='77' align='right'><p>"+Math.round(monthgross*12)+"</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='29'><p>&nbsp;</p></TD>");
					 out.println("</TR>"); 
					 
					 
					 
					 
					 
					 if("C".equals(pf))
					 {
						 
						if(monthbasic < pfminimumlimit)
						{
							monthpf = (pfminimumlimit*pfpercentage/100); 
							staffpf = (pfminimumlimit*pfpercentage/100); 
						}
						else if( (monthbasic>=pfminimumlimit)  && (monthbasic <=pfmaximumlimit))	
						{
							monthpf = (monthbasic*pfpercentage/100); 
							staffpf = (monthbasic*pfpercentage/100); 
						}
						else
						{
							monthpf = (pfmaximumlimit*pfpercentage/100);
							staffpf = (pfmaximumlimit*pfpercentage/100);
						}	
				
					}
					else
					{
						monthpf = 0;
						staffpf = 0;
					}
					
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom' noWrap width='398' colSpan='2'><p>EMPLOYEER PF</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='64'><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='107' align='right'><p>"+Math.round(monthpf)+"</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='39'><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='77' align='right'><p>"+Math.round(monthpf*12)+"</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='29'><p>&nbsp;</p></TD>");
					 out.println("</TR>"); 
				   
				   
				   if("C".equals(esi) && monthgross <=esilimitamount)
					 {
							monthesi=(monthgross*esicomapnypercentage/100);
							staffesi=(monthgross*esipercentage/100);
					 }
					 else
					 {
							monthesi=0;
						 	staffesi=0;
					  }
					  
					  
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom' noWrap width='398' colSpan='2'><p>EMPLOYEER ESI</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='64'><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='107' align='right'><p>"+Math.round(monthesi)+"</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='39'><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='77' align='right'><p>"+Math.round(monthesi*12)+"</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='29'><p>&nbsp;</p></TD>");
					 out.println("</TR>");
				  
					 
					 monthctc=monthgross+monthpf+monthesi;
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom' noWrap width='398' colSpan='2'><p>Total cost To Company   (TCTC)</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='64'><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='107' align='right'><p>"+Math.round(monthctc) +"</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='39'><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='77' align='right'><p>"+Math.round((monthctc)*12)+"</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='29'><p>&nbsp;</p></TD>");
					 out.println("</TR>"); 
					 
					 
					
					 
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom' noWrap width='398' colSpan='2'><p>As Applicable to your   Current Role</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='64'><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='107' align='right'><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='39'><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='77' align='right'><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='29'><p>&nbsp;</p></TD>");
					 out.println("</TR>"); 
					 
					 takehome=monthgross-(staffpf+staffesi);;
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom' noWrap width='398' colSpan='2'><p><strong>Take Home  Salary=</strong><strong>"+Math.round(takehome)+"</strong><strong></strong></p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='64'><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='107'><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='39'><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='77'><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='29'><p>&nbsp;</p></TD>");
					 out.println("</TR>"); 
					 
				}
			  %>
			    
             
              
              <TR>
                <TD vAlign="bottom" noWrap width="568"><p><strong>&nbsp;</strong></p>
                    <p><strong>IT Solutions PVT   Ltd</strong><strong></strong></p></TD>
                <TD vAlign="bottom" noWrap width="66" colSpan="2"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="222"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="39"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="77"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="29"><p>&nbsp;</p></TD>
              </TR>
              <TR>
                <TD vAlign="bottom" noWrap width="568"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="66" colSpan="2"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="222"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="39"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="77"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="29"><p>&nbsp;</p></TD>
              </TR>
              <TR>
                <TD vAlign="bottom" noWrap width="568"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="66" colSpan="2"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="222"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="39"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="77"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="29"><p>&nbsp;</p></TD>
              </TR>
              <TR>
                <TD vAlign="bottom" noWrap width="568"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="66" colSpan="2"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="222"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="39"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="77"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="29"><p>&nbsp;</p></TD>
              </TR>
              <TR>
                <TD vAlign="bottom" noWrap width="568"><p><strong><em>Authorised   Signatory</em></strong><strong></strong></p></TD>
                <TD vAlign="bottom" noWrap width="66" colSpan="2"><p><strong>&nbsp;</strong></p></TD>
                <TD vAlign="bottom" noWrap width="222"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="39"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="77"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="29"><p>&nbsp;</p></TD>
              </TR>
              <TR>
                <TD vAlign="bottom" noWrap width="568" colSpan="4"><p><strong>&nbsp;</strong></p></TD>
                <TD vAlign="bottom" noWrap width="39"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="77"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="29"><p>&nbsp;</p></TD>
              </TR>
              <TR>
                <TD vAlign="bottom" noWrap width="568" colSpan="2"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="64"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="222"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="39"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="77"><p>&nbsp;</p></TD>
                <TD vAlign="bottom" noWrap width="29"><p>&nbsp;</p></TD>
              </TR>
              <TR>
                <TD vAlign="bottom" noWrap width="568" colSpan="2"><p><strong>&nbsp;</strong></p></TD>
                <TD vAlign="bottom" noWrap width="64"><p><strong>&nbsp;</strong></p></TD>
                <TD vAlign="bottom" noWrap width="222" colSpan="3"><p>Accepted : </p></TD>
                <TD vAlign="bottom" noWrap width="29"><p>&nbsp;</p></TD>
              </TR>
              <TR height="0">
                <TD width="568"></TD>
                <TD width="66"></TD>
                <TD width="64"></TD>
                <TD width="222"></TD>
                <TD width="39"></TD>
                <TD width="77"></TD>
                <TD width="29"></TD>
              </TR>
            </TBODY>
          </TABLE></td>
        </tr>
      </table></td>
    </tr>
  </table>
  <p>&nbsp;</p> 
  <p>&nbsp;</p>
  <p align="center">
  
  <%
  	if("-".equals(staffdata[0][12]))
		out.println("<font class='bolddeepred'> Email id not avalaiable for send mail</font>");
	else
		out.println("<a href='../SmartLoginAuth?filename=AppoinmentMail&actionS=PAYAppoinmentMailSend&ename="+staffid+"&intial="+grade+"'>send mail </a>");	
  %>
</p><br>


<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
</form>
