<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<%@ page isELIgnored="false" %>
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
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

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
    <td>      <table class="BackGround1" cellspacing="0" cellpadding="0" width="600"
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
              
              <table width="95%" border="0" align="center" cellpadding="3" cellspacing="3">
                <tr>
                  <td width="173" class="boldEleven">1.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="AccountInfo.jrxml"/>                                      
                      <c:param name="query" value="SELECT @count:=@count+1 SNO, a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME, b.CHR_COMPANYNAME,c.CHR_BRANCHNAME, d.CHR_OFFICENAME, e.CHR_DEPARTNAME, f.CHR_DESIGNAME,g.CHR_CATEGORYNAME, a.CHR_GENDER,  DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'), h.CHR_BANKGROUPNAME,a.CHR_IFSC,a.CHR_ACCNO ,
IF(a.CHR_TYPE ='T',CONCAT('RESIGNED',' / ', DATE_FORMAT(a.DAT_RESIGNDATE,'%d-%b-%Y')),'LIVE') FROM  com_m_staff a,com_m_company b,com_m_branch c,com_m_office d, com_m_depart e,com_m_desig f , com_m_employeecategory g , com_m_bankgroup h, (SELECT @count:=0) sno WHERE a.INT_COMPANYID = b.INT_COMPANYID AND a.INT_BRANCHID = c.INT_BRANCHID
AND a.INT_OFFICEID = d.INT_OFFICEID AND a.INT_DEPARTID = e.INT_DEPARTID AND a.CHR_CATEGORY = g.INT_EMPLOYEECATEGORYID AND a.INT_DESIGID = f.INT_DESIGID AND a.CHR_BANK = h.INT_BANKGROUPID"/>                                      
                    </c:url>
                    <a href="${url}" target="_blank">AccountInformation</a></span></td>
                  <td width="173" class="boldEleven">16.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="AddrProof.jrxml"/>                                      
                      <c:param name="query" value="SELECT @count:=@count+1 SNO,ap.CHR_PROOFNAME   FROM  com_m_addressproof ap,(SELECT @count:=0) t ORDER BY  ap.CHR_PROOFNAME"/>                                      
                    </c:url>
                    <a href="${url }" target="_blank">Address Proof</a></span></td>
                  <td width="208" class="boldEleven">31.</td>
                  <td width="208"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="Bank.jrxml"/>                                      
                      <c:param name="query" value="SELECT @count:=@count+1 SNO, bank.INT_BANKGROUPID,bank.CHR_BANKGROUPNAME,bank.CHR_SHORTNAME FROM com_m_bankgroup bank, (SELECT @count:=0) t  ORDER BY bank.CHR_BANKGROUPNAME"/>                                      
                    </c:url>
                    <a href="${url }" target="_blank">Bank</a></span></td>
                </tr>
                <tr>
                  <td width="173" class="boldEleven">2.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="BankBranch.jrxml"/>                                        
                      <c:param name="query" value="SELECT @count:=@count+1 SNO,  b.CHR_BANKGROUPNAME,b.CHR_SHORTNAME,a.CHR_IFSC,a.CHR_MCR,a.CHR_BRANCHNAME, a.CHR_ADDRESS,a.CHR_CONTACT,a.CHR_CITY,a.CHR_DISTRICT,a.CHR_STATE,a.CHR_COUNRY FROM com_m_bankbranchname a,com_m_bankgroup b,com_m_bank c, (SELECT @count:=0) t
WHERE a.INT_BANKGROUPID= b.INT_BANKGROUPID AND a.CHR_BRANCHNAME=c.CHR_BRANCH"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Bank Branch</a></span></td>
                  <td width="173" class="boldEleven">17.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="BloodGroup.jrxml"/>                                        
                      <c:param name="query" value="SELECT @count:=@count+1 SNO,bg.CHR_GROUPNAME  FROM  com_m_bloodgroup bg, (SELECT @count:=0) t ORDER BY bg.CHR_GROUPNAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">BloodGroup</a></span></td>
                  <td width="208" class="boldEleven">32.</td>
                  <td width="208"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="Certification.jrxml"/>                                        
                      <c:param name="query" value="SELECT @count:=@count+1 SNO,cert.CHR_CERTIFICATIONNAME   FROM  com_m_certification cert,(SELECT @count:=0) t ORDER BY  cert.CHR_CERTIFICATIONNAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Certification</a></span></td>
                </tr>
                <tr>
                  <td width="173" class="boldEleven">3.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="City.jrxml"/>                                        
                      <c:param name="query" value="SELECT @count:=@count+1 SNO,a.CHR_COUNTRYNAME,b.CHR_STATENAME,c.CHR_DISTRICT,d.CHR_CITYNAME,DECODE(d.CHR_PINCODE,'9865043008') FROM com_m_country a , com_m_state b, com_m_district c, com_m_city d, (SELECT @count:=0) t WHERE a.INT_COUNTRYID =b.INT_COUNTRYID AND b.INT_STATEID = c.INT_STATEID AND d.INT_DISTRICTID = c.INT_DISTRICTID ORDER BY a.CHR_COUNTRYNAME,b.CHR_STATENAME,c.CHR_DISTRICT,d.CHR_CITYNAME"/>                                        
                    </c:url>
                    <a href="${url }" target="_blank">City</a></span></td>
                  <td width="173" class="boldEleven">18.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="Company.jrxml"/>                                        
                      <c:param name="query" value="SELECT @count:=@count+1 SNO,a.CHR_COMPANYNAME,a.CHR_LEGALNAME,a.CHR_STREET,e.CHR_CITYNAME,d.CHR_STATENAME ,c.CHR_COUNTRYNAME, CONCAT('PIN :',a.INT_PINCODE), a.CHR_AREACODE,a.CHR_PHONE,a.CHR_FAX,a.CHR_EMAIL,a.CHR_WEBSITE, a.CHR_TNGSTNO,a.CHR_CSTNO,a.CHR_REGNO,a.CHR_TINNO,a.CHR_SERVICETAX, a.CHR_SHORTNAME,
