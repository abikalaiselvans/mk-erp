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
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="JavaScript">

function Validate()
  {
	if(  
		 checkNull( "unittype","Select Equipment type" ,'' ) 
		 && checkNull( "model","Enter The Equipment Model" ) 
	     &&  checkNull( "desc","Enter The description" )
		  )
		return true;
	else
		return false;				
		
	
 } 	
 
  

</script>
<body   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="document.getElementById('model').focus()" >
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
                <td colspan="2" class="bold1"><div align="center"><span class="boldThirteen">EQUIPMENT MODEL</span>
                    <%
							String action=request.getParameter("action1");
							String type=request.getParameter("type");
							 
							String id="",name="",desc="",actionS="",value="";
							String sql="";
							String link="";
							String unitid=""; 
							String taxValue="";
							String oem,equivalent;
							if("Add".equals(action))
							{
								id="";name=""; desc=" ";unitid=""; 
								 
								actionS="INVEquipementModelAdd";
								value="Add";taxValue="";
								link=" onBlur=\"upperMe(this), CheckUnique(this,'divunitname','spare_m_equipement_model','CHR_MODEL')\"  onKeyUp=\"upperMe(this),CheckUnique(this,'divunitname','spare_m_equipement_model','CHR_MODEL')\" ";
								
							}
							else
							{
								id="";name=""; 
								id=request.getParameter("rowid");
								sql = "SELECT INT_INT_EQUIPEMENTMODELID,INT_EQUIPEMENTTYPEID,CHR_MODEL,CHR_DESC FROM spare_m_equipement_model WHERE INT_INT_EQUIPEMENTMODELID= "+id;
								String data[][]=CommonFunctions.QueryExecute(sql);
								id=data[0][0];unitid=data[0][1]; name=data[0][2];  
								desc=data[0][3]; 
								 
								actionS="INVEquipementModelEdit";
								value="Update";
								link=" onBlur=\"upperMe(this)\"";
							}
							
						%>			
                  
                </div></td>
                </tr>
              <tr>
                <td class="boldEleven">Equipment type <span class="boldred"> *</span></td>
                <td class="boldEleven"><select name="unittype" id="unittype" class="formText135" style="width:200" >
                 <option value="" >Select Equipement Type</option>
                  <%
String	typeData[][]= CommonFunctions.QueryExecute("SELECT INT_EQUIPEMENTTYPEID,CHR_EQUIPEMENTTYPENAME  FROM spare_m_equipement_type   ORDER BY CHR_EQUIPEMENTTYPENAME");
for(int u=0;u<typeData.length;u++)
	out.println("<option value='"+typeData[u][0]+"'>"+typeData[u][1]+"</option>");
				%>
                </select>
                <script language="javascript">setOptionValue('unittype','<%=type%>')</script>
                </td>
              </tr>
              <tr>
                <td width="32%" class="boldEleven">Model</td>
                <td width="68%" class="boldEleven"><input name="model" type="text" class="formText135" id="model" <%=link%>     onBlur="upperMe(this)"      value="<%=name%>" size="38" maxlength="60">
				<div id='divunitname'></div>											</td>
              </tr>
               
              <tr>
                <td align="left" valign="top" class="boldEleven">Description <span class="boldred">*</span></td>
                <td align="left" valign="top" class="boldEleven"><textarea name="desc" cols="35" rows="5" class="formText135" id="desc" onKeyPress="textArea('desc','450')" ><%=desc%></textarea></td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input type="hidden" name="filename" value="EquipementModel" />
				<input type="hidden" name="actionS"  value="<%=actionS%>" />
				<input name="rowid" type="HIDDEN" id="rowid" value="<%=id%>">				 
				<input name="userid" type="hidden" id="userid" value="<%=""+session.getAttribute("USRID")%>"></td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" id="Submit" type="submit" 	class="buttonbold13" value="<%=value%>"></td>
                    <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('EquipementModel.jsp')"></td>
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
