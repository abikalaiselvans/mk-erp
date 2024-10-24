<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*,java.io.*"%>
<%!
	String termName,termId,termDes;
	String actionStu;
%>
<%@ page import="com.my.org.erp.SmartInventory.Term"%>
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
 <%
      //System.out.println("Inside Action 2");  
      try
       {    	  
    	ArrayList termList=(ArrayList) session.getAttribute("termList");
        int i=0;
	%> var termitems=[<%        
        while(i<termList.size())
        {
        	Term term= (Term)termList.get(i); 
        	if(i==0){
        		termId=""+term.getTermId();
        		termName=(String)term.getTermName();
	             %>["<%=termId%>","<%=termName%>"] <% }
             else{
            	 termId=""+term.getTermId();
            	 termName=(String)term.getTermName();
            	 %> ,["<%=termId%>","<%=termName%>"] <% }
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
bid="<%=request.getParameter("OptTermId")%>";

  function checkName()
  {	  	
	  	var lname=document.getElementById("TxtTermName").value;
	  	var message;
	  	var messageText;	  	
	  	if(true)
	  	{
          i=0;
          var userMessageElement = document.getElementById("TxtTermName");
          lname=lname.toLowerCase();
          while(i<labitems.length)
          {
            id=labitems[i][0];
            labitem=labitems[i][1].toLowerCase();
            if(act=="Edit" && id==bid)
            {
            	window.status="Valid Name";
                message="true";
                break;
            }
            if(lname==labitem)
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
	     if (message == "false" || lname=="") {
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
  
   if(checkNull("TxtTermName","Enter Terms and Conditions"))
  		return true;
  	else
  		return false;
}  	
 
function set()
{
	document.branch.TxtTermName.focus();
}
function upperMe(field)
  {
  	field.value=field.value.toUpperCase();
  }
function mainPage()
	{
	     document.branch.action="TermView.jsp";	    
    }
 </script>
<style type="text/css">
<!--
.style1 {	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
}
.style12 {color: #FFFFFF}
.style14 {color: #FFFFFF; font-weight: bold; }
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
</head>
<body >
<form  AUTOCOMPLETE = "off"   name="branch" action="../SmartLoginAuth">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td><%@ include file="indexinv.jsp"%></td>
	</tr>
	<tr>
		<td height="63">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="379" border="1" align="center" cellpadding="2"
			cellspacing="2"  >
			<tr>
				<%   
  	String action=request.getParameter("action1");
    //System.out.println(action); 
	ArrayList termList=(ArrayList) session.getAttribute("termList");
	if(action.equals("Edit")){
		 actionStu="INVtermEdit";
		 termId=request.getParameter("OptTermId");		 
		 for(int i=0;i<termList.size();i++)
		 {
			Term term= (Term)termList.get(i);
			if(term.getTermId()==Integer.parseInt(termId)){
				termName=term.getTermName();				
				break;
			}
		 }
	}else{
		actionStu="INVtermAdd";
		termName="";		
	}	
	%>
				<td width="163" class="bolddeepblue" valign="top">Terms and
				Conditions</td>
				<td width="196" valign="middle"><textarea name="TxtTermName"
					onKeyPress="alphaNumeric('TxtTermName','25')" cols=30 rows=6><%=termName%></textarea></td>
			</tr>
			<tr>
				<td><input type="text" name="TxtTermDes" onKeyPress="">
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table border="0" align="center" cellpadding="1" cellspacing="1">
			<!--DWLayoutTable-->
			<tr>
				<td width="56"><input type="HIDDEN" name="filename"
					value="Term"> <input type="HIDDEN" name="actionS"
					value="<%=actionStu %>"> <input type="HIDDEN" name="termId"
					value="<%= termId %>"> <input type="submit"
					class="buttonbold" name="Submit" value="Submit"   accesskey="s"   
					onClick="return validate()"></td>
				<td width="56"><input type="submit" class="buttonbold"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</td>
</tr>
</table>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<%@ include file="../footer.jsp"%></form>
</body>
</html>
