<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
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



</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/AJAX.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/commonAJAX.js" type="text/javascript"></script>


<script language="JavaScript">
 
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
				   )
		return true;
	else
		return false;				
		
	
 } 	
</script>
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
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
	 <form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">
	<table class="BackGround1" cellspacing="0" cellpadding="0" width="800"
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
          <td   valign="top">
		 
		    <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3">
              <tr>
                <td colspan="2" class="bold1"><div align="center"> 
                  <%
							 
							String id="";
							String sql="";
							String link="";
							String empname="";
							id="";
							id=request.getParameter("staffid");
							sql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,FIND_A_EMPLOYEE_ID_NAME(a.CHR_EMPID),a.CHR_PF,a.CHR_PFTYPE,a.CHR_PFNO,a.INT_PFAMT, a.CHR_NOMINEE,a.CHR_NOMINEE_RELATIONSHIP,a.CHR_ESI,a.CHR_ESITYPE,a.CHR_ESINO ,a.INT_ESIAMT,a.INT_PLACEID,IF(a.CHR_PFCALCULATIONTYPE= 'T1','Type-I','Type-II'),a.CHR_PROFESSIONALTAX FROM com_m_staff a WHERE CHR_EMPID= '"+id+"'";
							//out.println(sql);
							String data[][]= CommonFunctions.QueryExecute(sql);
							id=data[0][0];
							String actionS="";
							String value="Update";
							link=" onKeyUp=\" CheckUnique(this,'divunitname','com_m_staff','CHR_ACCNO')\" ";
						 
							
						%>
                  PF AND ESI UPDATION FOR <%=data[0][2]%>
				
				    			
				
				</div></td>
                </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="100%" border="0" align="center" cellpadding="2"
												cellspacing="2">
                  <tr>
                    <td width="52%" height="167"><table width="100%" border="0" align="center"
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
                          <td class="boldEleven"><input name="txtpfno" type="text" class="formText135" id="txtpfno" tabindex="40"  onkeypress="return numeric_only(event,'txtpfno','15');" onKeyUp="CheckUnique(this,'divpfnumber','com_m_staff','CHR_PFNO')" value="<%=data[0][5]%>" size="30" maxlength="13" />
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
                          <td class="boldEleven"><input name="uannumber" id="uannumber" type="text" class="formText135" size="30" maxlength="12"  onkeypress="return numeric_only(event,'uannumber','15');" tabindex="40" onKeyUp="CheckUnique(this,'divuanpfnumber','com_m_staff','CHR_PF_UAN')" /></td>
                        </tr>
                    </table></td>
                    <td width="48%"><table width="100%" border="0" align="center"
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
																 size="30" maxlength="13" value="<%=data[0][11]%>"  tabindex="55"  onKeyPress="return numeric_only(event,'txtesno','14'); "  onKeyUp="CheckUnique(this,'divesinumber','com_m_staff','CHR_ESINO')" />
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
                         <script language="javascript">setOptionValue('professionaltax','<%=data[0][15]%>')</script>	
                        </td>
                      </tr>
                    </table></td>
                    </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                  </tr>
                </table></td>
                </tr>
               
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input name="filename" type="hidden" value="StaffRegistration" />
				<input type="hidden" name="actionS"  value="GENStaffRegistrationPFESIUpdation" />
				<input name="id" type="HIDDEN" id="id" value="<%=id%>">				</td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" id="Submit" type="submit" 	class="buttonbold13" value="<%=value%>"></td>
                    <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('Staff_PFandESI_Changes.jsp')"></td>
                  </tr>
                </table></td>
                </tr>
            </table>
		 </td>
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
    </table> </form></td>
  </tr>
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
