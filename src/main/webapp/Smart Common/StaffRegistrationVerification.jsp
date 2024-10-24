<%@ page import="java.sql.*,java.io.*,com.my.org.erp.bean.Attendance.StaffRegistration,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonFunction"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%@ page import="java.io.*,java.util.*,com.my.org.erp.common.*"%>
<%-- <%@ page import="sun.net.smtp.SmtpClient"%> --%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>
<%!
	Connection con ;
	PreparedStatement pstm;
	ResultSet rst;
	String userid;
%>
<%
try
{
String sql = "";
String dojlock =CommonFunctions.QueryExecute("SELECT CHR_DOJLOCK FROM M_INSTITUTION  WHERE INT_ID=1")[0][0];
String staffid=""+request.getParameter("staffid");
boolean rflag=false;
if( CommonFunction.RecordExist("SELECT COUNT(*) FROM com_m_staff WHERE CHR_TYPE='T' AND CHR_EMPID='"+staffid+"'"))
{
	rflag=true;
%>
<script language="javascript">
	alert("This is Resigned Staff details ");

</script>

<%

}


 
 
String dbvalue="";
String value="";
String dbvalue1="";

String staffsql="";
staffsql = " ";
staffsql = staffsql +" ";
staffsql = staffsql +" SELECT FUN_GET_COMPANY_NAME(INT_COMPANYID),FUN_GET_BRANCH_NAME(INT_BRANCHID),  ";
staffsql = staffsql +" CHR_EMPID,CHR_STAFFNAME,CHR_STAFFFNAME,  ";
staffsql = staffsql +" FUN_GET_DEPARTMENT_NAME(INT_DEPARTID), FUN_GET_DESIGNATION_NAME(INT_DESIGID),  ";
staffsql = staffsql +" FUN_GET_OFFICE_NAME(INT_OFFICEID), CHR_GENDER,DATE_FORMAT(DT_DOB,'%d-%m-%Y'),  ";
staffsql = staffsql +" CHR_BG, DATE_FORMAT(DT_DOJCOLLEGE,'%d-%m-%Y'),  INT_BALANCE,CHR_TYPE,  ";
staffsql = staffsql +" INT_SALARY,CHR_PF,CHR_ESI,INT_GROSSSALARY,CHR_MARITALSTATUS,   ";
staffsql = staffsql +" DATE_FORMAT(DT_WEDDATE,'%d-%m-%Y'), CHR_BANK,CHR_ACCNO,  ";
staffsql = staffsql +" CHR_PADD1,CHR_PADD2,CHR_PCITY,CHR_PSTATE,CHR_PPIN,CHR_SADD1,CHR_SADD2,  ";
staffsql = staffsql +" CHR_SCITY, CHR_SSTATE,CHR_SPIN,CHR_PPHONE,CHR_SPHONE,CHR_EMAILID,CHR_MOBILE,  ";
staffsql = staffsql +" CHR_PFTYPE,INT_PFAMT, CHR_PFNO,CHR_ESITYPE,INT_ESIAMT,CHR_ESINO,CHR_LEAVECARRY,  ";
staffsql = staffsql +" CHR_QUALIFICATION,CHR_MANAGEMENT, FIND_A_EMPLOYEE_ID_NAME(CHR_REPTO),CHR_REP,CHR_HOLD,INT_PLACEID,  ";
staffsql = staffsql +" CHR_CONVEYANCECLEAR,CHR_SALARYCALCULATE,CHR_PAYSLIPHIDE, CHR_CATEGORY,CHR_USERID,   ";
staffsql = staffsql +" DATE_FORMAT(DAT_PFESIDATE,'%d-%m-%Y'),DATE_FORMAT(DAT_RESIGNDATE,'%d-%m-%Y'),   ";
staffsql = staffsql +" CHR_PAN,CHR_PASSPORT,CHR_DRIVING, CHR_PERMAILID,CHR_PREVIOUSDETAILS,  ";
staffsql = staffsql +" CHR_MOTHERNAME,CHR_COMPANYPFNO,CHR_ADDRESSSTATUS, CHR_FUTURE10,INT_PDISTRICTID,  ";
staffsql = staffsql +" INT_PCOUNTRYID,INT_CDISTRICTID,INT_CCOUNTRY,CHR_ADDRESSPROOFSTATUS, CHR_PFCLAIMSTATUS,  ";
staffsql = staffsql +" DATE_FORMAT(DAT_PFCLIAMDATE,'%d-%m-%Y'),CHR_PFCLIAMDESCRIPTION,   ";
staffsql = staffsql +" DATE_FORMAT(DAT_PFRESIGNDATE,'%d-%m-%Y'),CHR_INTERVIEW,   ";
staffsql = staffsql +" CHR_REJOIN,CHR_NOMINEE,CHR_SALARYSPLITUP,DATE_FORMAT(DT_CREATION_DATE,'%d-%m-%Y'),  ";
staffsql = staffsql +" CHR_CREATEDBY, DATE_FORMAT(DAT_RIVISION,'%d-%m-%Y'), INT_CTC,INT_GROSS_PERCENT,  ";
staffsql = staffsql +" INT_VARIABLE_PERCENT,CHR_IFSC,INT_ATTENDANCECYCLE,CHR_SALARYTYPE,  ";
staffsql = staffsql +" FUN_GET_LOCATION_NAME(INT_LOCATIONID),CHR_NOMINEE_RELATIONSHIP,CHR_SPOUSENAME ,  ";
staffsql = staffsql +" DATE_FORMAT(DT_ACTUAL_DOB,'%d-%m-%Y'),";
staffsql = staffsql +" FUN_GET_ADDRESS(CHR_EMPID,'P','<br>'), ";
staffsql = staffsql +" FUN_GET_ADDRESS(CHR_EMPID,'C','<br>'),  ";
staffsql = staffsql +" FUN_PAY_GET_PF_CALCULATION(CHR_EMPID,INT_SALARY,CHR_PFCALCULATIONTYPE), ";
staffsql = staffsql +" FUN_GET_ESIAMOUNT('STAFF',CHR_ESI,FUN_PAY_GET_ORIGINAL_GROSS(CHR_EMPID) ), ";
staffsql = staffsql +" FUN_GET_ESIAMOUNT('CPY',CHR_ESI,FUN_PAY_GET_ORIGINAL_GROSS(CHR_EMPID) ),  "; 
staffsql = staffsql +" FIND_A_INSTITUTION_NAME(),CONCAT('Type-',CHR_PFCALCULATIONTYPE),  "; 
staffsql = staffsql +" FUN_PAY_GET_ORIGINAL_PROFESSIONAL_TAX_AMOUNTS(CHR_EMPID,FUN_PAY_GET_ORIGINAL_GROSS(CHR_EMPID)  ),CHR_AADHARNO ";
staffsql = staffsql +" FROM com_m_staff WHERE CHR_EMPID='"+staffid+"'  ";
//out.println(staffsql);
String staffData[][]= CommonFunctions.QueryExecute(staffsql);
 

%>
<html>
<head>

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
 
  <title> :: COMMON ::</title>


 



<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
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

</head>
 <jsp:include page="index.jsp" flush="true" />
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  onselectstart="return false" onpaste="return false;"  onCut="return false" onDrag="return false" onDrop="return false" autocomplete="off">

<form  AUTOCOMPLETE = "off"   name="a" method="post" action="../SmartLoginAuth" onSubmit="return validateFields()">


<table width="100%" border="0">
	<tr>
		<td class="boldEleven">	  </td>
	</tr>
	<tr>
	  <td height="59">&nbsp;</td>
    </tr>
	<tr>
		<td height="59"><table width="80%" border="0" align="center" cellpadding="2" cellspacing="2" class="formTableOuterDesign">
  <tr>
    <td class="whiteHead"><div align="center">STAFF REGISTRATION VERIFICATION </div></td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td bgcolor="#FFFFFF" class="formTableInnerDesign"> <table width="99%" border="0" cellspacing="0" cellpadding="0">

      <tr>
        <td colspan="2"><div align="right"><span class="errormessage"> * </span><span
										class="changePos">Mandatory</span></div></td>
      </tr>
      <tr>
        <td colspan="2"></td>
      </tr>
      <tr>
        <td height="19" colspan="2"><fieldset>
          <legend><strong><img src="../images/icon-misuse.gif"> Official Informations</strong></legend>
          <table width="100%"  align="center" cellpadding="0"
										cellspacing="0" >
            <tr>
              <td height="290"><table width="100%" border="0" align="center" cellpadding="2"
												cellspacing="2">
                  <tr>
                    <td valign="top"><table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2"  
														class="boldEleven">
                        <tr>
                          <td colspan="2">&nbsp;</td>
                        </tr>
                        <tr>
                          <td colspan="2"><div align="center"><span class="tabledata"><strong>Personal
                            Informations </strong></span></div></td>
                        </tr>
                        <tr>
                          <td width="129">&nbsp;</td>
                          <td width="170">&nbsp;</td>
                        </tr>
                        <tr>
                          <td class="boldEleven"> Staff Id <font class="errormessage"
																align="absmiddle">&nbsp; </font></td>
                          <td class="errormessage"><b><%=staffData[0][2]%>
                            <div id="userIdMessage"></div></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Staff Name<font class="errormessage" align="absmiddle">&nbsp; </font></td>
                          <td class="errormessage"><%=staffData[0][3]%></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Father Name</td>
                          <td class="errormessage"><%=staffData[0][4]%></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Mother Name<font class="errormessage" align="absmiddle">&nbsp; </font></td>
                          <td class="errormessage"><%=staffData[0][61]%></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Gender
                            <%
										
												
									String grd="";
									String grd1="";
									 
										 
										   %>                          </td>
                          <td class="errormessage"> 
						  <%=staffData[0][8]%>						  </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Blood Group <font class="errormessage"
																align="absmiddle">&nbsp; </font></td>
                          <td class="errormessage">
						 <%
						  
						String bgdata[][]=CommonFunctions.QueryExecute( " SELECT  CHR_GROUPNAME FROM com_m_bloodgroup  WHERE INT_BLOODGROUPID = "+staffData[0][10]);
						if(bgdata.length>0) 
							out.println(bgdata[0][0]);
						 %>		                            </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Date Of Birth <font class="errormessage"
																align="absmiddle">&nbsp; </font> </td>
                          <td class="errormessage"><%=staffData[0][9] %>                          </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Actual Date Of Birth </td>
                          <td class="errormessage"><%=staffData[0][90] %> </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Date Of Join <font class="errormessage"
																align="absmiddle">&nbsp;</font></td>
                          <td class="errormessage"><span class="errormessage"><%=staffData[0][11] %>
                             
                           </span></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Marital  Status
                            <%
									grd="";
									grd1="";
							 
									if("M".equals(staffData[0][18] ))
										grd ="checked='checked' ";
									
									if("U".equals(staffData[0][18] ))
										grd1 ="checked='checked' ";
												
									
									
										%>                          </td>
                          <td class="errormessage"> <%="M".equals(staffData[0][18])?"Married":"Unmarried"%></td>
                        </tr>
                        <tr id="cwd">
                          <td class="boldEleven">Wedding Date </td>
                          <td class="errormessage"><%=staffData[0][19] %> </td>
                        </tr>
                        <tr  id="cwd1">
                          <td valign="top" class="boldEleven">Spouse Name <font class="errormessage"
																align="absmiddle">&nbsp;</font></td>
                          <td valign="top" class="errormessage"><%=staffData[0][89]%> </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Off. E-mail </td>
                          <td class="errormessage"><%=staffData[0][34] %> </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Per. E-mail <font class="errormessage"
																align="absmiddle">&nbsp; </font> </td>
                          <td class="errormessage"><%=staffData[0][59] %> 
                              <div id='emaildiv'></div></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Mobile </td>
                          <td class="errormessage"><%=staffData[0][35] %>  </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Qualifications <font class="errormessage"
																align="absmiddle">&nbsp; </font> </td>
                          <td class="errormessage"> 
                              <%
										String ssql=" SELECT  CHR_QUALIFICATIONNAME FROM com_m_qualification  WHERE INT_QUALIFICATIONID = "+staffData[0][43]+" ORDER BY CHR_QUALIFICATIONNAME";
										String qualdata[][]=CommonFunctions.QueryExecute(ssql);
										if(qualdata.length>0) 
											out.println(qualdata[0][0]);
									%>                             </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Reporting to<font
																class="errormessage" align="absmiddle">&nbsp; </font></td>
                          <td class="errormessage"><%=staffData[0][45]%> </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Category <font class="errormessage"
																align="absmiddle">&nbsp; </font></td>
                          <td class="errormessage"><%= CommonFunctions.QueryExecute(" SELECT CHR_CATEGORYNAME FROM  com_m_employeecategory where INT_EMPLOYEECATEGORYID="+staffData[0][52])[0][0]%> </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Attendance Cycle
                            <%
String cdata[][]=CommonFunctions.QueryExecute("SELECT INT_FROM,INT_TO FROM att_m_basicsettings  WHERE INT_ID=1");
%>
                              <font
																class="errormessage" align="absmiddle">&nbsp; </font></td>
                          <td class="errormessage"><%="1".equals(staffData[0][85])?" 1-31" : (cdata[0][0] +"th -" +cdata[0][1]+"-th") %>
                              <input name="attendancecycle"   id="attendancecycle" type="hidden" value="<%=staffData[0][85]%>">                          </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Salary Type <font
																class="errormessage" align="absmiddle">&nbsp; </font></td>
                          <td class="boldEleven">
						  <%
						  if("CTC".equals(staffData[0][86]))
						  	out.println("CTC - Based");
						  else 	if("MTH".equals(staffData[0][86]))
						  	out.println("MONTH - Based");
						  else
						  	out.println("Working Days (Daily Wages) - Based");
						  %>						                            </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">PF Calculation Type</td>
                          <td class="boldEleven"><strong><%=staffData[0][97]%></strong></td>
                        </tr>
                    </table></td>
                    <td class="boldEleven"><table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="3" bordercolor="#D4D0C8"
														class="boldEleven">
                        <tr>
                          <td colspan="5">&nbsp;</td>
                        </tr>
                        <tr>
                          <td colspan="5"><div align="center"><span class="tabledata"><strong>Official
                            Details</strong></span></div></td>
                        </tr>
                        <tr>
                          <td width="125" class="boldEleven">Company<font
																class="errormessage" align="absmiddle">&nbsp; </font></td>
                          <td colspan="4" class="errormessage"><%=staffData[0][0]%> </td>
                        </tr>
                        <tr>
                          <td width="125" class="boldEleven">Branch<font
																class="errormessage" align="absmiddle">&nbsp; </font></td>
                          <td colspan="4" class="errormessage"><%=staffData[0][1]%> </td>
                        </tr>
                        <tr>
                          <td   class="boldEleven">Office<font
																class="errormessage" align="absmiddle">&nbsp; </font></td>
                          <td colspan="4" class="errormessage"><%=staffData[0][7]%> </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Location</td>
                          <td colspan="4" class="errormessage"><%=staffData[0][87]%> </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Department<font class="errormessage"
																align="absmiddle">&nbsp; </font></td>
                          <td colspan="4" class="errormessage"><%=staffData[0][5]%> </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Designation<font class="errormessage"
																align="absmiddle">&nbsp; </font><font class="redcol style3"
																align="absmiddle">&nbsp;</font></td>
                          <td colspan="4" class="errormessage"><%=staffData[0][6]%> </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Type <font class="errormessage"
																align="absmiddle">&nbsp; </font></td>
                          <td colspan="4" class="errormessage"><%



 out.println("<input type='hidden'  name='stype'   id='stype' value='"+staffData[0][13]+"'><font class='errormessage'> "+staffData[0][13]+"  </font>");
%>                          </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Salary Split up
                            <script language="javascript">


function basicdisable()
{
	bid.style.visibility="hidden";
	document.getElementById('basic').value="0";
}
	
	 
function basicenable()
{
	document.getElementById('basic').value="0";
	bid.style.visibility="visible";
} 


                                                            </script></td>
                          <td colspan="4" class="errormessage"><%
														  if("A".equals(staffData[0][77]))
														  	out.println("Automatic");
														  else if("M".equals(staffData[0][77]))
														  	out.println("Manual");
														  else 	
														  	out.println("");
														  %>
                              <input name="salarysplitupby" type="hidden" value="<%=staffData[0][77]%>">                          </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Basic Salary </td>
                          <td colspan="4" class="errormessage"><%=staffData[0][14]%></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Splitup Gross </td>
                          <td colspan="4" class="errormessage"><%=staffData[0][17]%>
                              <%
String salaryData[][] = CommonFunctions.QueryExecute(" SELECT INT_STARTINGSALARY,INT_ENDINGSALARY FROM  pay_m_salaryband  ORDER BY INT_SALARYBANDID ");
	String lvalue="";
	for(int x=0; x<salaryData.length;x++)
	{
		for(int y=0; y<2;y++)
		{
			lvalue = lvalue+salaryData[x][y]+",";
		}
		lvalue = lvalue+"~";	
	}
	
	
	
	String stafftypeDatas[][] = CommonFunctions.QueryExecute(" SELECT  CHR_TYPENAME,CHR_FLAG FROM com_m_stafftype  ORDER BY CHR_TYPENAME ");
	String svalue="";
	for(int x=0; x<stafftypeDatas.length;x++)
	{
		for(int y=0; y<2;y++)
		{
			svalue = svalue+stafftypeDatas[x][y]+",";
		}
		svalue = svalue+"~";	
	}
	
	
%>
                              <script language="javascript">
	var salarybandvalue = "<%=lvalue%>";
	var salarybandvalue1 =salarybandvalue.split("~");
	var f= false;
	function checkSalaryBand()
	{
		var gross =document.getElementById("gross").value;
		for(i=0; i<salarybandvalue1.length-1; i++)
 		{
   			 var v = salarybandvalue1[i].split(",")
			 var gt = parseInt(v[0]);
			 var lt = parseInt(v[1]);
			 if((gross >gt) &&(gross <=lt))
			 	f = true; 
			 
   		}
		if(f)
			return true;
		else
		{
			alert("Your gross not in Salary Slab....");
			document.getElementById("gross").focus();
			return false;
		}	
	}
	
	
	var f1 =false;
	function checkSalaryType()
	{
		var salarytypevalue = "<%=svalue%>";
		var salarytypevalue1 =salarytypevalue.split("~");
		var type =document.getElementById("type").value;
		f1 =false;
		for(i=0; i<salarytypevalue1.length-1; i++)
 		{
   			 var v = salarytypevalue1[i].split(",")
			 var name =  (v[0]);
			 var status =  (v[1]);
			 if((type === name) &&(status ==="Y"))
			 	f1 = true; 
		}
		
		return f1;
		
	}
	
	
      </script>                          </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Bank Name </td>
                          <td colspan="4" class="errormessage"><input name="bank" id="bank" type="hidden" value="<%=staffData[0][20]%>">
                              <font class='errormessage'><%=CommonFunctions.QueryExecute("SELECT INT_BANKGROUPID, CHR_BANKGROUPNAME  FROM com_m_bankgroup WHERE INT_BANKGROUPID = "+staffData[0][20]+" ORDER BY CHR_BANKGROUPNAME")[0][1]%> </font></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Account No </td>
                          <td colspan="4" class="errormessage"><input name="number"  type="hidden" class="formText135" id="no" value="<%=staffData[0][21]%>"  size="30" maxlength="25"  onkeyup=" checkAccounts(this) "/>
                              <script language="javascript">
 
function checkAccounts(ctr)
{
	try
	{
		
		document.getElementById('submit_btn').disabled=false;	
		var v = ctr.value;
		v = v.toUpperCase();
		v = v.replace('','');
		var f = ( ( v !="") && (v != "DD") );
		
		if( f)
			LoadUniqueCheck('no', 'acc', 'com_m_staff', 'CHR_ACCNO', 'submit_btn')
		else
		{
			document.getElementById('submit_btn').disabled=false;	
			document.getElementById('acc').innerHTML=""; 
		}
	}
	catch(err)
	{
		alert(err);
	}			
	
}


      </script>
                              <div id="acc"></div>
                            <font class='errormessage'><%=staffData[0][21]%> </font> </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">IFSC CODE </td>
                          <td colspan="4" class="errormessage"><script language="javascript">
 function ifsccodefill(thisValue) 
{
	 document.getElementById('ifsccode').value=thisValue;
	
	 
	setTimeout("$('#ifsccode1').hide();", 200);
}

function ifsccodelookup(inputString) 
{
	if(checkNullSelect('bank','Select Bank','0'))
	{
		var bank = document.getElementById('bank').value;
		if(inputString.length == 0) 
		{
			$('#ifsccode1').hide();
		} 
		else 
		{
			$.post("ifsccode.jsp?bank="+bank, {queryString: ""+inputString+" "  }, function(data)
			{
				if(data.length >0) 
				{
					$('#ifsccode1').show();
					$('#ifsccodeList1').html(data);
				}
			});
		}	
	}
	
	
}
    </script>
                              <style type="text/css">
 

.ifsccodeBox1 
{
	position: relative;
	margin: 0px 0px 0px 0px;
	width: 200px;
	background-color: #ffffff;
	-moz-border-radius: 7px;
	-webkit-border-radius: 7px;
	border: 1px solid #000;
	color: #000;
}
.ifsccodeList1 
{
	margin: 0px;
	padding: 0px;
}
.ifsccodeList1 li 
{
	margin: 0px 0px 3px 0px;
	padding: 3px;
	cursor: pointer;
}

.ifsccodeList1 li:hover {
background-color: #ffffff;
}
      </style>
                              <input name="ifsccode" type="hidden"	class="formText135" id="ifsccode"  size="30"    onBlur="ifsccodefill('0');" 											maxlength="20"  tabindex="29" onKeyUp="ifsccodelookup(this.value);" value="<%=staffData[0][84]%>"/>
                              <div class="ifsccodeBox1" id="ifsccode1" style="display: none;width:250%;">
                                <div class="ifsccodeList1" id="ifsccodeList1" style="OVERFLOW:auto;width:100%;height:200px" ></div>
                              </div>
                            <font class='errormessage'><%=staffData[0][84]%> </font></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Leave Carry                                    </td>
                          <td class="errormessage">
						  <%="Y".equals(staffData[0][42])?"Yes":"NO"%>						  </td>
                          <td class="boldEleven">&nbsp;</td>
                          <td class="boldEleven">Interview                            </td>
                          <td class="errormessage">  <%="Y".equals(staffData[0][74])?"Yes":"NO"%></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Management                                    </td>
                          <td class="errormessage"> <%="Y".equals(staffData[0][44])?"Yes":"NO"%></td>
                          <td class="boldEleven">&nbsp;</td>
                          <td class="boldEleven">Payslip hide                            </td>
                          <td class="errormessage"> <%="Y".equals(staffData[0][51])?"Yes":"NO"%></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Reporting Head                                    </td>
                          <td width="22" class="errormessage"> <%="Y".equals(staffData[0][46])?"Yes":"NO"%></td>
                          <td width="16" class="boldEleven">&nbsp;</td>
                          <td width="129" class="boldEleven">Conveyance clear                            </td>
                          <td width="66" class="errormessage"> <%="Y".equals(staffData[0][49])?"Yes":"NO"%></td>
                        </tr>
                        <tr>
                          <td class="boldEleven"><span class="boldEleven">Staff Holding
                            
                          </span></td>
                          <td class="errormessage"> <%="Y".equals(staffData[0][47])?"Yes":"NO"%></td>
                          <td class="errormessage">&nbsp;</td>
                          <td class="boldEleven">Salary Calculation                            </td>
                          <td class="errormessage"> <%="Y".equals(staffData[0][50])?"Yes":"NO"%></td>
                        </tr>
                        <tr>
                          <td class="boldEleven"></td>
                          <td class="errormessage">&nbsp;</td>
                          <td colspan="2" class="errormessage">&nbsp;</td>
                          <td class="boldEleven">&nbsp;</td>
                        </tr>
                        <tr>
                          <td class="boldEleven"></td>
                          <td class="errormessage"><input   name="rejoin"  type="hidden"
																id="rejoin" value="<%=staffData[0][75]%>"  ></td>
                          <td colspan="2" class="errormessage">&nbsp;</td>
                          <td class="boldEleven">&nbsp;</td>
                        </tr>
                    </table></td>
                  </tr>
              </table></td>
            </tr>
          </table>
        </fieldset></td>
      </tr>
      <tr>
        <td height="19" colspan="2">&nbsp;</td>
      </tr>
      <tr>
        <td height="19" colspan="2">&nbsp;</td>
      </tr>
      <tr>
        <td height="19" colspan="2"><fieldset>
          <legend><strong><img src="../images/icon-misuse.gif"> Contact Informations</strong> </legend>
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td colspan="3" align="center"><div align="center" class="bold1"> Permanent
                Address</div></td>
              <td colspan="3" align="center"><div align="center" class="bold1">Communication
                Address</div></td>
            </tr>
            <tr>
              <td width="11%" class="errormessage"><div align="left"></div></td>
              <td width="25%" class="errormessage"><%=staffData[0][91]%></td>
              <td width="10%" class="errormessage">&nbsp;</td>
              <td width="11%" class="errormessage"><div align="left"></div></td>
              <td width="34%" class="errormessage"><%=staffData[0][92]%></td>
              <td width="9%" class="errormessage">&nbsp;</td>
            </tr>
          </table>
          <br>
          </fieldset></td>
      </tr>
      <tr>
        <td width="49%" height="19">&nbsp;</td>
        <td width="51%">&nbsp;</td>
      </tr>
      <tr>
        <td height="19" colspan="2"><fieldset>
          <legend ><strong><img src="../images/icon-misuse.gif">&nbsp;&nbsp;PF & ESI Informations&nbsp;&nbsp;</strong> </legend>
          <table width="100%"   align="center" cellpadding="0"
										cellspacing="0" >
            <tr>
              <td height="185"><table width="100%" border="0" align="center" cellpadding="2"
												cellspacing="2">
                  <tr>
                    <td width="49%" height="167" colspan="2"><table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
                        <tr>
                          <td colspan="2" class="boldEleven"><div align="center"><span class="tabledata"><strong>PF</strong></span></div></td>
                        </tr>
                        <tr>
                          <input type="hidden" name="hidpf" id="hidpf"
																value="<%=staffData[0][13]%>">
                          <td width="101" class="boldEleven">PF <font class="errormessage"
																align="absmiddle">&nbsp;</font></td>
                          <td width="156" class="errormessage"><%
	if("Y".equals(staffData[0][15]))
		out.println("Yes");
	else if("N".equals(staffData[0][15]))
		out.println("No");
	else if("C".equals(staffData[0][15]))
		out.println("Common");
	else
		out.println("-");	
		
	
%>
                              <input name="pf" id="pf" type="hidden" value="<%=staffData[0][15]%>">                          </td>
                        </tr>
                        <tr id="pf0">
                          <td class="boldEleven">PF TYPE </td>
                          <td class="errormessage"><%
	if("A".equals(staffData[0][36]))
		out.println("Amount");
	else if("P".equals(staffData[0][36]))
		out.println("Percentage");
	else
		out.println("-");	
		
	
%>
                              <input name="optpf" id="optpf" type="hidden" value="<%=staffData[0][36]%>">                          </td>
                        </tr>
                        <tr id="pf1">
                          <td class="boldEleven">PF Number
                            <%
									dbvalue=staffData[0][38];
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>                          </td>
                          <td class="errormessage"><input name="txtpfno" id="txtpfno" type="hidden" value="<%=dbvalue%>">
                              <%=dbvalue%> </td>
                        </tr>
                        <tr id='pf2'>
                          <td class='boldEleven'>PF Amount
                            <%
									dbvalue=staffData[0][37];
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase("0.00"))
										dbvalue="";
									%>                          </td>
                          <td class='errormessage'><input name="txtpfvalue" id="txtpfvalue" type="hidden" value="<%=dbvalue%>">
                              <%=dbvalue%> </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">PF Nominee </td>
                          <td class="errormessage"><input name="nominee" id="nominee" type="hidden" value="<%=staffData[0][76] %>">
                              <%=staffData[0][76] %> </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Relationship</td>
                          <td class="errormessage"><%
	if("F".equals(staffData[0][88]))
		out.println("Father");
	else if("M".equals(staffData[0][88]))
		out.println("Mother");
	else if("W".equals(staffData[0][88]))
		out.println("wife");
	else if("H".equals(staffData[0][88]))
		out.println("Husband");
	else if("G".equals(staffData[0][88]))
		out.println("Guardian");
	else if("S".equals(staffData[0][88]))
		out.println("Son");
	else if("D".equals(staffData[0][88]))
		out.println("Daugther");
	else
		out.println("-");	
