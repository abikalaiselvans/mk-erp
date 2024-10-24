<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html>
<head>
<title>:: INVENTORY ::</title> 
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
 <script language="javascript" src="../JavaScript/Numericfunctions.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="JavaScript">

function  selectTaxType(){
if(document.getElementById('flag').checked)
	{
		t1.style.visibility="Visible";
		t2.style.visibility="hidden";
		setOptionValue('IGST','100.0'); 
		
 	}	
	else 
	{
		t1.style.visibility="hidden";
		t2.style.visibility="Visible";
		setOptionValue('IGST','0.0'); 
	}	
}

function Validate()
  {
	
   
	if(  checkNull( "TxtTaxName","Enter Tax Name ..." ) && checkNull( "TxtTaxValue","Enter Tax Value..." )  
		 && checkIsNumeric('TxtTaxValue','Invalid Tax value...')
		 && checkNull( "TxtTaxDes","Enter Tax Description..." ) 
		 
		  )
		return true;
	else
		return false;				
		
	
 } 	
 
  

</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<%@ include file="indexinv.jsp"%>
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
	<table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
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
                <td colspan="3" class="bold1"><div align="center"> TAX 
				
				    <%
							String action=request.getParameter("action1");
							String id="",name="",desc="",actionS="",value="";
							String sql="";
							String link="";
							String taxValue="";
							String flag="",igst="100.0",cgst="50.0",sgst="50.0";
							if("Add".equals(action))
							{
								id="";name=""; desc="";
								actionS="INVtaxAdd";
								value="Add";taxValue="";
								flag="";igst="100.0";cgst="50.0";sgst="50.0";
								link=" onBlur=\"upperMe(this), CheckUnique(this,'divunitname','inv_m_tax','CHR_TAXNAME')\"  onKeyUp=\" CheckUnique(this,'divunitname','inv_m_tax','CHR_TAXNAME')\" ";
								
							}
							else
							{
								id="";name=""; flag="Y";igst="100.0";cgst="50.0";sgst="50.0";
								id=request.getParameter("rowid");
								sql = " SELECT INT_TAXID,CHR_TAXNAME,DOU_VALUE,CHR_DES,CHR_FLAG,ROUND(DOU_IGST,1),ROUND(DOU_SGST,1),ROUND(DOU_CGST,1)  FROM inv_m_tax  WHERE INT_TAXID= "+id;
 								String data[][]=CommonFunctions.QueryExecute(sql);
								id=data[0][0];name=data[0][1];  taxValue=data[0][2];  desc=data[0][3]; 
								flag=data[0][4];igst=data[0][5];sgst=data[0][6];cgst=data[0][7];
								actionS="INVtaxEdit";
								value="Update";
								link=" onBlur=\" upperMe(this),CheckUnique(this,'divunitname','inv_m_tax','CHR_TAXNAME')\"  onKeyUp=\" CheckUnique(this,'divunitname','inv_m_tax','CHR_TAXNAME')\" ";
							}
							
						%>			
				
				</div></td>
                </tr>
              <tr>
                <td width="31%" class="boldEleven"> Name <span class="boldred">*</span> </td>
                <td width="69%" colspan="2" class="boldEleven"><input name="TxtTaxName" type="text" class="formText135" id="TxtTaxName" <%=link%>         value="<%=name%>" size="40" maxlength="100">
				<div id='divunitname'></div>											</td>
              </tr>
              
              <tr>
                <td valign="top" class="boldEleven">Tax Value  <span class="boldred">*</span> </td>
                <td colspan="2" valign="top" class="boldEleven">
<input 	name="TxtTaxValue"  type="text" class="formText135" id="TxtTaxValue" value="<%=taxValue%>" size="40" maxlength="5"  onkeyup="extractNumber(this,2,true);" onKeyPress="return blockNonNumbers(this, event, true, true);"></td>
              </tr>
              <tr>
                <td valign="top" class="boldEleven">IGST / SGST</td>
                <td valign="top" class="boldEleven"><label> 
                  <input name="flag" type="checkbox" id="flag" onClick="selectTaxType()" value="Y" <%=flag.equals("Y")?" checked":""%>>
                </label></td>
                <td valign="top" class="boldEleven"><table id='t1' border="0" cellspacing="0" class="boldEleven">
                  <tr>
                    <td>SGST</td>
                    <td><select name='SGST' id='SGST'>
                        <%
						for(double x=0;x<=100;x=x+0.50)
							out.println("<option value='"+x+"'>" +x +"  %</option>");
					%>
                    </select> 
						<script>setOptionValue('SGST',"<%=sgst%>");</script>

					</td>
                    <td>CGST</td>
                    <td><select name='CGST' id='CGST'>
                        <%
						for(double x=0;x<=100;x=x+0.5)
							out.println("<option value='"+x+"'>" +x +"  %</option>");
					%>
                    </select><script>setOptionValue('CGST',"<%=cgst%>");</script></td>
                  </tr>
                </table></td>
              </tr>
              <tr >
                <td valign="top" class="boldEleven">&nbsp;</td>
                <td colspan="2" valign="top" class="boldEleven"><table  id='t2' border="0" cellspacing="0" class="boldEleven">
                  <tr>
                     <td>IGST</td>
                    <td><select name='IGST' id='IGST'><%
						for(double x=0;x<=100;x=x+0.5)
							out.println("<option value='"+x+"'>" +x +"  %</option>");
					%>
					</select><script>setOptionValue('IGST',"<%=igst%>");selectTaxType()</script></td>
                  </tr>
                </table></td>
              </tr>
              
              <tr>
                <td valign="top" class="boldEleven"> Description  <span class="boldred">*</span> </td>
                <td colspan="2" valign="top" class="boldEleven"><textarea name="TxtTaxDes"  id="TxtTaxDes" cols="35"
								rows="5" class="formText135"    onBlur="upperMe(this)"     
								onKeyPress="textArea('TxtTaxDes','400')"><%= desc%></textarea></td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td colspan="2" class="boldEleven">
				<input type="hidden" name="filename" value="Tax" />
				<input type="hidden" name="actionS"  value="<%=actionS%>" />
				<input name="taxId" type="HIDDEN" id="taxId" value="<%=id%>">				 </td>
              </tr>
              <tr>
                <td colspan="3" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" id="Submit" type="submit" 	class="buttonbold13" value="<%=value%>"></td>
                    <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('TaxView.jsp')"></td>
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
	System.out.println(e.getMessage());
}
%>
</body>
</html>
