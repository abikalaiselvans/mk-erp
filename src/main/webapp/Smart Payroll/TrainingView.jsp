<%@ page import="java.io.*,java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.my.org.erp.SmartPayroll.Training"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon">
</jsp:useBean>
<%!
String pgmId;
String staff;
String staffName;
%>
<html>
<head>
<script language="javascript"> 	

    function Delete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].training
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].training.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frmState.action="../SmartLoginAuth";				
				return true;			
			}
			else
				return false;
		}
		else
		{
		    alert("Select Atleast One Value");
		    return false;
		}		
 	}
 	function Edit()
 	{		
 	    var count=0;
 	    sel=document.forms[0].training
 	   
 	    for(i=0;i<sel.length;i++)
 	    {
 	       if(sel[i].checked)
 	       count=count+1; 
 	    }
 	    if(count==0)
		{
			if (document.forms[0].training.checked) { count=1;	}
		}
 	    if(count==0)
 	    {
 	        alert("Select Program to Edit");
 	        return false; 
 	    }
 	    
 	    if(count==1)
 	    {
     	    document.frmState.action="TrainingAction.jsp";
	    	document.frmState.submit();
	    	return true;
 	    }
 	    else
 	    {
 	        alert("Select Only One Program to Edit");
 	        return false; 
 	    }
	}
	function Add()
 	{		
		document.frmState.action="TrainingAction.jsp";
		document.frmState.submit();
 	}
	function mainPage()
	{
	    //document.frmState.action="Payrollmain.jsp";
		//document.frmState.submit();
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
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<title> :: PAYROLL ::</title>


 
</head>
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   method="get" name='frmState'>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<br>
<br>
<br>
<br>
<center>
<table width="751" align="center" border="1"  >
	<tr>
		<td colspan="4" height="32" align="center" valign="middle"
			class="BackGround" >Training Program</td>
	</tr>
	<%
    String fromDate=request.getParameter("fromDate");
    String toDate=request.getParameter("toDate");    
    %>
	<tr>
		<td width="193" class="bolddeepblue">
		<div align="center">Program Id</font></div>
		</td>
		<td width="193" class="bolddeepblue">
		<div align="center">Program Name</div>
		</td>
		<td width="193" class="bolddeepblue">
		<div align="center">Staff Id</div>
		</td>
		<td width="193" class="bolddeepblue">
		<div align="center">Staff Name</div>
		</td>
	</tr>
	<%
		    ArrayList trainingList=(ArrayList) session.getAttribute("trainingList");
			for(int i=0;i<trainingList.size();i++)
			{
				Training train= (Training)trainingList.get(i);	    
		    	pgmId=train.getProgId();
	%>
	<tr class="bolddeepblue">
		<td valign="middle" align="left"><input type="checkbox"
			name="training" value="<%=train.getProgId()%>"> <%=train.getProgId()%>
		</td>
		<td><%=train.getProgName()%></td>

		<%
        con=conbean.getConnection();
        st=con.createStatement();
        ResultSet rst=st.executeQuery("SELECT * FROM PAY_T_EMP_TRAINIGLIST WHERE INT_PROGRAMID="+pgmId);
        while(rst.next())
        {
        	staff=rst.getString("CHR_EMPID");
        }
        %>
		<td><%=staff%></td>
		<%
        con=conbean.getConnection();
        st=con.createStatement();
        ResultSet rst1=st.executeQuery("SELECT * FROM  com_m_staff  WHERE CHR_EMPID='"+staff+"'");
        while(rst1.next())
        {
        	staffName=rst1.getString("CHR_STAFFNAME");
        }
        %>
		<td><%=staffName%></td>
	</tr>
	<%	

		   }
			String dis="";
			if(trainingList.size()==0) dis="disabled='disabled'";		 	
	%>
</table>
<table BORDER="0" ALIGN="CENTER"  >
	<br>
	<tr>
		<input type="hidden" name="filename" value="Training">
		<input type="hidden" name="fromdt" value=<%=fromDate%>>
		<input type="hidden" name="todt" value=<%=toDate%>>
		<input type="hidden" name="actionS" value="PaytrainingDelete">
		<input type="hidden" name="msg" value="">

		<td width="56" height="26" valign="top"><input class="buttonbold"
			type="submit" onClick="Add()" name="action1" value="Add"></td>
		<td width="56" height="26" valign="top"><input class="buttonbold"
			type="submit" onclick="return Edit()" <%=dis%> name="action1"
			value="Edit"></td>
		<td width="56" valign="top"><input name="Submit" type="submit"
			class="buttonbold" onclick="return Delete()" <%=dis%> value="Delete"></td>
		<td width="56" valign="top"><input type="button" name="Submit"
			class="buttonbold"  value="Close"   accesskey="c"  onclick="mainPage()"></td>
	</tr>
</table>
</td>
<tr>
	<td width="996" height="25">
	</table>

	<% 
	String msg=""+request.getParameter("message");
	if(!msg.equals("null")){
%>
	<CENTER>
	<table width="50%" border="1" cellspacing="2" cellpadding="2"
		 >
		<tr>
			<td align="center" class="tabledata"><%=msg%></td>
		</tr>
		<% 
   }
	st.close();
	//rs.close();
	 
	
	%>
	</table>
	</CENTER>

	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<%@ include file="../footer.jsp"%>
</body>
</html>
