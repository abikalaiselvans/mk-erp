<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
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
 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script> 
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/AJAX.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/commonAJAX.js" type="text/javascript"></script>

<script language="javascript">
function validate()
{
    if(checkNull("ename","Select Staff"))
    	return true;
    else
    	return false;
}

function closed()
{
	history.back(1);
  	window.close();
 } 	
  
function list()
  {   
     if(checkNull("ename","Select Staff"))
	 {
        return true;
     }
     else
     {
     	return false;
     }     
   }
function mainPage()
	{
	    document.allow.action="Payrollmain.jsp";
		document.allow.submit();
		return true;
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
		document.getElementById('txtpfvalue').value="0";
	}	
	else if (document.getElementById('pf').value== "C" )
	{
		setOptionValue('optpf','P');
		pf0.style.visibility="Visible";
		pf1.style.visibility="Visible";
		pf2.style.visibility="hidden";
		document.getElementById('txtpfvalue').value="0";
	}
	else if (document.getElementById('pf').value== "0" )
	{
		setOptionValue('optpf','0');
		pf0.style.visibility="Visible";
		pf1.style.visibility="Visible";
		pf2.style.visibility="Visible";
	}		
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
		pf2.style.visibility="hidden";
		document.getElementById('txtpfvalue').value="0";
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
		document.getElementById('txtesivalue').value="0";
	}	
	else if (document.getElementById('esi').value== "C" )
	{
		setOptionValue('optesi','P');
		ppf0.style.visibility="Visible";
		ppf1.style.visibility="Visible";
		ppf2.style.visibility="hidden";
		document.getElementById('txtesivalue').value="0";
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
		ppf2.style.visibility="hidden";
		document.getElementById('txtesivalue').value="0";
	}	
}



function checkPFNomineeRelationship()
{
	try
	{
		var pf =document.getElementById('pf').value;
		if(pf =="Y" || pf =="C")
		{
			if( checkNull('nominee','Enter the nominee name') 
				&& checkNullSelect('pfnomineerelationship','Select pf nominee relation ship','0')
			  )
			  return true;
			else
				return false;	
		}
		return true;
	}
	catch(err)
	{
		alert( "  error : "+err);
		return false;
	}
}



