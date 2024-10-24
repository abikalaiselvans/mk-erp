<%@ page isErrorPage="false" errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 


<%
try
{
%>



<html>
 
<title> :: PAYROLL ::</title>



<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>
<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
 
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Payroll/LoanAjax.js"></script>
<script language="javascript">    
	  
	  function  Delete()
 	{		
		obj = findObj("id"); 
		if(obj == null)
		{
			alert("Delete not available");
			return false;
		}


		var count;
		count=0;
		coffee1=document.forms[0].id
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
	
	
 	function  Edit()
	{		
		
		
		obj = findObj("id"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}
		
		var count;
		count=0;
		coffee1=document.forms[0].id;
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
			if (document.forms[0].id.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="LoanAction.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}
 	
	function Add()
 	{				
		document.frm.action="LoanAction.jsp";
 	}
 	 
</script>

 
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<form  AUTOCOMPLETE = "off"   method="get" name='frm' action="../SmartLoginAuth" >
<body  onpaste="return false;" onLoad=" loadItem('0')">
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
		<td>
		<table width="90%" height="220" border="0" align="center" cellpadding="0" cellspacing="0" class="TableDesign">
			<tr>
			  <td height="30" align="center"  class="whiteMedium">LOAN</td>
		    </tr>
			<tr>
			 <td height="30" align="center">
				<table width="100%" border="0" align="center" cellpadding="5" cellspacing="0" class="whiteMedium">
                  <tr>
                    <td width="30%" ><div align="center">S.No</div></td>
                    <td  width="40%" ><div align="center">LOAN   </div></td>
					<td width="30%"  ><div align="center">DESCRIPTION </div></td>
                  </tr>
                </table>             </td>
			</tr>
			<tr class="MRow1">
				<td>				
				<div id="AdvanceTable" style="OVERFLOW:auto;width:100%;height:300px"></div><br>
				<div id="totrec"  > </div><br>				</td>
		   </tr>
		</table>		</td>
	</tr>

	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
	  <td><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign">
        <tr class="para">
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('0')">ALL</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('A')">A</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('B')">B</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('C')">C</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('D')">D</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('E')">E</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('F')">F</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('G')">G</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('H')">H</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('I')">I</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('J')">J</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('K')">K</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('L')">L</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('M')">M</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('N')">N</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('O')">O</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('P')">P</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('Q')">Q</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('R')">R</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('S')">S</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('T')">T</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('U')">U</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('V')">V</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('W')">W</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('X')">X</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('Y')">Y</a></div></td>
          <td><div align="center"><a class="whiteMedium" href="javascript:loadItem('Z')">Z</a></div></td>
        </tr>
      </table></td>
  </tr>
	<tr>
	  <td><input type="hidden" name="filename" value="Loan">
      <input type="hidden" name="actionS"	value="PAYLoanDelete"></td>
  </tr>
	<tr>
		<td>
		  <div align="center">
            <%
			out.println("<table   border='0' align='center' cellpadding='1' cellspacing='1'>");
			out.println("<tr>");
			 
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_ADD_PAY FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='Add()' name='action1' id='action1' value='Add'>");
			else	
				out.println("<input type='hidden' name='action1' id='action1' value='Add'>");
			out.println("</td>");
			
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_EDIT_PAY FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
			 out.println("<input class='ButtonHead' type='submit' onClick='return Edit()' name='action1' id='action1' value='Edit'>");
			else	
				out.println("<input type='hidden'  name='Edit' id='Edit' value='Edit'>");
			out.println("</td>");
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_DELETE_PAY FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='return  Delete()' name='Submit' id='Submit' value='Delete'>");
			else	
				out.println("<input type='hidden'  name='Delete' id='Delete' value='Delete'>");
			out.println("</td>");	
			
			out.println("<td ' valign='top'>");
			out.println("<input type='button' class='ButtonHead' name='Button' value='Close' onClick=\"redirect('Payrollmain.jsp')\" />");
			out.println("</td>");
			
			out.println("</tr>");	
			out.println("</table>");
			
			%>
          </div></td>
	</tr>
</table>

 

<%@ include file="../footer.jsp"%>

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