%>
                              <input name="pfnomineerelationship" id="pfnomineerelationship" type="hidden" value="<%=staffData[0][88]%>">                          </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">&nbsp;</td>
                          <td class="errormessage">&nbsp;</td>
                        </tr>
                    </table></td>
                    <td width="51%" colspan="2"><table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
                        <tr>
                          <td height="21" colspan="2" class="boldEleven"><div align="center"><span class="tabledata"><strong> ESI</strong></span></div></td>
                        </tr>
                        <tr>
                          <td width="107" height="21" class="boldEleven">ESI <font class="errormessage"
																align="absmiddle">&nbsp;</font></td>
                          <td width="161" class="errormessage"><%
	if("Y".equals(staffData[0][16]))
		out.println("Yes");
	else if("N".equals(staffData[0][16]))
		out.println("No");
	else if("C".equals(staffData[0][16]))
		out.println("Common");
	else
		out.println("-");	
%>
                              <input name="esi" id="esi" type="hidden" value="<%=staffData[0][16]%>">                          </td>
                        </tr>
                        <tr id="ppf0">
                          <td height="21" class="boldEleven">ESI TYPE </td>
                          <td class="errormessage"><%
	if("A".equals(staffData[0][39]))
		out.println("Amount");
	else if("P".equals(staffData[0][39]))
		out.println("Percentage");
	else
		out.println("-");	
		
	