a.CHR_PANNO , a.CHR_PFNUMBER FROM com_m_company a,com_m_country c ,com_m_state d,  com_m_city e , (SELECT @count:=0) t WHERE a.INT_COUNTRYID = c.INT_COUNTRYID AND a.INT_STATEID =d.INT_STATEID AND a.INT_CITYID = e.INT_CITYID ORDER BY a.CHR_COMPANYNAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Company</a></span></td>
                  <td width="208" class="boldEleven">33.</td>
                  <td width="208"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="Country.jrxml"/>                                        
                      <c:param name="query" value="SELECT @count:=@count+1 SNO,ap.CHR_COUNTRYNAME,ap.CHR_COUNTRYDESC   FROM  com_m_country  ap,(SELECT @count:=0) t ORDER BY  ap.CHR_COUNTRYNAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Country</a></span></td>
                </tr>
                <tr>
                  <td width="173" class="boldEleven">4.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="Department.jrxml"/>                                        
                      <c:param name="query" value="SELECT @count:=@count+1 SNO,d.CHR_DEPARTNAME,d.CHR_DEPARTDES  FROM  com_m_depart d, (SELECT @count:=0) t ORDER BY d.CHR_DEPARTNAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Department</a></span></td>
                  <td width="173" class="boldEleven">19.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="Designation.jrxml"/>                                        
                      <c:param name="query" value="SELECT @count:=@count+1 SNO,des.CHR_DESIGNAME,des.CHR_DESIGDES  FROM  com_m_desig des, (SELECT @count:=0) t ORDER BY des.CHR_DESIGNAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Designation</a></span></td>
                  <td width="208" class="boldEleven">34.</td>
                  <td width="208"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="Dispensary.jrxml"/>                                        
                      <c:param name="query" value="SELECT @count:=@count+1 SNO,disp.CHR_DESPNAME,disp.CHR_ADDRESS,disp.INT_PINCODE,disp.INT_PHONE   FROM  com_m_dispensary disp, (SELECT @count:=0) t ORDER BY  disp.CHR_DESPNAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Dispensary</a></span></td>
                </tr>
                <tr>
                  <td width="173" class="boldEleven">5.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="District.jrxml"/>                                        
                      <c:param name="query" value="SELECT @count:=@count+1 SNO, a.CHR_COUNTRYNAME,b.CHR_STATENAME,c.CHR_DISTRICT,c.CHR_DISTRICTDES FROM com_m_country a , com_m_state b, com_m_district c, (SELECT @count:=0) t
WHERE a.INT_COUNTRYID =b.INT_COUNTRYID AND b.INT_STATEID = c.INT_STATEID ORDER BY a.CHR_COUNTRYNAME,b.CHR_STATENAME,c.CHR_DISTRICT"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">District</a></span></td>
                  <td width="173" class="boldEleven">20.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="EmpCategeory.jrxml"/>                                        
                      <c:param name="query" value="SELECT @count:=@count+1 SNO,empcat.CHR_CATEGORYNAME   FROM  com_m_employeecategory empcat,(SELECT @count:=0) t ORDER BY  empcat.CHR_CATEGORYNAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">EmployeeCategeory</a></span></td>
                  <td width="208" class="boldEleven">35.</td>
                  <td width="208"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="Location.jrxml"/>                                        
                      <c:param name="query" value="SELECT @count:=@count+1 SNO, a.CHR_LOCATION,b.CHR_OFFICENAME,if(a.CHR_ACTIVE='Y','Active','Inactive')  FROM com_m_locations a , com_m_office b , (SELECT @count:=0) t WHERE a.INT_OFFICEID = b.INT_OFFICEID  ORDER BY a.CHR_LOCATION"/>                                        
                    </c:url>
                    <a href="${url }" target="_blank">Location</a></span></td>
                </tr>
                <tr>
                  <td  width="173" class="boldEleven">6.</td>
                  <td  width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="MobileInfo.jrxml"/>                                        
                      <c:param name="query" value="SELECT @count:=@count+1 SNO,a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,b.CHR_COMPANYNAME,c.CHR_BRANCHNAME, d.CHR_OFFICENAME, e.CHR_DEPARTNAME,f.CHR_DESIGNAME,g.CHR_CATEGORYNAME, a.CHR_GENDER,  DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'),a.CHR_EMAILID, a.CHR_PERMAILID,a.CHR_MOBILE,a.CHR_PPHONE,a.CHR_SPHONE,
IF(a.CHR_TYPE ='T',CONCAT('RESIGNED',' / ', DATE_FORMAT(a.DAT_RESIGNDATE,'%d-%b-%Y')),'LIVE') FROM  com_m_staff a,com_m_company b,com_m_branch c,com_m_office d,com_m_depart e,com_m_desig f , com_m_employeecategory g ,(SELECT @count:=0) sno WHERE a.INT_COMPANYID = b.INT_COMPANYID AND a.INT_BRANCHID = c.INT_BRANCHID AND a.INT_OFFICEID = d.INT_OFFICEID
AND a.INT_DEPARTID = e.INT_DEPARTID AND a.CHR_CATEGORY = g.INT_EMPLOYEECATEGORYID AND a.INT_DESIGID = f.INT_DESIGID"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">MobileInformation</a></span></td>
                  <td width="173" class="boldEleven">21.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="Office.jrxml"/>                                        
                      <c:param name="query" value="SELECT @count:=@count+1 SNO,o.CHR_OFFICENAME,o.CHR_OFFICESHORTNAME,o.CHR_OFFICEDES FROM  com_m_office o, (SELECT @count:=0) t ORDER BY o.CHR_OFFICENAME"/>                                        
                    </c:url>
                    <a href="${url }" target="_blank">Office</a></span></td>
                  <td width="208" class="boldEleven">36.</td>
                  <td width="208"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="Qualification.jrxml"/>                                        
                      <c:param name="query" value="SELECT @count:=@count+1 SNO,q.CHR_QUALIFICATIONNAME,q.CHR_QUALIFICATIONDES  FROM  com_m_qualification q, (SELECT @count:=0) t ORDER BY q.CHR_QUALIFICATIONNAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Qualification</a></span></td>
                </tr>
                <tr>
                  <td width="173" class="boldEleven">7.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="StaffType.jrxml"/>                                        
                      <c:param name="query" value="SELECT @count:=@count+1 SNO, staff.CHR_TYPENAME   FROM  com_m_stafftype staff,(SELECT @count:=0) t ORDER BY  staff.CHR_TYPENAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Staff Type</a></span></td>
                  <td width="173" class="boldEleven">22</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="State.jrxml"/>                                        
                      <c:param name="query" value="SELECT @count:=@count+1 SNO, a.CHR_COUNTRYNAME,b.CHR_STATENAME,b.CHR_SHORTNAME,b.CHR_STATEDES FROM com_m_country a , com_m_state b,(SELECT (@count:=0)) r
WHERE a.INT_COUNTRYID =b.INT_COUNTRYID ORDER BY b.CHR_STATENAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">State</a></span></td>
                  <td width="208" class="boldEleven">37.</td>
                  <td width="208"><span class="boldEleven"><a href="JRept_Relivingletter.jsp" target="_blank">Releaving Letter</a></span></td>
                </tr>
                <tr>
                  <td width="173" class="boldEleven">8.</td>
                  <td width="173"><span class="boldEleven"><a href="JRept_formq.jsp" target="_blank">Form Q</a></span></td>
                  <td width="173" class="boldEleven">23</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="personalInfo.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO, a.CHR_EMPID,a.CHR_STAFFNAME ,a.CHR_GENDER , DATE_FORMAT(a.DT_DOB,'%d-%b-%Y') dob,IF(a.CHR_MARITALSTATUS='U','Unmarried','Married') mstatus,DATE_FORMAT(a.DT_WEDDATE,'%d-%m-%Y') wdate,b.CHR_GROUPNAME,LOWER(a.CHR_EMAILID) eid,a.CHR_MOBILE