function Validate()
  {
	
   
	if(  checkNullSelect('pf','SELECT PF ','0')
		 && checkNullSelect('esi','SELECT esi','0')
		 && checkPFNomineeRelationship()  
		  && checkNull('basic','Enter the basic')
		  
				   )
		return true;
	else
		return false;				
		
	
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
</head>

<body  onpaste='return false;'>
<%
try
{
	Connection con ;
	Statement st=null; 
	ResultSet rs;
	ResultSet rsMenu;
%>
<form  AUTOCOMPLETE = "off"   name="allowance" method="post" action="../SmartLoginAuth"  onSubmit="return Validate()">
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
		
        <%
				   String staff =""+request.getParameter("staffid");
                   staff = staff.trim();
                   boolean aflag =StaffRegistration.allowanceRecordExist(staff.trim()) ;
				   boolean rflag =StaffRegistration.recoveryRecordExist(staff.trim()) ;
				    
				    
				if((aflag==false) && (rflag ==false))
				{
					out.println("<center><br><br><br><br>");
					out.println("<font class='bolddeepred'>Allowance not allocated</font><br><br><br>");	
					out.println("<input type='button' name='submit' class='ButtonHead' value='Close' onClick='closed()' />");
					out.println("</center>");
				}
				else
				{	   
					    
        %>
                   
        
        <table width="564" border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../SmartGovernment/Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../SmartGovernment/Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block"></td>
					<td width="545" valign="top">
					<table width="549" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td colspan="2">
							<div align="right"><span class="boldEleven">* </span><span
								class="changePos">Mandatory</span></div>							</td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td height="19" colspan="2" class="boldEleven">
							<div align="center">
							  <%
						  String staffsql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,FIND_A_EMPLOYEE_ID_NAME(a.CHR_EMPID),a.CHR_PF,a.CHR_PFTYPE,a.CHR_PFNO,a.INT_PFAMT, a.CHR_NOMINEE,a.CHR_NOMINEE_RELATIONSHIP,a.CHR_ESI,a.CHR_ESITYPE,a.CHR_ESINO ,a.INT_ESIAMT,a.INT_PLACEID,IF(a.CHR_PFCALCULATIONTYPE= 'T1','Type-I','Type-II'),a.CHR_PROFESSIONALTAX,a.INT_SALARY FROM com_m_staff a WHERE CHR_EMPID= '"+staff+"'";
							//out.println(sql);
							String data[][]= CommonFunctions.QueryExecute(staffsql);
						  %>
							  Staff id : <%=data[0][0] +"/" + data[0][1]%> <input
								name="staffid" type="hidden" id="staffid" value="<%=staff%>">
							<input name="staffid" type="hidden" id="staffid" value="staffid">
							<input name="id" type="HIDDEN" id="id" value="<%=staff%>">
							</div>							</td>
						</tr>
						<tr>
							<td height="19">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td height="19" class="boldEleven">
							<div align="right">Effective Date</div>							</td>
							<td><input name="effectdt" type="text" class="formText135"
								id="effectdt" size="15" readonly onKeyPress="dateOnly(this)" /> <a
								href="javascript:cal1.popup();"> <img
								src="../JavaScript/img/cal.gif" width="16" height="16"
								border="0" /> </a> <script language='JavaScript'
								type="text/javascript">
						<!--			
							var cal1 = new calendar1(document.forms['allowance'].elements['effectdt']);
							cal1.year_scroll = true;
							cal1.time_comp = false;
							setCurrentDate('effectdt'); 
						//-->
                       </script></td>
						</tr>
						<tr>
						  <td height="19" colspan="2">&nbsp;</td>
					  </tr>
						<tr>
						  <td height="19" colspan="2">
						  
						  <table width="100%" border="0" align="center" cellpadding="2"
												cellspacing="2">
                  <tr>
                    <td width="52%" height="167" valign="top"><table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
                        <tr>
                          <td colspan="2" class="boldEleven"><div align="center"><strong>PF</strong></div></td>
                        </tr>
                        
                        <tr class="boldEleven">
                          <td width="160" class="boldEleven">PF<font
																class="bolddeepred" align="absmiddle"> *</font></td>
                          <td width="194" class="boldEleven"><select name="pf" class="formText135" id="pf" onChange="pfchange()"  style="width:165" tabindex="48">
                              <option value="0">Select PF </option>
                               <option value="Y">Yes</option> 
                              <option value="N">No</option>
                              <option value="C">Common</option>
                          </select>
						  <script language="javascript">setOptionValue('pf','<%=data[0][3]%>')</script>						  </td>
                        </tr>
                        <tr id="pf0">
                          <td class="boldEleven">PF TYPE</td>
                          <td class="boldEleven"><select name="optpf" id="optpf" class="formText135" onChange="pftypechange()"  style="width:165" tabindex="49">
                              <option value="0">Select PF  TYPE</option>
                              <option value="A">Amount</option>
                              <option value="P">Percentage</option>
                          </select>
						  <script language="javascript">setOptionValue('optpf','<%=data[0][4]%>')</script>						  </td>
                        </tr>
                        <tr id="pf1">
                          <td class="boldEleven">PF Number</td>
                          <td class="boldEleven"><input name="txtpfno" type="text" class="formText135" id="txtpfno" tabindex="40"  onkeypress="return numeric_only(event,'txtpfno','15');" onKeyUp="CheckUnique(this,'divpfnumber','com_m_staff','CHR_PFNO')" value="<%=data[0][5]%>" size="30" maxlength="25" />
                              <div id='divpfnumber'></div></td>
                        </tr>
                        <tr id="pf2">
                          <td class="boldEleven">PF Amount</td>
                          <td class="boldEleven"><input name="txtpfvalue"  type="text" class="formText135"  id="txtpfvalue"  tabindex="51" onKeyPress=" return  numeric_priceonly(event,'txtpfvalue','12' )" value="<%=data[0][6]%>" size="30"	maxlength="8"/></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">PF Nominee <font
																class="bolddeepred" align="absmiddle"> *</font></td>
                          <td class="boldEleven"><input name="nominee" type="text" class="formText135" id="nominee" value="<%=data[0][7]%>" size="30" maxlength="50"></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Relationship<font
																class="bolddeepred" align="absmiddle"> *</font></td>
                          <td class="boldEleven"><select name="pfnomineerelationship" class="formText135" id="pfnomineerelationship"   style="width:165">
                              <option value="0">Select Relationship</option>
                              <option value="F" selected="selected"> Father</option>
                              <option value="M">Mother</option>
                              <option value="W">wife</option>
                              <option value="H">Husband</option>
                              <option value="G">Guardian</option>
                              <option value="S">Son</option>
                              <option value="D">Daugther</option>
                            </select>
							  <script language="javascript">setOptionValue('pfnomineerelationship','<%=data[0][8]%>')</script>                          </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">PF Calculation Type</td>
                          <td class="boldEleven"><%=data[0][14]%></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Universal Account Number (UAN)</td>
                          <td class="boldEleven"><input name="uannumber" id="uannumber" type="text" class="formText135" size="30" maxlength="25"  onkeypress="return numeric_only(event,'uannumber','15');" tabindex="40" onKeyUp="CheckUnique(this,'divuanpfnumber','com_m_staff','CHR_PF_UAN')" /></td>
                        </tr>
                    </table></td>
                    <td width="48%" valign="top"><table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
                        <tr>
                          <td height="21" colspan="2" class="boldEleven"><div align="center"><strong> ESI </strong></div></td>
                        </tr>
                        <tr>
                          <td width="120" height="21" class="boldEleven">ESI<font
																class="bolddeepred" align="absmiddle"> *</font></td>
                          <td class="boldEleven"><select name="esi" class="formText135" id="esi"  onchange="ESIchange()"  style="width:165" tabindex="53">
                              <option value="0">Select esi </option>
                               <option value="Y">Yes</option> 
                              <option value="N">No</option>
                              <option value="C">Common</option>
                          </select>
						   <script language="javascript">setOptionValue('esi','<%=data[0][9]%>')</script>						  </td>
                        </tr>
                        <tr id="ppf0">
                          <td height="21" class="boldEleven">ESI TYPE</td>
                          <td class="boldEleven"><select name="optesi" class="formText135" id="optesi" onChange="esitypechange()"  style="width:165" tabindex="54">
                              <option value="0">Select esi  TYPE</option>
                              <option value="A">Amount</option>
                              <option value="P">Percentage</option>
                          </select>
						  <script language="javascript">setOptionValue('optesi','<%=data[0][10]%>')</script>						  </td>
                        </tr>
                        <tr id="ppf1">
                          <td class="boldEleven">ESI Number</td>
                          <td class="boldEleven"><input name="txtesno"
																id="txtesno" type="text" class="formText135"
																 size="30" maxlength="25" value="<%=data[0][11]%>"  tabindex="55"  onKeyPress="return numeric_only(event,'txtesno','14'); "  onKeyUp="CheckUnique(this,'divesinumber','com_m_staff','CHR_ESINO')" />
                              <div id='divesinumber'></div>
                            <div id="ESIDiv"></div></td>
                        </tr>
                        <tr id="ppf2">
                          <td class="boldEleven">ESI Amount</td>
                          <td class="boldEleven"><input name="txtesivalue" type="text" class="formText135"  id="txtesivalue"  tabindex="56" onKeyPress="return numeric_priceonly(event,'txtesivalue','10'); " value="<%=data[0][12]%>" size="30" 	maxlength="8"/></td>
                        </tr>
                        <tr>
                          <td class="boldEleven">Dispensary</td>
                          <td class="boldEleven"><select id="dispensary" name="dispensary" class="formText135"   style="width:165" tabindex="13">
                              <option value="0">Select Dispensary</option>
                              <%
		   String Disdata[][] = CommonFunctions.QueryExecute("Select INT_DESPID,CHR_DESPNAME From com_m_dispensary order by INT_DESPID ");
		   for(int c=0;c<Disdata.length;c++)
		   		out.println("<option value='"+Disdata[c][0]+"'>"+Disdata[c][1]+"</option>");
		   %>
                          </select>
						  <script language="javascript">setOptionValue('dispensary','<%=data[0][13]%>')</script>						  </td>
                        </tr>
                        <tr>
                          <td class="boldEleven">&nbsp;</td>
                          <td class="boldEleven">&nbsp;</td>
                        </tr>
                        <tr>
                          <td class="boldEleven">&nbsp;</td>
                          <td class="boldEleven">&nbsp;</td>
                        </tr>
                        
                    </table></td>
                  </tr>
                  
                  <tr>
                    <td colspan="2" class="boldEleven"></td>
                  </tr>
                  <tr>
                    <td colspan="2"><table width="300" border="0" align="center" cellpadding="0" cellspacing="0">
                      <tr>
                        <td class="boldgreen"><span class="boldEleven">Professional Tax Deduction</span></td>
                        <td>
                        <select name="professionaltax" class="formText135" id="professionaltax">
                        <option value="Y">Yes</option>
                        <option value="N">No</option>
                        </select>
                         <script language="javascript">setOptionValue('professionaltax','<%=data[0][15]%>')</script>                        </td>
                      </tr>
                    </table></td>
                    </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                  </tr>
                </table>						  </td>
					  </tr>
						<tr>
							<td width="49%" height="19" align="right"><span class="boldEleven">Basic Salary </span></td>
							<td width="51%" align="left"><input name="basic" type="text"
																class="formText135" id="basic"
																 value="<%=data[0][16]%>"  onKeyPress="return numeric_only(event,'basic','12')" 
																size="30" maxlength="10" /></td>
						</tr>
						<tr>
						  <td height="19" colspan="2">&nbsp;</td>
					  </tr>
						<tr>
							<td height="19" colspan="2">

							<div align="center">
							  <%
				  	Connection con1 ;
					PreparedStatement pstm;
					ResultSet rst;
					con1 = conbean.getConnection();
					ResultSetMetaData rsmd;
					String query = "";
					query = "Select count(*) from pay_m_allowance";
					pstm = con1.prepareStatement(query);
					rst = pstm.executeQuery();
					String txtname="";
					String txtfield="";
					int rcount=0;
					if(rst.next())
						rcount =rst.getInt(1);
					////System.out.println("ooooooooo"+rcount);
					
					
					

					query = "Select * from pay_t_allowance WHERE CHR_EMPID = '"+staff+"'  ";
					
					pstm = con1.prepareStatement(query);
					rst = pstm.executeQuery();
					rsmd = rst.getMetaData();
					String s="";
					int u=0;
					String x ="";				
					if (aflag)
					if(rst.next())
					{	
						for(int i=1; i<=rsmd.getColumnCount();i++) {
							x = ""+rst.getString(i);
							if (x.equals("0") || "null".equals(x))
								x = "0";
						s = s +x+" ~ ";
						}
					}
					else
						s = s +"0~0~0~0~0~0~0~0~0~0~0~0~0~0~0~" ;					
					String asval[] = s.split("~");
					//-------------
					if(rcount > 0)
					{	
						out.println("<table   align='center'  cellpadding='2' cellspacing='2'  class='TableDesign'  ><tr>");
						out.println("<td colspan='2'  class='whiteMedium'><div align='center'>Allowance</div></td>");
						out.println("</tr>");
						out.println(" <tr class='MRow1'>");
						query = "Select  CHR_ACODE,CHR_ANAME  from pay_m_allowance  order by INT_ALLOWANCEID";
						pstm = con1.prepareStatement(query);
						rst = pstm.executeQuery();
						u=1;
						String fun1="";
						while(rst.next())
						{
							
							txtfield=rst.getString("CHR_ACODE");
							txtname=rst.getString("CHR_ANAME");
							if(u%2==0)
								out.println("<tr  class='MRow1'> ");
							else
								out.println("<tr  class='MRow2'> ");
							out.println(" <td class='boldEleven' align='left'>"+txtname+"</td>");
							
							fun1 = "onKeyPress="+"\"return numeric_only(event,'"+txtfield+"','7')\"";
							 
							out.println("<td width='80' align='left'><input value='"+asval[u].trim()+"' class='formText135' maxlength='6' type='text' "+ fun1 +" name='"+txtfield+"'  id='"+txtfield+"'></td>" );
							out.println("</tr>");
							u =u+1;
						}
						out.println("</table>");
					}	
				%>
							</div>							</td>
						</tr>
						<tr>
							<td height="19">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<div align="center">
							  <%
				  
				  	query = "Select count(*) from pay_m_recovery";
					pstm = con1.prepareStatement(query);
					rst = pstm.executeQuery();
					txtname="";
					
					rcount=0;
					if(rst.next())
						rcount =rst.getInt(1);
					////System.out.println("Recovery" +rcount);
					
					
					//-------------------------
					query = "Select * from pay_t_recovery WHERE CHR_EMPID = '"+staff+"' ";
					pstm = con1.prepareStatement(query);
					rst = pstm.executeQuery();
					rsmd = rst.getMetaData();
					 s="";
					 u=1;
					 if (rflag)
							if(rst.next())
							{	
								for(int i=1; i<=rsmd.getColumnCount();i++) {
									x = ""+rst.getString(i);
									if (x.equals("0") || "null".equals(x))
										x="0";
									s = s + x +" ~ ";
								}
							}
						else
							s = s +"0~0~0~0~0~0~0~0~0~0~0~0~0~0~0~" ;					
					String rsval[] = s.split("~");
					//---------------------------
					
					if(rcount >0 )
					{	
						out.println("<table   align='center' cellpadding='2' cellspacing='2'   class='TableDesign' ><tr>");
						out.println("<td colspan='2' maxlength='7' class='whiteMedium'><div align='center'>Recovery</div></td>");
						out.println("</tr>");
						 
						query = "Select  CHR_RCODE,CHR_RNAME  from pay_m_recovery order by INT_RECOVERYID";
						pstm = con1.prepareStatement(query);
						rst = pstm.executeQuery();
						u=1;
						String fun2="";
						while(rst.next())
						{
							txtfield=rst.getString(1);
							txtname=rst.getString(2);
                            if(u%2==0)
								out.println("<tr  class='MRow1'> ");
							else
								out.println("<tr  class='MRow2'> ");
							
							fun2 = "onKeyPress="+"\"return numeric_only(event,'"+txtfield+"','7')\"";
							 
							out.println("<td class='boldEleven' align='left'>"+txtname+"</td>");
						out.println("<td width='80' align='left'><input value='"+rsval[u].trim()+"' class='formText135' type='text' "+fun2+" maxlength='6' name='"+txtfield.trim()+"'  id='"+txtfield.trim()+"'></td>" );
							u = u+1;
						   out.println("</tr>");	
						}
						out.println("</table>");
					}	
				  %>
							</div>							</td>
						</tr>
						<tr>
							<td height="19">&nbsp;</td>
							<td><input name="filename" type="hidden" id="filename"
								value="StaffAllowanceRecovery" /> <input name="actionS"
								type="hidden" id="actionS"
								value="PAYStaffAllowanceRecoveryUpdate" /></td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input type="submit" name="Submit"
										id="submit_btn" class="ButtonHead" value="Update" /></td>
									<td width="56"><input type="button" name="submit"
										class="ButtonHead"  value="Close"   accesskey="c"  onClick="closed()" /></td>
								</tr>
							</table>							</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="5"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="2"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../SmartGovernment/Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block"></td>
					<td colspan="2" rowspan="2" valign="bottom">
					<div align="right"><img height="7"
						src="../SmartGovernment/Image/General/BRCorner.gif" width="7" /></div>
					</td>
				</tr>
				<tr>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>

			</tbody>
		</table>
        
        <%
				}
		%>
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
<%
}
catch(Exception e)
{
}
%>
</body>

</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