%>
                              <input name="optesi" id="optesi" type="hidden" value="<%=staffData[0][39]%>">                          </td>
                        </tr>
                        <tr id="ppf1">
                          <td class="boldEleven">ESI Number </td>
                          <td class="errormessage"><input name="txtesno" id="txtesno" type="hidden" value="<%=staffData[0][41]%>">
                              <%=staffData[0][41]%> </td>
                        </tr>
                        <tr id="ppf2">
                          <td class="boldEleven">ESI Amount
                            <%
									dbvalue=staffData[0][40];
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase("0.00"))
										dbvalue="";
									%>                          </td>
                          <td class="errormessage"><input name="txtesivalue" id="txtesivalue" type="hidden" value="<%=dbvalue%>">
                              <%=dbvalue%> </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Dispensary</td>
                          <td class="errormessage"><%
		   String Disdata[][] =CommonFunctions.QueryExecute("Select INT_DESPID,CHR_DESPNAME From com_m_dispensary WHERE INT_DESPID = "+staffData[0][48]+ " order by INT_DESPID ");
		    if(Disdata.length>0)
				out.println( Disdata[0][1]);
			
		   %>
                              <input name="dispensary" id="dispensary" type="hidden" value="<%=staffData[0][48]%>">                          </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">&nbsp;</td>
                          <td class="errormessage">&nbsp;</td>
                        </tr>
                        <tr>
                          <td class="boldEleven">&nbsp;</td>
                          <td class="errormessage">&nbsp;</td>
                        </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td colspan="2" class="boldEleven">&nbsp;</td>
                    <td colspan="2" class="boldEleven">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="boldEleven">Date of Reivision<font
																class="errormessage" align="absmiddle">&nbsp; </font> </td>
                    <td class="errormessage"><%=staffData[0][80]%> </td>
                    <td class="boldEleven">Date of PF &amp; ESI Registration </td>
                    <td class="errormessage"><%=staffData[0][54]%> </td>
                  </tr>
                  <tr>
                    <td class="boldEleven">Date of Resign </td>
                    <td class="errormessage"><%=staffData[0][55]%> </td>
                    <td class="boldEleven">&nbsp;</td>
                    <td class="boldEleven">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="2" class="boldEleven">&nbsp;</td>
                    <td colspan="2" class="boldEleven">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="2" class="boldEleven"><table width="330" border="0" align="center">
                        <tr>
                          <td class="boldEleven">PAN Number</td>
                          <td class="errormessage"><%=staffData[0][56] %> </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">PASS PORT Number </td>
                          <td class="errormessage"><%=staffData[0][57] %> </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">DRIVING LICENSE Number </td>
                          <td class="errormessage"><%=staffData[0][58] %> </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">AADHAR NO</td>
                          <td class="errormessage"><%=staffData[0][99] %></td>
                        </tr>
                    </table></td>
                    <td colspan="2" class="boldEleven"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td class="boldEleven">Previous Details </td>
                          <td rowspan="3" align="left" valign="top" class="errormessage"><%=staffData[0][60] %> </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">&nbsp;</td>
                        </tr>
                        <tr>
                          <td class="boldEleven">&nbsp;</td>
                        </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td colspan="4"></td>
                  </tr>
                  <tr>
                    <td colspan="2" class="boldEleven">&nbsp;</td>
                    <td colspan="2" class="boldEleven">&nbsp;</td>
                  </tr>
              </table></td>
            </tr>
          </table>
        </fieldset></td>
      </tr>
      <tr>
        <td height="19">&nbsp;</td>
        <td class="boldEleven">&nbsp;</td>
      </tr>
      <tr>
        <td height="19" colspan="2"><TABLE width="90%" border="0" align="center" cellPadding="4" cellSpacing="4">
          <TBODY>
            <TR>
              <TD vAlign="bottom" noWrap colSpan="7" align="center"><h1>Annexure</h1>			  			  </TD>
            </TR>
             
            <TR>
              <TD vAlign="bottom" noWrap  colSpan="2"><p><strong>Salary   Component</strong></p></TD>
              <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
              <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
              <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
              <TD vAlign="bottom" noWrap><p>&nbsp;</p></TD>
              <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
            </TR>
            <TR bgcolor="#666666"   >
              <TD vAlign="bottom" noWrap  colSpan="2"><p><strong>Particulars</strong></p></TD>
              <TD vAlign="bottom" noWrap ><p><strong>&nbsp;</strong></p></TD>
              <TD vAlign="bottom" noWrap ><p><strong>Amount</strong><strong>(P   M)</strong></p></TD>
              <TD vAlign="bottom" noWrap ><p><strong>&nbsp;</strong></p></TD>
              <TD vAlign="bottom" noWrap><p><strong>Amount   (P A)</strong></p></TD>
              <TD vAlign="bottom" noWrap ><p><strong>&nbsp;</strong></p></TD>
            </TR>
            <%
	   
				
				String AllowanceData[][] = CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME  FROM pay_m_allowance WHERE CHR_FLAG='Y' ORDER BY INT_ALLOWANCEID");
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
				
				//out.println(com.my.org.erp.SmartPayroll.GetAnnexture.getAnnexture(staffid));
				String payData[][] = CommonFunctions.QueryExecute(sql);
				
				
					
					
				double monthbasic=0;
				double monthgross=0;
				double monthpf=0;
				double monthesi=0;
				double monthctc=0;
				
				double staffpf=0;
				double staffesi=0;
				double takehome=0;
				
				
				String institutionData[][] =  CommonFunctions.QueryExecute("SELECT  INT_PFAMT,INT_ESIAMT,INT_ESILIMIT,INT_PFLIMIT,INT_PFLIMITMINIMUM ,INT_CPY_ESIAMT FROM m_institution WHERE INT_ID=1");
				double pfpercentage = Double.parseDouble( institutionData[0][0]);
				double esipercentage = Double.parseDouble( institutionData[0][1]);
				double esilimitamount = Double.parseDouble( institutionData[0][2]);
				double pfmaximumlimit = Double.parseDouble( institutionData[0][3]);
				double pfminimumlimit = Double.parseDouble( institutionData[0][4]);
				double esicomapnypercentage = Double.parseDouble( institutionData[0][5]);

	 	
				if(payData.length>0)
				{
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom' noWrap  colSpan='2'><p>Basic</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap align='right'><p>"+payData[0][0]+"</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  align='right'><p>"+payData[0][1]+"</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("</TR>");
					 int g=1;
					 int v=1;
					 //Gross Allowance
					 for(int u=0; u<AllowanceData.length;u++)
					 {
						 v=v+1;
						 if(!"0".equals(payData[0][v]))
						 {
						  	g = g+2;
						 	out.println("<TR bgcolor='CCCCCC'>");
						 	out.println("<TD vAlign='bottom' noWrap  colSpan='2'><p> "+AllowanceData[u][1]+"</p></TD>");
						 	out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
						   
						 	out.println("<TD vAlign='bottom' noWrap align='right'><p> "+payData[0][v]+"</p></TD>");
						 	out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
						 	v=v+1;
						 	out.println("<TD vAlign='bottom' noWrap  align='right'><p> "+payData[0][v]+"</p></TD>");
							out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
						 	out.println("</TR>");
						 }
						 else
						 {
							g = g+2; 
							
							v=v+1;	
						 }
					}
					
					
					
					
					monthbasic=Double.parseDouble(payData[0][0]);
					monthgross=Double.parseDouble(payData[0][(g+1)]);
					
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom' noWrap  colSpan='2'><p>GROSS</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap align='right'><p>"+Math.round(monthgross)+"</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  align='right'><p>"+Math.round(monthgross*12)+"</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("</TR>"); 
					 
					 
					 String pf = staffData[0][36];//pftype
					 String  esi = staffData[0][39];	//Esitype
 
					
					monthpf = Double.parseDouble(staffData[0][93]);
					staffpf = Double.parseDouble(staffData[0][93]);
					
					 
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom'    colSpan='2' class='boldEleven' ><p>EMPLOYEER PF</p></TD>");
					 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
					 out.println("<TD vAlign='bottom'    align='right' class='boldEleven' ><p>"+Math.round(monthpf)  +"</p></TD>");
					 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
					 out.println("<TD vAlign='bottom'   align='right' class='boldEleven' ><p>"+Math.round(monthpf*12)+"</p></TD>");
					 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
					 out.println("</TR>");  
				 
					 
					 
					
					staffesi = Double.parseDouble(staffData[0][94]);
					monthesi = Double.parseDouble(staffData[0][95]);
					
					
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom'   colSpan='2' class='boldEleven' ><p>EMPLOYEER ESI</p></TD>");
					 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
					 out.println("<TD vAlign='bottom'    align='right' class='boldEleven' ><p>"+Math.round(monthesi)+"</p></TD>");
					 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
					 out.println("<TD vAlign='bottom'    align='right' class='boldEleven' ><p>"+Math.round(monthesi*12)+"</p></TD>");
					 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
					 out.println("</TR>");
					  	  
					 
					  String OthersAllowanceData[][] = CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME  FROM pay_m_allowance WHERE CHR_FLAG='N' ORDER BY INT_ALLOWANCEID");
					String othersband="   ";
					for(int u=0; u<OthersAllowanceData.length;u++)
						othersband = othersband+"  b."+OthersAllowanceData[u][0]+",( b."+OthersAllowanceData[u][0]+" *12) ,"; 
					othersband=othersband.trim();
					othersband = othersband.substring(0,othersband.length()-1);		
					sql = " SELECT "+othersband+" FROM com_m_staff a,pay_t_allowance b ";
					sql = sql +" 	WHERE a.CHR_EMPID = b.CHR_EMPID AND a.CHR_EMPID='"+staffid+"' ";
					//out.println(sql);
					String otherspayData[][] = CommonFunctions.QueryExecute(sql);
					//Others Allowance 
					if(otherspayData.length>0)
					{
						int h= 0;
						for(int u=0; u<OthersAllowanceData.length;u++)
						{
							 if(!"0".equals(otherspayData[0][h]))
							 {
							 	out.println("<TR bgcolor='#666666'>");
							 	out.println("<TD vAlign='bottom' noWrap  colSpan='2'><p> "+OthersAllowanceData[u][1]+"</p></TD>");
							 	out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
							 	out.println("<TD vAlign='bottom' noWrap align='right'><p> "+otherspayData[0][h]+"</p></TD>");
							 	out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
							 	h =h+1;
							 	out.println("<TD vAlign='bottom' noWrap  align='right'><p> "+otherspayData[0][h]+"</p></TD>");
							 	out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
							 	out.println("</TR>");
							 	h = h+1;
							 }
							 else
							 {
								 h = h+1;
								 h = h+1;
							 }
						}
					}
					 
					  monthctc=monthgross+monthpf+monthesi;
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom' noWrap  colSpan='2'><p>Total cost To Company   (TCTC)</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap align='right'><p>"+Math.round(monthctc) +"</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  align='right'><p>"+Math.round((monthctc)*12)+"</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("</TR>"); 
					 
					 double professiontax = Double.parseDouble(staffData[0][98]);
					 takehome=monthgross-(staffpf+staffesi+professiontax); 
					  
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom' noWrap  colSpan='2'><p>Professional Tax</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap align='right'>"+ (professiontax) +"</TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  align='right'>"+ (professiontax*12) +"</TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("</TR>");  
					
					 
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom' noWrap  colSpan='2'><p>As Applicable to your   Current Role</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap align='right'><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  align='right'><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("</TR>");  
					 
					
					  
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom' noWrap  colSpan='2'><p><strong>Take Home  Salary = [ "+monthgross+"-("+staffpf+"+"+staffesi+" +"+ professiontax + ") ] </strong> </p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap width='107' align='right'><b>"+Math.round(takehome)+" </b></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap ><p>&nbsp;</p></TD>");
					 out.println("<TD vAlign='bottom' noWrap  ><p>&nbsp;</p></TD>");
					 out.println("</TR>"); 
					 
				}
			  %>
            <TR>
              <TD colspan="7" vAlign="bottom" noWrap ><div id="Rupees">
                  <script language="javascript">numberWord("<%=takehome%>","Rupees") </script>
              </div></TD>
            </TR>
            <TR>
              <TD vAlign="bottom" noWrap ><p><strong><%=staffData[0][96]%></strong></p></TD>
              <TD vAlign="bottom" noWrap width="66" colSpan="2"><p>&nbsp;</p></TD>
              <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
              <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
              <TD vAlign="bottom" noWrap><p>&nbsp;</p></TD>
              <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
            </TR>
            <TR>
              <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
              <TD vAlign="bottom" noWrap width="66" colSpan="2"><p>&nbsp;</p></TD>
              <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
              <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
              <TD vAlign="bottom" noWrap><p>&nbsp;</p></TD>
              <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
            </TR>
            <TR>
              <TD vAlign="bottom" noWrap ><p><strong><em>Authorised   Signatory</em></strong><strong></strong></p></TD>
              <TD vAlign="bottom" noWrap width="66" colSpan="2"><p><strong>&nbsp;</strong></p></TD>
              <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
              <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
              <TD vAlign="bottom" noWrap><p>&nbsp;</p></TD>
              <TD vAlign="bottom" noWrap ><p>&nbsp;</p></TD>
            </TR>
            <TR height="0">
              <TD ></TD>
              <TD width="66"></TD>
              <TD ></TD>
              <TD ></TD>
              <TD ></TD>
              <TD></TD>
              <TD ></TD>
            </TR>
          </TBODY>
        </TABLE></td>
        </tr>
      <tr>
        <td height="19">&nbsp;</td>
        <td class="boldEleven">&nbsp;</td>
      </tr>
      <tr>
        <td height="19" align="center" valign="top" class="boldEleven">Modification  <span class="errormessage">*</span></td>
        <td align="left" valign="top" class="boldEleven"><table width="100" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="20" class="boldEleven"><input name="modification" type="radio" value="Y"></td>
            <td width="34" class="boldEleven">Yes</td>
            <td width="20" class="boldEleven"><input name="modification" type="radio" value="N" checked></td>
            <td width="26" class="boldEleven">No</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="19" align="center" valign="top" class="boldEleven">Description <span class="errormessage">*</span> </td>
        <td align="left" valign="top" class="boldEleven">
