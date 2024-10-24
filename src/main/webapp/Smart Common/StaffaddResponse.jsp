
<%@ page language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<title>-</title>

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" type="text/javascript">
	var x = "<%= request.getParameter("addMore")%>"
	var regx = "<%= request.getParameter("regid")%>"
	var regname = "<%= request.getParameter("Name")%>"
	var salarysplitupby = "<%= request.getParameter("salarysplitupby")%>"
	
	
	if (x=="Y")
	{
			alert("Employee Registration Id : "+regx +" / NAME "+regname);
			
			if( salarysplitupby== "M")
			{
				location ="../Smart Payroll/ManulaAllowanceRecoveryAdd.jsp?flag=Y&ename="+regx ;
				
				/*if (confirm("Are you sure, Enter the salary split up ... "))
					location ="../Smart Payroll/ManulaAllowanceRecoveryAdd.jsp?ename="+regx ;	
				else
					location ="../Smart Payroll/ManulaAllowanceRecoveryAdd.jsp?ename="+regx ;
				*/	
			}
			else
			{
				
				if( confirm(regname+" - Registraton number is -"+regx+".  Do You Want to Add One More Record...") )
					location ="Staffadd.jsp" ;
				else
					location ="StaffRegistrationView.jsp" ;
 		
			}
 	}
	else if (x=="F")
	{
		alert("Staff Registration failed....");
		location ="Staffadd.jsp" ;
	}
	
	
	function redirection(URLStr) 
	{ 
		var rs=confirm("You press a close button");
		if (rs==true)
  		 	location = URLStr; 
  	}
	
</script>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}

%>
