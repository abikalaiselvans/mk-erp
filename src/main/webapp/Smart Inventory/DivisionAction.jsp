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
	 try
	 {
			if(  checkNull("Division","Enter Division Name")  
				&& checkNull("Divisionshortname","Enter Divisionshortname") 
				&& codeLength('Divisionshortname', '3')
				&& checkNullSelect("divisionhead","Select the divisionhead",'0') 
				&& checkNull("email","Enter email")
				&& chkemail('email')
				 && anyCheck( ) 
				 ) 
			{
					return true;
			}
			else
				return false;		
	 }	
	 catch(err)
	 {
	 }	
} 	
 
function codeLength(ctr, inputLength) 
{
	var inputString = document.getElementById(ctr).value;
	if(inputString.length >= inputLength)
		return true;
	else
	{
			alert("Atleast "+inputLength+"-Character required");
			document.getElementById(ctr).focus();
			return false;
	}
}

 
 function  chkCertification()
 {
 	if(document.getElementById("checkbox").checked == true)
		return true;
	else
	{
		alert("Atleast One Office Tick..");
		return false;
	}
 }
 
 
 
function anyCheck( ) 
{
		var count;
		count=0;
		coffee1=document.forms[0].checkbox
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
				count=count+1;
			}
		}
		 
		 if(count>=1)
		 {			
				return true;			
		 }
		 else
		{
		    alert("Select Atleast One Office");
		    return false;
		}		
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
	<table class="BackGround1" cellspacing="0" cellpadding="0" width="600"
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
                <td colspan="2" class="bold1"><div align="center"><span class="boldThirteen">Division/Team Information</span>
                    <%
							String action=request.getParameter("action1");
							String id="", actionS="",value="";
							String sql="";
							String link="";
							String link1="";
							String cid="";
							String Division="",Divisionshortname="",email="";
							String taxValue="";
							if("Add".equals(action))
							{
								id=""; cid="";
								actionS="INVDivisionAdd";
								value="Add";taxValue="";
								Division="";Divisionshortname="";email="";
								link=" onKeyUp=\"upperMe(this),CheckUnique(this,'divunitname','inv_m_division','CHR_DIVICODE')\" ";
								
								link1=" onKeyUp=\"upperMe(this),CheckUnique(this,'divunitname1','inv_m_division','CHR_DIVISHORTCODE')\" ";
								
							}
							else
							{
								id=""; 
								id=request.getParameter("rowid");
								sql = "SELECT INT_DIVIID,CHR_DIVICODE,CHR_DIVISHORTCODE,CHR_EMAILID,CHR_OFFICEIDS  FROM inv_m_division WHERE INT_DIVIID   = "+id;
								String data[][]=CommonFunctions.QueryExecute(sql);
								id=data[0][0];
								Division=data[0][1];  
								Divisionshortname=data[0][2];  
								email=data[0][3];  
								cid=data[0][4];  
								actionS="INVDivisionUpdate";
								value="Update";
								link=" onBlur=\"upperMe(this)\"";
								link1=" onBlur=\"upperMe(this)\"";
							}
							
						%>			
                  
                </div></td>
                </tr>
               
              <tr>
                <td width="200" class="boldEleven">Division/Team Name <span
									class="bolddeepred">* </span></td>
                <td width="359" class="boldEleven"><input name="Division"
									type="text"     onBlur="upperMe(this)"     class="formText135" id="Division" value="<%=Division%>"
									<%=link%>
									maxlength="50" size="40"><div id="divunitname"></div></td>
              </tr>
              <tr>
                <td class="boldEleven">Division/Team Short Name <span class="bolddeepred">* </span> </td>
                <td class="boldEleven"><input name="Divisionshortname" value="<%=Divisionshortname%>"
									type="text"     onBlur="upperMe(this)"     class="formText135" id="Divisionshortname"
										<%=link1%>
									maxlength="3" size="10"><div id="divunitname1"></div></td>
              </tr>
              <tr>
                <td class="boldEleven">Email <span class="bolddeepred">* </span></td>
                <td class="boldEleven"><input name="email" value="<%=email%>"
									type="text" class="formText135" id="email"
									 
									maxlength="60" size="40"></td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">Division/Team Head <span class="bolddeepred">* </span></td>
                <td align="left" valign="top" class="boldEleven">
<select name="divisionhead" class="formText135" id="divisionhead" style="width:250">
<option value="0">Select Division Head</option>
<%
 String headdata[][]=CommonFunctions.QueryExecute("SELECT a.CHR_EMPID,a.CHR_STAFFNAME  FROM com_m_staff a  WHERE CHR_REP='Y' ORDER  BY a.CHR_EMPID");
 if(headdata.length>0)
 {
     for(int u=0;u<headdata.length;u++)
     {
         out.println("<option value='"+headdata[u][0]+"'>"+headdata[u][1]+"</option>");
     }
 }
%>
</select>

                </td>
              </tr>
              <tr>
                <td align="left" valign="top" class="boldEleven">Office </td>
                <td align="left" valign="top" class="boldEleven">
				
				
				  <%
		String s="";		  
		if(!"Add".equals(action))
		{
			  
			 String cycle[][] =  CommonFunctions.QueryExecute("SELECT INT_OFFICEID,CHR_OFFICENAME FROM com_m_office  ORDER BY CHR_OFFICENAME ");
			 String cycleid[] =cid.split(",");
			 
			 out.println("<center><table width='100%' cellspacing=2 cellpadding=1 border=0>");
			 out.println("<tr>");
			 for(int x=0;x<cycle.length;x++)
			 {
				s="";
				if(x%3 == 0)
				{
					out.println("<tr>");
					for(int g=0;g<cycleid.length;g++)
						if(cycleid[g].equals(cycle[x][0]))
							s=" checked = checked";
					out.println("<td class='boldEleven'><input "+s+" type='checkbox' name='checkbox' id='checkbox' value='"+cycle[x][0]+"' >"+cycle[x][1]);	
				}	
				else
				{
					for(int g=0;g<cycleid.length;g++)
						if(cycleid[g].equals(cycle[x][0]))
							s=" checked = checked";
					out.println("<td class='boldEleven'><input "+s+" type='checkbox' name='checkbox' id='checkbox' value='"+cycle[x][0]+"' >"+cycle[x][1]);				}	
			 }
			 out.println("</table></center>");
			 
		}
		else
		{				  
			String cdata[][] =  CommonFunctions.QueryExecute(" SELECT INT_OFFICEID,CHR_OFFICENAME FROM com_m_office  ORDER BY CHR_OFFICENAME ");
			out.println("<center><table width='100%' cellspacing=2 cellpadding=1 border=0>");
			out.println("<tr>");
			
				for(int u=0;u<cdata.length;u++)
				{
					if(u%3 == 0)
					{
							out.println("<tr>");
							out.println("<td class='boldEleven'><input type='checkbox' name='checkbox' id='checkbox' value='"+cdata[u][0]+"'>"+cdata[u][1]+"</td>");	
					}	
					else
						out.println("<td class='boldEleven'><input type='checkbox' name='checkbox' id='checkbox' value='"+cdata[u][0]+"'>"+cdata[u][1]+"</td>");	
				}	
					
					
			out.println("</table></center>");		
		}	
				  %>
				  
				
				</td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input type="hidden" name="filename" value="Division" />
				<input type="hidden" name="actionS"  value="<%=actionS%>" />
				<input name="rowid" type="HIDDEN" id="rowid" value="<%=id%>">				 </td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" id="Submit" type="submit" 	class="buttonbold13" value="<%=value%>"></td>
                    <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('DivisionView.jsp')"></td>
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
