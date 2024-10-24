<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html>
<head>
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

 function validate()
  {
  	try
	{
      if( checkNull('aname','Enter Allowance Name'))
          return true;          
	  else
      	return true;              
	}
	catch(err)
	{
		alert(err)
		return false;
	}	
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
	 <form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return validate()">
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
                <td colspan="2" class="bold1"><div align="center"><span class="boldThirteen">ALLOWANCE</span>
                    <%
							String action=request.getParameter("action1");
							 
							String id="",actionS="",value="";
							String sql="";
							String link="";
							String code="",addedtogross="",changes="",addedtobonus="",name="";
							if("Add".equals(action))
							{
								id="";
								code="";addedtogross="N";changes="N";addedtobonus="N";name="";
								actionS="PAYallowanceAdd";
								value="Add";
								link=" onBlur=\"upperMe(this), CheckUnique(this,'divunitname','pay_m_allowance','CHR_ANAME')\"  onKeyUp=\"upperMe(this),CheckUnique(this,'divunitname','pay_m_allowance','CHR_ANAME')\" ";
								
							}
							else
							{
								id="";
								id=request.getParameter("rowid");
								sql = "SELECT INT_ALLOWANCEID,CHR_ACODE,CHR_ANAME,CHR_FLAG,CHR_MONTHFLAG,CHR_BONUS FROM  pay_m_allowance WHERE INT_ALLOWANCEID = "+id;
								 
								String data[][]=CommonFunctions.QueryExecute(sql);
								id=data[0][0];
								code=data[0][1];  
								name=data[0][2];  
								addedtogross=data[0][3];  
								changes=data[0][4];  
								addedtobonus=data[0][5];  

								
								actionS="PAYallowanceEdit";
								value="Update";
								link=" onBlur=\"upperMe(this)\"";
							}
							
						%>			
                  
                </div></td>
                </tr>
              <tr>
                <td width="31%" valign="middle" class="boldEleven">Code <font color='red'>*</font></td>
                <td width="268" valign="top" class="boldEleven"><%=code%></td>
              </tr>
              <tr>
                <td class="boldEleven">Added to GP</td>
                <td class="boldEleven"><%
			out.println("<table  border='0' cellspacing='0' cellpadding='0'>");
			out.println("<tr>");
			out.println("<td>");
			String assignflag="";
			String assignflag1="";
			if("Y".equals(addedtogross))
				assignflag="checked='checked'";
			else
				assignflag1="checked='checked'";
			
			out.println("<input name='Flag' type='radio'    value='Y' "+assignflag+"  class='formText135' />");                                          
			out.println("<td class='boldEleven'>Yes</td>");
			out.println("<td>");
			out.println("<input name='Flag' type='radio'   value='N' "+assignflag1+" class='formText135' /> ");                                        
			out.println("<td class='boldEleven'>No</td>");
			out.println("</tr></table>");
        %>
                </td>
              </tr>
              <tr>
                <td valign="middle" class="boldEleven">Changes</td>
                <td valign="top" class="boldEleven"><table width="50" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="20" class="boldEleven"><%
			  	String mchanges1= "";
				String mchanges2= "";
				if("Y".equals(changes))
					mchanges1 =" checked='checked' ";
				if("N".equals(changes))
					mchanges2 =" checked='checked' ";
					 
			  %> 
                          <input name="changes" type="radio" value="M" <%=mchanges1%>></td>
                      <td width="50" class="boldEleven">Month</td>
                      <td width="20" class="boldEleven"><input name="changes"
										type="radio" value="Y" <%=mchanges2%>></td>
                      <td width="110" class="boldEleven">Year</td>
                    </tr>
                </table></td>
              </tr>
              <tr>
                <td valign="middle" class="boldEleven">Added to Bonus </td>
                <td valign="top" class="boldEleven"><table width="50" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="20" class="boldEleven"><%
			  	String bonus1= "";
				String bonus2= "";
				if("Y".equals(addedtobonus))
					bonus1 ="checked='checked'";
				if("N".equals(addedtobonus))
					bonus2 ="checked='checked'";
					 
			  %>
                          <input name="Bonus" type="radio" value="Y" <%=bonus1%>></td>
                      <td width="50" class="boldEleven">Yes</td>
                      <td width="20" class="boldEleven"><input name="Bonus"
										type="radio" value="N" <%=bonus2%>></td>
                      <td width="110" class="boldEleven">No</td>
                    </tr>
                </table></td>
              </tr>
              <tr>
                <td valign="middle" class="boldEleven">Name <font
								color='red'>*</font></td>
                <td valign="top" class="boldEleven"><input name="aname" type="text"
								class="formText135" id="aname"  
								onBlur="upperMe(this)"  
								value="<%= name %>"  size="40" maxlength="50" <%=link%>>
                   <div id='divunitname'></div></td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input type="hidden" name="filename" value="Allowance" />
				<input type="hidden" name="actionS"  value="<%=actionS%>" />
				<input name="rowid" type="HIDDEN" id="rowid" value="<%=id%>">				 </td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" id="Submit" type="submit" 	class="buttonbold13" value="<%=value%>"></td>
                    <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('AllowanceView.jsp')"></td>
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