FROM com_m_staff a,com_m_bloodgroup b,(SELECT @c:=0) r WHERE a.CHR_TYPE!='T' AND a.CHR_HOLD !='Y' AND a.CHR_BG=b.INT_BLOODGROUPID ORDER BY a.CHR_STAFFNAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Personal Information</a></span></td>
                  <td width="208" class="boldEleven">38.</td>
                  <td width="208"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="OfficeInfo.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,a.CHR_EMPID,a.CHR_STAFFNAME , c.CHR_OFFICENAME,d.CHR_DEPARTNAME,
e.CHR_DESIGNAME,
a.CHR_GENDER , DATE_FORMAT(a.DT_DOB,'%d-%b-%Y') dob,  LOWER(a.CHR_EMAILID) email,a.CHR_MOBILE FROM com_m_staff a,com_m_bloodgroup b,com_m_office c,com_m_depart d,com_m_desig e,(SELECT @c:=0) r WHERE a.CHR_TYPE!='T' AND a.CHR_HOLD !='Y' AND a.CHR_BG=b.INT_BLOODGROUPID AND a.INT_OFFICEID=c.INT_OFFICEID AND a.INT_DEPARTID= d.INT_DEPARTID
AND a.INT_DESIGID = e.INT_DESIGID ORDER BY a.CHR_STAFFNAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Office Information</a></span></td>
                </tr>
                <tr>
                  <td width="173" class="boldEleven">9.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="AddressInfo.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,a.CHR_EMPID,a.CHR_STAFFNAME,g.CHR_COMPANYNAME,f.CHR_BRANCHNAME,CONCAT(a.CHR_PADD1,',',a.CHR_PADD2,',',n.CHR_CITYNAME,',',m.CHR_DISTRICT,',',l.CHR_STATENAME,',',k.CHR_COUNTRYNAME,',Pincode : ',a.CHR_PPIN,', Phone : ',a.CHR_PPHONE,',Email :',a.CHR_EMAILID,',Mobile :',a.CHR_MOBILE),
CONCAT(a.CHR_SADD1,',',a.CHR_SADD2,',',n.CHR_CITYNAME,',',m.CHR_DISTRICT,',',l.CHR_STATENAME,',',k.CHR_COUNTRYNAME,',Pincode : ',a.CHR_SPIN,', Phone : ',a.CHR_SPHONE,',Email :',a.CHR_EMAILID,',Mobile :',a.CHR_MOBILE) ,a.CHR_MOBILE FROM com_m_staff a ,com_m_branch f , com_m_company g,com_m_country k,com_m_state l,com_m_district m,com_m_city n ,(SELECT @c:=0) r
WHERE  a.INT_BRANCHID =f.INT_BRANCHID AND a.INT_COMPANYID =g.INT_COMPANYID AND a.CHR_PCITY = n.INT_CITYID AND a.INT_PDISTRICTID=m.INT_DISTRICTID AND a.CHR_PSTATE=l.INT_STATEID AND a.INT_PCOUNTRYID =k.INT_COUNTRYID AND a.CHR_SCITY = n.INT_CITYID AND a.INT_CDISTRICTID=m.INT_DISTRICTID AND a.CHR_SSTATE=l.INT_STATEID AND a.INT_CCOUNTRY =k.INT_COUNTRYID    AND  a.CHR_TYPE !='T' AND a.CHR_HOLD !='Y'
ORDER BY a.CHR_STAFFNAME "/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Address Information</a></span></td>
                  <td width="173" class="boldEleven">24</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="PFInfo.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,a.CHR_EMPID,a.CHR_STAFFNAME,g.CHR_COMPANYNAME,f.CHR_BRANCHNAME,c.CHR_DEPARTNAME, i.CHR_DESIGNAME,b.CHR_OFFICENAME , q.CHR_CATEGORYNAME,a.CHR_GENDER, DATE_FORMAT(a.DT_DOB,'%d-%m-%Y') DOB,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%m-%Y') DOJ,
