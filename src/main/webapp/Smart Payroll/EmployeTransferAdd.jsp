<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.*"%>

<%
try
{
	
String dojlock =CommonFunctions.QueryExecute("SELECT if(CHR_FIRSTTIMEAUTOMATE='Y' ,'18250',CHR_DOJLOCK)  FROM M_INSTITUTION  WHERE INT_ID=1")[0][0];

%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>

<html>
<head>

<title> :: PAYROLL ::</title>


 <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
 </style>
 <script language="JavaScript" src="../JavaScript/jquery/jquery-1.7.1.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.core.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.widget.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js" type="text/javascript"></script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
<script>
		
	var d1=new Date();
	var day1=d1.getDate();	
	var dojlock= "<%=dojlock%>";
	 
	$(function() {
		var dates = $( "#transferdate, #releavingdate" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			changeYear: true,
			minDate: -dojlock, maxDate: "+30D" ,showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true,
			onSelect: function( selectedDate ) 
			{
				var option = this.id == "transferdate" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings );
					dates.not( this ).datepicker( "option", option, date );
			}
		});
	}); 
	
 	 
</script>
	
	

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
 <script language="javascript">
function validateFields()
    {
   	 if(
	 	
		  checkNullSelect('company','Select company','0')
		&& checkNullSelect('branch','Select branch','0')
		&& checkNullSelect('desigination','Select desigination','0')
		&& checkNullSelect('department','Select department','0')
		&& checkNullSelect('office','Select office','0')
		&& checkNullSelect('location','Select location','0')
		&& checkNullSelect('category','Select category','0')
		&& checkNullSelect('repto','Select Reporting To','0')
		&& checkNullSelect('stafftype','Select stafftype  ','0')
		&& checkNull('transferdate','Enter Transfer Date') 
		&& checkNull('releavingdate','Enter Releaving Date')
		&& checkNull('txtauthorised','Enter Authorised')
		&& checkNull('reason','Enter Reason') 
		)
   	  {   	
	  		if(confirm("Confirm, All the informations are correct") == true) 	
   	 	   		return true;
			else
				return false;	
   	   }
   	 else{
   	   return false;	  
   	 }
	 }
</script>



<script language="javascript">


 
function loadAttendanceCycle(ctr)
{
   	if(ctr.value !="0")
	{
		var url = "../SmartCommonAjax?actionS=loadAttendanceCycle&startLetter=0&categoryid="+ctr.value;
		initRequest(url);
		req.onreadystatechange = loadAttendanceCycleRequest;
    	req.open("GET", url, true);
    	req.send(null);
	}
	else
	{
		alert("Kindly select employeee category");
		ctr.focus();
		
	}
		
}

function loadAttendanceCycleRequest() 
{
    if(req.readyState == 4) 
    {    
        
       var _targ=document.getElementsByName('attendancecycle')[0];       
	   _targ.options.length=0;	
       _targ.options[0]=new Option('Select Attendance Cycle','0');       
        if (req.status == 200) 
        {
        	loadAttendanceCycleDetails();
        }
    }
}


