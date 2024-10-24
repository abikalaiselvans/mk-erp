<%@ page import="java.io.*,java.util.*"%>
<%!
	String departName,departDes,departId;
	String actionStu;
%>
<%@ page import="com.my.org.erp.bean.Department"%>
<html>
<head>

<title> :: PAYROLL ::</title>


 
<style type="text/css">
<!--
	.style8 {
		font-family: Verdana;
		font-size: 12px;
			}
	.style9 {color: #FFFFFF}
	.style10 {font-family: Verdana; font-size: 12px; color: #FFFFFF; }
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
    	  ArrayList departmentList=(ArrayList) session.getAttribute("departmentList");
        int i=0;
%>  var departmentitems=[<%        
        while(i<departmentList.size())
        {
        	Department department= (Department)departmentList.get(i); 
        	if(i==0){
        		departId=""+department.getDepartId();
        		departName=(String)department.getDepartName();
	             %>["<%=departId%>","<%=departName%>"] <% }
             else{
            	 departId=""+department.getDepartId();
            	 departName=(String)department.getDepartName();
            	 %> ,["<%=departId%>","<%=departName%>"] <% }
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
bid="<%=request.getParameter("OptDepartName")%>";

    function checkName()
  {	  	
	  	var aname=document.getElementById("depart").value;
	  	var message;
	  	var messageText;	  	
	  	if(true)
	  	{
          i=0;
          var userMessageElement = document.getElementById("dep");
          aname=aname.toLowerCase();
		  aname=Trim(aname);	
          while(i<departmentitems.length)
          {
            id=departmentitems[i][0];
            allowitem=departmentitems[i][1].toLowerCase();
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
  	if(checkNull('depart','Enter Department Name'))
  		return true;
  	else
  		return false;
  	
  }
  function set()
  {
     document.frmDepart.TxtDepartName.focus();
  }
  function upperMe(field)
  {
  	field.value=field.value.toUpperCase();
  }
function mainPage()
	{
	  history.back(1);
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
</head>
<body  onpaste="return false;" onLoad="set()">
<%@ include file="index.jsp"%>
<%   
  	String action=request.getParameter("action1");
	//courseName=""+request.getParameter("courseName");
	//courseId=request.getParameter("TxtCourseId");
	ArrayList departmentList=(ArrayList) session.getAttribute("departmentList");
	if(action.equals("Edit")){
		 actionStu="COM_PAYdepartEdit";
		 departId=request.getParameter("OptDepartName");		 
		 for(int i=0;i<departmentList.size();i++)
		 {
			Department depart= (Department)departmentList.get(i);
			if(depart.getDepartId()==Integer.parseInt(departId)){
				departName=depart.getDepartName();
				departDes=depart.getDepartDes();
				break;
			}
		 }
	}else{
		actionStu="COM_PAYdepartAdd";
		departName="";
		departDes="";
	}
		
%>
<form  AUTOCOMPLETE = "off"   method="get" name='frmDepart' action="../SmartLoginAuth"><br>
<br>
<br>
<br>
<table width="1000" border=0>
	<!--DWLayoutTable-->
	<tr>
		<td width="305" height="102">&nbsp;</td>
		<td colspan="5" valign="top" background="../if">
		<table width="425" border="1" cellspacing="2" cellpadding="2"
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle" class="tablehead">
				<td height="28" colspan="2" class="tablehead" >Department
				</td>
			</tr>
			<tr>
				<td width="150" height="29" valign="middle" class="tabledata">Department
				Name <font color="#ff0000">*</font></td>
				<td width="246" valign="top"><input name="TxtDepartName"
					type="text" class="tabledata" id="depart" onBlur="TxtTrim(this)"
					onChange="upperMe(this)" onKeyPress="charOnly('depart','25')"
					onKeyUp="checkName()" value="<%= departName %>" size="35">
				<div id="dep"></div>
				</td>
			</tr>
			<tr>
				<td height="29" valign="middle" class="tabledata">Description</td>
				<td valign="top"><input name="TxtDepartDes" type="text"
					class="tabledata" onKeyPress="charOnly('TxtDepartDes','50')"
					value="<%= departDes%>" size="35"></td>
			</tr>
			<tr>
				<td height="2"></td>
				<td></td>
			</tr>
		</table>
		</td>
		<td width="260">&nbsp;</td>
	</tr>
	<tr>
		<td height="21">&nbsp;</td>
		<td width="148">&nbsp;</td>
		<td width="24">&nbsp;</td>
		<td width="31">&nbsp;</td>
		<td width="53">&nbsp;</td>
		<td width="154">&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="26"></td>
		<td>&nbsp;</td>
		<td width="56" colspan="2" valign="top"><input type="submit"
			id="submit" name="Submit" class="buttonbold" disabled="disabled"
			value="Submit" onClick="return validate()"></td>
		<td width="56" valign="top"><input class="buttonbold"
			type="button" name="Submit"  value="Close"   accesskey="c"  onClick="mainPage()">
		</td>
		<td>&nbsp;</td>
		<td></td>
	</tr>
	<tr>
		<td height="21" colspan="3" align="center"><input type="HIDDEN"
			name="filename" value="Department"> <input type="HIDDEN"
			name="actionS" value="<%=actionStu %>"> <input type="HIDDEN"
			name="departId" value="<%=departId %>"></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>
<br>
<br>
<br>
<br>
<br>
<%@ include file="../footer.jsp"%>
</body>
</html>