<textarea onKeyUp="teatArea('description','500')" name="description" cols="50" rows="10" id="description">ok</textarea></td>
      </tr>
      <tr>
        <td height="19">&nbsp;</td>
        <td class="boldEleven">&nbsp;</td>
      </tr>
      <tr>
        <td height="19">&nbsp;</td>
        <td class="boldEleven"><input name="filename" type="hidden" id="filename"
										value="StaffRegistration">
            <input name="actionS"
										type="hidden" id="actionS"
										value="GENStaffRegistrationVerify">
            <span class="errormessage">
            <input name="id" type="hidden" class="formText135" id="id" value="<%=staffData[0][2]%> " size="25" />
            </span></td>
      </tr>
      <tr>
        <td height="19" colspan="2"><table border="0" align="center" cellpadding="2"
										cellspacing="2">
            <tr>
              <td width="56"><%
 
  if("F".equals(""+session.getAttribute("USRTYPE"))|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_APPROVAL_USER   FROM m_institution  WHERE INT_ID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
		out.println("<input type='submit' name='Submit' id='submit_btn' class='buttonbold' value='Submit' />");

%>              </td>
              <td width="56"><input type="button" name="submit"
												class="buttonbold"  value="Close"   accesskey="c" 
												onClick="javascript:history.back()" /></td>
            </tr>
        </table></td>
      </tr>
    </table>      
      <span class="style1"></span></td>
  </tr>
</table>
 </td>
	</tr>
	<tr>
		<td valign="top">&nbsp;
		</td>
	</tr>
	<tr>
		<td class="boldEleven">&nbsp;</td>
	</tr>
	<tr>
		<td class="boldEleven">&nbsp;</td>
	</tr>
	<tr>
		<td class="boldEleven"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</form>
</body>

</html>



<script language="javascript">
 
 

function validateFields()
{
	 
	try
	{
		 
		if(checkNull('description','Enter the description'))
		{
			var rs=confirm("Are you sure?, All the informations are correct");
			if (rs==true)
				return true;
			else
				return false;		
		}
		else
			return false;
		
		
	}
	catch(err)
	{
		alert(err)
		return false;
	}
	    
}	
   
   
  
 
  
   
   
</script>


<%
}
catch(Exception e)
{
	e.printStackTrace();
	//System.out.println(e);
}
%>