IF(a.CHR_MARITALSTATUS='U','Unmarried','Married') Marital_Status, DATE_FORMAT(a.DT_WEDDATE,'%d-%m-%Y') Wed_Date, e.CHR_QUALIFICATIONNAME ,j.CHR_GROUPNAME, a.CHR_EMAILID, a.CHR_MOBILE, a.INT_SALARY,a.CHR_PF ,CONCAT(g.CHR_PFNUMBER,a.CHR_PFNO) PFNO,a.CHR_ESI ,a.CHR_ESINO,FIND_A_BANKGROUP_NAME(a.CHR_BANK) ,CONCAT('A/c : ',a.CHR_ACCNO) ACCOUNTNO
FROM com_m_staff a , com_m_office b ,com_m_depart c ,pay_t_allowance d ,com_m_qualification e , com_m_branch f , com_m_company g,com_m_desig i,com_m_bloodgroup j, com_m_employeecategory q ,(SELECT @c:=0) r WHERE a.INT_DEPARTID = c.INT_DEPARTID AND a.INT_OFFICEID= b.INT_OFFICEID AND a.CHR_EMPID =d.CHR_EMPID AND a.CHR_QUALIFICATION =e.INT_QUALIFICATIONID
AND a.INT_BRANCHID =f.INT_BRANCHID AND a.INT_COMPANYID =g.INT_COMPANYID AND a.INT_DESIGID= i.INT_DESIGID AND a.CHR_BG=j.INT_BLOODGROUPID AND a.CHR_TYPE !='T' AND a.CHR_CATEGORY= q.INT_EMPLOYEECATEGORYID ORDER BY a.CHR_STAFFNAME "/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">PF Information</a></span></td>
                  <td width="208" class="boldEleven">39.</td>
                  <td width="208"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="DateOfBirth.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO, A.CHR_EMPID,A.CHR_STAFFNAME,D.CHR_OFFICENAME,B.CHR_DEPARTNAME,C.CHR_DESIGNAME,A.CHR_GENDER, DATE_FORMAT(A.DT_DOB,'%d-%b-%Y') , DATE_FORMAT(A.DT_ACTUAL_DOB,'%d-%b-%Y') ,DAY(A.DT_ACTUAL_DOB), A.CHR_MOBILE,A.CHR_PERMAILID
 FROM  com_m_staff  A,  com_m_depart   B, com_m_desig  C , com_m_office D,(SELECT @c:=0) r WHERE  A.INT_OFFICEID= D.INT_OFFICEID  AND A.INT_DEPARTID=B.INT_DEPARTID AND A.INT_DESIGID=C.INT_DESIGID AND  A.CHR_TYPE !='T'  AND A.CHR_HOLD!='Y' ORDER BY a.CHR_STAFFNAME "/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Date of birth</a></span></td>
                </tr>
                <tr>
                  <td width="173" class="boldEleven">10.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="DateOfWedding.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO, A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_DEPARTNAME,C.CHR_DESIGNAME,D.CHR_OFFICENAME,A.CHR_GENDER, DATE_FORMAT(A.DT_DOJCOLLEGE,'%d-%b-%Y') dojc ,
 DATE_FORMAT(A.DT_WEDDATE,'%d-%b-%Y')  wdate ,DAY(A.DT_WEDDATE), DAY(now()) day, A.CHR_MOBILE   FROM  com_m_staff  A,  com_m_depart   B, com_m_desig  C , com_m_office D ,(SELECT @c:=0) r
 WHERE   A.INT_DEPARTID=B.INT_DEPARTID  AND A.INT_DESIGID=C.INT_DESIGID  AND A.INT_OFFICEID= D.INT_OFFICEID  AND A.CHR_TYPE !='T' AND A.CHR_HOLD!='Y' ORDER BY a.CHR_STAFFNAME "/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Date of Wedding</a></span></td>
                  <td width="173" class="boldEleven">25</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="BloodGroupList.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO, A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_DEPARTNAME,C.CHR_DESIGNAME,D.CHR_OFFICENAME,A.CHR_GENDER, DATE_FORMAT(A.DT_DOJCOLLEGE,'%d-%b-%Y') , E.CHR_GROUPNAME,A.CHR_MOBILE  FROM  com_m_staff  A,  com_m_depart   B, com_m_desig  C , com_m_office D,com_m_bloodgroup E ,(SELECT @c:=0) r
 WHERE   A.INT_DEPARTID=B.INT_DEPARTID  AND A.INT_DESIGID=C.INT_DESIGID  AND A.INT_OFFICEID= D.INT_OFFICEID  AND A.CHR_BG = E.INT_BLOODGROUPID  AND A.CHR_TYPE !='T' AND A.CHR_HOLD!='Y' ORDER BY a.CHR_STAFFNAME "/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">BloodGroup List</a></span></td>
                  <td width="208" class="boldEleven">40.</td>
                  <td width="208"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="QualificationList.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO, A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_DEPARTNAME,C.CHR_DESIGNAME,D.CHR_OFFICENAME, F.CHR_CATEGORYNAME,A.CHR_GENDER, DATE_FORMAT(A.DT_DOJCOLLEGE,'%d-%b-%Y') , E.CHR_QUALIFICATIONNAME,A.CHR_MOBILE ,if(A.CHR_TYPE ='T','Resigned','Live')  FROM  com_m_staff  A,  com_m_depart   B, com_m_desig  C ,
 com_m_office D,com_m_qualification E , com_m_employeecategory F,(SELECT @c:=0) r  WHERE   A.INT_DEPARTID=B.INT_DEPARTID  AND A.INT_DESIGID=C.INT_DESIGID  AND A.CHR_CATEGORY=F.INT_EMPLOYEECATEGORYID  AND A.INT_OFFICEID= D.INT_OFFICEID  AND A.CHR_QUALIFICATION = E.INT_QUALIFICATIONID ORDER BY a.CHR_STAFFNAME "/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Qualification List</a></span></td>
                </tr>
                 
                 
                 
                <tr>
                  <td width="173" class="boldEleven">11.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="StaffMailId.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO, A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_DEPARTNAME,C.CHR_DESIGNAME,D.CHR_OFFICENAME,A.CHR_GENDER, DATE_FORMAT(A.DT_DOJCOLLEGE,'%d-%b-%Y') , A.CHR_MOBILE,A.CHR_PERMAILID , A.CHR_EMAILID,A.CHR_PASSPORT,A.CHR_DRIVING,A.CHR_PAN FROM com_m_staff A, com_m_depart B, com_m_desig C , com_m_office D ,(SELECT @c:=0) t
WHERE A.INT_DEPARTID=B.INT_DEPARTID AND A.INT_DESIGID=C.INT_DESIGID AND A.INT_OFFICEID= D.INT_OFFICEID AND A.CHR_TYPE !='T'  ORDER BY A.CHR_STAFFNAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Staff Mail ID</a></span></td>
                  <td width="173" class="boldEleven">26</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="ResignerList.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO, a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,DATE_FORMAT(a.DT_DOB,'%d-%b-%Y'),b.CHR_COMPANYNAME, c.CHR_BRANCHNAME, d.CHR_OFFICENAME, e.CHR_DEPARTNAME,f.CHR_DESIGNAME,a.CHR_GENDER, DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'),DATE_FORMAT(g.DT_TERM_DATE,'%d-%b-%Y'),(PERIOD_DIFF(EXTRACT(YEAR_MONTH FROM g.DT_TERM_DATE),
EXTRACT(YEAR_MONTH FROM a.DT_DOJCOLLEGE))/ 12) PERIOD, a.INT_SALARY,a.INT_GROSSSALARY ,MONTHNAME(g.DT_TERM_DATE),YEAR(g.DT_TERM_DATE) FROM com_m_staff a,com_m_company b,com_m_branch c,com_m_office d,com_m_depart e,com_m_desig f ,(SELECT @c:=0) t,pay_m_emp_termination g WHERE a.INT_COMPANYID= b.INT_COMPANYID AND a.INT_BRANCHID=c.INT_BRANCHID AND a.INT_OFFICEID=d.INT_OFFICEID
AND a.INT_DEPARTID= e.INT_DEPARTID AND a.INT_DESIGID = f.INT_DESIGID AND a.CHR_TYPE ='T' AND a.CHR_EMPID = g.CHR_EMPID  ORDER BY a.CHR_STAFFNAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Resigner List</a></span></td>
                  <td width="208" class="boldEleven">41.</td>
                  <td width="208"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="BankInfo.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,a.CHR_EMPID,a.CHR_STAFFNAME ,a.CHR_STAFFFNAME ,FUN_GET_BRANCH_WITH_COMPANY_NAME(a.INT_BRANCHID),a.CHR_GENDER , DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'), a.CHR_MOBILE,b.CHR_BANKGROUPNAME,CONCAT('A/c : ',a.CHR_ACCNO) , UPPER(a.CHR_IFSC) FROM com_m_staff a, com_m_bankgroup b,(SELECT @c:=0) t WHERE a.CHR_TYPE!='T' AND a.CHR_BANK =b.INT_BANKGROUPID AND a.CHR_HOLD !='Y'
ORDER BY a.CHR_STAFFNAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Bank Information</a></span></td>
                </tr>
                <tr>
                  <td width="173" class="boldEleven">12.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="RejoinInfo.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,a.CHR_EMPID,a.CHR_STAFFNAME ,a.CHR_STAFFFNAME , a.CHR_GENDER ,DATE_FORMAT(a.DT_DOB,'%d-%b-%Y'), LOWER(a.CHR_EMAILID),a.CHR_MOBILE ,a.CHR_REJOIN FROM com_m_staff a, (SELECT @c:=0) t WHERE a.CHR_TYPE!='T' AND a.CHR_REJOIN='Y' ORDER BY a.CHR_STAFFNAME asc"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Rejoin Information</a></span></td>
                  <td width="173" class="boldEleven">27</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="RegularList.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,a.CHR_EMPID,a.CHR_STAFFNAME ,a.CHR_STAFFFNAME , c.CHR_OFFICENAME,d.CHR_DEPARTNAME,e.CHR_DESIGNAME, a.CHR_GENDER , DATE_FORMAT(a.DT_DOB,'%d-%b-%Y'), LOWER(a.CHR_EMAILID),a.CHR_MOBILE , IF(a.CHR_EMPLOYEE ='R','REGULAR','NON REGULAR')  FROM com_m_staff a,com_m_bloodgroup b,com_m_office c,com_m_depart d,com_m_desig e ,(SELECT @c:=0) t WHERE a.CHR_TYPE!='T' AND a.CHR_HOLD !='Y' AND a.CHR_BG=b.INT_BLOODGROUPID 
