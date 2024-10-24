<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<table>
<tr>
<table>
<tr><th>General</th></tr>
<tr>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="AccountInfo.jrxml"/>
<c:param name="query" value="SELECT @count:=@count+1 SNO, a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME, b.CHR_COMPANYNAME,c.CHR_BRANCHNAME, d.CHR_OFFICENAME, e.CHR_DEPARTNAME, f.CHR_DESIGNAME,g.CHR_CATEGORYNAME, a.CHR_GENDER,  DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'), h.CHR_BANKGROUPNAME,a.CHR_IFSC,a.CHR_ACCNO ,
IF(a.CHR_TYPE ='T',CONCAT('RESIGNED',' / ', DATE_FORMAT(a.DAT_RESIGNDATE,'%d-%b-%Y')),'LIVE') FROM  com_m_staff a,com_m_company b,com_m_branch c,com_m_office d, com_m_depart e,com_m_desig f , com_m_employeecategory g , com_m_bankgroup h, (SELECT @count:=0) sno WHERE a.INT_COMPANYID = b.INT_COMPANYID AND a.INT_BRANCHID = c.INT_BRANCHID
AND a.INT_OFFICEID = d.INT_OFFICEID AND a.INT_DEPARTID = e.INT_DEPARTID AND a.CHR_CATEGORY = g.INT_EMPLOYEECATEGORYID AND a.INT_DESIGID = f.INT_DESIGID AND a.CHR_BANK = h.INT_BANKGROUPID"/>
</c:url>

<a href="${url}">AccountInformation</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="AddrProof.jrxml"/>
<c:param name="query" value="SELECT @count:=@count+1 SNO,ap.CHR_PROOFNAME   FROM  com_m_addressproof ap,(SELECT @count:=0) t ORDER BY  ap.CHR_PROOFNAME"/>
</c:url>

<a href="${url }">Address Proof</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="Bank.jrxml"/>
<c:param name="query" value="SELECT @count:=@count+1 SNO, bank.INT_BANKGROUPID,bank.CHR_BANKGROUPNAME,bank.CHR_SHORTNAME FROM com_m_bankgroup bank, (SELECT @count:=0) t  ORDER BY bank.CHR_BANKGROUPNAME"/>
</c:url>

<a href="${url }">Bank</a>
</td>
</tr>

<tr>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="BankBranch.jrxml"/>
<c:param name="query" value="SELECT @count:=@count+1 SNO,  b.CHR_BANKGROUPNAME,b.CHR_SHORTNAME,a.CHR_IFSC,a.CHR_MCR,a.CHR_BRANCHNAME, a.CHR_ADDRESS,a.CHR_CONTACT,a.CHR_CITY,a.CHR_DISTRICT,a.CHR_STATE,a.CHR_COUNRY FROM com_m_bankbranchname a,com_m_bankgroup b,com_m_bank c, (SELECT @count:=0) t
WHERE a.INT_BANKGROUPID= b.INT_BANKGROUPID AND a.CHR_BRANCHNAME=c.CHR_BRANCH"/>
</c:url>

<a href="${url}">Bank Branch</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="BloodGroup.jrxml"/>
<c:param name="query" value="SELECT @count:=@count+1 SNO,bg.CHR_GROUPNAME  FROM  com_m_bloodgroup bg, (SELECT @count:=0) t ORDER BY bg.CHR_GROUPNAME"/>
</c:url>

<a href="${url}">BloodGroup</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="Certification.jrxml"/>
<c:param name="query" value="SELECT @count:=@count+1 SNO,cert.CHR_CERTIFICATIONNAME   FROM  com_m_certification cert,(SELECT @count:=0) t ORDER BY  cert.CHR_CERTIFICATIONNAME"/>
</c:url>

