<%@ page import="java.io.*,java.util.*"%>
<%!
	String desigName,desigDes,desigId;
	String actionStu;
%>
<%@ page import="com.my.org.erp.bean.Designation"%>
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
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="javascript">
 <%
      try
       {
    	  ArrayList designationList=(ArrayList) session.getAttribute("designationList");
        int i=0;
%>  var designationitems=[<%        
        while(i<designationList.size())
        {
        	Designation designation= (Designation)designationList.get(i); 
        	if(i==0){
        		desigId=""+designation.getDesigId();
        		desigName=(String)designation.getDesigName();
	             %>["<%=desigId%>","<%=desigName%>"] <% }
             else{
            	 desigId=""+designation.getDesigId();
            	 desigName=(String)designation.getDesigName();
            	 %> ,["<%=desigId%>","<%=desigName%>"] <% }
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
bid="<%=request.getParameter("OptDesigName")%>";

    function checkName()
  {	  	
	  	var aname=document.getElementById("desig").value;
	  	var message;
	  	var messageText;	  	
	  	if(true)
	  	{
          i=0;
          var userMessageElement = document.getElementById("des");
          aname=aname.toLowerCase();
		  aname=Trim(aname);	
          while(i<designationitems.length)
          {
            id=designationitems[i][0];
            allowitem=designationitems[i][1].toLowerCase();
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
  	if(checkNull('desig','Enter Designation Name'))
  		return true;
  	else
  		return false;
  	
  }
   function set()
  {
     document.frmDesig.TxtDesigName.focus();
  }
  function upperMe(field)
  {
  	field.value=field.value.toUpperCase();
  }  
 function mainPage()
	{
	    //document.frmDesig.action="Payrollmain.jsp";
		//document.frmDesig.submit();
		//return true;
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

</head>
<body  onpaste="return false;" onLoad="set()">
<%@ include file="index.jsp"%>
<%   
  	String action=request.getParameter("action1");
	//courseName=""+request.getParameter("courseName");
	//courseId=request.getParameter("TxtCourseId");
	ArrayList designationList=(ArrayList) session.getAttribute("designationList");
	if(action.equals("Edit")){
		 actionStu="COM_PAYdesigEdit";
		 desigId=request.getParameter("OptDesigName");		 
		 for(int i=0;i<designationList.size();i++)
		 {
			Designation desig= (Designation)designationList.get(i);
			if(desig.getDesigId()==Integer.parseInt(desigId)){
				desigName=desig.getDesigName();
				desigDes=desig.getDesigDes();
				break;
			}
		 }
	}else{
		actionStu="COM_PAYdesigAdd";
		desigName="";
		desigDes="";
	}
		
%>
<form  AUTOCOMPLETE = "off"   method="get" name='frmDesig' action="../SmartLoginAuth"><br>
<br>
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
				<td height="28" colspan="2" class="tablehead" >Designation
				
			</tr>
			<tr>
				<td width="150" height="29" valign="middle" class="bolddeepblue">Designation
				Name <font color="#ff0000">*</font></td>
				<td width="246" valign="top"><input name="TxtDesigName"
					type="text" class="tabledata" onBlur="TxtTrim(this)" id="desig"
					onChange="upperMe(this)" onKeyPress="charOnly('desig','25')"
					onKeyUp="checkName()" value="<%=desigName %>" size="35">
				<div id="des"></div>
				</td>
			</tr>
			<tr>
				<td height="29" valign="middle" class="bolddeepblue">Description</td>
				<td valign="top"><input name="TxtDesigDes" type="text"
					class="tabledata" onKeyPress="charOnly('TxtDesigDes','50')"
					value="<%= desigDes  %>" size="35"></td>
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
		<td width="138">&nbsp;</td>
		<td width="34">&nbsp;</td>
		<td width="21">&nbsp;</td>
		<td width="183">&nbsp;</td>
		<td width="33">&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="26"></td>
		<td>&nbsp;</td>
		<td colspan="2" valign="top"><input name="Submit" type="submit"
			disabled="disabled" class="buttonbold" id="submit" value="Submit"   accesskey="s"   
			onClick="return validate()"></td>
		<td width="56" valign="top"><input class="buttonbold"
			type="button" name="Submit"  value="Close"   accesskey="c"  onClick="mainPage()">
		</td>
		<td>&nbsp;</td>
		<td></td>
	</tr>
	<tr>
		<td height="21" colspan="3" align="center"><input type="HIDDEN"
			name="filename" value="Designation"> <input type="HIDDEN"
			name="actionS" value="<%=actionStu %>"> <input type="HIDDEN"
			name="desigId" value="<%= desigId %>"></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>
</td>
</tr>
</table>
</form>
<br>
<br>
<br>
<%@ include file="../footer.jsp"%>
</body>
</html>
