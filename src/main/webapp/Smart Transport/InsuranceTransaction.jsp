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
 <script language="javascript" 	src="../JavaScript/Transport/InsuranceTransactionAjax.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
		document.frm.action="InsuranceTransactionAction.jsp";
		document.frm.submit();
		return true;
		}
 	}
 	
	 
		
	function Add()
 	{		
		document.frm.action="InsuranceTransactionAction.jsp";
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
  
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="LoadInsuranceTransaction('0')">
<form method="get" name="frm">
<table width="100%" height="293" align="center">
	<!--DWLayoutTable-->
	<tr>
		<td height="21" colspan="6" align="center">
	<tr>
		<td height="80" colspan="6" align="center">
		<table height="72" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign">
			<!--DWLayoutTable-->
			<tr align="center" valign="middle"  >
				<td   height="28"  
					class="bold1"><div align="center" class="whiteMedium">INSURANCE</div></td>
			</tr>
			<tr>
			  <td height="21" valign="top"><table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="whiteMedium">
                <tr>
                  <td  >Office</td>
                  <td  ><select name="offices" class="formText135" id="offices" onChange="LoadInsuranceTransaction('0')"  style="width:200;">
                          <option value="0">All</option>
                          <%
		String sql ="SELECT INT_OFFICEID,CHR_OFFICENAME FROM com_m_office ORDER BY CHR_OFFICENAME ";
		String officeData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		for(int u=0;u<officeData.length;u++)
			out.println("<option value='"+officeData[u][0]+"'>"+officeData[u][1]+"</option>");

	%>
                  </select></td>
                  <td  >Remainder</td>
				  <td  ><select name="reminder" class="formText135" id="reminder" onChange="LoadInsuranceTransaction('0')">
                          <option value="0">All</option>
                          <%
		sql ="SELECT INT_REMINDERID,CHR_REMINDERNAME FROM vehicle_m_insurancereminder ORDER BY CHR_REMINDERNAME";
		String reminderData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		for(int u=0;u<reminderData.length;u++)
			out.println("<option value='"+reminderData[u][0]+"'>"+reminderData[u][1]+"</option>");

	%>
                  </select></td>
                   <td  >Month</td>
				  <td  ><jsp:include page="../JavaScript/month.jsp" flush="true" /></td>
				  <td  >year</td>
				  <td><jsp:include page="../JavaScript/year.jsp" flush="true" /></td> 
                </tr>
              </table>            
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
		<table width="800" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign">
			<tr class="para">
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('0')">ALL</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('A')">A</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('B')">B</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('C')">C</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('D')">D</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('E')">E</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('F')">F</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('G')">G</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('H')">H</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('I')">I</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('J')">J</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('K')">K</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('L')">L</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('M')">M</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('N')">N</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('O')">O</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('P')">P</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('Q')">Q</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('R')">R</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('S')">S</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('T')">T</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('U')">U</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('V')">V</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('W')">W</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('X')">X</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('Y')">Y</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:LoadInsuranceTransaction('Z')">Z</a></div>				</td>
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
<input name="filename" type="hidden" id="filename" value="InsuranceTransaction"> 
<input name="actionS" type="hidden" id="actionS" value="TRSInsuranceTransactionDelete"></td>
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