<a href="${url}">Certification</a>
</td>
</tr>
<tr>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="City.jrxml"/>
<c:param name="query" value="SELECT @count:=@count+1 SNO,a.CHR_COUNTRYNAME,b.CHR_STATENAME,c.CHR_DISTRICT,d.CHR_CITYNAME,DECODE(d.CHR_PINCODE,'9865043008') FROM com_m_country a , com_m_state b, com_m_district c, com_m_city d, (SELECT @count:=0) t WHERE a.INT_COUNTRYID =b.INT_COUNTRYID AND b.INT_STATEID = c.INT_STATEID AND d.INT_DISTRICTID = c.INT_DISTRICTID ORDER BY a.CHR_COUNTRYNAME,b.CHR_STATENAME,c.CHR_DISTRICT,d.CHR_CITYNAME"/>
</c:url>
<a href="${url }">City</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="Company.jrxml"/>
<c:param name="query" value="SELECT @count:=@count+1 SNO,a.CHR_COMPANYNAME,a.CHR_LEGALNAME,a.CHR_STREET,e.CHR_CITYNAME,d.CHR_STATENAME ,c.CHR_COUNTRYNAME, CONCAT('PIN :',a.INT_PINCODE), a.CHR_AREACODE,a.CHR_PHONE,a.CHR_FAX,a.CHR_EMAIL,a.CHR_WEBSITE, a.CHR_TNGSTNO,a.CHR_CSTNO,a.CHR_REGNO,a.CHR_TINNO,a.CHR_SERVICETAX, a.CHR_SHORTNAME,
a.CHR_PANNO , a.CHR_PFNUMBER FROM com_m_company a,com_m_country c ,com_m_state d,  com_m_city e , (SELECT @count:=0) t WHERE a.INT_COUNTRYID = c.INT_COUNTRYID AND a.INT_STATEID =d.INT_STATEID AND a.INT_CITYID = e.INT_CITYID ORDER BY a.CHR_COMPANYNAME"/>
</c:url>
<a href="${url}">Company</a>
</td>
<td width="208">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="Country.jrxml"/>
<c:param name="query" value="SELECT @count:=@count+1 SNO,ap.CHR_COUNTRYNAME,ap.CHR_COUNTRYDESC   FROM  com_m_country  ap,(SELECT @count:=0) t ORDER BY  ap.CHR_COUNTRYNAME"/>
</c:url>
<a href="${url}">Country</a>
</td>
</tr>
<tr>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="Department.jrxml"/>
<c:param name="query" value="SELECT @count:=@count+1 SNO,d.CHR_DEPARTNAME,d.CHR_DEPARTDES  FROM  com_m_depart d, (SELECT @count:=0) t ORDER BY d.CHR_DEPARTNAME"/>
</c:url>

<a href="${url}">Department</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="Designation.jrxml"/>
<c:param name="query" value="SELECT @count:=@count+1 SNO,des.CHR_DESIGNAME,des.CHR_DESIGDES  FROM  com_m_desig des, (SELECT @count:=0) t ORDER BY des.CHR_DESIGNAME"/>
</c:url>

<a href="${url}">Designation</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="Dispensary.jrxml"/>
<c:param name="query" value="SELECT @count:=@count+1 SNO,disp.CHR_DESPNAME,disp.CHR_ADDRESS,disp.INT_PINCODE,disp.INT_PHONE   FROM  com_m_dispensary disp, (SELECT @count:=0) t ORDER BY  disp.CHR_DESPNAME"/>
</c:url>

<a href="${url}">Dispensary</a>
</td>
</tr>

<tr>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="District.jrxml"/>
<c:param name="query" value="SELECT @count:=@count+1 SNO, a.CHR_COUNTRYNAME,b.CHR_STATENAME,c.CHR_DISTRICT,c.CHR_DISTRICTDES FROM com_m_country a , com_m_state b, com_m_district c, (SELECT @count:=0) t
WHERE a.INT_COUNTRYID =b.INT_COUNTRYID AND b.INT_STATEID = c.INT_STATEID ORDER BY a.CHR_COUNTRYNAME,b.CHR_STATENAME,c.CHR_DISTRICT"/>
</c:url>
<a href="${url}">District</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="EmpCategeory.jrxml"/>
<c:param name="query" value="SELECT @count:=@count+1 SNO,empcat.CHR_CATEGORYNAME   FROM  com_m_employeecategory empcat,(SELECT @count:=0) t ORDER BY  empcat.CHR_CATEGORYNAME"/>
</c:url>

