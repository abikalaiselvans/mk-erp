<%@ page import="java.io.*,java.util.*,com.my.org.erp.bean.*"%>
<%@include file="Redirect.jsp" %>
<%! 
	String str=null;
	int nosize=0;
	int start=0;
	int end=0;
	int remsize=0;
	String AV100,BIO,A6;
%>
<html>
<head>

<title> :: UTILITY :: </title>


 
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
	function Import()
 	{		
			var mod=document.getElementById("model").value;
			if(checkNull("fromdt","Enter From Date") && checkNull("todt","Enter To Date") ){
				if(mod=="AV100") {
					 document.frmImport.action="ImportEmpAttenData.jsp";  // AV 100				 
				}
				else if(mod=="BIO"){
					 document.frmImport.action="ImportEmpAttenDataBio.jsp"; // Bio 
				}
				else if(mod=="A6"){
					 document.frmImport.action="ImportEmpAttenDataBio.jsp"; // A6
				}
				//document.frmImport.action="ImportEmpAttenDataBio.jsp";
				document.frmImport.submit();
			}
 	}
 	function Save()
 	{	
			document.frmImport.action="SaveEmpAttenData.jsp";
			document.frmImport.submit();	
 	}
 	function Back()
 	{	
			document.frmImport.action="import.jsp";
			document.frmImport.submit();	
 	}
</script>
</head>
<%
	String model=""+request.getParameter("model");
	AV100="";BIO="";A6="";
	if(model.equals("AV100")){
		AV100="selected='selected'";
	}else if(model.equals("BIO")){
		BIO="selected='selected'";
	}else if(model.equals("A6")){
		A6="selected='selected'";
	}
%>
<body  onpaste="return false;" topmargin="0" leftmargin="0" rightmargin="0" >
<form name="frmImport"> 
<table width='100%' height="261" border='0' cellpadding='0' cellspacing='0' class='bolddeepblue'>
	<tr valign="top">
		<td height="35" align="center">
		<p class="staffsearch">Importing Attendance From <select
			style="width: 100" class="staffsearch" name="model" id="model">
			<option value="AV100" <%=AV100 %>>AV 100</option>
			<option value="BIO" <%=BIO %>>BIO</option>
			<option value="A6" <%=A6 %>>A6</option>
		</select></p>		</td>
	</tr>
	<tr>
		<td height="71" align="center">
		<table border="0">
			<tr valign="top">
			  <td align="center" class="tabledata"><%	
	ArrayList empdata =(ArrayList)session.getValue("empdata");
	String message=""+session.getValue("message");
	String ss=""+request.getParameter("startLetter");
	if(ss.equals("not") && empdata.size()>0)  {
		  empdata.clear();	      
	}
	if(message.equals("null") || message.equals("")) 
	{
			message="";
			if(empdata!=null){
//			   empdata.clear();
//	  		   session.putValue("empdata",empdata);
			}
	}
	//System.out.println("MESS :"+message);