function loadAttendanceCycleDetails() 
{
	try
	{
		var batchs = req.responseXML.getElementsByTagName("Rowss")[0];      
		var _targ=document.getElementsByName('attendancecycle')[0];       
		 _targ.options.length=0;
		 _targ.options[0]=new Option('Select Attendance Cycle','0');
		 for (loop = 0; loop < batchs.childNodes.length; loop++) 
		 {
			var batch = batchs.childNodes[loop];
			var Cycle = batch.getElementsByTagName("Cycle")[0].childNodes[0].nodeValue;
			var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
			var Calculation = batch.getElementsByTagName("Calculation")[0].childNodes[0].nodeValue;
			var Employeetype = batch.getElementsByTagName("Employeetype")[0].childNodes[0].nodeValue;
			_targ.options[loop+1]=new Option(Cycle,Id);
			 setOptionValue('pfcalculationtype',Calculation);
			 setOptionValue('employeetype',Employeetype);
			 setOptionValue('attendancecycle',Id);
		  }
		_targ.options.length=loop+1;
		_targ.selectedIndex=1;
	}
	catch(err)
	{
		alert(err);
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


<script language="javascript">
 function loadLocations(ctr)
{
   	var url = "../SmartCommonAjax?actionS=loadlocation&startLetter=0&officeid="+ctr.value;
	initRequest(url);
	req.onreadystatechange =loadLocationsRequest;
    req.open("GET", url, true);
    req.send(null);
}

function loadLocationsRequest() 
{
    if(req.readyState == 4) 
    {    
        
       var _targ=document.getElementsByName('location')[0];       
	   _targ.options.length=0;	
       _targ.options[0]=new Option('Select location','0');       
        if (req.status == 200) 
        {
        	loadLocationsDetails();
        }
    }
}

function loadLocationsDetails() 
{
	try
	{
		var batchs = req.responseXML.getElementsByTagName("Rowss")[0];      
		var _targ=document.getElementsByName('location')[0];       
		 _targ.options.length=0;
		 _targ.options[0]=new Option('Select location','0');
		 for (loop = 0; loop < batchs.childNodes.length; loop++) 
		 {
			var batch = batchs.childNodes[loop];
			var locationname = batch.getElementsByTagName("locationname")[0];
			var Id = batch.getElementsByTagName("Id")[0];
			_targ.options[loop+1]=new Option(locationname.childNodes[0].nodeValue,Id.childNodes[0].nodeValue);
		  }
		_targ.options.length=loop+1;
		_targ.selectedIndex=0;
	}
	catch(err)
	{
		alert(err);
	}
}  


//loadBranch
function loadBranch(ctr)
{
   	var url = "../SmartCommonAjax?actionS=loadBranch&startLetter=0&companyid="+ctr.value;
	initRequest(url);
	req.onreadystatechange =loadBranchRequest;
    req.open("GET", url, true);
    req.send(null);
}

function loadBranchs(ctr)
{
   	var url = "../SmartCommonAjax?actionS=loadBranch&startLetter=0&companyid="+document.getElementById(ctr).value;
	initRequest(url);
	req.onreadystatechange =loadBranchRequest;
    req.open("GET", url, true);
    req.send(null);
}

function loadBranchRequest() 
{
    if(req.readyState == 4) 
    {    
        
       var _targ=document.getElementsByName('branch')[0];       
	   _targ.options.length=0;	
       _targ.options[0]=new Option('Select Branch','0');       
        if (req.status == 200) 
        {
        	loadBranchDetails();
        }
    }
}

function loadBranchDetails() 
{
	try
	{
		var batchs = req.responseXML.getElementsByTagName("branches")[0];      
		var _targ=document.getElementsByName('branch')[0];       
		 _targ.options.length=0;
		 _targ.options[0]=new Option('Select Branch','0');
		 for (loop = 0; loop < batchs.childNodes.length; loop++) 
		 {
			var batch = batchs.childNodes[loop];
			var name = batch.getElementsByTagName("branchName")[0].childNodes[0].nodeValue;
			var Id = batch.getElementsByTagName("id")[0].childNodes[0].nodeValue;
			_targ.options[loop+1]=new Option(name,Id);
		  }
		_targ.options.length=loop+1;
		_targ.selectedIndex=0;
	}
	catch(err)
	{
		alert(err);
	}
}  


</script>
 
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="EmployeTransfer" action="../SmartLoginAuth" onSubmit="return validateFields()">
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="2">
	<tr>
		<td></td>
	</tr>

	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="54">
		<table width="563" border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block"></td>
					<td width="549" valign="top">
					<table width="700" border="0" cellspacing="0" cellpadding="0">
						<tr class="boldEleven">
							<td height="20" colspan="2">
							<div align="center" class="tabledata">EMPLOYEE TRANSFER </div>
							</td>
						</tr>
						<tr>
							<td colspan="2">
							<div align="right"><span class="bolddeepred">*</span>
							Mandatory</div>
							</td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>

						<tr>
							<td width="49%" height="19">&nbsp;</td>
							<td width="51%">&nbsp;</td>
						</tr>
						<tr>
							<td height="19" colspan="2">&nbsp;</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<table width="100%" border="0" align="center" cellpadding="2"
								cellspacing="2">
								<tr>
									<td align="left" valign="middle"  
										class="boldEleven"><strong>Staff id</strong></td>
									<td class="boldEleven">
									<%
String staff =request.getParameter("staffid");

String sql ="";
sql = " SELECT  A.CHR_EMPID, A.CHR_STAFFNAME,  E.CHR_COMPANYNAME,B.CHR_BRANCHNAME,D.CHR_DESIGNAME,C.CHR_DEPARTNAME,F.CHR_OFFICENAME,DATE_FORMAT(A.DT_DOJCOLLEGE,'%d-%m-%Y'),G.CHR_CATEGORYNAME ,A.CHR_REPTO,A.CHR_TYPE,A.INT_LOCATIONID,A.INT_ATTENDANCECYCLE,A.CHR_PFCALCULATIONTYPE, CONCAT('Type - ',A.CHR_PFCALCULATIONTYPE)  "; 
sql = sql + " from  com_m_staff  A, com_m_branch  B,    com_m_depart   C, com_m_desig  D, com_m_company  E  ,com_m_office F,com_m_employeecategory G   ";
sql = sql + " where A.INT_BRANCHID=B.INT_BRANCHID   ";
sql = sql + " AND A.INT_COMPANYID =E.INT_COMPANYID  AND A.INT_DEPARTID=C.INT_DEPARTID   ";
sql = sql + " AND A.INT_DESIGID=D.INT_DESIGID     ";
sql = sql + " AND A.CHR_TYPE!='T' AND A.CHR_HOLD!='Y'    ";
sql = sql + " AND A.INT_OFFICEID = F.INT_OFFICEID  AND A.CHR_CATEGORY=G.INT_EMPLOYEECATEGORYID"; 
sql = sql + " AND  A.CHR_EMPID='"+staff+"'  ";
//out.println(sql);
String Datas[][] =  CommonFunctions.QueryExecute(sql);		

sql = " SELECT  A.CHR_EMPID, A.CHR_STAFFNAME,  E.INT_COMPANYID,B.INT_BRANCHID,D.INT_DESIGID,C.INT_DEPARTID,F.INT_OFFICEID,DATE_FORMAT(A.DT_DOJCOLLEGE,'%d-%m-%Y'),A.CHR_TYPE,A.CHR_CATEGORY ,A.CHR_EMPLOYEE "; 
sql = sql + " from  com_m_staff  A, com_m_branch  B,    com_m_depart   C, com_m_desig  D, com_m_company  E  ,com_m_office F   ";
sql = sql + " where A.INT_BRANCHID=B.INT_BRANCHID   ";
sql = sql + " AND A.INT_COMPANYID =E.INT_COMPANYID  AND A.INT_DEPARTID=C.INT_DEPARTID   ";
sql = sql + " AND A.INT_DESIGID=D.INT_DESIGID     ";
sql = sql + " AND A.CHR_TYPE!='T' AND A.CHR_HOLD!='Y'    ";
sql = sql + " AND A.INT_OFFICEID = F.INT_OFFICEID  "; 
sql = sql + " AND  A.CHR_EMPID='"+staff+"'  ";
String Data[][] =  CommonFunctions.QueryExecute(sql);							
						String staffname= Datas[0][1];
						out.println(staff);
					  %> <input name="staffid" type="hidden" id="staffid"
										value="<%=staff%>"></td>
								</tr>
								<tr>
									<td align="left" valign="middle"  
										class="boldEleven"><strong>Staff Name</strong></td>
									<td class="boldEleven"><%=staffname%></td>
								</tr>
								<tr>
								  <td class="boldEleven"><strong>Date Of Joining</strong></td>
								  <td class="boldEleven"><%=Datas[0][7]%>
                                    <input name="doj" type="hidden" id="doj" value="<%=Datas[0][7]%>"></td>
							  </tr>
								<tr>
								  <td colspan="2" class="boldEleven"><table width="100%" border="3" align="center" cellpadding="5" cellspacing="0" bordercolor="#000000">
                                    <tr>
                                      <td colspan="2" class="bolddeepred"><div align="center"><strong>FROM</strong></div>                                        <div align="center"></div></td>
                                      <td colspan="2" class="bolddeepred"><div align="center"><strong>TO</strong></div>                                        <div align="center"></div></td>
                                    </tr>
                                    <tr>
                                      <td width="18%" class="boldEleven"><strong>Company</strong></td>
                                      <td width="23%" class="boldEleven"><input name="fromcompany" type="hidden" id="fromcompany" value="<%=Data[0][2]%>"><%=Datas[0][2]%></td>
                                      <td width="25%" class="boldEleven"><strong>Company <span class="boldred">*</span></strong></td>
                                      <td width="34%"><select name="company"  id="company"  onChange="loadBranch(this)" class="formText135" style="width:200">
                                        <option value="0">Select Company</option>
                                        <%
                                              String sql1="SELECT INT_COMPANYID,CHR_COMPANYNAME FROM  com_m_company  WHERE INT_ACTIVE=1  ORDER BY CHR_COMPANYNAME";
                                              String company[][]= CommonFunctions.QueryExecute(sql1);
                                              for(int i=0;i<company.length;i++){
                                            	  out.println("<option value="+company[i][0]+">"+company[i][1]+"</option>");		
                                              }
                                            %>
                                      </select>	
									  
									  
									  							  </td>
                                    </tr>
                                    <tr>
                                      <td class="boldEleven"><strong>Branch</strong></td>
                                      <td class="boldEleven"><input name="frombranch" type="hidden" id="frombranch" value="<%=Data[0][3]%>"><%=Datas[0][3]%></td>
                                      <td class="boldEleven"><strong>Branch <span class="boldred">*</span></strong></td>
                                      <td>
                                      <select name="branch" class="formText135" id="branch"  style="width:200" tabindex="21" >
                                        <option value="0">Select Branch</option>
										
										<%
sql1="SELECT INT_BRANCHID,UPPER(CHR_BRANCHNAME) FROM com_m_branch  WHERE INT_ACTIVE =1 AND INT_COMPANYID = "+Data[0][2]+" ORDER BY CHR_BRANCHNAME ";
String b[][]= CommonFunctions.QueryExecute(sql1);
for(int i=0;i<b.length;i++){
  out.println("<option value="+b[i][0]+">"+b[i][1]+"</option>");		
}
											  
											 %> 


                                      </select>
                                      <div id="descriptionss"></div></td>
                                    </tr>
                                    <tr>
                                      <td class="boldEleven"><strong>Designation</strong></td>
                                      <td class="boldEleven"><input name="fromdesig" type="hidden" id="fromdesig" value="<%=Data[0][4]%>"><%=Datas[0][4]%></td>
                                      <td class="boldEleven"><strong>Designation <span class="boldred">*</span></strong></td>
                                      <td><select name="desigination" class="formText135" id="desigination" style="width:200">
                                        <option value="0">Select Designation</option>
                                        <%
         		String desgdata[][]= CommonFunctions.QueryExecute("SELECT INT_DESIGID,CHR_DESIGNAME FROM  com_m_desig  WHERE CHR_STATUS ='Y' ORDER BY CHR_DESIGNAME");
			for(int h=0;h<desgdata.length;h++)
				out.print("<option value='"+desgdata[h][0]+"'>"+desgdata[h][1]+"</option>");
			

		
%>
                                      </select></td>
                                    </tr>
                                    <tr>
                                      <td class="boldEleven"><strong>Department</strong></td>
                                      <td class="boldEleven"><input name="fromdepart" type="hidden" id="fromdepart" value="<%=Data[0][5]%>"><%=Datas[0][5]%></td>
                                      <td class="boldEleven"><strong>Department <span class="boldred">*</span></strong></td>
                                      <td><select name="department" class="formText135"
																		id="department" style="width:200">
                                        <option value="0">Select Department</option>
                                        <%
      	String depdata[][]= CommonFunctions.QueryExecute("SELECT INT_DEPARTID,CHR_DEPARTNAME FROM  com_m_depart    WHERE CHR_STATUS ='Y'  ORDER BY CHR_DEPARTNAME");
	for(int h=0;h<depdata.length;h++)
		out.print("<option value='"+depdata[h][0]+"'>"+depdata[h][1]+"</option>");

		
%>
                                      </select></td>
                                    </tr>
                                    <tr>
                                      <td class="boldEleven"><strong>Office</strong></td>
                                      <td class="boldEleven"><input name="fromoffice" type="hidden" id="fromoffice" value="<%=Data[0][6]%>"><%=Datas[0][6]%></td>
                                      <td class="boldEleven"><strong>Office <span class="boldred">*</span></strong></td>
                                      <td><select name="office" class="formText135" id="office" style="width:200"  onChange="loadLocations(this)">
                                        <option value="0">Select Office</option>
                                        <%
        String offdata[][]= CommonFunctions.QueryExecute("SELECT INT_OFFICEID,CHR_OFFICENAME FROM   com_m_office    WHERE CHR_STATUS ='Y'  ORDER BY CHR_OFFICENAME");
for(int h=0;h<offdata.length;h++)
	out.print("<option value='"+offdata[h][0]+"'>"+offdata[h][1]+"</option>");

		
%>
                                      </select></td>
                                    </tr>
                                    <tr>
                                      <td class="boldEleven"><strong>Location</strong></td>
                                      <td class="boldEleven"><input name="fromlocation" type="hidden" id="fromlocation" value="<%=Datas[0][11]%>">
                                      <%= CommonFunctions.QueryExecute(" SELECT CHR_LOCATION FROM  com_m_locations WHERE INT_LOCATIONID ="+Datas[0][11])[0][0]%></td>
                                      <td valign="top"  class="boldEleven"><strong>Location  <span class="boldred">*</span></strong></td>
                                      <td valign="top"  class="boldEleven"><select name="location" class="formText135" id="location"  style="width:200" tabindex="21" >
                                        <option value="0">Select location</option>
										
										<%
sql1="SELECT INT_LOCATIONID,UPPER(CHR_LOCATION) FROM com_m_locations  WHERE CHR_ACTIVE =1  AND INT_OFFICEID = "+Data[0][6]+" ORDER BY CHR_LOCATION ";
String l[][]= CommonFunctions.QueryExecute(sql1);
for(int i=0;i<l.length;i++){
  out.println("<option value="+l[i][0]+">"+l[i][1]+"</option>");		
}
											  
											 %> 
                                      </select></td>
                                    </tr>
                                    <tr>
                                      <td class="boldEleven"><strong>category</strong></td>
                                      <td class="boldEleven"><input name="fromcategory" type="hidden" id="fromcategory" value="<%=Data[0][9]%>">
                                          <%=Datas[0][8]%></td>
                                      <td valign="top"  class="boldEleven"><strong>category <span class="boldred">*</span></strong></td>
                                      <td valign="top"  class="boldEleven">
									   <select name="category" class="formText135" id="category" style="width:200" onChange="loadAttendanceCycle(this)">
	<option value="0">Select category</option>
	<%
	String empcategorysql=" SELECT INT_EMPLOYEECATEGORYID,CHR_CATEGORYNAME  FROM   com_m_employeecategory   ORDER BY CHR_CATEGORYNAME ";
	String empcategoryData[][]=CommonFunctions.QueryExecute(empcategorysql);
	if (empcategoryData.length>0)
		for (int i=0; i<empcategoryData.length; i++) 
			out.println("<option value="+empcategoryData[i][0]+">"+empcategoryData[i][1] +"</option>");			
	
						%>
</select>									  </td>
                                    </tr>
                                    <tr>
                                      <td class="boldEleven"><strong>Attendance Cycle
                                        <%
String cdata[][]=CommonFunctions.QueryExecute("SELECT INT_FROM,INT_TO FROM att_m_basicsettings  WHERE INT_ID=1");
%>
                                      </strong></td>
                                      <td class="boldEleven">
									  
									  <%="1".equals(Datas[0][12])?" 1-31" : (cdata[0][0] +"th -" +cdata[0][1]+"-th") %>
									  <input name="fromattendancecycle"   id="fromattendancecycle" type="hidden" value="<%=Datas[0][12]%>">
									  </td>
                                      <td valign="top"  class="boldEleven"><strong>Attendance Cycle
                                           
                                      </strong></td>
                                      <td valign="top"  class="boldEleven"><select name="attendancecycle" id="attendancecycle" class="formText135"  style="width:200" tabindex="30">
                                        <option value="0">Select Attendance Cycle</option>
                                        <option value="1" selected="selected">1-31</option>
                                        <option value="2"><%=cdata[0][0]%>th to <%=cdata[0][1]%>th</option>
                                      </select></td>
                                    </tr>
                                    <tr>
                                      <td class="boldEleven"><strong>Reporting To </strong></td>
                                      <td class="boldEleven"><input name="fromreportingto" type="hidden" id="fromreportingto" value="<%=Datas[0][9]%>">
									   
									 <%=Datas[0][9]+" / "+CommonFunctions.QueryExecute("SELECT CHR_STAFFNAME FROM com_m_staff WHERE CHR_EMPID='"+Datas[0][9]+"'")[0][0]%></td>
                                      <td valign="top"  class="boldEleven"><strong>Reporting To <span class="boldred">*</span></strong></td>
                                      <td valign="top"  class="boldEleven">
									  <select id="repto" name="repto"
																class="formText135" style="width:200">
																<option value="0">Select Reporting to</option>
																<%
		   String rptodata[][] =CommonFunction.RecordSetArray("select CHR_EMPID,CHR_STAFFNAME from com_m_staff WHERE CHR_TYPE<>'T'  AND CHR_REP='Y' ");
		   for(int c=0;c<rptodata.length;c++)
		   		out.println("<option value='"+rptodata[c][0]+"'>"+rptodata[c][1]+"</option>");
		   %>
										</select>									  </td>
                                    </tr>
                                    <tr>
                                      <td class="boldEleven"><strong>Staff Type</strong></td>
                                      <td class="boldEleven"><input name="fromstafftype" type="hidden" id="fromstafftype" value="<%=Data[0][8]%>">
                                        <%=Datas[0][10]%></td>
                                      <td valign="top"  class="boldEleven"><strong>Staff Type <span class="boldred">*</span></strong></td>
                                      <td valign="top"  class="boldEleven">
									  <select id="stafftype" name="stafftype" class="formText135"  style="width:200">
                                        <option value="0">Select Staff Type</option>
                                        <%
		   String stafftypedata[][] =CommonFunctions.QueryExecute(" SELECT INT_STAFFTYPEID,CHR_TYPENAME  FROM  com_m_stafftype  ORDER BY CHR_TYPENAME");
		   for(int c=0;c<stafftypedata.length;c++)
		   		out.println("<option value='"+stafftypedata[c][1]+"'>"+stafftypedata[c][1]+"</option>");
		   %>
                                      </select></td>
                                    </tr>
                                    <tr>
                                      <td class="boldEleven"><strong>Employee Type</strong></td>
                                      <td class="boldEleven"><%="R".equals(Data[0][10])?"Regular":"Non-Regular"%>
                                      <input name="fromemployeetype" type="hidden" value="<%=Data[0][10]%>">
                                      </td>
                                      <td valign="top"  class="boldEleven"><strong>Employee Type</strong></td>
                                      <td valign="top"  class="boldEleven"><select name="employeetype" id="employeetype" class="formText135"  style="width:170" tabindex="30">
                  			  <option value="R">Regular</option>
                              <option value="N">Non-Regular</option>
                              </select></td>
                                    </tr>
                                    <tr>
                                      <td class="boldEleven"><strong>PF Calculation Type</strong></td>
                                      <td class="boldEleven">
									  
									  
									  <input name="frompfcalculationtype" type="hidden" id="frompfcalculationtype" value="<%=Datas[0][13]%>"><%=Datas[0][14]%></td>
                                      <td valign="top"  class="boldEleven"><strong>PF Calculation Type <span class="boldred">*</span></strong></td>
                                      <td valign="top"  class="boldEleven"><select name="pfcalculationtype" id="pfcalculationtype" class="formText135"  style="width:170" tabindex="30" >
                                        <%
		   String pfdata[][] =CommonFunctions.QueryExecute("SELECT INT_ROWID,INT_PFMINIMUM_LIMIT,INT_PFMAXIMUM_LIMIT FROM m_pf_setting WHERE CHR_STATUS='Y' ORDER BY INT_ROWID ");
		   for(int c=0;c<pfdata.length;c++)
		   		out.println("<option value='"+pfdata[c][0]+"'>Rs."+pfdata[c][1]+" -  Rs."+pfdata[c][2]+ "</option>");
		   %>
                                      </select>
									  <script language="javascript">
									  setOptionValue('company','<%=Data[0][2]%>');
									  setOptionValue('desigination','<%=Data[0][4]%>');
									  setOptionValue('department','<%=Data[0][5]%>');
									  setOptionValue('office','<%=Data[0][6]%>');
									  setOptionValue('location','<%=Datas[0][11]%>');
									  setOptionValue('category','<%=Data[0][9]%>');
									  setOptionValue('attendancecycle','<%=Datas[0][12]%>');
									  setOptionValue('repto','<%=Datas[0][9]%>');
									  setOptionValue('stafftype','<%=Data[0][8]%>');
									  setOptionValue('branch','<%=Data[0][3]%>');
									  setOptionValue('pfcalculationtype','<%=Datas[0][13]%>');
									   setOptionValue('employeetype','<%=Data[0][10]%>');
									  </script> </td>
                                    </tr>
                                  </table></td>
							  </tr>
								<tr>
									<td width="188" class="boldEleven"><strong>Transfer Order Issued
									Date<span class="boldred"> *</span></strong></td>
									<td width="280" class="boldEleven"><input
										name="transferdate" type="text" class="formText135"
										id="transferdate"  value=" "
										maxlength="10" readonly ><script language="javascript">setCurrentDate('transferdate')</script>  </td>
								</tr>
								<tr>
									<td class="boldEleven"><strong>Date Of Relieving.<span class="boldred"> *</span></strong></td>
									<td class="boldEleven"><input name="releavingdate"
										type="text" class="formText135" id="releavingdate"
										  readonly="readonly"  value=" " maxlength="10">
                                          <script language="javascript">setCurrentDate('releavingdate')</script> 
									 </td>
								</tr>
								<tr>
                                  <td align="left" valign="top"  
												class="boldEleven"><strong>Authorised By <span class="boldred">*</span></strong></td>
								  <td><select name="txtauthorised" id="txtauthorised" class="formText135" size="5">
                                      <option value="">Select</option>
                                      <%
										//SELECT CHR_EMPID,CHR_STAFFNAME  FROM com_m_staff WHERE INT_OFFICEID=  "+session.getAttribute("OFFICEID")+"  AND  CHR_HOLD!='Y'  AND CHR_TYPE!='T'  ORDER BY CHR_STAFFNAME
	String empdata[][]=CommonFunctions.QueryExecute("SELECT CHR_EMPID,CHR_STAFFNAME  FROM com_m_staff  WHERE   CHR_HOLD!='Y'  AND CHR_TYPE!='T' AND CHR_REP='Y' ORDER BY CHR_STAFFNAME");
	for(int y=0; y<empdata.length;y++)
		out.println("<option  value='"+empdata[y][0]+"' title='"+empdata[y][0]+"'>"+empdata[y][1]+" / " +empdata[y][0]+ "</option>");	
%>
								    
										%>
                                    </select>                                  </td>
							  </tr>
								<tr>
									<td align="left" valign="top" class="boldEleven"><strong>Reason <span class="boldred">*</span><span class="style4"></span></strong></td>
									<td class="boldEleven"><textarea name="reason" cols="25"
										rows="5" class="formText135" id="reason"
										onKeyPress="textArea('reason','250')"></textarea></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<div align="center"><input name="filename" type="hidden"
								id="filename" value="StaffTransfer" /> <input name="actionS"
								type="hidden" id="actionS" value="PAYStaffTransferAdd" />  </div>
							</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input type="submit" name="Submit"
										id="submit_btn" class="buttonbold14" value="Transfer" /></td>
									<td width="56"><input type="button" name="submit"
										class="buttonbold14"  value="Close"   accesskey="c" 
										onClick="redirect('EmployeTransfer.jsp')" /></td> 
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="6"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block"></td>
					<td colspan="2" rowspan="2" valign="bottom">
					<div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div>
					</td>
				</tr>
				<tr>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>
		</td>
	</tr>
	<tr>
		<td height="23">&nbsp;</td>
	</tr>
	<tr>
		<td height="40">&nbsp;</td>
	</tr>
</table>
</form>
<%@ include file="../footer.jsp"%>


<%
}
catch(Exception e)
{
}
%>