<a href="${url}">EmployeeCategeory</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="Location.jrxml"/>
<c:param name="query" value="SELECT @count:=@count+1 SNO, a.CHR_LOCATION,b.CHR_OFFICENAME,if(a.CHR_ACTIVE='Y','Active','Inactive')  FROM com_m_locations a , com_m_office b , (SELECT @count:=0) t WHERE a.INT_OFFICEID = b.INT_OFFICEID  ORDER BY a.CHR_LOCATION"/>
</c:url>

<a href="${url }">Location</a>
</td>
</tr>

<tr>
<td  width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="MobileInfo.jrxml"/>
<c:param name="query" value="SELECT @count:=@count+1 SNO,a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,b.CHR_COMPANYNAME,c.CHR_BRANCHNAME, d.CHR_OFFICENAME, e.CHR_DEPARTNAME,f.CHR_DESIGNAME,g.CHR_CATEGORYNAME, a.CHR_GENDER,  DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'),a.CHR_EMAILID, a.CHR_PERMAILID,a.CHR_MOBILE,a.CHR_PPHONE,a.CHR_SPHONE,
IF(a.CHR_TYPE ='T',CONCAT('RESIGNED',' / ', DATE_FORMAT(a.DAT_RESIGNDATE,'%d-%b-%Y')),'LIVE') FROM  com_m_staff a,com_m_company b,com_m_branch c,com_m_office d,com_m_depart e,com_m_desig f , com_m_employeecategory g ,(SELECT @count:=0) sno WHERE a.INT_COMPANYID = b.INT_COMPANYID AND a.INT_BRANCHID = c.INT_BRANCHID AND a.INT_OFFICEID = d.INT_OFFICEID
AND a.INT_DEPARTID = e.INT_DEPARTID AND a.CHR_CATEGORY = g.INT_EMPLOYEECATEGORYID AND a.INT_DESIGID = f.INT_DESIGID"/>
</c:url>

<a href="${url}">MobileInformation</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="Office.jrxml"/>
<c:param name="query" value="SELECT @count:=@count+1 SNO,o.CHR_OFFICENAME,o.CHR_OFFICESHORTNAME,o.CHR_OFFICEDES FROM  com_m_office o, (SELECT @count:=0) t ORDER BY o.CHR_OFFICENAME"/>
</c:url>
<a href="${url }">Office</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="Qualification.jrxml"/>
<c:param name="query" value="SELECT @count:=@count+1 SNO,q.CHR_QUALIFICATIONNAME,q.CHR_QUALIFICATIONDES  FROM  com_m_qualification q, (SELECT @count:=0) t ORDER BY q.CHR_QUALIFICATIONNAME"/>
</c:url>

<a href="${url}">Qualification</a>
</td>
</tr>

<tr>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="StaffType.jrxml"/>
<c:param name="query" value="SELECT @count:=@count+1 SNO, staff.CHR_TYPENAME   FROM  com_m_stafftype staff,(SELECT @count:=0) t ORDER BY  staff.CHR_TYPENAME"/>
</c:url>

<a href="${url}">Staff Type</a>
</td>
<td width="173">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="State.jrxml"/>
<c:param name="query" value="SELECT @count:=@count+1 SNO, a.CHR_COUNTRYNAME,b.CHR_STATENAME,b.CHR_SHORTNAME,b.CHR_STATEDES FROM com_m_country a , com_m_state b,(SELECT (@count:=0)) r
WHERE a.INT_COUNTRYID =b.INT_COUNTRYID ORDER BY b.CHR_STATENAME"/>
</c:url>
<a href="${url}">State</a>
</td>
 <td width="170">
 <a href="letterReport1.jsp">Releaving Letter</a>
 </td> 
</tr>

<tr>
<td width="170">
<a href="formq.jsp">Form Q</a>
</td>
</tr>

