<%try{%>

<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%><html>
<head>
 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<script language="JavaScript" src="../JavaScript/AJAX.js" type="text/javascript"></script>

<script language="javascript">



  
function basic_Gross_check()
{
	try
	{
		
		 
		var a = parseFloat(document.getElementById('basic').value);
		var b = parseFloat(document.getElementById('gross').value);
		
		if(b<1)
		{
			alert("please check the Gross... ");
			document.getElementById('gross').focus();
			return false;
		}
		if(a>40000)
		{
			alert("please check Basic, It is high Amount...")
			document.getElementById('gross').focus();
			return false;
		}
		if(a>b)
		{
			alert("Kindly check the Basic and Gross...");
			document.getElementById('gross').focus();
			return false;
		}
		else
			return true;
	 }
	 catch(err)
	 {
		alert(err);
	 }
		
}

function confirm1(){
				var name=confirm("Confirm to Update")
				 
				if (name==true)
				{ 
					return true;
				}
				else{
					return false;
				}

}


 function Validate()
  {
		   
		try
		{
			if(
				 checkNull('empid','Enter Staff Id ...')
				 && checkNull('empname','Enter Staff  Name...')
				 && checkNull('basic','Enter the basic')
				 && checkNull('gross','Enter the gross')
				 && checkNullSelect('bank','Select Bank','0')
				 && basic_Gross_check()
				 && checkNullSelect('pf','SELECT PF ','0')
				 && checkNullSelect('esi','SELECT esi','0')
				 && consolidateCheck()
				 && confirm1()
			)
				return true;
			else
				return false;
		 }
		 catch(err)
		 {
			alert(err.description);
			return false;
		 }
}	
	 
function consolidateCheck()
	{
		var f = true;
		if(checkSalaryType())
			f = checkSalaryBand();
		
		return f;	
	} 
	
	
function pftypechange()
{
	 
	if(document.getElementById('optpf').value== "0" )
	{
		setOptionValue('pf','0');
		pf0.style.visibility="Visible";
		pf1.style.visibility="Visible";
		pf2.style.visibility="Visible";
	}	
	else if (document.getElementById('optpf').value== "A" )
	{
		setOptionValue('pf','Y');
		pf0.style.visibility="Visible";
		pf1.style.visibility="Visible";
		pf2.style.visibility="Visible";
	}	
	else if (document.getElementById('optpf').value== "P" )
	{
		setOptionValue('pf','C');
		pf0.style.visibility="Visible";
		pf1.style.visibility="Visible";
		pf2.style.visibility="Visible";
	}	
}

function pfchange()
{
	 
	if(document.getElementById('pf').value== "Y" )
	{
		setOptionValue('optpf','A');
		document.getElementById('optpf').disabled;
		pf0.style.visibility="Visible";
		pf1.style.visibility="Visible";
		pf2.style.visibility="Visible";
	}	
	else if (document.getElementById('pf').value== "N" )
	{
		setOptionValue('optpf','o');
		pf0.style.visibility="hidden";
		pf1.style.visibility="hidden";
		pf2.style.visibility="hidden";
	}	
	else if (document.getElementById('pf').value== "C" )
	{
		setOptionValue('optpf','P');
		pf0.style.visibility="Visible";
		pf1.style.visibility="Visible";
		pf2.style.visibility="Visible";
	}
	else if (document.getElementById('pf').value== "0" )
	{
		setOptionValue('optpf','0');
		pf0.style.visibility="Visible";
		pf1.style.visibility="Visible";
		pf2.style.visibility="Visible";
	}		
}


function ESIchange()
{
	 
	if(document.getElementById('esi').value== "Y" )
	{
		setOptionValue('optesi','A');
		ppf0.style.visibility="Visible";
		ppf1.style.visibility="Visible";
		ppf2.style.visibility="Visible";
	}	
	else if (document.getElementById('esi').value== "N" )
	{
		setOptionValue('optesi','o');
		ppf0.style.visibility="hidden";
		ppf1.style.visibility="hidden";
		ppf2.style.visibility="hidden";
	}	
	else if (document.getElementById('esi').value== "C" )
	{
		setOptionValue('optesi','P');
		ppf0.style.visibility="Visible";
		ppf1.style.visibility="Visible";
		ppf2.style.visibility="Visible";
	}
	else if (document.getElementById('esi').value== "0" )
	{
		setOptionValue('optesi','0');
		ppf0.style.visibility="Visible";
		ppf1.style.visibility="Visible";
		ppf2.style.visibility="Visible";
	}		
}


function esitypechange()
{
	 
	if(document.getElementById('optesi').value== "0" )
	{
		setOptionValue('esi','0');
		ppf0.style.visibility="Visible";
		ppf1.style.visibility="Visible";
		ppf2.style.visibility="Visible";
	}	
	else if (document.getElementById('optesi').value== "A" )
	{
		setOptionValue('esi','Y');
		ppf0.style.visibility="Visible";
		ppf1.style.visibility="Visible";
		ppf2.style.visibility="Visible";
	}	
	else if (document.getElementById('optesi').value== "P" )
	{
		setOptionValue('esi','C');
		ppf0.style.visibility="Visible";
		ppf1.style.visibility="Visible";
		ppf2.style.visibility="Visible";
	}	
}





  
 </script>

<title> :: PAYROLL ::</title>



 
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
.style8 {font-family: Verdana;
	font-size: 12px;
}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >

<%@ include file="index.jsp"%>
<!--PaySlipView.jsp-->
<form  AUTOCOMPLETE = "off"   name="staffaddfrm" method="post" action="../SmartLoginAuth" onSubmit="return Validate()">

<table width="100%" height="412" border="0" align="center"
	cellpadding="0" cellspacing="0">
	<tr>
		<td height="31">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="390"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="412">
					
					
					
					<fieldset>
<legend><strong><img src="../images/icon-misuse.gif" /> Salary Information</strong> 
<%
							String action=request.getParameter("action1");
							String id="",name="",desc="",actionS="",value="";
							String stid="",stname="",salsplit="",salary="",grosssalary="",bank="",accno="",ifsc="",pf="",pfno="",pfamt="",pfnominee="",pfesidate="",pfesi="",esitype="",esino="",esiamt="",pfno1="",esitype1="";
							String sql="";

							if("Add".equals(action))
							{
								name=""; desc="";
								actionS="PAYStaffBasicAdd";
								value="Add"; 
								 
								
							}
							else
							{
								id="";name="";
								
						String sid=request.getParameter("staffid");
								sql = " SELECT CHR_EMPID,CHR_STAFFNAME,CHR_SALARYSPLITUP,INT_SALARY,INT_GROSSSALARY,CHR_BANK,CHR_ACCNO,CHR_IFSC,CHR_PF,CHR_PFTYPE,CHR_PFNO,INT_PFAMT,CHR_NOMINEE,DAT_PFESIDATE,CHR_ESI,CHR_ESITYPE,CHR_ESINO,INT_ESIAMT FROM pay_t_basic_informations  WHERE CHR_EMPID= '"+sid+"'";
								String stdata[][]=com.my.org.erp.common.CommonFunction.doubleRecordSetArray(sql);
								if(stdata.length>0){
								stid=stdata[0][0];stname=stdata[0][1];  salsplit=stdata[0][2];  salary=stdata[0][3]; grosssalary=stdata[0][4];bank=stdata[0][5];accno=stdata[0][6];ifsc=stdata[0][7];pf=stdata[0][8];pfno=stdata[0][9];pfno1=stdata[0][10];pfamt=stdata[0][11];pfnominee=stdata[0][12];pfesi=stdata[0][13];esitype1=stdata[0][14];esitype=stdata[0][15];esino=stdata[0][16];esiamt=stdata[0][17]; }
								actionS="PAYStaffBasicEdit";
								value="Update";
								 
							}
							
						%>
</legend>
<table width="100%" border="0" align="center" cellpadding="2"
												cellspacing="2">
  <tr>
    <td height="167" colspan="2"><table width="100%" border="0" align="center"
														cellpadding="1"   bordercolor="#D4D0C8"
														class="boldEleven">
      <tr>
        <td width="75" class="boldEleven">Empid<font class="bolddeepred" align="absmiddle">*</font></td>
        <td width="189"><input name="empid" type="text" class="formText135" id="empid" 	size="30" maxlength="25" onKeyPress=""  onpaste="return false;" tabindex="26"  value="<%=stid%>" onKeyUp="LoadUniqueCheckempid('empid', 'EMPDiv', 'com_m_staff', 'CHR_EMPID', 'submit_btn')"  readonly="readonly"/><div id="EMPDiv"></div></td>
        <td width="47" class="boldEleven">Emp name<font class="bolddeepred" align="absmiddle">*</font></td>
        <td width="188"><input name="empname" type="text" class="formText135" id="empname" 	size="30" maxlength="50" onKeyPress=""  onpaste="return false;" tabindex="26" value="<%=stname%>" readonly="readonly" /></td>
      </tr>
      <tr>
        <td class="boldEleven">Salary Split up
          <script language="JavaScript" type="text/javascript">


function basicdisable()
{
	bid.style.visibility="hidden";
	bid1.style.visibility="hidden";

	document.getElementById('basic').value="0";
}
	
	 
function basicenable()
{
	document.getElementById('basic').value="0";
	bid.style.visibility="visible";
	bid1.style.visibility="visible";

} 


          </script>        </td>
        <td><table width="100" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td class="boldEleven"><input name="salarysplitupby"  id="salarysplitupby"  type="radio" value="A" onClick="basicdisable()" /></td>
              <td class="boldEleven">Automatic</td>
              <td class="boldEleven"><input name="salarysplitupby" type="radio"  id="radio" onClick="basicenable()" value="M" checked="checked" /></td>
              <td class="boldEleven">Manual</td>
            </tr>
        </table></td>
        <td id="bid" class="boldEleven">Basic Salary<font class="bolddeepred" align="absmiddle">*</font></td>
        <td id="bid1"><input name="basic" type="text" class="formText135" id="basic" tabindex="25" onKeyPress="return numeric_only(event,'basic','11')" size="30" 																maxlength="10"  onpaste="return false;" value="<%=salary%>"/></td>
      </tr>
      <tr>
        <td class="boldEleven">Splitup Gross Salary<font class="bolddeepred" align="absmiddle">*</font></td>
        <td><input name="gross" type="text" class="formText135" id="gross" 	size="30" maxlength="9" onKeyPress="return numeric_only(event,'gross','10')"  onpaste="return false;" tabindex="26" value="<%=grosssalary%>"/>
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
	
	
	
	String stafftypeDatas[][] =CommonFunctions.QueryExecute(" SELECT  CHR_TYPENAME,CHR_FLAG FROM com_m_stafftype  ORDER BY CHR_TYPENAME ");
	String svalue="";
	for(int x=0; x<stafftypeDatas.length;x++)
	{
		for(int y=0; y<2;y++)
			svalue = svalue+stafftypeDatas[x][y]+",";
		svalue = svalue+"~";	
	}
	
	
%>
            <script language="JavaScript" type="text/javascript">
	var salarybandvalue = "<%=lvalue%>";
	var salarybandvalue1 =salarybandvalue.split("~");
	var f= false;
	
	
	
	function checkSalaryBand()
	{
		try
		{
			var gross =document.getElementById("gross").value;
			for(i=0; i<salarybandvalue1.length-1; i++)
			{
				 var v = salarybandvalue1[i].split(",")
				 var gt = parseInt(v[0]);
				 var lt = parseInt(v[1]);
				 if((gross >=gt) &&(gross <=lt))
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
		catch(err)
		{
			alert(err);
		}
	}
	
	
	
	var f1 =false;
	function checkSalaryType()
	{
		try
		{
			var salarytypevalue = "<%=svalue%>";
			var salarytypevalue1 =salarytypevalue.split("~");
			//var type =document.getElementById("stype").value;
			f1 =false;
			for(i=0; i<salarytypevalue1.length-1; i++)
			{
				 var v = salarytypevalue1[i].split(",")
				 var name =  (v[0]);
				 var status =  (v[1]);
				 if((status ==="Y"))
					f1 = true; 
			}
			
			return f1;
		}
		catch(err)
		{
			 alert(err.description)
		}		
	}
                                                            </script></td>
        <td class="boldEleven">Bank Name<font
																class="bolddeepred" align="absmiddle">*</font></td>
        <td><select name="bank" class="formText135" id="bank"  style="width:170" tabindex="27">
          <option value="0">Select Bank Name</option>
		   <%
                  out.println("<option value='1'>No Bank</option>");	
						String query="SELECT a.INT_BANKID, b.CHR_BANKGROUPNAME FROM com_m_bank a, com_m_bankgroup b WHERE a.INT_BANKGROUPID=b.INT_BANKGROUPID  ORDER BY  b.CHR_BANKGROUPNAME";
                  		String datas[][]= CommonFunctions.QueryExecute(query);
                  		if (datas.length>0){
                  			for (int i=0; i<datas.length; i++) {
								out.println("<option value="+datas[i][0]+">"+datas[i][1]+"</option>");			
                  			}
                  		}
				%>
        </select></td><script language="javascript">setOptionValue('bank','<%=bank%>')</script>
      </tr>
      <tr>
        <td class="boldEleven">Account No </td>
        <td><input name="no" type="text" class="formText135" id="no" size="30"  maxlength="20"     onkeyup="upperMe(this),checkAccounts(this) " tabindex="28" value="<%=accno%>"/>
            <script language="JavaScript" type="text/javascript">
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
            <!--CheckUnique(ctr,'acc','com_m_staff','CHR_ACCNO') ;
            <div id="acc"></div>-->                                                <div id="acc"></div>

          <span class="boldred">A/c no does'nt have, Put DD </span></td>
        <td class="boldEleven">IFSC CODE </td>
        <td><input name="ifsccode" type="text"
																class="formText135" id="ifsccode" value="<%=ifsc%>"
																  size="30"   onBlur="upperMe(this)"   
																maxlength="20"  tabindex="29"/></td>
      </tr>
      <tr>
        <td class="boldEleven">&nbsp;</td>
        <td></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="23">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td width="53%" height="167"><table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
      <tr>
        <td colspan="2" class="boldEleven"><div align="center"><strong>PF</strong></div></td>
      </tr>
      <tr class="boldEleven">
        <td width="50" height="21" class="boldEleven">PF<font
																class="bolddeepred" align="absmiddle"> *</font></td>
        <td width="" class="boldEleven"><select name="pf" class="formText135" id="pf" onChange="pfchange()"  style="width:170" tabindex="48" on>
          <option value="0">Select PF </option>
          <option value="Y">Yes</option>
          <option value="N">No</option>
          <option value="C">Common</option>
        </select></td><script language="javascript">setOptionValue('pf','<%=pf%>')</script>
      </tr>
		
      <tr id="pf0">
        <td class="boldEleven" >PF TYPE</td>
        <td class="boldEleven"><select name="optpf" id="optpf" class="formText135" onChange="pftypechange()"  style="width:170" tabindex="49">
          <option value="0">Select PF  TYPE</option>
          <option value="A">Amount</option>
          <option value="P">Percentage</option>
        </select></td><script language="javascript">setOptionValue('optpf','<%=pfno%>')</script>
      </tr>

      <tr id="pf1">
        <td class="boldEleven" height="">PF Number</td>
        <td class="boldEleven"><input name="txtpfno" id="txtpfno" type="text" class="formText135" size="30" maxlength="8"  onkeypress="return numeric_only(event,'txtpfno','10');" tabindex="40" value="<%=pfno1%>"/></td>
      </tr>

      <tr id="pf2">
        <td class="boldEleven" height="">PF Amount</td>
        <td class="boldEleven"><input name="txtpfvalue"  id="txtpfvalue"  type="text" class="formText135" onKeyPress="  return numeric_only(event,'txtpfvalue','10'); " size="30"	maxlength="8"  tabindex="51" value="<%=pfamt%>"/></td>
      </tr>
      <tr>
        <td class="boldEleven" height="">PF Nominee</td>
        <td class="boldEleven"><input name="nominee" type="text" class="formText135" id="nominee" size="30" maxlength="50" value="<%=pfnominee%>" /></td>
      </tr>
      <tr>
        <td class="boldEleven">Date of PF &amp; esi Registration </td>
        <td class="boldEleven"><input name="pfdate"
									type="text" class="formText135" id="pfdate" size="21"
									onKeyPress="dateOnly(this)" readonly="readonly"/>
          <a
									href="javascript:ccal1.popup();"> <img
									src="../JavaScript/img/cal.gif" width="16" height="16"
									border="0" /> </a>
          <script language='JavaScript'
									type="text/javascript">
						<!--			
							var ccal1 = new calendar1(document.forms['staffaddfrm'].elements['pfdate']);
							ccal1.year_scroll = true;
							ccal1.time_comp = false;
							setCurrentDate('pfdate'); 
						//-->
                                </script>
          
          
          <span class="boldred">(dd-mm-yyyy) </span></td></tr>
    </table></td>
    <td width="47%"><table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
														<tr>
        <td height="21" colspan="2" class="boldEleven"><div align="center"><strong> esi</strong></div></td>
      </tr>
     
      <tr>
        <td width="50" height="21" class="boldEleven">ESI<font
																class="bolddeepred" align="absmiddle"> *</font></td>
        <td width="189" class="boldEleven"><select name="esi" class="formText135" id="esi"  onchange="ESIchange()"  style="width:170" tabindex="53">
          <option value="0">Select esi </option>
          <option value="Y">Yes</option>
          <option value="N">No</option>
          <option value="C">Common</option>
        </select></td><script language="javascript">setOptionValue('esi','<%=esitype1%>')</script>
      </tr>
      <tr id="ppf0">
        <td height="21" class="boldEleven">ESI TYPE</td>
        <td class="boldEleven"><select name="optesi" class="formText135" id="optesi" onChange="esitypechange()"  style="width:170" tabindex="54">
          <option value="0">Select esi  TYPE</option>
          <option value="A">Amount</option>
          <option value="P">Percentage</option>
        </select></td><script language="javascript">setOptionValue('optesi','<%=esitype%>')</script>
      </tr>
      <tr id="ppf1">
        <td class="boldEleven">ESI Number</td>
        <td class="boldEleven"><input name="txtesno"
																id="txtesno" type="text" class="formText135" value="<%=esino%>"
																onkeyup="upperMe(this), LoadUniqueCheck('txtesno', 'ESIDiv', 'com_m_staff', 'CHR_ESINO', 'submit_btn')"
																size="30" maxlength="12"  tabindex="55"  onkeypress="return numeric_only(event,'txtesno','14'); "/>
              <div id="ESIDiv"></div></td>
      </tr>
      <tr id="ppf2">
        <td class="boldEleven">ESI Amount</td>
        <td class="boldEleven"><input name="txtesivalue"  id="txtesivalue" type="text" class="formText135" onKeyPress="return numeric_only(event,'txtesivalue','10'); " size="30" 	maxlength="8"  tabindex="56" value="<%=esiamt%>"/></td>
      </tr>
      <tr>
        <td class="boldEleven">&nbsp;</td>
        <td class="boldEleven">        </td>
      </tr> <tr>
        <td height="21" colspan="2" class="boldEleven"><div align="center"><strong></strong></div></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td colspan="2" class="boldEleven"></td>
  </tr>
  <tr>
    <td colspan="2"><input name="filename" type="hidden" id="filename" value="StaffBasic"/>
                    <input name="actionS" type="hidden" id="actionS" value="<%=actionS%>"/><table border="0" align="center" cellpadding="2"
										cellspacing="2">
      <tr>
        <td width="56" height="28"><input type="submit" name="Submit"
												id="submit_btn" class="buttonbold" value="<%=value%>"   tabindex="62"/></td>
        <td width="56"><input type="button" name="submit" class="buttonbold"
												 value="Close"   accesskey="c" 
												onclick="redirect('StaffBasic.jsp')"   tabindex="63"/></td>
      </tr>
    </table></td>
    </tr>
  <tr>
    <td height="23">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</fieldset>					</td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
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
		<td height="19">&nbsp;</td>
	</tr>
	<tr>
		<td height="37">&nbsp;</td>
	</tr>
</table>
</form>

<%@ include file="../footer.jsp"%>
</body>
</html><%
}catch(Exception e){

}%>
