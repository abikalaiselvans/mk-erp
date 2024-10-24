<%@ page import="java.io.*,java.util.*"%>
<%!
	String stateName,stateDes,stateId;
	String actionStu;
%>
<%@ page import="com.my.org.erp.bean.State"%>
<html>
<head>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='COM' ")[0][0]%></title>

<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<style type="text/css">
<!--
a:visited {
	color: #663366;
}

a:hover {
	color: #FF0000;
}

a:active {
	color: #0000FF;
}
-->
</style>

<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="javascript">
<%
      try
       {
    	  ArrayList stateList=(ArrayList) session.getAttribute("stateList");
        int i=0;
%>  var stateitems=[<%        
        while(i<stateList.size())
        {
        	State state= (State)stateList.get(i); 
        	if(i==0){
        		stateId=""+state.getStateId();
        		stateName=(String)state.getStateName();
	             %>["<%=stateId%>","<%=stateName%>"] <% }
             else{
            	 stateId=""+state.getStateId();
            	 stateName=(String)state.getStateName();
            	 %> ,["<%=stateId%>","<%=stateName%>"] <% }
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
bid="<%=request.getParameter("OptStateName")%>";

  function checkName()
  {	  	
	  	var aname=document.getElementById("state").value;
	  	var message;
	  	var messageText;	  	
	  	if(true)
	  	{
          i=0;
		  var userMessageElement = document.getElementById("st");
          aname=aname.toLowerCase();
          aname=Trim(aname);		
          while(i<stateitems.length)
          {
            id=stateitems[i][0];
            allowitem=stateitems[i][1].toLowerCase();
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
	     else 
	     {
	         userMessageElement.appendChild(messageBody);
	     }
	    
	    }
      } 
    function validate()
  {
  	if(checkNull('state','Enter State Name'))
  		return true;
  	else
  		return false;
  	
  }
 function set()
  {
     document.frmState.TxtStateName.focus();
  }
  function upperMe(field)
  {
  	field.value=field.value.toUpperCase();
  }    
  
  </script>
<style type="text/css">
<!--
.style11 {
	color: #FF0000
}

body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright"
	content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords"
	content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

</head>
<body onpaste="return false;" onLoad="set()">
<form AUTOCOMPLETE="off" method="get" name='frmState'
	action="../SmartLoginAuth">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><%@ include file="insert.jsp"%> <input
			name="path" type="hidden" value="<%=qp%>"></td>
	</tr>
	<tr>
		<td height="29">&nbsp;</td>
	</tr>
	<tr>
		<td height="29">&nbsp;</td>
	</tr>
	<tr>
		<td height="29">
		<%   
  		String action=request.getParameter("action1");
	 	stateId=request.getParameter("OptStateName");		
		ArrayList stateList=(ArrayList) session.getAttribute("stateList");
		if(action.equals("Edit"))
		{
		 	actionStu="ATTstateEdit";
		 	stateId=request.getParameter("OptStateName");	
		 	for(int i=0;i<stateList.size();i++)
		 	{
				State state= (State)stateList.get(i);
					if(state.getStateId()==Integer.parseInt(stateId))
					{
						stateName=state.getStateName();
						stateDes=state.getStateDes();
					break;
					}
		 	}
		}
		else
		{
		actionStu="COMstateAdd";
		stateName="";
		stateDes="";
		}
		
	%>
		</td>
	</tr>
	<tr>
		<td align="center">
		<table class="BackGround" cellspacing="0" cellpadding="0" width="424"
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


					<table width="207" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
							<table width="425" border="0" cellpadding="2" cellspacing="2"
								class="bolddeepblue">
								<!--DWLayoutTable-->
								<tr align="center" valign="middle">
									<td height="28" colspan="2" class="BackGround">State</td>
								</tr>
								<tr class="bolddeepblue">
									<td width="150" height="29" valign="middle"
										class="bolddeepblue">State Name <span class="style11">*</span></td>
									<td width="246" valign="top"><input name="TxtStateName"
										type="text" class="tabledata" id="state"
										onBlur="TxtTrim(this)" onChange="upperMe(this)"
										onKeyPress="charOnly('state','100')" onKeyUp="checkName()"
										value="<%= stateName %>" size="35" maxlength="100">
									<div id="st"></div>
									</td>
								</tr>
								<tr class="bolddeepblue">
									<td height="29" valign="middle" class="bolddeepblue">Description</td>
									<td valign="top"><input name="TxtStateDes" type="text"
										class="tabledata" onKeyPress="charOnly('TxtStateDes','500')"
										value="<%= stateDes %>" size="35"></td>
								</tr>
							</table>
							<tr>
								<td><input type="HIDDEN" name="filename" value="State">
								<input type="HIDDEN" name="actionS" value="<%=actionStu %>">
								<input type="HIDDEN" name="stateId" value="<%= stateId %>">
								</p>
								<table align="center">
									<tr>
										<td width="56" align="center"><input name="Submit"
											type="submit" class="buttonbold" id="submit" value="Submit"
											accesskey="s" onClick="return validate()"></td>
										<td width="57"><input class="buttonbold" type="button"
											name="Submit" value="Close" accesskey="c"
											onClick="redirect('../Common/StateView.jsp?&qp=<%=qp %>')"></td>
									</tr>
								</table>
								</td>
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
	<tr>
		<td align="center">&nbsp;</td>
	</tr>
	<tr>
		<td align="center">&nbsp;</td>
	</tr>
	<tr>
		<td align="center">&nbsp;</td>
	</tr>
	<tr>
		<td align="center">&nbsp;</td>
	</tr>
	<tr>
		<td align="center">&nbsp;</td>
	</tr>
	<tr>
		<td align="center">&nbsp;</td>
	</tr>
	<tr>
		<td align="center">&nbsp;</td>
	</tr>
	<tr>
		<td align="center">&nbsp;</td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</body>
</html>
