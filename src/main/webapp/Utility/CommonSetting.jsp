<%@ page contentType="text/html; " language="java" import="java.sql.*" 	errorPage="../error/index.jsp"%>

<%@include file="Redirect.jsp" %>

<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<html>
<head>

<title> :: UTILITY :: </title>

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
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

 <link href="style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="JavaScript">
function mainPage()
	{
	    document.a.action="SettingType.jsp";
		
		return true;
    }
	
function valid()
{
	if( checkNull(ctr,msg))
		return true;
	else
		return false;
}	
	//&& chkemail('emailid')
</script>

<script language="javascript">         
function  Valid()
{
	var name=confirm("Want to update the settings")
	if (name==true)
	{ 
		 if(
		     checkNull('companyname','Enter Company Name')
			 && checkNull('companyaddress','Enter company address')
			 && checkNull('city','Enter city')
			 && checkNull('state','Enter state')
			 && checkNull('pincode','Enter pincode')
			 && checkNull('phone','Enter phone')
			 && checkNull('mailid','Enter mailid')
			 && checkNull('pf','Enter PF')
			 && checkNull('esi','Enter ESI')
			 && checkNull('companypf1','Enter company pf1')
			 && checkNull('companypf2','Enter company pf2')
			 && checkNullSelect('loginby','Select Login By','0')
			 
		   )
		 {
		 	return true;
		 }
		 else
		 {
		 	return false;
		 }			
	}
	else
		return false;
}		  

// onpaste='return false;'
</script>



