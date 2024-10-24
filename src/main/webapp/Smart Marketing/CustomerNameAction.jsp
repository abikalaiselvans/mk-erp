   <%@ page import="java.sql.*,java.util.*,java.io.*"%>
 <%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html>
<head>
<title> :: MARKETING ::</title> 
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
	if(  checkNull( "customername","Enter The Account  ..." ) && checkNameLength() && checkNullSelect( "division","select the division  ...","0" ) )
		return true;
	else
		return false;				
 } 	
 
 function checkNameLength()
 {
	 try
	 {
		 var customername = document.getElementById('customername').value;
		 if(customername.length >=8)
		 {
			 return true;
		 }
		 else
		 {
			 alert("Check the customer name");
			 return false;
		 }
	

	 }
	 catch(err)
	 {
		 alert(err);
		 return false;
	 }
 }
</script>



<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>

<script type="text/javascript">
function lookup(SerialNumber) 
{
	if(SerialNumber.length == 0) 
	{
		$('#suggestions').hide();
	} 
	else 
	{
		$.post("Search_Customername.jsp", {queryString: ""+SerialNumber+""}, function(data)
		{
			if(data.length >0) 
			{
				$('#suggestions').show();
				$('#autoSuggestionsList').html(data);
			}
		});
	}
}

function fill(thisValue) 
{
	setTimeout("$('#suggestions').hide();", 200);
}

 
</script>
<style type="text/css">
body {
font-family: Helvetica;
font-size: 13px;
color: #000;
}
h3 {
margin: 0px;
padding: 0px;
}


.suggestionsBox 
{
	position: relative;
	margin: 0px 0px 0px 0px;
	width: 300px;
	background-color: #ffffff;
	-moz-border-radius: 7px;
	-webkit-border-radius: 7px;
	border: 1px solid #000;
	color: #000;
}
.suggestionList 
{
	margin: 0px;
	padding: 0px;
}
.suggestionList li 
{
	margin: 0px 0px 3px 0px;
	padding: 1px;
	cursor: pointer;
}

.suggestionList li:hover {
background-color: #99cc99;
}
</style>




<body onselectstart="return false" onpaste="return false;" onCopy="return false"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
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
	<table class="BackGround1" cellspacing="0" cellpadding="0" width="700"
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
                <td colspan="3" class="bold1"><div align="center"><span class="boldThirteen">CUSTOMER NAME</span>
                  
                      <%
							String action=request.getParameter("action1");
							String msg= ""+request.getParameter("msg");
							String rowid= ""+request.getParameter("rowid");
							
							String id="",name="",sortname="",verify="N",desc="",actionS="",value="",division="0";
							String sql="";
							String link="";
							String link1="";
							String taxValue="";
							if("Add".equals(action))
							{
								id="";name=""; desc="";sortname="";verify="N";division="0";
								actionS="MKTCustomerNameAdd";
								value="Add";taxValue="";
link=" onKeyUp=\"upperMe(this),lookup(this.value),CheckUnique(this,'divunitname','mkt_m_customername','CHR_NAME')\" ";
link1=" onKeyUp=\"upperMe(this), CheckUnique(this,'divshort','mkt_m_customername','CHR_SHORT')\" ";
								
	 					}
							else
							{
								id="";name=""; 
								id=request.getParameter("rowid");
								sql = "SELECT INT_CUSTOMERNAMEID,CHR_NAME,CHR_SHORT,CHR_VERIFY,INT_DIVIID FROM mkt_m_customername WHERE INT_CUSTOMERNAMEID="+id;
								String data[][]=CommonFunctions.QueryExecute(sql);
								id=data[0][0];name=data[0][1]; sortname=data[0][2];verify=data[0][3];division=data[0][4];
								actionS="MKTCustomerNameEdit";
								value="Update";
								link=" onBlur=\"upperMe(this),fill()\"  ";
								link1="";
							}
							
						%>			
                  
                </div></td>
                </tr>
              <tr>
                <td width="19%" class="boldEleven">Account  Name<font color="ff0000"> *</font></td>
                <td width="79%" class="boldEleven">
                <input name="customername" type="text" class="formText135" id="customername" <%=link%>     onBlur="upperMe(this)"      value="<%=name%>" size="40" maxlength="100" >
				
				<div class="suggestionsBox" id="suggestions" style="display: none; width:440">
					<div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:100px" ></div>
				</div> 
				<span class="boldred">For e.g  Mythra IT SOLUTIONS,</span><br>
				<div id='divunitname'></div>
				<br></td>
                <td width="2%" class="boldEleven"></td>
              </tr>
               
              <tr>
                <td class="boldEleven">Short Name </td>
                <td class="boldEleven"><input name="shortname" <%=link1%> type="text" class="formText135" id="shortname" onBlur="upperMe(this)" value="<%=sortname%>" maxlength="6">
                  <span class="errormessage">Mythra</span><br>
				<div id='divshort'></div>
				<br></td>
                <td class="errormessage">&nbsp;</td>
              </tr>
              <tr>
                <td class="boldEleven">Division <font
									color="ff0000"> *</font></td>
                <td class="boldEleven"><span class="boldThirteen">
                  <select name="division"
							class="formText135" id="division" tabindex="1"  style="width:300" >
                    <option value='0'>Select Division</option>
                    <%
								String divisionData[][] =  CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0   ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<divisionData.length; u++)
									out.print("<option value='"+divisionData[u][0]+"'>"+divisionData[u][1]  +"</option>");
							%>
                  </select>
                  <script language="javascript">setOptionValue('division','<%=division%>')</script>
                  <input type="hidden" name="filename" value="CustomerName" />
                  <input type="hidden" name="actionS"  value="<%=actionS%>" />
                  <input name="Rowid" type="HIDDEN" id="Rowid" value="<%=id%>">
                </span></td>
                <td class="boldEleven">&nbsp;</td>
              </tr>
              
              
              
              <%
					if(!"Add".equals(action))
					{
						if(  "F".equals(""+session.getAttribute("USERTYPE")) || "B".equals(""+session.getAttribute("USERTYPE"))  )
						{
							out.println("<tr>");
							out.println("<td class='boldEleven'>Verification</td> ");
							out.println("<td class='boldEleven'>");
							
							
							out.println("<select name='verification'  id='verification' class='formText135' > ");
							out.println("<option value='N'>Pending</option> ");
							out.println("<option value='Y' selected='selected' >Verified</option> ");
							out.println("<option value='R'>Reject</option> ");
							out.println("</select> ");
							%>
                            <script language="javascript">setOptionValue('verification','<%=verify%>')</script>
                            <%
							 
							out.println("</td>");
							out.println("<td class='boldEleven'> </td>");
							out.println(" </tr>");
							
						}
						else
						{
							out.println("<input type='hidden' name='verification'  id='verification' value='"+verify+"'>");
						
						}
						
					}
					%>
                     
              
              
              <tr>
                <td colspan="3" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" id="Submit" type="submit" 	class="buttonbold13" value="<%=value%>"></td>
                    <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('CustomerName.jsp')"></td>
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
	if("Y".equals(msg))
	{
%>
<script language="javascript" >
	var rs=confirm("Account name added successfully, Are you want to add a account informations...");
	if (rs==true)
  		location = "CustomerInfoAction.jsp?action1=Add&customerrowid=<%=rowid%>"; 
	else
		location = "CustomerNameAction.jsp?action1=Add Customer";
			
</script>
<%			
	}
 
}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>
</body>
</html>
