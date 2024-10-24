<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.Attendance.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonFunction"%>

<%
try
{
	
 
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
	  
	$(function() {
		var dates = $( "#transferdate, #releavingdate" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			changeYear: true,
			minDate: -30, maxDate: "+30D" ,showOn: "button",
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
 <script language="JavaScript">
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
   	 	   return true;
   	   }
   	 else{
   	   return false;	  
   	 }
	 }

</script>

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
			 alert(""+Employeetype);
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

<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.style3 {color: #FF0000}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<%
try
{

	String staff =request.getParameter("staffid");
	if(! CommonFunction.RecordExist("SELECT count(*) FROM pay_m_emp_transfer   WHERE CHR_EMPID='"+staff+"' "))
	{
		out.println(" <br><br><br><center><font  class='bolddeepred'>Employee Transfer Record not found....<font></center> <br><br><br> <br><br><br>");
	}
	else
	{
%>
<form  AUTOCOMPLETE = "off"   name="frm" action="../SmartLoginAuth" onSubmit="return validateFields()">
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
		<table width="700" border="0" align="center" cellpadding="0"
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
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr class="boldEleven">
							<td height="20">
							<div align="center"><span class="tabledata">EMPLOYEE TRANSFER </span></div>
							</td>
						</tr>
						<tr>
							<td>
							<div align="right"><span class="boldEleven style3">*
							</span><span class="changePos">Mandatory</span></div>
							</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td></td>
						</tr>

						<tr>
						  <td height="19"><table width="100%" border="0" align="center" cellpadding="2"
								cellspacing="2">
                            <tr>
                              <td align="left" valign="middle"  
										class="boldEleven"><strong>Staff id</strong></td>
                              <td class="boldEleven"><%

String sql ="";

 
sql = " SELECT  a.INT_TRANSFER_ID,a.CHR_EMPID, g.CHR_STAFFNAME, DATE_FORMAT(g.DT_DOJCOLLEGE,'%d-%m-%Y'), b.CHR_COMPANYNAME,c.CHR_BRANCHNAME,d.CHR_DESIGNAME,e.CHR_DEPARTNAME,f.CHR_OFFICENAME,  ";
sql = sql + " a.CHR_REASON,DATE_FORMAT(a.DT_TRANSFERDATE,'%d-%m-%Y'),DATE_FORMAT(a.DT_RELEAVINGFROM,'%d-%m-%Y'),a.CHR_AUTHORITY,h.CHR_CATEGORYNAME ,g.CHR_REPTO,g.CHR_TYPE ,g.INT_LOCATIONID  ";
sql = sql + " FROM pay_m_emp_transfer a ,com_m_company b,com_m_branch c,com_m_desig d,com_m_depart e,com_m_office f ,com_m_staff g ,com_m_employeecategory h";
sql = sql + " WHERE a.INT_FROM_COMPANYID = b.INT_COMPANYID  ";
sql = sql + " AND a.INT_FROM_BRANCHID=c.INT_BRANCHID  ";
sql = sql + " AND a.INT_FROM_DESIGID=d.INT_DESIGID  ";
sql = sql + " AND a.INT_FROM_DEPARTID=e.INT_DEPARTID  ";
sql = sql + " AND a.INT_FROM_OFFICEID=f.INT_OFFICEID AND a.CHR_EMPID = g.CHR_EMPID  AND a.INT_FROM_CATEGORY=h.INT_EMPLOYEECATEGORYID";
sql = sql + " AND a.CHR_EMPID='"+staff+"' ORDER BY a.INT_TRANSFER_ID DESC";
//out.println(sql);
String Datas[][] =  CommonFunctions.QueryExecute(sql);		
String staffname= Datas[0][2];
out.println(staff);

//CHR_EMPLOYEE_FROM,CHR_EMPLOYEE_TO

sql = " SELECT   ";
sql = sql + " INT_TRANSFER_ID,   ";
sql = sql + " INT_FROM_COMPANYID,INT_FROM_BRANCHID,INT_FROM_DEPARTID,INT_FROM_DESIGID,INT_FROM_OFFICEID,  ";
sql = sql + " INT_TO_COMPANYID,INT_TO_BRANCHID,INT_TO_DEPARTID,INT_TO_DESIGID,INT_TO_OFFICEID,  ";
sql = sql + " CHR_REASON,DT_TRANSFERDATE,DT_RELEAVINGFROM,CHR_AUTHORITY,INT_FROM_CATEGORY,INT_TO_CATEGORY, ";
sql = sql + " CHR_FROM_REPTO,CHR_TO_REPTO,CHR_FROM_TYPE,CHR_TO_TYPE,INT_FROM_LOCATIONID,INT_TO_LOCATIONID ,CHR_EMPLOYEE_FROM,CHR_EMPLOYEE_TO ,";
sql = sql + " INT_FROMATTENDANCECYCLE,INT_ATTENDANCECYCLE,CHR_FROM_PFCALCULATIONTYPE,CHR_TO_PFCALCULATIONTYPE ";
sql = sql + " FROM pay_m_emp_transfer WHERE CHR_EMPID='"+staff+"' ORDER BY INT_TRANSFER_ID DESC  ";
//out.println(sql);
String Data[][] =  CommonFunctions.QueryExecute(sql);							

					  %>
                                  <input name="staffid" type="hidden" id="staffid"
										value="<%=staff%>"></td>
                            </tr>
                            <tr>
                              <td align="left" valign="middle"  
										class="boldEleven"><strong>Staff Name</strong></td>
                              <td class="boldEleven"><%=staffname%></td>
                            </tr>
                            <tr>
                              <td class="boldEleven"><strong>Date Of Joining</strong></td>
                              <td class="boldEleven"><%=Datas[0][3]%>
                                  <input name="doj" type="hidden" id="doj" value="<%=Datas[0][3]%>"></td>
                            </tr>
                            <tr>
                              <td colspan="2" class="boldEleven"><table width="100%" border="3" align="center" cellpadding="5" cellspacing="0" bordercolor="#000000">
                                  <tr>
                                    <td width="20%" class="bolddeepred"><div align="center">FROM</div></td>
                                    <td width="28%" class="bolddeepred"><div align="center"></div></td>
                                    <td width="20%" class="bolddeepred"><div align="center">TO</div></td>
                                    <td width="32%" class="bolddeepred"><div align="center"></div></td>
                                  </tr>
                                  <tr>
                                    <td class="boldEleven"><strong>Company</strong></td>
                                    <td class="boldEleven"><%=Datas[0][4]%></td>
                                    <td class="boldEleven"><strong>Company<span class="style3"> *</span></strong></td>
                                    <td><select name="company"  id="company"   style="width:200"   onChange="loadBranch(this)" class="formText135">
                                        <option value="0">Select</option>
                                        <%
                                              String sql1="SELECT INT_COMPANYID,CHR_COMPANYNAME FROM  com_m_company  ORDER BY CHR_COMPANYNAME";
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
                                    <td class="boldEleven"><%=Datas[0][5]%></td>
                                    <td class="boldEleven"><strong>Branch <span class="style3">*</span></strong></td>
                                    <td><div id="description">
									<select name="branch" id="branch" class="formText135"   style="width:200" >
                                  <option value="0">Select</option>
                                  <%
										 
	String bdata[][]= CommonFunctions.QueryExecute("SELECT INT_BRANCHID,CHR_BRANCHNAME FROM  com_m_branch  WHERE INT_COMPANYID="+Data[0][6]+" ORDER BY CHR_BRANCHNAME");
	for(int y=0; y<bdata.length;y++)
		out.println("<option  value='"+bdata[y][0]+"'  >"+bdata[y][1] + "</option>");	
%>
                                
								    
										%>
                                </select>
									
									</div></td>
                                  </tr>
                                  <tr>
                                    <td class="boldEleven"><strong>Designation</strong></td>
                                    <td class="boldEleven"><%=Datas[0][6]%></td>
                                    <td class="boldEleven"><strong>Designation <span class="style3">*</span></strong></td>
                                    <td><select name="desigination" class="formText135"
																		id="desigination"  style="width:200" >
                                        <option value="0">Select</option>
                                        <%
         		String desgdata[][]= CommonFunctions.QueryExecute("SELECT INT_DESIGID,CHR_DESIGNAME FROM  com_m_desig  ORDER BY CHR_DESIGNAME");
			for(int h=0;h<desgdata.length;h++)
				out.print("<option value='"+desgdata[h][0]+"'>"+desgdata[h][1]+"</option>");
			

		
%>
                                    </select></td>
                                  </tr>
                                  <tr>
                                    <td class="boldEleven"><strong>Department</strong></td>
                                    <td class="boldEleven"><%=Datas[0][7]%></td>
                                    <td class="boldEleven"><strong>Department <span class="style3">*</span></strong></td>
                                    <td><select name="department" class="formText135"
																		id="department"  style="width:200" >
                                        <option value="0">Select</option>
                                        <%
      	String depdata[][]= CommonFunctions.QueryExecute("SELECT INT_DEPARTID,CHR_DEPARTNAME FROM  com_m_depart  ORDER BY CHR_DEPARTNAME");
	for(int h=0;h<depdata.length;h++)
		out.print("<option value='"+depdata[h][0]+"'>"+depdata[h][1]+"</option>");

		
%>
                                    </select></td>
                                  </tr>
                                  <tr>
                                    <td class="boldEleven"><strong>Office</strong></td>
                                    <td class="boldEleven"><%=Datas[0][8]%></td>
                                    <td class="boldEleven"><strong>Office <span class="style3">*</span></strong></td>
                                    <td><select name="office" class="formText135" id="office" style="width:200"  onChange="loadLocations(this)">
                                        <option value="0">Select</option>
                                        <%
        String offdata[][]= CommonFunctions.QueryExecute("SELECT INT_OFFICEID,CHR_OFFICENAME FROM   com_m_office   ORDER BY CHR_OFFICENAME");
for(int h=0;h<offdata.length;h++)
	out.print("<option value='"+offdata[h][0]+"'>"+offdata[h][1]+"</option>");

		
%>
                                    </select></td>
                                  </tr>
                                  <tr>
                                    <td class="boldEleven"><strong>Location</strong></td>
                                    <td class="boldEleven"><%= CommonFunctions.QueryExecute(" SELECT CHR_LOCATION FROM  com_m_locations WHERE INT_LOCATIONID ="+Datas[0][16])[0][0]%></td>
                                    <td valign="top"  class="boldEleven"><strong>Location <span class="boldred">*</span></strong></td>
                                    <td valign="top"  class="boldEleven"><select name="location" class="formText135" id="location"  style="width:200" tabindex="21" >
                                      <option value="0">Select location</option>
                                      <%
        String locationdata[][]= CommonFunctions.QueryExecute("SELECT INT_LOCATIONID,CHR_LOCATION FROM   com_m_locations   WHERE INT_OFFICEID = "+Data[0][10] + " ORDER BY CHR_LOCATION ");
if(locationdata.length>0)
	for(int h=0;h<locationdata.length;h++)
		out.print("<option value='"+locationdata[h][0]+"'>"+locationdata[h][1]+"</option>");

		
%>
                          
                                    </select></td>
                                  </tr>
                                  <tr>
                                    <td class="boldEleven"><strong>category</strong></td>
                                    <td><%=Datas[0][13]%>
									
                                    </td>
                                    <td valign="top"  class="boldEleven"><strong>category <span class="style3">*</span></strong></td>
                                    <td valign="top"  class="boldEleven"><select name="category" class="formText135" id="category"  style="width:200"  onChange="loadAttendanceCycle(this)">
                                        <option value="0">Select</option>
                                        <%
	String empcategorysql=" SELECT INT_EMPLOYEECATEGORYID,CHR_CATEGORYNAME  FROM   com_m_employeecategory   ORDER BY CHR_CATEGORYNAME ";
	String empcategoryData[][]= CommonFunctions.QueryExecute(empcategorysql);
	if (empcategoryData.length>0)
		for (int i=0; i<empcategoryData.length; i++) 
			out.println("<option value="+empcategoryData[i][0]+">"+empcategoryData[i][1] +"</option>");			
	
						%>
                                      </select>                                    </td>
                                  </tr>
                                  <tr>
                                    <td class="boldEleven"><strong>Attendance Cycle 
                                      <%
String cdata[][]=CommonFunctions.QueryExecute("SELECT INT_FROM,INT_TO FROM att_m_basicsettings  WHERE INT_ID=1");
%>
                                    </strong></td>
                                    <td class="boldEleven">
									 
                                    <%
									if("1".equals(Data[0][25]))
										out.println("1-31");
									else
										out.println(cdata[0][0]+"th to "+cdata[0][1] +"th");	
									%></td>
                                    <td valign="top"  class="boldEleven"><strong>Attendance Cycle <span class="style3">*</span></strong></td>
                                    <td valign="top"  class="boldEleven"><select name="attendancecycle" id="attendancecycle" class="formText135"  style="width:200" tabindex="30">
                                      <option value="0">Select Attendance Cycle</option>
                                      <option value="1" selected="selected">1-31</option>
                                      <option value="2"><%=cdata[0][0]%>th to <%=cdata[0][1]%>th</option>
                                    </select></td>
                                  </tr>
                                  
                                   <tr>
                                    <td class="boldEleven"><strong>Reporting To </strong></td>
                                    <td><%=Data[0][17]+" / "+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_STAFFNAME FROM com_m_staff WHERE CHR_EMPID='"+Data[0][17]+"'")[0][0]%> </td>
                                    <td valign="top"  class="boldEleven"><strong>Reporting To <span class="style3">*</span></strong></td>
                                    <td valign="top"  class="boldEleven"><select id="repto" name="repto"
																class="formText135"  style="width:200" >
                                        <option value="0">Select</option>
                                        <%
		   String rptodata[][] = CommonFunction.RecordSetArray("select CHR_EMPID,CHR_STAFFNAME from com_m_staff WHERE CHR_TYPE<>'T'  AND CHR_REP='Y' ");
		   for(int c=0;c<rptodata.length;c++)
		   		out.println("<option value='"+rptodata[c][0]+"'>"+rptodata[c][1]+"</option>");
		   %>
                                      </select>                                    </td>
                                  </tr>
                                  
                                   <tr>
                                    <td class="boldEleven"><strong>Staff Type</strong></td>
                                    <td><%=Data[0][19]%> 
                                    </td>
                                    <td valign="top"  class="boldEleven"><strong>Staff Type <span class="style3">*</span></strong></td>
                                    <td valign="top"  class="boldEleven"><select id="stafftype"  style="width:200"  name="stafftype" class="formText135">
                                      <option value="0">Select Staff Type</option>
                                      <%
		   String stafftypedata[][] = CommonFunctions.QueryExecute(" SELECT INT_STAFFTYPEID,CHR_TYPENAME  FROM  com_m_stafftype  ORDER BY CHR_TYPENAME");
		   for(int c=0;c<stafftypedata.length;c++)
		   		out.println("<option value='"+stafftypedata[c][1]+"'>"+stafftypedata[c][1]+"</option>");
		   %>
                                    </select></td>
                                  </tr>
                                  <tr>
                                    <td class="boldEleven"><strong>PF Calculation Type</strong></td>
                                    <td class="boldEleven"> 
                                    <%
									
									String ppfdata[][] = CommonFunctions.QueryExecute("SELECT INT_ROWID,INT_PFMINIMUM_LIMIT,INT_PFMAXIMUM_LIMIT FROM m_pf_setting WHERE INT_ROWID =  "+Data[0][27]);
									if(ppfdata.length>0)
										out.println("Rs."+ppfdata[0][1]+" -  Rs."+ppfdata[0][2]);
									%></td>
                                    <td valign="top"  class="boldEleven"><strong>PF Calculation Type <span class="style3">*</span></strong></td>
                                    <td valign="top"  class="boldEleven"><select name="pfcalculationtype" id="pfcalculationtype" class="formText135"  style="width:170" tabindex="30" >
                                      <%
		   String pfdata[][] =CommonFunctions.QueryExecute("SELECT INT_ROWID,INT_PFMINIMUM_LIMIT,INT_PFMAXIMUM_LIMIT FROM m_pf_setting WHERE CHR_STATUS='Y' ORDER BY INT_ROWID ");
		   for(int c=0;c<pfdata.length;c++)
		   		out.println("<option value='"+pfdata[c][0]+"'>Rs."+pfdata[c][1]+" -  Rs."+pfdata[c][2]+ "</option>");
		   %>
                                    </select></td>
                                  </tr>
                                  <tr>
                                      <td class="boldEleven"><strong>Employee Type </strong></td>
                                      <td class="boldEleven"><%="R".equals(Data[0][23])?"Regular":"Non-Regular"%>
                                      
                                     <input name="rowid" type="hidden" id="rowid" value="<%=Data[0][0]%>">
									<input name="fromcompany" type="hidden" id="fromcompany" value="<%=Data[0][1]%>">
                                    <input name="frombranch" type="hidden" id="frombranch" value="<%=Data[0][2]%>">
                                    <input name="fromdesig" type="hidden" id="fromdesig" value="<%=Data[0][4]%>">
                                    <input name="fromdepart" type="hidden" id="fromdepart" value="<%=Data[0][3]%>">
                                    <input name="fromoffice" type="hidden" id="fromoffice" value="<%=Data[0][5]%>"> 
									<input name="fromcategory" type="hidden" id="fromcategory" value="<%=Data[0][15]%>">                                    			
                                    <input name="fromlocation" type="hidden" id="fromlocation" value="<%=Datas[0][16]%>">
									<input name="fromattendancecycle"   id="fromattendancecycle" type="hidden" value="<%=Data[0][25]%>">
									<input name="fromreportingto" type="hidden" id="fromreportingto" value="<%=Data[0][17]%>">
									<input name="fromstafftype" type="hidden" id="fromstafftype" value="<%=Data[0][19]%>">
									<input name="frompfcalculationtype" type="hidden" id="frompfcalculationtype" value="<%=Data[0][27]%>">
									<input name="fromemployeetype" type="hidden" value="<%=Data[0][23]%>">
                                    
                                    
                                      </td>
                                      <td valign="top"  class="boldEleven"><strong>Employee Type <span class="style3">*</span></strong></td>
                                      <td valign="top"  class="boldEleven"><select name="employeetype" id="employeetype" class="formText135"  style="width:170" tabindex="30">
                  			  <option value="R">Regular</option>
                              <option value="N">Non-Regular</option>
                              </select></td>
                                    </tr>
                                 
                                 
                              </table></td>
                            </tr>
                            <tr>
                              <td width="188" class="boldEleven"><strong>Transfer Order Issued
                                Date <span class="style3">*</span></strong></td>
                              <td width="280" class="boldEleven"><input
										name="transferdate" type="text" class="formText135"
										id="transferdate"  readonly="readonly"  value="<%=Datas[0][10].trim()%>"
										maxlength="10">
                                 </td>
                            </tr>
                            <tr>
                              <td class="boldEleven"><strong>Date Of Relieving.<span class="style3">*</span></strong></td>
                              <td class="boldEleven"><input name="releavingdate"
										type="text" class="formText135" id="releavingdate"
										 readonly="readonly"  value="<%=Datas[0][11].trim()%> " maxlength="11">
                                 </td>
                            </tr>
                            <tr>
                              <td align="left" valign="top"  
												class="boldEleven"><strong>Authorised By<span class="style3">*</span></strong></td>
                              <td><select name="txtauthorised" id="txtauthorised" class="formText135" size="5">
                                  <option value="">Select</option>
                                  <%
										//SELECT CHR_EMPID,CHR_STAFFNAME  FROM com_m_staff WHERE INT_OFFICEID=  "+session.getAttribute("OFFICEID")+"  AND  CHR_HOLD!='Y'  AND CHR_TYPE!='T'  ORDER BY CHR_STAFFNAME
	String empdata[][]= CommonFunctions.QueryExecute("SELECT CHR_EMPID,CHR_STAFFNAME  FROM com_m_staff  WHERE   CHR_HOLD!='Y'  AND CHR_TYPE!='T' AND CHR_REP='Y' ORDER BY CHR_STAFFNAME");
	for(int y=0; y<empdata.length;y++)
		out.println("<option  value='"+empdata[y][0]+"' title='"+empdata[y][0]+"'>"+empdata[y][1]+" / " +empdata[y][0]+ "</option>");	
%>
                                
								    
										%>
                                </select>
								<script language="javascript">setOptionValue('txtauthorised','<%=Datas[0][12]%>')</script>
								<script language="javascript">setOptionValue('company','<%=Data[0][6]%>')</script>
								<script language="javascript">setOptionValue('branch','<%=Data[0][7]%>')</script>
								<script language="javascript">setOptionValue('desigination','<%=Data[0][9]%>')</script>
								<script language="javascript">setOptionValue('department','<%=Data[0][8]%>')</script>
								<script language="javascript">setOptionValue('office','<%=Data[0][10]%>')</script>
								<script language="javascript">setOptionValue('category','<%=Data[0][16]%>')</script>
								<script language="javascript">setOptionValue('repto','<%=Data[0][18]%>')</script>
								<script language="javascript">setOptionValue('stafftype','<%=Data[0][20]%>')</script>
								<script language="javascript">setOptionValue('location','<%=Data[0][22]%>')</script>
                                <script language="javascript">setOptionValue('employeetype','<%=Data[0][24]%>')</script>
								<script language="javascript">setOptionValue('attendancecycle','<%=Data[0][26]%>')</script>
                                <script language="javascript">setOptionValue('pfcalculationtype','<%=Data[0][28]%>')</script> 
								  
                              </td>
                            </tr>
                            <tr>
                              <td align="left" valign="top" class="boldEleven"><strong>Reason<span class="style3">*</span></strong></td>
                              <td class="boldEleven"><textarea name="reason" cols="25"
										rows="5" class="formText135" id="reason"
										onKeyPress="textArea('reason','250')"><%=Datas[0][9]%></textarea></td>
                            </tr>
                          </table></td>
						</tr>

						<tr>
							<td height="19">
							<div align="center"><input name="filename" type="hidden"
								id="filename" value="StaffTransfer" /> <input name="actionS"
								type="hidden" id="actionS" value="PAYStaffTransferUpdate" />  </div>
							</td>
						</tr>
						<tr>
							<td height="19">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input type="submit" name="Submit"  
										id="submit_btn" class="buttonbold14" value="Update" /></td>
									<td width="56"><input type="button" name="submit"  id="submit"
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
		<td height="40"></td>
	</tr>
</table>
<%
		}//else end	  
	}
	catch(NumberFormatException ee)
	{
		
	}		
	catch(Exception e)
	{
		out.println(e.getMessage());
	}
	
%> 
<%@ include file="../footer.jsp"%></form>
<%
}
catch(Exception e)
{
}
%>