%>
		      From Date</td>
			  <td><input type="text" name="fromdt" id="fromdt" value=""
					size="15">
                <a href="javascript:cal1.popup();"><img
					src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
					alt="Click Here to Pick up the date"></a> </td>
		  </tr>
			<tr valign="top">
			  <td align="center" class="tabledata">To Date</td>
			  <td><span class="tabledata">
              <input
					type="text" name="todt" id="todt" value="" size="15">
              <a
					href="javascript:cal2.popup();"><img
					src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
					alt="Click Here to Pick up the date"></a></span></td>
		  </tr>
			<tr valign="top">
			  <td colspan="2" align="center" class="tabledata"><table border="0" cellpadding="1" cellspacing="1">
                <tr>
                  <td width="56"><input name="button" type="button" class="buttonbold" accesskey="I" onClick="Import()"
							value="Import"></td>
                  <td width="56"><input name="button" type="button" class="buttonbold" id="cmdsave" accesskey="S" onClick="Save()"
							value="Save"></td>
                  <td width="56"><input name="button" type="button" class="buttonbold" accesskey="C" onClick="Back()"
							 value="Close"   accesskey="c" ></td>
                </tr>
              </table></td>
		  </tr>
			
		</table>
	<tr>
		<td height="18" align="center" valign="top">
		<%
	   if(empdata!=null)
       {
       if(empdata.size()>0){
    	  
           out.println("<tr valign='top'><td valign='top' align='center'>");
           out.println("<div  id='divscroll' style='OVERFLOW: auto;width:940;height:150px'>");        
           out.println("<table width=900  id='myTable' align=center    cellpadding=2 cellspacing=1 bgcolor='#9900CC' class='boldeleven' >");
		    out.println("<tr bgcolor='#ffffff'><td width='100'> <strong class='bold1'> Emp Id </strong> </td>");
    	   out.println("<td width='150'> <strong class='bold1'> Emp Name </strong> </td>");
           out.println("<td width='90'> <strong class='bold1'> LogIn Date </strong> </td>");
           out.println("<td width='90'> <strong class='bold1'> LogIn Time </strong> </td>");
           out.println("<td width='90'> <strong class='bold1'> LogOut Date </strong>  </td>");
           out.println("<td width='90'>  <strong class='bold1'>  LogOut Time </strong> </td>");
           out.println("<td width='90'> <strong class='bold1'> Total Time </strong> </td>");
           out.println("<td width='90'>  <strong class='bold1'>  Lunch In </strong> </td>");
           out.println("<td width='80'> <strong class='bold1'> Lunch Out </strong> </td></tr>");
           
           int color=0;
           String startLetter=""+request.getParameter("startLetter");
	       for(int i=0;i< empdata.size();i++){	    	    
	    	   EmployeeAtten emp=(EmployeeAtten)empdata.get(i);	    	
	    	    startLetter=startLetter.toLowerCase();
	    	    if(startLetter.equals("null") || emp.getEmpName().toLowerCase().startsWith(startLetter))
	    	    {
	    	    if(color%2==0)
					out.println("<tr bgcolor='#FFFFFF'>");
	    	    else
	    	    	out.println("<tr bgcolor='#EEFFEE'>");
	    	    color++;
				out.println("<td width='100'>"+emp.getEmpId()+ "</td>");
				out.println("<td width='180'>" + emp.getEmpName() +"</td>");   		
				out.println("<td width='100'>" + emp.getLoginDate() +"</td>");
				out.println("<td width='100'>" + emp.getTimeIn() +"</td>");
				out.println("<td width='100'>" + emp.getLogoutDate() +"</td>");
				out.println("<td width='90'>" + emp.getTimeOut() +"</td>");
				out.println("<td width='100'>" + emp.getTotalHours()+":"+emp.getTotalMinutes()+"</td>");
				out.println("<td width='90'>" + emp.getLunchIn() +"</td>");
				out.println("<td width='90'>" + emp.getLunchOut() +"</td>");
				out.println("</tr>");
	    	    }
		   }
	       if(color==0){
	    	   out.println("<tr bgcolor='#FFFFFF'><td colspan='9' align='center'><font color='FF0000'>");
	    	   out.println(" Record not found...in Starting letter ' "+startLetter.toUpperCase()+" '");
			   out.println("<font></td></tr>");
	       }
	       out.println("</table>");	       
	       out.println("</div>");
       }
       }
	   out.println("<table border='0' width='690' align='center' class='bolddeepblue'>");
       out.println("<tr align='center'><td align='center'> <strong class='bold1'>");
       out.println(message+"</strong></td></tr>");
       out.println("</table>"); 
       if(empdata.size()>0){
       out.println("<table border='0' width='690' align='center' class='bolddeepblue'>");
%>		</td>
	<tr class="para">	</tr>
	<tr>
	  <td colspan="26" align="center">
	  <table width="600" border="0" cellspacing="0" cellpadding="0">
        <tr>
         
		  <td width="8"><a href="ImportEmpAtten.jsp?startLetter=null">ALL</a></td>
		<td width="8"><a href="ImportEmpAtten.jsp?startLetter=A">A</a></td>
		<td width="8"><a href="ImportEmpAtten.jsp?startLetter=B">B</a></td>
		<td width="8"><a href="ImportEmpAtten.jsp?startLetter=C">C</a></td>
		<td width="8"><a href="ImportEmpAtten.jsp?startLetter=D">D</a></td>
		<td width="8"><a href="ImportEmpAtten.jsp?startLetter=E">E</a></td>
		<td width="8"><a href="ImportEmpAtten.jsp?startLetter=F">F</a></td>
		<td width="8"><a href="ImportEmpAtten.jsp?startLetter=G">G</a></td>
		<td width="8"><a href="ImportEmpAtten.jsp?startLetter=H">H</a></td>
		<td width="8"><a href="ImportEmpAtten.jsp?startLetter=I">I</a></td>
		<td width="8"><a href="ImportEmpAtten.jsp?startLetter=J">J</a></td>
		<td width="8"><a href="ImportEmpAtten.jsp?startLetter=K">K</a></td>
		<td width="8"><a href="ImportEmpAtten.jsp?startLetter=L">L</a></td>
		<td width="8"><a href="ImportEmpAtten.jsp?startLetter=M">M</a></td>
		<td width="8"><a href="ImportEmpAtten.jsp?startLetter=N">N</a></td>
		<td width="8"><a href="ImportEmpAtten.jsp?startLetter=O">O</a></td>
		<td width="8"><a href="ImportEmpAtten.jsp?startLetter=P">P</a></td>
		<td width="8"><a href="ImportEmpAtten.jsp?startLetter=Q">Q</a></td>
		<td width="8"><a href="ImportEmpAtten.jsp?startLetter=R">R</a></td>
		<td width="8"><a href="ImportEmpAtten.jsp?startLetter=S">S</a></td>
		<td width="8"><a href="ImportEmpAtten.jsp?startLetter=T">T</a></td>
		<td width="8"><a href="ImportEmpAtten.jsp?startLetter=U">U</a></td>
		<td width="8"><a href="ImportEmpAtten.jsp?startLetter=V">V</a></td>
		<td width="8"><a href="ImportEmpAtten.jsp?startLetter=W">W</a></td>
		<td width="8"><a href="ImportEmpAtten.jsp?startLetter=X">X</a></td>
		<td width="8"><a href="ImportEmpAtten.jsp?startLetter=Y">Y</a></td>
		<td width="8"><a href="ImportEmpAtten.jsp?startLetter=Z">Z</a></td>
        </tr>
      </table>
	  
	  </td>
    </tr>
	<tr>
		<td colspan="26" align="center"><a href="ReportEmpAtten.jsp">
		Report </a></td>
	</tr>
	<%	   
       out.println("</table>"); 
       }
       if(message.equalsIgnoreCase("Saved Sucessfully")) {
  		 //empdata.clear();
  		 //session.putValue("empdata",empdata);
  		 message="";
  		 session.putValue("message",message);
  	}
       %>
	</td>
	<td><script language='JavaScript'>
		<!--
			var cal1 = new calendar1(document.forms['frmImport'].elements['fromdt']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			var cal2 = new calendar1(document.forms['frmImport'].elements['todt']);
			cal2.year_scroll = true;
			cal2.time_comp = false;				
		 <%       
	       if(empdata!=null){
		 	if(empdata.size()>0)	  
				out.println("document.getElementById('cmdsave').disabled=false;");
		 	else
		 		out.println("document.getElementById('cmdsave').disabled=true;");
	       }
	       else{
	    	   out.println("document.getElementById('cmdsave').disabled=true;");
	       }
		 %>			
		//-->
		</script></td>
	</tr>
</table>
<%
	//message="";
	//session.putValue("message",message);
%> </form>
</body>
</html>