AND a.CHR_EMPLOYEE = 'R' AND a.INT_OFFICEID=c.INT_OFFICEID AND a.INT_DEPARTID= d.INT_DEPARTID  AND a.INT_DESIGID = e.INT_DESIGID ORDER BY a.CHR_STAFFNAME "/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Regular List</a></span></td>
                  <td width="208" class="boldEleven">42.</td>
                  <td width="208"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="approvalWaiting.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,a.CHR_EMPID,a.CHR_STAFFNAME , c.CHR_OFFICENAME,d.CHR_DEPARTNAME,e.CHR_DESIGNAME, a.CHR_GENDER , DATE_FORMAT(a.DT_DOB,'%d-%b-%Y'),LOWER(a.CHR_EMAILID),a.CHR_MOBILE FROM com_m_staff a,com_m_bloodgroup b,com_m_office c,com_m_depart d,com_m_desig e ,(SELECT @c:=0) t WHERE a.CHR_TYPE!='T' AND a.CHR_HOLD !='Y' AND a.CHR_BG=b.INT_BLOODGROUPID AND a.CHR_APPROVED = 'N' AND a.INT_OFFICEID=c.INT_OFFICEID AND a.INT_DEPARTID= d.INT_DEPARTID
 AND a.INT_DESIGID = e.INT_DESIGID ORDER BY a.CHR_STAFFNAME "/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Approval Waiting</a></span></td>
                </tr>
                <tr>
                  <td width="173" class="boldEleven">13.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="contactInfo.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO, a.CHR_EMPID,a.CHR_STAFFNAME, b.CHR_COMPANYNAME,c.CHR_BRANCHNAME, d.CHR_OFFICENAME, e.CHR_DEPARTNAME, f.CHR_DESIGNAME,g.CHR_CATEGORYNAME, a.CHR_GENDER,  DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'), a.CHR_EMAILID, a.CHR_PERMAILID,a.CHR_MOBILE,  a.CHR_PPHONE,a.CHR_SPHONE, IF(a.CHR_TYPE ='T',CONCAT('RESIGNED',' / ', DATE_FORMAT(a.DAT_RESIGNDATE,'%d-%b-%Y')),'LIVE')   FROM com_m_staff a,com_m_company b,com_m_branch c,com_m_office d, com_m_depart e,com_m_desig f ,
   com_m_employeecategory g,(SELECT @c:=0) t WHERE a.INT_COMPANYID = b.INT_COMPANYID    AND a.INT_BRANCHID = c.INT_BRANCHID AND a.INT_OFFICEID = d.INT_OFFICEID   AND a.INT_DEPARTID = e.INT_DEPARTID AND a.CHR_CATEGORY = g.INT_EMPLOYEECATEGORYID  AND a.INT_DESIGID = f.INT_DESIGID  ORDER BY a.CHR_STAFFNAME "/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Contact Information</a></span></td>
                  <td width="173" class="boldEleven">28</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="PFInformation.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,a.CHR_EMPID,a.CHR_STAFFNAME,g.CHR_COMPANYNAME,f.CHR_BRANCHNAME, c.CHR_DEPARTNAME, i.CHR_DESIGNAME,b.CHR_OFFICENAME , q.CHR_CATEGORYNAME, a.CHR_GENDER, DATE_FORMAT(a.DT_DOB,'%d-%m-%Y'),DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%m-%Y'), IF(a.CHR_MARITALSTATUS='U','Unmarried','Married'), DATE_FORMAT(a.DT_WEDDATE,'%d-%m-%Y'), e.CHR_QUALIFICATIONNAME ,j.CHR_GROUPNAME, a.CHR_EMAILID, a.CHR_MOBILE, a.INT_SALARY, IF(a.CHR_PF='N','',IF(a.CHR_PF='Y','YES','COMMON')) ,CONCAT(g.CHR_PFNUMBER,a.CHR_PFNO),
 IF(a.CHR_ESI='N','',IF(a.CHR_ESI='Y','YES','COMMON')) ,a.CHR_ESINO, FIND_A_BANKGROUP_NAME(a.CHR_BANK) ,CONCAT('A/c : ',a.CHR_ACCNO)  FROM com_m_staff a , com_m_office b ,com_m_depart c ,pay_t_allowance d , com_m_qualification e , com_m_branch f , com_m_company g, com_m_desig i,com_m_bloodgroup j, com_m_employeecategory q ,(SELECT @c:=0) t  WHERE a.INT_DEPARTID = c.INT_DEPARTID  AND a.INT_OFFICEID= b.INT_OFFICEID AND a.CHR_EMPID =d.CHR_EMPID  AND a.CHR_QUALIFICATION =e.INT_QUALIFICATIONID AND a.INT_BRANCHID =f.INT_BRANCHID
 AND a.INT_COMPANYID =g.INT_COMPANYID AND a.INT_DESIGID= i.INT_DESIGID  AND a.CHR_BG=j.INT_BLOODGROUPID AND a.CHR_TYPE !='T'  AND a.CHR_CATEGORY= q.INT_EMPLOYEECATEGORYID AND a.CHR_TYPE !='T' ORDER BY a.CHR_STAFFNAME asc "/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">PF Information</a></span></td>
                  <td width="208" class="boldEleven">43.</td>
                  <td width="208"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="Passport.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO, A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_DEPARTNAME,C.CHR_DESIGNAME,D.CHR_OFFICENAME,A.CHR_GENDER,DATE_FORMAT(A.DT_DOJCOLLEGE,'%d-%b-%Y') , A.CHR_MOBILE,A.CHR_PASSPORT,A.CHR_DRIVING,A.CHR_PAN,A.CHR_PERMAILID FROM com_m_staff A, com_m_depart B, com_m_desig C , com_m_office D ,(SELECT @c:=0) t WHERE A.INT_DEPARTID=B.INT_DEPARTID AND A.INT_DESIGID=C.INT_DESIGID AND A.INT_OFFICEID= D.INT_OFFICEID AND A.CHR_TYPE !='T' AND A.CHR_HOLD!='Y' ORDER BY A.CHR_STAFFNAME "/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Passport</a></span></td>
                </tr>
                <tr>
                  <td width="173" class="boldEleven">14</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="PANNO.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO, A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_DEPARTNAME,C.CHR_DESIGNAME,D.CHR_OFFICENAME,A.CHR_GENDER, DATE_FORMAT(A.DT_DOJCOLLEGE,'%d-%b-%Y') , A.CHR_MOBILE,A.CHR_PAN,A.CHR_PASSPORT, A.CHR_DRIVING,A.CHR_PERMAILID FROM com_m_staff A, com_m_depart B, com_m_desig C , com_m_office D ,(SELECT @c:=0) t  WHERE A.INT_DEPARTID=B.INT_DEPARTID AND A.INT_DESIGID=C.INT_DESIGID  AND A.INT_OFFICEID= D.INT_OFFICEID AND A.CHR_TYPE !='T' AND A.CHR_HOLD!='Y' ORDER BY A.CHR_STAFFNAME "/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">PANNO</a></span></td>
                  <td width="173" class="boldEleven">29</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="driving.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO, A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_DEPARTNAME,C.CHR_DESIGNAME,D.CHR_OFFICENAME,A.CHR_GENDER,DATE_FORMAT(A.DT_DOJCOLLEGE,'%d-%b-%Y') , A.CHR_MOBILE,A.CHR_DRIVING,A.CHR_PAN,A.CHR_PASSPORT,A.CHR_PERMAILID FROM com_m_staff A, com_m_depart B, com_m_desig C , com_m_office D,(SELECT @c:=0) t WHERE A.INT_DEPARTID=B.INT_DEPARTID AND A.INT_DESIGID=C.INT_DESIGID AND A.INT_OFFICEID= D.INT_OFFICEID AND A.CHR_TYPE !='T' AND A.CHR_HOLD!='Y'  ORDER BY A.CHR_STAFFNAME "/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Driving</a></span></td>
                  <td width="208" class="boldEleven">44.</td>
                  <td width="208"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="gross.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,a.CHR_EMPID,a.CHR_STAFFFNAME,g.CHR_COMPANYNAME,f.CHR_BRANCHNAME,c.CHR_DEPARTNAME,i.CHR_DESIGNAME,b.CHR_OFFICENAME , round(datediff(now(),a.DT_DOJCOLLEGE)/365) ,a.INT_SALARY, o.A001, o.A002, o.A003, o.A004, o.A005, o.A006, o.A0010, o.A0011,( o.A001+ o.A002+ o.A003+ o.A004+ o.A005+ o.A006+ o.A0010+ o.A0011+ 0 ) basic,( a.INT_SALARY + o.A001+ o.A002+ o.A003+ o.A004+ o.A005+ o.A006+ o.A0010+ o.A0011+ 0 ) total,