</table>
</tr>
<tr>
<table>
<tr><th>Inventory</th></tr>
<tr>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="chipset.jrxml"/>
<c:param name="query" value="SELECT (@c:=@c+1) SNO,chp.CHR_CHIPSET,chp.CHR_DESC FROM  inv_m_chipset chp,(SELECT @c:=0) c ORDER BY chp.CHR_CHIPSET"/>
</c:url>

<a href="${url}">ChipSet</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="color.jrxml"/>
<c:param name="query" value="SELECT (@c:=@c+1) SNO,c.CHR_COLORCODE FROM  inv_m_color c,(SELECT @c:=0) t ORDER BY c.CHR_COLORCODE"/>
</c:url>

<a href="${url}">Color</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="customerGroup.jrxml"/>
<c:param name="query" value="SELECT (@c:=@c+1) SNO,cg.CHR_NAME FROM inv_m_customergroup cg,(SELECT @c:=0) c  ORDER BY cg.CHR_NAME"/>
</c:url>

<a href="${url}">CustomerGroup</a>
</td>

</tr>
<tr>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="CustInformation.jrxml"/>
<c:param name="query" value="SELECT  (@c:=@c+1) SNO,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),a.CHR_ALIASNAME, a.CHR_CONTACTPERSON,a.CHR_ADDRESS1,a.CHR_ADDRESS2,a.CHR_ADDRESS3, f.CHR_CITYNAME, e.CHR_DISTRICT,d.CHR_STATENAME, c.CHR_COUNTRYNAME, a.INT_PINCODE,a.CHR_AREACODE,a.CHR_PHONE,a.CHR_MOBILE,a.CHR_FAX,
 a.CHR_EMAIL,a.CHR_WEBSITE,if(a.INT_ACTIVE =1 ,'Active','Inactive'), a.CHR_TIN,a.CHR_CST,b.CHR_NAME  FROM inv_m_customerinfo a,inv_m_customergroup b, com_m_country c, com_m_state d, com_m_district e, com_m_city f, (SELECT @c:=0) count  WHERE a.INT_CUSTOMERGROUPID = b.INT_CUSTOMERGROUPID  AND a.INT_COUNTRYID= c.INT_COUNTRYID
 AND a.INT_STATEID = d.INT_STATEID  AND a.INT_DISTRICTID = e.INT_DISTRICTID  AND a.INT_CITYID = f.INT_CITYID  ORDER BY FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID)"/>
</c:url>

<a href="${url}">CustomerInformation</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="CustomerType.jrxml"/>
<c:param name="query" value="SELECT (@c:=@c+1) SNO,ct.CHR_TYPENAME FROM inv_m_customertype ct,(SELECT @c:=0) c  ORDER BY ct.CHR_TYPENAME"/>
</c:url>

<a href="${url}">CustomerType</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="division.jrxml"/>
<c:param name="query" value="SELECT (@c:=@c+1) SNO,d.CHR_DIVICODE,lower(d.CHR_EMAILID) FROM  inv_m_division d,(SELECT @c:=0) c ORDER BY d.CHR_DIVICODE"/>
</c:url>

<a href="${url}">Division</a>
</td>
</tr>

<tr>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="graphics.jrxml"/>
<c:param name="query" value="SELECT (@c:=@c+1) SNO,g.CHR_GRAPHICS,g.CHR_DESC FROM  inv_m_graphics g,(SELECT @c:=0) c ORDER BY g.CHR_GRAPHICS"/>
</c:url>

<a href="${url}">Graphics</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="harddisk.jrxml"/>
<c:param name="query" value="SELECT (@c:=@c+1) SNO,h.CHR_HARDDISKNAME,h.CHR_DESC FROM  inv_m_harddisk h,(SELECT @c:=0) c  ORDER BY h.CHR_HARDDISKNAME"/>
</c:url>

<a href="${url}">Harddisk</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="itemGroup.jrxml"/>
<c:param name="query" value="SELECT (@c:=@c+1) SNO,ig.CHR_GROUPNAME FROM  inv_m_itemgroup ig,(SELECT @c:=0) c  ORDER BY ig.CHR_GROUPNAME"/>
</c:url>

