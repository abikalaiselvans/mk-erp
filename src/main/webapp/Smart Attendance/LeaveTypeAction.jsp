<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ include file="index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%@ page import="com.my.org.erp.bean.Attendance.LeaveType"%>
<%!		String leaveName,leaveCode;
		Connection con;
		PreparedStatement pstm;
		ResultSet rst;		
%>
<%	String action=request.getParameter("action1");
String actionStu="ATTleaveTypeadd"; %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title> :: ATTENDANCE ::</title>


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

<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
<%
      try
       {
    	  ArrayList leaveList=(ArrayList) session.getAttribute("leaveType");
        int i=0;
%>  var leaveitems=[<%        
        while(i<leaveList.size())
        {
        	LeaveType leave= (LeaveType)leaveList.get(i); 
        	if(i==0){
        		leaveCode=""+leave.getLeaveCode();
        		leaveName=(String)leave.getLeaveName();
	             %>["<%=leaveCode%>","<%=leaveName%>"] <% }
             else{
            	 leaveCode=""+leave.getLeaveCode();
            	 leaveName=(String)leave.getLeaveName();
            	 %> ,["<%=leaveCode%>","<%=leaveName%>"] <% }
              i++;       	
        }
%>];<%
       }
       catch(Exception e)
       {
    	   //System.out.println(e);
    	   
       }
%>
act="<%=request.getParameter("action1")%>";
bid="<%=request.getParameter("leavename")%>";

  function checkName(ctr,m)
  {	  	
	  	var aname=document.getElementById(ctr).value;
	  	var message;
	  	var messageText;	  	
	  	if(true)
	  	{
          i=0;
          var userMessageElement=document.getElementById(ctr);
          aname=aname.toLowerCase();
          aname=Trim(aname);
          while(i<leaveitems.length)
          {
            id=leaveitems[i][0];
            allowitem=leaveitems[i][m].toLowerCase();
            if(act=="Edit" && id==bid)
            {
            	window.status="Valid Name";
                message="true";
                break;
            }
            if(aname==allowitem)
            {
               window.status="Already Exists";
               message="false";
               break;
            }
            else{
	            window.status="Valid Name";
                message="true";
            }
            i++;
          }           
	     if (message == "false" || aname=="") {
	         userMessageElement.style.color = "red";
	         messageText = " Already Exists";
	         document.getElementById("submit").disabled=true;
	       
	     } else {
	         userMessageElement.style.color = "green";
	         messageText = "Valid Name";
             document.getElementById("submit").disabled=false;
   	       
	     }
	     var messageBody = document.createTextNode(messageText);
	     if (userMessageElement.childNodes[0]) 
	     {
	         userMessageElement.replaceChild(messageBody, userMessageElement.childNodes[0]);
	     }
	    
	    }
       
	}
   
  function validate()
  {
  	if(
		checkNull('TxtLeaveName','Enter Leave Name')
		&& checkNullSelect('TxtLeaveType','Enter Leave Type','') 
		&& checkNull('TxtLimit','Enter Leave Limit'))
  		return true;
  	else
  		return false;
  	
  }
  function set()
  {
     document.frmState.TxtLeaveName.focus();
  }
  function upperMe(field)
  {
  	field.value=field.value.toUpperCase();
  }  
   function mainPage()
	{
	  
	   document.frmState.action="LeaveType.jsp";
	  
    }
  </script>

</head>
<body  onpaste="return false;" onload="set()" leftmargin="0" topmargin="0" marginwidth="0"
	marginheight="0">
<form  AUTOCOMPLETE = "off"   method="post" name="frmState" action="../SmartLoginAuth">

</p>
<input type="HIDDEN" name="actionS" value="<%=actionStu %>"> <input
	type="HIDDEN" name="filename" value="LeaveType">
<table align="center">
	<tr>
		<td height="66">&nbsp;</td>
	</tr>
	<tr>
		<td width="461" height="66">
		<table class="BackGround" cellspacing="0" cellpadding="0" width="310"
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

					<table width="400" align="center" border="0" cellspacing="2"
						cellpadding="2"  >
						<tr>
							<td width="134" align="center" class="boldEleven"><div align="left"><span
								class="style9">Leave Name</span><span class="bolddeepblue"><strong>
						    <font color="#ff0000">*</font></strong></span></div></td>
						<td width="246"><input name="TxtLeaveName" type="text"
								class="formText135" id="TxtLeaveName" onblur="TxtTrim(this)"
								 
								  size="40" title="Please enter the leave name" required>						</tr>
						<tr>
							<td align="center" class="boldEleven"><div align="left"><span class="style9">Leave
						    Type</span><span class="bolddeepblue"><strong> <font
								color="#ff0000">*</font></strong></span></div></td>
							<td>
							
							 <span
								class="boldEleven"> </span>
								
								
								
								<select name="TxtLeaveType"   id="TxtLeaveType"  class="formText135" style="width:100" onchange="CheckUnique(this,'divgrade','att_m_leavetype','CHR_SYMBOL')"  title="Please select leave Symbol" required>
	<option value="">Select leave symbol</option>
	 <%
	 	
		 
		String salband = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,";
		String sdata[][] =  CommonFunctions.QueryExecute(" SELECT CHR_SYMBOL  FROM att_m_leavetype order by CHR_SYMBOL");
		if(sdata.length>0)
			for(int y=0;y<sdata.length;y++)
				salband = salband.replaceAll( sdata[y][0]+"," ,"");
		String gradedata[] = salband.split(",");
		for (int i=0; i<gradedata.length; i++) 
			out.println("<option value='"+gradedata[i]+"'>"+gradedata[i]  +"</option>");	
	 %>

</select>
<div id="divgrade"></div>
								
								
								
								
								
								</td>
						</tr>
						<tr>
							<td align="center" class="boldEleven"><div align="left">Continous Limit<strong> <font
								color="#ff0000">*</font></strong></div></td>
							<td><input name="TxtLimit" type="text" class="formText135"
								id="TxtLimit" onKeyPress="return numeric_only(event,'TxtLimit','2')"
								size="40" maxlength="1"  title="Please enter the leave limit" required></td>
						</tr>
						<tr>
							<td align="center" class="boldEleven"><div align="left">Carry farward to next year </div></td>
							<td><input type="checkbox" name="Txtcheckbox"  id="Txtcheckbox"></td>
						</tr>
						<tr class="boldEleven">
							<td colspan="2" align="center" class="bolddeepblue">
							<table width="30%" border="0" align="center" cellpadding="0"
								cellspacing="0">
								<tr>
									<td width="56" height="28" valign="top"><input
										name="submit" type="submit" class="buttonbold" id="Submit"
										 value="Add"   accesskey="s"   onClick="return validate()"></td>
									<td width="56" height="28" valign="top"><input
										name="Button" type="button" class="buttonbold"  value="Close"   accesskey="c" 
										id="submit2" onClick="redirect('LeaveType.jsp')"></td>
								</tr>
							</table>							</td>
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
	<tr valign="bottom" height="70%">
		<td height="90">

		<p>&nbsp;</p>
		<p>&nbsp;</p>
		</td>
	</tr>
</table>
<p><%@ include file="../footer.jsp"%></p>
<p>
<% 	
	String msg= request.getParameter("msg");	
	if(msg.equals(null)) msg="";
	if(msg.equals(""))
	   msg="";
	else  {  
	%> <script language="javascript">
	   alert("<%=msg%>");
	  </script> <% 
	}	
%>
</p>
</form>
</body>
</html>