<body>
<form name="a" action="../SmartLoginAuth" method="post"  onSubmit="return Valid()" >
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td> </td>
	</tr>
	<tr>
		<td align="center">
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
                <td><table width="98%" border='0' align="center" cellpadding='1' cellspacing='2'  class='boldEleven'>
                    <!--DWLayoutTable-->
                    <tr align="center" valign="middle">
                      <td height="28" colspan="5"  class="BackGround">Common
                        Information
                        <input name="filename" type="hidden"
								id="filename" value="CommonSetting" />
                        <input name="actionS"
								type="hidden" id="actionS" value="UTICommonSetting" /></td>
                    </tr>
                    <tr class="BackGround">
                      <%
        	Connection con=conbean.getConnection();
        	Statement st=con.createStatement();
        	ResultSet rst=st.executeQuery("SELECT * FROM m_institution");
        	if(rst.next()){        	
        	%>
                      <td width="161" height="28" valign="middle" class="bolddeepblue">Name</td>
                      <td width="177" valign="top"><input name="companyname"  id="companyname"
								type="text" class="formText135" onBlur="upperMe(this)"
								value="<%=rst.getString("CHR_NAME")%>" size="30" maxlength="100"></td>
                      <td width="17" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td width="115" valign="top"><span class="bolddeepblue">PF</span></td>
                      <td width="147" valign="top"><input name="pf"  id="pf" type="text"
								class="formText135" 
								value="<%=rst.getString("INT_PFAMT")%>" size="10" maxlength="7" /></td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="bolddeepblue">Address</td>
                      <td valign="top"><input name="companyaddress"  id="companyaddress" type="text"
								class="formText135" value="<%=rst.getString("CHR_ADD1")%>"
								size="30" maxlength="100"  onBlur="upperMe(this)"></td>
                      <td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top" class="boldEleven">ESI</td>
                      <td valign="top"><input name="esi"  id="esi"
								type="text" class="formText135"
								 
								value="<%=rst.getString("INT_ESIAMT")%>" size="10" maxlength="7" />                      </td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="bolddeepblue">City</td>
                      <td valign="top"><input name="city"  id="city" type="text"
								class="formText135" value="<%=rst.getString("CHR_CITY")%>"
								size="30" maxlength="100"  onBlur="upperMe(this)" /></td>
                      <td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top" class="boldEleven">Employer
                        PF</td>
                      <td valign="top"><input name="companypf1"
								type="text" class="formText135" id="companypf1"
								onKeyPress="doubleValue('companypf1','5')"
								value="<%=rst.getString("INT_CPY_PFAMT")%>" size="10"
								maxlength="7" />                      </td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="bolddeepblue">State</td>
                      <td valign="top"><input name="state" type="text"
								class="formText135"   id="state"
								value="<%=rst.getString("CHR_STATE")%>" size="30"
								maxlength="100"  onBlur="upperMe(this)"/></td>
                      <td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top" class="boldEleven">Employer
                        Pension Fund</td>
                      <td valign="top"><input name="companypf2"
								type="text" class="formText135" id="companypf2"
								onKeyPress="doubleValue('companypf2','5')"
								value="<%=rst.getString("INT_CPY_PENSIONAMT")%> " size="10"
								maxlength="7" />                      </td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="bolddeepblue">Pin</td>
                      <td valign="top"><input name="pincode" type="text" id="pincode" 
								class="formText135" onKeyPress="return numeric_only(event,'pincode','6')"
								value="<%=rst.getString("INT_PINCODE")%>" size="10"
								maxlength="6" /></td>
                      <td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top" class="boldEleven">Employer
                        ESI</td>
                      <td valign="top"><input name="companyesi"
								type="text" class="formText135" id="companyesi"
								onKeyPress="doubleValue('companyesi','5')"
								value="<%=rst.getString("INT_CPY_ESIAMT")%> " size="10"
								maxlength="7" />                      </td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="bolddeepblue">Phone</td>
                      <td valign="top"><input name="phone" type="text" id="phone" 
								class="formText135" onKeyPress="return numeric_only(event,'phone','10')"
								value="<%=rst.getString("INT_PHONE")%>" size="30" maxlength="14" /></td>
                      <td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top" class="boldEleven">salary
                        Calculation
                        <%
			  	String s="";
				String s1="";
				if("D".equals(""+rst.getString("CHR_SALARY")))
					s = " checked ='checked'";
				if("H".equals(""+rst.getString("CHR_SALARY")))
					s1 = " checked ='checked'";	
			  %>                      </td>
                      <td valign="top"><table width="100" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td><input name="salary"  type="radio" value="H" <%=s1%>></td>
                            <td class="boldEleven">Hours</td>
                            <td class="boldEleven"><input name="salary" type="radio"
										value="D" <%=s%>></td>
                            <td class="boldEleven">Day</td>
                          </tr>
                      </table></td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="bolddeepblue">Mail Id</td>
                      <td valign="top"><input name="mailid"  id="mailid"  type="text" required
								class="formText135" value="<%=rst.getString("CHR_MAILID")%>"
								size="30" maxlength="50" /></td>
                      <td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top"><span class="bolddeepblue">Date
                        Lock</span></td>
                      <td valign="top"><span class="bolddeepblue">
                        <%
			if("Y".equals(rst.getString("DAT_LOCK")))
			 	out.println("<input type=\"checkbox\" name=\"dtlock\" value=\"Y\" checked>");
			else
			 	out.println("<input type=\"checkbox\" name=\"dtlock\"  value=\"Y\" >");		
			  %>
                      </span></td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="bolddeepblue">Default Password </td>
                      <td valign="top"><%
						  	String defaultpass = ""+rst.getString("CHR_PASSWORD");
							if(("".equals(defaultpass)) || ("null".equals(defaultpass)))
								defaultpass="";
						  %>
                          <input name="txtpassword"
								type="text" class="formText135" id="txtpassword"
								value="<%=defaultpass%>" size="10"
								maxlength="8" />                      </td>
                      <td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top"><span class="bolddeepblue">Petrol per Kilo Meter</span></td>
                      <td valign="top"><input name="txtpetrol"
								type="text" class="formText135" id="txtpetrol"  onKeyPress="doubleValue('txtpetrol','8')"
								value="<%=rst.getString("DOU_PETROL")%>" size="10"
								maxlength="8" />                      </td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="boldEleven">Copy paste<%
			
			  	s="";
				s1="";
				if("Y".equals(""+rst.getString("CHR_COPYPAST")))
					s = " checked ='checked'";
				if("N".equals(""+rst.getString("CHR_COPYPAST")))
					s1 = " checked ='checked'";	
			
			%> </td>
                      <td valign="top" class="boldEleven">
					   
					  <table width=100%  border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td class="boldEleven"><input name="copypaste" type="radio" value="Y" <%=s%>></td>
                            <td class="boldEleven">Allowed</td>
                            <td class="boldEleven"><input name="copypaste" type="radio" value="N" <%=s1%>></td>
                            <td class="boldEleven">Not Allowed</td>
                          </tr>
                      </table>
					  </td>
                      <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="boldEleven"><span class="bolddeepblue">Session Time </span></td>
                      <td valign="top" class="boldEleven"><input name="sessiontime"  id="sessiontime" type="text"
								class="formText135" onKeyPress="return numeric_only(event,'sessiontime','5')"
								value="<%=rst.getString("INT_SESSION")%>" size="10"
								maxlength="6" />
                          <span class="boldred">in Seconds 3600/hrs </span></td>
                      <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top" class="boldEleven"><span class="bolddeepblue">Server Updation </span></td>
                      <td valign="top" class="boldEleven"><%
			if("Y".equals(rst.getString("CHR_UPDATE")))
			 	out.println("<input type=\"checkbox\" name=\"serverupdate\" value=\"Y\" checked>");
			else
			 	out.println("<input type=\"checkbox\" name=\"serverupdate\" value=\"Y\" value=\"Y\"  >");		
			  %></td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="boldEleven"><span class="bolddeepblue">Conveyance Last </span></td>
                      <td valign="top" class="boldEleven"><input name="conveyance" type="text"
								class="formText135" id="conveyance" onKeyPress="return numeric_only(event,'conveyance','5')"
								value="<%=rst.getString("INT_CONVEYANCECLEAR")%>" size="10"
								maxlength="6" />
                          <span class="boldred">(days)</span></td>
                      <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top" class="boldEleven">Enable Mail Features </td>
                      <td valign="top" class="boldEleven"><%
			if("Y".equals(rst.getString("CHR_MAILALERT")))
			 	out.println("<input type=\"checkbox\" name=\"maialert\" value=\"Y\" checked>");
			else
			 	out.println("<input type=\"checkbox\" name=\"maialert\"  value=\"Y\"   >");		
			  %></td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="boldEleven">Forget Password </td>
                      <td valign="top" class="boldEleven"><%
			if("Y".equals(rst.getString("CHR_FORGETPASSWORD")))
			 	out.println("<input type=\"checkbox\" name=\"fpass\" value=\"Y\" checked>");
			else
			 	out.println("<input type=\"checkbox\" name=\"fpass\"  value=\"Y\" >");		
			  %>
                          <span class="boldred">(display in maialert)</span></td>
                      <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top" class="boldEleven">Enable SMS  Features </td>
                      <td valign="top" class="boldEleven"><%
			if("Y".equals(rst.getString("CHR_SMSALERT")))
			 	out.println("<input type=\"checkbox\" name=\"sms\" value=\"Y\" checked>");
			else
			 	out.println("<input type=\"checkbox\" name=\"sms\"  value=\"Y\" >");		
			  %></td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="boldEleven">Leave Updation
                        <%
			
			  	s="";
				s1="";
				if("A".equals(""+rst.getString("CHR_LEAVEUPDATE")))
					s = " checked ='checked'";
				if("M".equals(""+rst.getString("CHR_LEAVEUPDATE")))
					s1 = " checked ='checked'";	
			
			%>                      </td>
                      <td valign="top" class="boldEleven"><table width=50  border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td class="boldEleven"><input name="leaveupdation" type="radio" value="A" <%=s%>></td>
                            <td class="boldEleven">Automatic</td>
                            <td class="boldEleven"><input name="leaveupdation" type="radio" value="M" <%=s1%>></td>
                            <td class="boldEleven">Manual</td>
                          </tr>
                      </table></td>
                      <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top" class="boldEleven">Hide Admin Info's </td>
                      <td valign="top" class="boldEleven"><%
			
			if("Y".equals(rst.getString("CHR_ADMININFORMATION")))
			 	out.println("<input type=\"checkbox\" name=\"adminhide\" value=\"Y\" checked>");
			else
			 	out.println("<input type=\"checkbox\" name=\"adminhide\"  value=\"Y\" >");		
			
			%>                      </td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="boldEleven">Staff Order By
                        <%
			
			  	s="";
				s1="";
				String ds1="";
				if("I".equals(""+rst.getString("CHR_ORDERBY")))
					s = " checked ='checked'";
				if("N".equals(""+rst.getString("CHR_ORDERBY")))
					s1 = " checked ='checked'";	
				if("D".equals(""+rst.getString("CHR_ORDERBY")))
					ds1 = " checked ='checked'";	
					
			
			%>                      </td>
                      <td valign="top" class="boldEleven"><table  border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td class="boldEleven"><input name="order" type="radio" value="I" <%=s%>></td>
                            <td class="boldEleven">Empid</td>
                            <td class="boldEleven"><input name="order" type="radio" value="D" <%=ds1%>></td>
                            <td class="boldEleven">Emp 6digit id </td>
                            <td class="boldEleven"><input name="order" type="radio" value="N" <%=s1%>></td>
                            <td class="boldEleven">Name</td>
                          </tr>
                      </table></td>
                      <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top" class="boldEleven">Pay Tax 
                        Deduction</td>
                      <td valign="top" class="boldEleven"><%
			if("Y".equals(rst.getString("CHR_PAYTAXDEDUCTION")))
			 	out.println("<input type=\"checkbox\" name=\"paytaxdeduction\" value=\"Y\" checked>");
			else
			 	out.println("<input type=\"checkbox\" name=\"paytaxdeduction\"  value=\"Y\" >");		
			  %>
                          <select name="taxdeductionemp"  id="taxdeductionemp" class="formText135" >
                            <option value="Y">Deducted Emp</option>
                            <option value="N">Non-deducted Emp</option>
                          </select>
                          <script language="javascript">setOptionValue('taxdeductionemp','<%=rst.getString("CHR_TAXDEDUCTIONEMP")%>')</script>                      </td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="boldEleven">bonus Percentage </td>
                      <td valign="top" class="boldEleven"><input id="bonus"  name="bonus" type="text"
								class="formText135" onKeyPress="doubleValue('bonus','5')"
								value="<%=rst.getString("DOU_BONUS")%>" size="10" maxlength="7" /></td>
                      <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top" class="boldEleven">Pay Tax Value
                        <%
			
			  	s="";
				s1="";
				if("P".equals(""+rst.getString("CHR_PAYTAXVALUE")))
					s = " checked ='checked'";
				if("A".equals(""+rst.getString("CHR_PAYTAXVALUE")))
					s1 = " checked ='checked'";	
			
			%></td>
                      <td valign="top" class="boldEleven"><table  border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td class="boldEleven"><input name="paytaxvalue" type="radio" value="P" <%=s%>></td>
                            <td class="boldEleven">Percentage</td>
                            <td class="boldEleven"><input name="paytaxvalue" type="radio" value="A" <%=s1%>></td>
                            <td class="boldEleven">Amount</td>
                          </tr>
                      </table></td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="boldEleven">Minimum working days for bonus </td>
                      <td valign="top" class="boldEleven"><input name="bonusdays" type="text"
								class="formText135" id="bonusdays" onKeyPress="doubleValue('bonus','5')"
								value="<%=rst.getString("INT_BONUSWORKINGDAYS")%>" size="10" maxlength="7" /></td>
                      <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top" class="boldEleven">Privelege Leave limit </td>
                      <td valign="top" class="boldEleven"><input name="leavelimit" type="text"
								class="formText135" id="leavelimit"  onKeyPress="return numeric_only(event,'leavelimit','6')"
								value="<%=rst.getString("INT_LEAVELIMIT")%>" size="10" maxlength="7" /></td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="boldEleven">Reseller Percentage </td>
                      <td valign="top" class="boldEleven"><input name="reseller" type="text"
								class="formText135" id="reseller" onKeyPress="doubleValue('reseller','5')"
								value="<%=rst.getString("DOU_RESELLERPERCENTAGE")%>" size="10" maxlength="7" />
                          <span class="errormessage"> ( % )</span></td>
                      <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top" class="boldEleven">Resignation Limit </td>
                      <td valign="top" class="boldEleven"><input name="resignlimit" type="text"
								class="formText135" id="resignlimit"  onKeyPress="return numeric_only(event,'resignlimit','2')"
								value="<%=rst.getString("INT_RESIGNATIONLIMIT")%>" size="10" maxlength="2" /></td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="boldEleven">Company PF Number </td>
                      <td valign="top" class="boldEleven"><input name="pfnumber" type="text"
								class="formText135" id="pfnumber" value="<%=rst.getString("CHR_PFNUMBER")%>"
								size="30" maxlength="25" /></td>
                      <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top" class="boldEleven">PF Minimum Limit </td>
                      <td valign="top" class="boldEleven"><input name="pflimitminimum" type="text"
								class="formText135" id="pflimitminimum" onKeyPress="return numeric_only(event,'pflimit','10')"
								value="<%=rst.getString("INT_PFLIMITMINIMUM")%>" size="15" maxlength="11" /></td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="boldEleven">Company ESI Number </td>
                      <td valign="top" class="boldEleven"><input name="esinumber" type="text"
								class="formText135" id="esinumber" value="<%=rst.getString("CHR_ESINUMBER")%>"
								size="30" maxlength="25" /></td>
                      <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top" class="boldEleven">PF Maximum Limit </td>
                      <td valign="top" class="boldEleven"><input name="pflimit" type="text"
								class="formText135" id="pflimit" onKeyPress="return numeric_only(event,'pflimit','10')"
								value="<%=rst.getString("INT_PFLIMIT")%>" size="15" maxlength="11" /></td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="boldEleven">Enable Mail  Features For New Joinner </td>
                      <td valign="top" class="boldEleven"><%
			if("Y".equals(rst.getString("CHR_NEWJOINNERMAILALERT")))
			 	out.println("<input type=\"checkbox\" name=\"newjoinnermailalert\" value=\"Y\" checked>");
			else
			 	out.println("<input type=\"checkbox\" name=\"newjoinnermailalert\"  value=\"Y\" >");		
			  %></td>
                      <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top" class="boldEleven">ESI Limit </td>
                      <td valign="top" class="boldEleven"><input name="esilimit" type="text"
								class="formText135" id="esilimit" onKeyPress="return numeric_only(event,'esilimit','10')"
								value="<%=rst.getString("INT_ESILIMIT")%>" size="15" maxlength="11" /></td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="boldEleven">Login Check for address,mail and mobile info </td>
                      <td valign="top" class="boldEleven"><%
			if("Y".equals(rst.getString("CHR_LOGINMAILDCHECK")))
			 	out.println("<input type=\"checkbox\" name=\"loginmailcheck\" value=\"Y\" checked>");
			else
			 	out.println("<input type=\"checkbox\" name=\"loginmailcheck\"  value=\"Y\" >");		
			  %></td>
                      <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top" class="boldEleven">Show</td>
                      <td valign="top" class="boldEleven">
					  <select name="show" id="show" class="formText135">
					  <option value="0">All</option>
					  <option value="R">Regular</option>
					  <option value="N">Non Regular</option>
                      </select>
<script language="javascript">setOptionValue('show','<%=rst.getString("CHR_SHOW_EMPLOYEE")%>')</script>                      </td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="boldEleven">Mail Host </td>
                      <td valign="top" class="boldEleven"><input name="mailhost" type="text" class="formText135" id="mailhost" value="<%=rst.getString("CHR_MAILHOST")%>" size="20" maxlength="15"></td>
                      <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top" class="boldEleven">Default Company Selection For Inventory </td>
                      <td valign="top" class="boldEleven"><select name="company" class="formText135" id="company">
                        <%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_COMPANYID,CHR_COMPANYNAME FROM  com_m_company ORDER BY CHR_COMPANYNAME");
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                      </select></td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="boldEleven">Group Mail </td>
                      <td valign="top" class="boldEleven"><input name="groupmail" type="text" class="formText135" id="groupmail" value="<%=rst.getString("CHR_GROUPMAIL")%>" size="20" maxlength="100"></td>
                      <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top" class="boldEleven">Billing Mailid </td>
                      <td valign="top" class="boldEleven"><input name="billingmailid" type="text"
								class="formText135" id="billingmailid" value="<%=rst.getString("CHR_BILLINGMAILID")%>"
								size="30" maxlength="50" /></td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="boldEleven">Technical  /Technology Infor</td>
                      <td valign="top" class="boldEleven"><input name="technicalmailid" type="text"
								class="formText135" id="technicalmailid" value="<%=rst.getString("CHR_TECHNICALEMAILID")%>"
								size="30" maxlength="50" /></td>
                      <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top" class="boldEleven">Billing Mailid Password </td>
                      <td valign="top" class="boldEleven"><input name="billingmailidpassword" type="text"
								class="formText135" id="billingmailidpassword" value="<%=rst.getString("CHR_BILLINGMAILPASSWORD")%>"
								size="30" maxlength="25" /></td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="boldEleven">HR Mail id </td>
                      <td valign="top" class="boldEleven"><input name="hrmailid" type="text"
								class="formText135" id="hrmailid" value="<%=rst.getString("CHR_HRMAILID")%>"
								size="30" maxlength="50" /></td>
                      <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top" class="boldEleven">Various  Products/Services</td>
                      <td valign="top" class="boldEleven"><input name="productmailid" type="text"
								class="formText135" id="productmailid" value="<%=rst.getString("CHR_PRODUCTMAILID")%>"
								size="30" maxlength="50" /></td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="boldEleven">Company Short Name </td>
                      <td valign="top" class="boldEleven"><input name="cpyshortname"
								type="text" class="formText135" id="cpyshortname"
								value="<%=rst.getString("CHR_SHORTNAME")%>" size="30" maxlength="100"></td>
                      <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top" class="boldEleven">Automatic Attendance Mark </td>
                      <td valign="top" class="boldEleven">
					  
					  
					  <%
			if("Y".equals(rst.getString("CHR_ATTENDANCEMARK")))
			 	out.println("<input type=\"checkbox\" name=\"automaticattendancemark\" id=\"automaticattendancemark\" value=\"Y\" checked>");
			else
			 	out.println("<input type=\"checkbox\" name=\"automaticattendancemark\" id=\"automaticattendancemark\" value=\"Y\" >");		
			  %>
			  
			  
			  
					  <script language="javascript">setOptionValue('company','<%=rst.getString("INT_COMPANYSELECTION")%>')</script>                      </td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="boldEleven">Minim wages applied for Gross </td>
                      <td height="28" valign="middle" class="boldEleven"><input name="grosslimit"
								type="text" class="formText135" id="grosslimit"
								value="<%=rst.getString("INT_GROSSLIMIT")%>" size="30" maxlength="100"></td>
                      <td height="28" valign="middle" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td height="28" valign="middle" class="boldEleven">Date  Lock </td>
                      <td height="28" valign="middle" class="boldEleven"><label>
                     <select name="joinnerlock"  id="joinnerlock">
                        <%
						  for(int u=1;u<=90;u++)
						  	out.println("<option value='"+u+"'>"+u+" - Days</option>");
						  %>
                      </select><script language="javascript">setOptionValue('joinnerlock','<%=rst.getString("INT_DATLOCK")%>')</script>
						  
                      </label></td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="boldEleven">Resigners Login date lock </td>
                      <td height="28" valign="middle" class="boldEleven"><select name="resignerlock"  id="resignerlock">
                        <%
						  for(int u=1;u<=100;u++)
						  	out.println("<option value='"+u+"'>"+u+" - Days</option>");
						  %>
                      </select>
					  <script language="javascript">setOptionValue('resignerlock','<%=rst.getString("INT_RESIGNERLOCK")%>')</script>					  </td>
                      <td height="28" valign="middle" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td height="28" valign="middle" class="boldEleven">First time automated </td>
                      <td height="28" valign="middle" class="boldEleven">
					  
					  <%
			if("Y".equals(rst.getString("CHR_FIRSTTIMEAUTOMATE")))
			 	out.println("<input type=\"checkbox\" name=\"firsttimeautomate\" id=\"firsttimeautomate\" value=\"Y\" checked>");
			else
			 	out.println("<input type=\"checkbox\" name=\"firsttimeautomate\" id=\"firsttimeautomate\" value=\"Y\" >");		
			  %>					   </td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="boldEleven">New Joinner Date lock </td>
                      <td height="28" valign="middle" class="boldEleven">
					   <select name="dojlock"  id="dojlock">
						  <%
						  for(int u=1;u<=90;u++)
						  	out.println("<option value='"+u+"'>"+u+" - Days</option>");
						  %>
                      </select>
					  <script language="javascript">setOptionValue('dojlock','<%=rst.getString("CHR_DOJLOCK")%>')</script>					  </td>
                      <td height="28" valign="middle" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td height="28" valign="middle" class="boldEleven">Show the Inactive Company in report </td>
                      <td height="28" valign="middle" class="boldEleven">
					  <%
			if("Y".equals(rst.getString("CHR_DISPLAYINACTIVECOMPANY")))
			 	out.println("<input type=\"checkbox\"  id=\"inactivecompany\" name=\"inactivecompany\" value=\"Y\" checked>");
			else
			 	out.println("<input type=\"checkbox\"  id=\"inactivecompany\" name=\"inactivecompany\"  value=\"Y\" >");		
			  %>					  </td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="boldEleven">Login By </td>
                      <td height="28" valign="middle" class="boldEleven"><select name="loginby"  id="loginby" class="formText135" >
                        <option value="0">Select LoginBy</option>
						 <option value="U">By User</option>
                        <option value="M">By Mailid</option>
                      </select><script language="javascript">setOptionValue('loginby','<%=rst.getString("CHR_LOGINBY")%>')</script>					  </td>
                      <td height="28" valign="middle" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td height="28" valign="middle" class="boldEleven">Whatsapp Alert <%=rst.getString("CHR_WHATSAPP_ALERT")%></td>
                      <td height="28" valign="middle" class="boldEleven">
					  <select name="whatsappalert"  id="whatsappalert" class="formText135" >
                        <option value="0">Select Whatsappalert</option>
						 <option value="Y">Yes</option>
                        <option value="N">No</option>
                      </select><script language="javascript">setOptionValue('whatsappalert','<%=rst.getString("CHR_WHATSAPP_ALERT")%>')</script>					</td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" valign="middle" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td height="28" valign="middle" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td height="28" valign="middle" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td height="28" valign="middle" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td height="28" valign="middle" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" colspan="5" valign="middle" class="boldEleven"><strong>Please tick Leave not carry forward </strong></td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" colspan="5" valign="middle" class="boldEleven"><%
						  
						 
						 String cycle[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_DEPARTID,CHR_DEPARTNAME FROM com_m_depart ORDER BY INT_DEPARTID");
						 String cycleid[] =(""+rst.getString("CHR_LEAVENOTCARRY")).split(",");
						 out.println("<center><table width='100%' cellspacing=2 cellpadding=1 border=0>");
						 out.println("<tr>");
						 
						 for(int x=0;x<cycle.length;x++)
						 {
						 	s="";
						 	if(x%6 == 0)
							{
								out.println("<tr>");
								for(int g=0;g<cycleid.length;g++)
									if(cycleid[g].equals(cycle[x][0]))
										s=" checked = checked";
								out.println("<td class='boldEleven'><input "+s+" type='checkbox' name='leavecarry' value='"+cycle[x][0]+"' >&nbsp;"+cycle[x][1]);	
							}	
							else
							{
								for(int g=0;g<cycleid.length;g++)
									if(cycleid[g].equals(cycle[x][0]))
										s=" checked = checked";
								out.println("<td class='boldEleven'><input "+s+" type='checkbox' name='leavecarry' value='"+cycle[x][0]+"' >&nbsp;"+cycle[x][1]);				}	
						 }
						 out.println("</table></center>");
						%>                      </td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" colspan="5" valign="middle" class="bolddeepblue"><%
    }	        	
     rst.close();
     st.close();
  
    %></td>
                    </tr>
                    <tr class="BackGround">
                      <td height="28" colspan="5" valign="top" class="bolddeepblue" align="center">
					  <center>
					  <table border="0" align="center" cellpadding="1" cellspacing="4">
                            <tr>
                              <td width="56"><input name="Submit" type="submit"
										class="buttonbold" value="Submit"   accesskey="s"    /></td>
                              <td width="56"><input class="buttonbold" type="button"
										name="Submit2"  value="Close"   accesskey="c" 
										onClick="redirect('Userframe.jsp')" /></td>
                            </tr>
                        </table>
						</center>						</td>
                    </tr>
                </table></td>
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
          </table>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td> </td>
	</tr>
</table>
</form>
</body>
</html>