FUN_GET_PFAMOUNT(a.CHR_PF,a.INT_SALARY) pf,FUN_GET_ESIAMOUNT('company' ,a.CHR_ESI,( a.INT_SALARY + o.A001+ o.A002+ o.A003+ o.A004+ o.A005+ o.A006+ o.A0010+ o.A0011+ 0 )) esi, ( ( a.INT_SALARY + o.A001+ o.A002+ o.A003+ o.A004+ o.A005+ o.A006+ o.A0010+ o.A0011+ 0 ) +FUN_GET_PFAMOUNT(a.CHR_PF,a.INT_SALARY) + FUN_GET_ESIAMOUNT ('company' ,a.CHR_ESI,( a.INT_SALARY + o.A001+ o.A002+ o.A003+ o.A004+ o.A005+ o.A006+ o.A0010+ o.A0011+ 0 )) ) total  FROM com_m_staff a , com_m_office b ,com_m_depart c ,pay_t_allowance d , com_m_branch f ,
 com_m_company g, com_m_desig i, pay_t_allowance o,(SELECT @c:=0) t  WHERE a.CHR_TYPE != 'T' AND a.INT_DEPARTID = c.INT_DEPARTID  AND a.INT_OFFICEID= b.INT_OFFICEID AND a.CHR_EMPID =d.CHR_EMPID  AND a.INT_BRANCHID =f.INT_BRANCHID AND a.INT_COMPANYID =g.INT_COMPANYID  AND a.INT_DESIGID= i.INT_DESIGID AND a.CHR_EMPID =o.CHR_EMPID  ORDER BY a.CHR_EMPID asc "/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Gross</a></span></td>
                </tr>
                <tr>
                  <td width="173" class="boldEleven">15.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="reportTo.jrxml"/>                                        
                      <c:param name="query" value=" SELECT (@c:=@c+1) SNO, a.CHR_EMPID,a.CHR_STAFFNAME,b.CHR_OFFICENAME,c.CHR_COMPANYNAME,d.CHR_BRANCHNAME, a.CHR_EMAILID,a.CHR_MOBILE,a.CHR_TYPE,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REPTO)   FROM com_m_staff a, com_m_office b,com_m_company c,(SELECT @c:=0) t, com_m_branch d WHERE a.INT_OFFICEID= b.INT_OFFICEID AND a.CHR_TYPE!='T' AND a.CHR_HOLD!='Y'   AND a.INT_COMPANYID=c.INT_COMPANYID AND a.INT_BRANCHID=d.INT_BRANCHID   ORDER BY a.CHR_STAFFNAME "/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Reporting To</a></span></td>
                  <td width="173" class="boldEleven">30</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="EmpSummaryRep.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,b.CHR_COMPANYNAME,c.CHR_BRANCHNAME,d.CHR_OFFICENAME,e.CHR_DEPARTNAME,f.CHR_DESIGNAME, a.CHR_GENDER, COUNT(*) FROM com_m_staff a,com_m_company b,com_m_branch c,com_m_office d,(SELECT @c:=0) t, com_m_depart e,com_m_desig f WHERE a.INT_COMPANYID= b.INT_COMPANYID  AND a.INT_BRANCHID=c.INT_BRANCHID AND a.INT_OFFICEID=d.INT_OFFICEID  AND a.INT_DEPARTID= e.INT_DEPARTID AND a.INT_DESIGID = f.INT_DESIGID  AND a.CHR_TYPE !='T' GROUP BY a.INT_COMPANYID,a.INT_BRANCHID,a.INT_OFFICEID,
 a.INT_DEPARTID,a.INT_DESIGID,a.CHR_GENDER  ORDER BY b.CHR_COMPANYNAME,c.CHR_BRANCHNAME,d.CHR_OFFICENAME,e.CHR_DEPARTNAME,  f.CHR_DESIGNAME,a.CHR_GENDER  "/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Employee Summary</a></span></td>
                  <td width="208" class="boldEleven">45.</td>
                  <td width="208"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="OfficeEmpSummary.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,c.CHR_OFFICENAME, a.CHR_GENDER, COUNT(*) FROM com_m_staff a,com_m_office c,(SELECT @c:=0) t   WHERE a.INT_OFFICEID =c.INT_OFFICEID AND a.CHR_TYPE !='T' AND a.CHR_HOLD!='Y'   GROUP BY a.INT_OFFICEID,a.CHR_GENDER ORDER BY c.CHR_OFFICENAME,a.CHR_GENDER  "/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Office Employee Summary</a></span></td>
                </tr>
                <tr>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><c:url value="report1.jsp" var="url">
                    <c:param name="file" value="StaffTransfer.jrxml"/>                  
                    <c:param name="query" value="SELECT (@c:=@c+1) SNO,a.CHR_EMPID ,a.CHR_STAFFNAME, FUN_GET_COMPANY(b.INT_FROM_COMPANYID) fromcompany , FUN_GET_COMPANY(b.INT_TO_COMPANYID) tocompany, FUN_GET_BRANCH(b.INT_FROM_BRANCHID) frombranch, FUN_GET_BRANCH(b.INT_TO_BRANCHID) tobranch, FUN_GET_DEPARTNAME(b.INT_FROM_DEPARTID) fromdepart, FUN_GET_DEPARTNAME(b.INT_TO_DEPARTID) todepart, FUN_GET_DESIGNAME(b.INT_FROM_DESIGID) fromdesig ,
 FUN_GET_DESIGNAME(b.INT_TO_DESIGID) todesig, FUN_GET_OFFICENAME(b.INT_TO_OFFICEID) fromoffice, FUN_GET_OFFICENAME(b.INT_TO_OFFICEID) tooffice, FUN_GET_LOCATION(b.INT_FROM_LOCATIONID) fromlocation, FUN_GET_LOCATION (b.INT_TO_LOCATIONID) tolocation, FUN_GET_CATEGORYNAME(b.INT_FROM_CATEGORY) fromcategory, FUN_GET_CATEGORYNAME(b.INT_TO_CATEGORY) tocategory, IF(b.INT_FROMATTENDANCECYCLE='1','1-31','20th-19th') fromcycle,
 IF(b.INT_ATTENDANCECYCLE='1','1-31','20th-19th') tocycle, FIND_A_EMPLOYEE_ID_NAME(b.CHR_FROM_REPTO) fromreporting, FIND_A_EMPLOYEE_ID_NAME(b.CHR_TO_REPTO) toreporting, DATE_FORMAT(b.DT_TRANSFERDATE,'%d-%b-%Y'), DATE_FORMAT(b.DT_RELEAVINGFROM,'%d-%b-%Y'), b.CHR_REASON  FROM com_m_staff a, pay_m_emp_transfer b,(SELECT @c:=0) t WHERE a.CHR_EMPID =b.CHR_EMPID  ORDER BY a.CHR_STAFFNAME  "/>                  