<a href="${url}">ItemGroup</a>
</td>
</tr>

<tr>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="make.jrxml"/>
<c:param name="query" value="SELECT (@c:=@c+1) SNO,m.CHR_MAKENAME,m.CHR_DESC FROM  inv_m_make m,(SELECT @c:=0) c  ORDER BY m.CHR_MAKENAME"/>
</c:url>

<a href="${url}">Make</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="monitor.jrxml"/>
<c:param name="query" value="SELECT (@c:=@c+1) SNO,m.CHR_MONITOR,m.CHR_DESC FROM  inv_m_monitor m,(SELECT @c:=0) t  ORDER BY m.CHR_MONITOR"/>
</c:url>

<a href="${url}">Monitor</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="memory.jrxml"/>
<c:param name="query" value="SELECT (@c:=@c+1) SNO,m.CHR_MEMORYNAME,m.CHR_DESC FROM  inv_m_memory m,(SELECT @c:=0) c ORDER BY m.CHR_MEMORYNAME"/>
</c:url>

<a href="${url }">Memory</a>
</td>
</tr>
<tr>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="model.jrxml"/>
<c:param name="query" value="SELECT (@c:=@c+1) SNO, m.CHR_MODELCODE FROM  inv_m_model  m,(SELECT @c:=0) c ORDER BY CHR_MODELCODE"/>
</c:url>

<a href="${url }">Model</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="OpticalDrive.jrxml"/>
<c:param name="query" value="SELECT (@c:=@c+1)SNO, o.CHR_OPTICAL,o.CHR_DESC FROM  inv_m_opticaldrive  o , (SELECT @c:=0) s ORDER BY o.CHR_OPTICAL"/>
</c:url>

<a href="${url}">OpticalDrive</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="OSystem.jrxml"/>
<c:param name="query" value="SELECT (@c:=@c+1)SNO, o.INT_OSNAME,o.CHR_DESC FROM  inv_m_operatingsystem o , (SELECT @c:=0) s ORDER BY o.INT_OSNAME"/>
</c:url>

<a href="${url}">OperatingSystem</a>
</td>
</tr>
<tr>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="payTerms.jrxml"/>
<c:param name="query" value="SELECT (@count:=@count+1) SNO,p.CHR_PAYMENTNAME,p.CHR_DES FROM  inv_m_paymentterms p,(SELECT @count:=0)  c ORDER BY p.CHR_PAYMENTNAME"/>
</c:url>

<a href="${url}">PayTerms</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="payment_cond.jrxml"/>
<c:param name="query" value="SELECT (@c:=@c+1) SNO, pc.CHR_PAYMENTNAME, pc.CHR_DES  FROM  inv_m_paymentcondition pc,(SELECT @c:=0) c  ORDER BY pc.CHR_PAYMENTNAME"/>
</c:url>

<a href="${url}">PaymentCondition</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="pInformation.jrxml"/>
<c:param name="query" value="SELECT (@c:=@c+1) SNO,a.CHR_PRODUCTCODE,a.DOU_PURCHASEPRICE,a.DOU_SALESPRICE,a.CHR_PRODUCTDESC,IF(a.INT_ACTIVE= 1, 'Active','Inactive'),IF(a.CHR_PTYPE='F','Full Product', if(a.CHR_PTYPE='C','Combination Product','Consumable Product'))
FROM inv_m_produtlist a, inv_m_productgroup b,(SELECT @c:=0) c WHERE a.INT_PRODUCTGROUPID = b.INT_PRODUCTGROUPID ORDER BY a.CHR_PRODUCTCODE"/>
</c:url>

<a href="${url}">ProductInformation</a>
</td>
</tr>
<tr>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="processor.jrxml"/>
<c:param name="query" value="SELECT (@c:=@c+1) SNO,p.CHR_PROCESSORNAME,p.CHR_DESC FROM  inv_m_processor p, (SELECT @c:=0) c  ORDER BY p.CHR_PROCESSORNAME"/>
</c:url>

