<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 


<%
try
{
%>



<%@ include file="index.jsp"%>
 <html>
<head>

<title> :: TRANSPORT ::</title>

<script language="javascript" src="../JavaScript/Transport/InsuranceRemindeAjax.js" 	 >
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>

<script language="javascript">

 	function sEdit()
 	{		
 	    var count=0;
 	    sel=document.forms[0].id;
 	    for(i=0;i<sel.length;i++)
 	    {
 	         if(sel[i].checked)
 	         count=count+1;  
 	    }
		 
 	    if(count==0)
 	    { 	       
		   if(document.forms[0].id.checked)
		    { 
		    	count=1;
		    }   
		    else{	    
		   	   alert("Select Record to Edit");
		   	   return false;
		   	 }
 	    }
 	    if(count>1)
 	    {
 	       alert("Select One Record to Edit");
 	       return false
 	    }
 	    if(count==1)
 	    {
		document.frm.action="InsuranceReminderAction.jsp";
		document.frm.submit();
		return true;
		}
 	}
 	
	 
		
	function Add()
 	{		
		document.frm.action="InsuranceReminderAction.jsp";
		document.frm.submit();
 	}		
	
	function sDelete()
 	{		
		var count;
		count=0;
		c1=document.forms[0].id
		txt=""
		for (i=0;i<c1.length;++ i)
		{
			if (c1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].id.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
				document.frm.submit();
				
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


</script>
<link rel="stylesheet" type="text/css" href="../JavaScript/styles.css">
 
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="LoadReminder('0')">
<form method="get" name="frm">
<table width="100%" height="293" align="center">
	<!--DWLayoutTable-->
	<tr>
		<td height="21" colspan="6" align="center">
	<tr>
		<td height="80" colspan="6" align="center">
		<table width="897" height="82" align="center"
			cellpadding="0" cellspacing="0"
			  class="TableDesign">
			<!--DWLayoutTable-->
			<tr align="center" valign="middle"   >
				<td width="893" height="28"  
					 ><div align="center" class="whiteMedium">INSURANCE REMAINDER </div></td>
			</tr>
			<tr  >
				<td height="31" align="left" valign="middle" class="boldEleven"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="whiteMedium">
                  <tr>
                    <td  >S.no</td>
                    <td  >Reminder Name </td>
                  </tr>
                </table></td>
			</tr>
			<tr class="MRow1">
				<td height="21" valign="top">
				<div id="divscroll" style="OVERFLOW:auto;width:100%;height:300px"></div>
				<br>
				<div id ="totRec" align="center"></div><br>
		</table>
	<tr>
	  <td height="17" colspan="6"><!--DWLayoutEmptyCell-->&nbsp;</td>
    </tr>
	<tr>
		<td height="17" colspan="6">
		<table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign">
			<tr class="para">
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('0')">ALL</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('A')">A</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('B')">B</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('C')">C</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('D')">D</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('E')">E</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('F')">F</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('G')">G</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('H')">H</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('I')">I</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('J')">J</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('K')">K</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('L')">L</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('M')">M</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('N')">N</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('O')">O</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('P')">P</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('Q')">Q</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('R')">R</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('S')">S</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('T')">T</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('U')">U</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('V')">V</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('W')">W</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('X')">X</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('Y')">Y</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadReminder('Z')">Z</a></div>				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
		<td id="tables" height="17" colspan="6">
	<tr>
		<td height="17" colspan="6">
		<table border="0" align="center" cellpadding="2" cellspacing="2">
			<tr>
				<td width="56">
				
<input class="ButtonHead" name="submit2" type="submit" onClick=Add() value="Add"></td>
				<td width="56">
<input name="btnEdit" type="button"	class="ButtonHead" id="Edit" onClick="sEdit()" value="Edit"></td>
				
				

<%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype)|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	  {
	  %>
				<td width="56"><input type="submit" class="ButtonHead"
					name="Delete" id="Delete" value="Delete"
					onClick="return sDelete()" /></td>
				<%
		}
		else
		{ 
			out.println("<input type='hidden'  name ='Delete' id='Delete'>");
		}


		%>
 
				<td width="56">
<input class="ButtonHead" type="button"	name="Button"  value="Close"   accesskey="c" 	onClick="redirect('Transportmain.jsp')"></td>
				<td width="56">
<input name="filename" type="hidden" id="filename" value="InsuranceReminder"> 
<input name="actionS" type="hidden" id="actionS" value="TRSInsuranceReminderDelete"></td>
			</tr>
		</table>
	<tr>
		<td height="17" colspan="6">
		 <%@ include file="../footer.jsp"%>
</table>
</form>
</body>
</html>

<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>