</c:url></td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven">46</td>
                  <td class="boldEleven"><a href="${url}" target="_blank">Staff Transfer</a></td>
                </tr>
                <tr>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven">&nbsp;</td>
                </tr>
                <tr>
                  <td width="173" class="boldEleven">1.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="chipset.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,chp.CHR_CHIPSET,chp.CHR_DESC FROM  inv_m_chipset chp,(SELECT @c:=0) c ORDER BY chp.CHR_CHIPSET"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">ChipSet</a></span></td>
                  <td width="173" class="boldEleven">10.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="color.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,c.CHR_COLORCODE FROM  inv_m_color c,(SELECT @c:=0) t ORDER BY c.CHR_COLORCODE"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Color</a></span></td>
                  <td width="208" class="boldEleven">19.</td>
                  <td width="208"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="customerGroup.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,cg.CHR_NAME FROM inv_m_customergroup cg,(SELECT @c:=0) c  ORDER BY cg.CHR_NAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">CustomerGroup</a></span></td>
                </tr>
                <tr>
                  <td width="173" class="boldEleven">2.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="CustInformation.jrxml"/>                                        
                      <c:param name="query" value="SELECT  (@c:=@c+1) SNO,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),a.CHR_ALIASNAME, a.CHR_CONTACTPERSON,a.CHR_ADDRESS1,a.CHR_ADDRESS2,a.CHR_ADDRESS3, f.CHR_CITYNAME, e.CHR_DISTRICT,d.CHR_STATENAME, c.CHR_COUNTRYNAME, a.INT_PINCODE,a.CHR_AREACODE,a.CHR_PHONE,a.CHR_MOBILE,a.CHR_FAX,
 a.CHR_EMAIL,a.CHR_WEBSITE,if(a.INT_ACTIVE =1 ,'Active','Inactive'), a.CHR_TIN,a.CHR_CST,b.CHR_NAME  FROM inv_m_customerinfo a,inv_m_customergroup b, com_m_country c, com_m_state d, com_m_district e, com_m_city f, (SELECT @c:=0) count  WHERE a.INT_CUSTOMERGROUPID = b.INT_CUSTOMERGROUPID  AND a.INT_COUNTRYID= c.INT_COUNTRYID
 AND a.INT_STATEID = d.INT_STATEID  AND a.INT_DISTRICTID = e.INT_DISTRICTID  AND a.INT_CITYID = f.INT_CITYID  ORDER BY FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID)"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">CustomerInformation</a></span></td>
                  <td width="173" class="boldEleven">11.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="CustomerType.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,ct.CHR_TYPENAME FROM inv_m_customertype ct,(SELECT @c:=0) c  ORDER BY ct.CHR_TYPENAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">CustomerType</a></span></td>
                  <td width="208" class="boldEleven">20.</td>
                  <td width="208"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="division.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,d.CHR_DIVICODE,lower(d.CHR_EMAILID) FROM  inv_m_division d,(SELECT @c:=0) c ORDER BY d.CHR_DIVICODE"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Division</a></span></td>
                </tr>
                <tr>
                  <td width="173" class="boldEleven">3.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="graphics.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,g.CHR_GRAPHICS,g.CHR_DESC FROM  inv_m_graphics g,(SELECT @c:=0) c ORDER BY g.CHR_GRAPHICS"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Graphics</a></span></td>
                  <td width="173" class="boldEleven">12.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="harddisk.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,h.CHR_HARDDISKNAME,h.CHR_DESC FROM  inv_m_harddisk h,(SELECT @c:=0) c  ORDER BY h.CHR_HARDDISKNAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Harddisk</a></span></td>
                  <td width="208" class="boldEleven">21.</td>
                  <td width="208"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="itemGroup.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,ig.CHR_GROUPNAME FROM  inv_m_itemgroup ig,(SELECT @c:=0) c  ORDER BY ig.CHR_GROUPNAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">ItemGroup</a></span></td>
                </tr>
                <tr>
                  <td width="173" class="boldEleven">4.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="make.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,m.CHR_MAKENAME,m.CHR_DESC FROM  inv_m_make m,(SELECT @c:=0) c  ORDER BY m.CHR_MAKENAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Make</a></span></td>
                  <td width="173" class="boldEleven">13.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="monitor.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,m.CHR_MONITOR,m.CHR_DESC FROM  inv_m_monitor m,(SELECT @c:=0) t  ORDER BY m.CHR_MONITOR"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Monitor</a></span></td>
                  <td width="208" class="boldEleven">22.</td>
                  <td width="208"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="memory.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,m.CHR_MEMORYNAME,m.CHR_DESC FROM  inv_m_memory m,(SELECT @c:=0) c ORDER BY m.CHR_MEMORYNAME"/>                                        
                    </c:url>
                    <a href="${url }" target="_blank">Memory</a></span></td>
                </tr>
                <tr>
                  <td width="173" class="boldEleven">5.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="model.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO, m.CHR_MODELCODE FROM  inv_m_model  m,(SELECT @c:=0) c ORDER BY CHR_MODELCODE"/>                                        
                    </c:url>
                    <a href="${url }" target="_blank">Model</a></span></td>
                  <td width="173" class="boldEleven">14.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="OpticalDrive.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1)SNO, o.CHR_OPTICAL,o.CHR_DESC FROM  inv_m_opticaldrive  o , (SELECT @c:=0) s ORDER BY o.CHR_OPTICAL"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">OpticalDrive</a></span></td>
                  <td width="208" class="boldEleven">23.</td>
                  <td width="208"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="OSystem.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1)SNO, o.INT_OSNAME,o.CHR_DESC FROM  inv_m_operatingsystem o , (SELECT @c:=0) s ORDER BY o.INT_OSNAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">OperatingSystem</a></span></td>
                </tr>
                <tr>
                  <td width="173" class="boldEleven">6.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="payTerms.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@count:=@count+1) SNO,p.CHR_PAYMENTNAME,p.CHR_DES FROM  inv_m_paymentterms p,(SELECT @count:=0)  c ORDER BY p.CHR_PAYMENTNAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">PayTerms</a></span></td>
                  <td width="173" class="boldEleven">15.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="payment_cond.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO, pc.CHR_PAYMENTNAME, pc.CHR_DES  FROM  inv_m_paymentcondition pc,(SELECT @c:=0) c  ORDER BY pc.CHR_PAYMENTNAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">PaymentCondition</a></span></td>
                  <td width="208" class="boldEleven">24.</td>
                  <td width="208"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="pInformation.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,a.CHR_PRODUCTCODE,a.DOU_PURCHASEPRICE,a.DOU_SALESPRICE,a.CHR_PRODUCTDESC,IF(a.INT_ACTIVE= 1, 'Active','Inactive'),IF(a.CHR_PTYPE='F','Full Product', if(a.CHR_PTYPE='C','Combination Product','Consumable Product'))
