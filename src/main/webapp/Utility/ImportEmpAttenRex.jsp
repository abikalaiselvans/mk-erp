<%@ page import="java.io.*,java.util.*,com.my.org.erp.bean.*"%>
<%@include file="Redirect.jsp" %>


<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
  
  
 	
	
	$(function() {
		var dates = $( "#fromdt, #todt" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			showOn: "button",
			minDate: -50, maxDate: "+8D" ,
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true,
			onSelect: function( selectedDate ) 
			{
				var option = this.id == "fromdt" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings );
					dates.not( this ).datepicker( "option", option, date );
			}
		});
	}); 
	
	
	
</script>
	
	
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">


<%
try
{
%>
<%! 
	String str=null;
	int nosize=0;
	int start=0;
	int end=0;
	int remsize=0;
%>
<html>
<head>

<title> :: UTILITY :: </title>


  
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
	function Import()
 	{		
           if(checkNull("fromdt","Enter From Date") && checkNull("todt","Enter To Date") ){
              document.frmImport.action="ImportEmpAttenDataBio.jsp";  // Bio
              //document.frmImport.action="ImportEmpAttenData.jsp";  // AV 100
			  //document.frmImport.action="ImportEmpAttenDataRex.jsp";  // REX
				document.frmImport.submit();
			}
 	}
 	function Save()
 	{	
			document.frmImport.action="SaveEmpAttenDataRex.jsp";
			document.frmImport.submit();	
 	}
 	function Back()
 	{	
			document.frmImport.action="import.jsp";
			document.frmImport.submit();	
 	}
</script>
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
</style>
</head>
<body  onpaste="return false;" topmargin="0" leftmargin="0" rightmargin="0" >
<form name="frmImport"> 
<table width='100%' height="400" border='0' cellpadding='0'	cellspacing='0' class='bolddeepblue'>
	<tr valign="top">
		<td align="center">
		<p class="staffsearch">&nbsp;</p>
		<table width="80%" border="0" cellspacing="0" cellpadding="0">
		  <tr>
		    <td colspan="4" align="center"><span class="staffsearch">Importing Attendance From AV 100</span></td>
	      </tr>
		  <tr>
		    <td colspan="4"><table border="0" align="center" cellpadding="3" cellspacing="3">
		      <tr class="boldEleven">
		        <td><span class="tabledata">
		          <%	
	ArrayList empdata =(ArrayList)session.getValue("empdata");
	String message=""+session.getValue("message");
	String ss=""+request.getParameter("startLetter");
	 
	 
%>
		        From Date</span></td>
		        <td><span class="tabledata">
		          <input type="text" name="fromdt" id="fromdt" value="" size="15">
                 </span></td>
		        <td><span class="tabledata">To Date</span></td>
		        <td> <input type="text" name="todt" id="todt" value="" size="15"> 
                <script language="javascript">
                setCurrentDate('fromdt');
				setCurrentDate('todt');
                </script>
                 </td>
		        <td><span class="tabledata">
		          <input type="button" value="Import" onClick="Import()" accesskey="I">
		        </span></td>
		        <td><span class="tabledata">
		          <input type="button" value="Save" id="cmdsave" onClick="Save()" accesskey="S">
		        </span></td>
		        <td><span class="tabledata">
		          <input type="button"  value="Close"  onClick="redirect('Userframe.jsp')" accesskey="C">
		        </span></td>
		        <td>&nbsp;</td>
	          </tr>
	        </table></td>
	      </tr>
		  <tr>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
	      </tr>
		  <tr>
		    <td colspan="4"> </td>
	      </tr>
		  <tr>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
	      </tr>
		  <tr>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
	      </tr>
		  </table>
		 
		</form>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