<a href="${url}">Processor</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="productGroup.jrxml"/>
<c:param name="query" value="SELECT (@c:=@c+1) SNO,pg.CHR_NAME,IF(pg.CHR_CONFIGURATION='Y','Yes','NO') FROM  inv_m_productgroup pg,(SELECT @c:=0) c ORDER BY pg.CHR_NAME"/>
</c:url>

<a href="${url}">ProductGroup</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="report1tax_detail.jrxml"/>
<c:param name="query" value="SELECT (@c:=@c+1) SNO,t.CHR_TAXNAME,t.DOU_VALUE,t.CHR_DES  FROM  inv_m_tax  t,(SELECT @c:=0) c  ORDER BY t.CHR_TAXNAME"/>
</c:url>

<a href="${url }">Tax Details</a>
</td>
</tr>
<tr>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="Terms_conditions.jrxml"/>
<c:param name="query" value="SELECT (@count:=@count+1) SNO,tc.CHR_CONDITIONNAME,tc.CHR_DES FROM  inv_m_terms_conditions tc,(SELECT @count:=0) c  ORDER BY tc.CHR_CONDITIONNAME"/>
</c:url>

<a href="${url}">TermsAndConditions</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="VenderGroup.jrxml"/>
<c:param name="query" value="SELECT (@c:=@c+1) SNO,vg.CHR_NAME   FROM  inv_m_vendorsgroup vg, (SELECT @c:=0) c ORDER BY vg.CHR_NAME"/>
</c:url>

<a href="${url}">VenderGroup</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="venderInfo.jrxml"/>
<c:param name="query" value="SELECT (@c:=@c+1) SNO,b.CHR_NAME,CONCAT('CR-',a.INT_VENDORID), a.CHR_VENDORNAME, a.CHR_CONTACTPERSON,a.CHR_ADDRESS1,a.CHR_ADDRESS2, f.CHR_CITYNAME, e.CHR_DISTRICT,d.CHR_STATENAME, c.CHR_COUNTRYNAME, a.INT_PINCODE,a.CHR_AREACODE,a.CHR_PHONE,a.CHR_MOBILE,a.CHR_FAX,a.CHR_EMAIL,a.CHR_WEBSITE,if(a.INT_ACTIVE =1 ,'Active','Inactive'),
 a.CHR_TINNO,a.CHR_CSTNO,a.CHR_PANNO FROM inv_m_vendorsinformation a,inv_m_vendorsgroup b,com_m_country c, com_m_state d, com_m_district e, com_m_city f, (SELECT @c:=0) count  WHERE a.INT_GROUPID = b.INT_GROUPID  AND a.INT_COUNTRYID= c.INT_COUNTRYID AND a.INT_STATEID = d.INT_STATEID  AND a.INT_DISTRICTID = e.INT_DISTRICTID  AND a.INT_CITYID = f.INT_CITYID
 ORDER BY a.CHR_VENDORNAME"/>
</c:url>

<a href="${url}">Vender Information</a>
</td>
</tr>
<tr>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="Wireless.jrxml"/>
<c:param name="query" value="SELECT (@c:=@c+1) SNO,w.CHR_WIRELESS,w.CHR_DESC FROM  inv_m_wireless w,(SELECT @c:=0) c ORDER BY w.CHR_WIRELESS"/>
</c:url>

<a href="${url}">Wireless</a>
</td>
<td width="170">
<c:url value="report1.jsp" var="url">
<c:param name="file" value="project.jrxml"/>
<c:param name="query" value="SELECT(@c:=@c+1) SNO, p.CHR_PROJECTNAME,IF(p.CHR_STATUS='Y','Active','Inactive') Status FROM  inv_m_project  p,(SELECT @c:=0) c ORDER BY p.CHR_PROJECTNAME"/>
</c:url>

<a href="${url}">Project</a>
</td>

</tr>

</table>
</tr>
</table>
</body>
</html>