FROM inv_m_produtlist a, inv_m_productgroup b,(SELECT @c:=0) c WHERE a.INT_PRODUCTGROUPID = b.INT_PRODUCTGROUPID ORDER BY a.CHR_PRODUCTCODE"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">ProductInformation</a></span></td>
                </tr>
                <tr>
                  <td width="173" class="boldEleven">7.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="processor.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,p.CHR_PROCESSORNAME,p.CHR_DESC FROM  inv_m_processor p, (SELECT @c:=0) c  ORDER BY p.CHR_PROCESSORNAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Processor</a></span></td>
                  <td width="173" class="boldEleven">16.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="productGroup.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,pg.CHR_NAME,IF(pg.CHR_CONFIGURATION='Y','Yes','NO') FROM  inv_m_productgroup pg,(SELECT @c:=0) c ORDER BY pg.CHR_NAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">ProductGroup</a></span></td>
                  <td width="208" class="boldEleven">25.</td>
                  <td width="208"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="report1tax_detail.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,t.CHR_TAXNAME,t.DOU_VALUE,t.CHR_DES  FROM  inv_m_tax  t,(SELECT @c:=0) c  ORDER BY t.CHR_TAXNAME"/>                                        
                    </c:url>
                    <a href="${url }" target="_blank">Tax Details</a></span></td>
                </tr>
                <tr>
                  <td width="173" class="boldEleven">8.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="Terms_conditions.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@count:=@count+1) SNO,tc.CHR_CONDITIONNAME,tc.CHR_DES FROM  inv_m_terms_conditions tc,(SELECT @count:=0) c  ORDER BY tc.CHR_CONDITIONNAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">TermsAndConditions</a></span></td>
                  <td width="173" class="boldEleven">17.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="VenderGroup.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,vg.CHR_NAME   FROM  inv_m_vendorsgroup vg, (SELECT @c:=0) c ORDER BY vg.CHR_NAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">VenderGroup</a></span></td>
                  <td width="208" class="boldEleven">26</td>
                  <td width="208"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="venderInfo.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,b.CHR_NAME,CONCAT('CR-',a.INT_VENDORID), a.CHR_VENDORNAME, a.CHR_CONTACTPERSON,a.CHR_ADDRESS1,a.CHR_ADDRESS2, f.CHR_CITYNAME, e.CHR_DISTRICT,d.CHR_STATENAME, c.CHR_COUNTRYNAME, a.INT_PINCODE,a.CHR_AREACODE,a.CHR_PHONE,a.CHR_MOBILE,a.CHR_FAX,a.CHR_EMAIL,a.CHR_WEBSITE,if(a.INT_ACTIVE =1 ,'Active','Inactive'),
 a.CHR_TINNO,a.CHR_CSTNO,a.CHR_PANNO FROM inv_m_vendorsinformation a,inv_m_vendorsgroup b,com_m_country c, com_m_state d, com_m_district e, com_m_city f, (SELECT @c:=0) count  WHERE a.INT_GROUPID = b.INT_GROUPID  AND a.INT_COUNTRYID= c.INT_COUNTRYID AND a.INT_STATEID = d.INT_STATEID  AND a.INT_DISTRICTID = e.INT_DISTRICTID  AND a.INT_CITYID = f.INT_CITYID
 ORDER BY a.CHR_VENDORNAME"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Vender Information</a></span></td>
                </tr>
                <tr>
                  <td width="173" class="boldEleven">9.</td>
                  <td width="173"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="Wireless.jrxml"/>                                        
                      <c:param name="query" value="SELECT (@c:=@c+1) SNO,w.CHR_WIRELESS,w.CHR_DESC FROM  inv_m_wireless w,(SELECT @c:=0) c ORDER BY w.CHR_WIRELESS"/>                                        
                    </c:url>
                    <a href="${url}" target="_blank">Wireless</a></span></td>
                  <td class="boldEleven">18.</td>
                  <td class="boldEleven"><span class="boldEleven">
                    <c:url value="report1.jsp" var="url">
                      <c:param name="file" value="project.jrxml"/>                                        
                      <c:param name="query" value="SELECT(@c:=@c+1) SNO, p.CHR_PROJECTNAME,IF(p.CHR_STATUS='Y','Active','Inactive') Status FROM  inv_m_project  p,(SELECT @c:=0) c ORDER BY p.CHR_PROJECTNAME"/>                                        
</c:url>
                  <a href="${url}" target="_blank">Project</a></span></td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven">&nbsp;</td>
                </tr>
                <tr>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven">&nbsp;</td>
                </tr>
                <tr>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven">&nbsp;</td>
                </tr>
                <tr>
                  <td colspan="6" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
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
