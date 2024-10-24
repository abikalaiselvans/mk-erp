<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*" %>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 


<%
try
{
%>


<%@ include file="indexhrm.jsp"%>
<%!	ArrayList empdata = new ArrayList();%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>:: HRM ::</title>


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

 
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="../JavaScript/HRM/demandEntryAjax.js"></script>
<script language="javascript">

function Edit()
{		
 	    
		obj = findObj("rowid"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}	
		
		
		var count=0;
 	    sel=document.forms[0].rowid;
 	    for(i=0;i<sel.length;i++)
 	    {
 	         if(sel[i].checked)
 	         count=count+1;  
 	    }
		 
 	    if(count==0)
 	    { 	       
		   if(document.forms[0].rowid.checked)
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
		document.frm.action="DemandEdit.jsp";
		return true;
		}
 	}	
 	
 	function Add()
 	{		
		document.frm.action="DemandAction.jsp";
 	}	
	
	
	
	
	 function   Delete()  
 	{		
		
		obj = findObj("rowid"); 
		if(obj == null)
		{
			alert("Delete not available");
			return false;
		}	
		
		var count;
		count=0;
		c1=document.forms[0].rowid
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
			if (document.forms[0].rowid.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";				
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
.style3 {color: #000000}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadDemand('0')">
<form  AUTOCOMPLETE = "off" method="get" name="frm" > 
<table width="100%" height="370" align="center"  >
  <tr>
    <td align="center">&nbsp;</td>
  </tr>
  <tr>
    <td height="151" align="center">       
        <table width="90%" height="40" border="0" align="center" cellpadding="0" cellspacing="0" class="TableDesign0">
          <!--DWLayoutTable-->
           <tr align="center" valign="middle"  background="">
            <td height="28"  class="tablehead">
          <span class="whiteMedium">DEMAND ENTRY</span></td>
          </tr>     
            
          <tr>
       		 <td height="31" ><table width="58%" border="0" align="center" cellpadding="1" cellspacing="1" class="boldEleven">
         		 <tr>
            		<td class="whiteMedium">YEAR</td>
            		<td class="whiteMedium"><span class="boldThirteen">
              			<select name="year" class="formText135" id="year"  onChange="loadDemand('0')">
	
                			<%@ include file="../JavaScript/years.jsp" %>
           			</select>
           			   
				   </span>				  </td>
                    <td class="whiteMedium">MONTH</td>
       		        <td class="whiteMedium">
					<select name="month" class="formText135" id="month"  onChange="loadDemand('0')">
					<option value="0">All</option>
	
                			<%@ include file="../JavaScript/months.jsp" %>
           			  </select>
       			   <script language='JavaScript' type="text/javascript">
							<!--			
								var d=new Date()
								var month1=d.getMonth() + 1
								if(month1<10) month1="0"+month1;
								var year1=d.getFullYear();
								setOptionValue('year',year1);	
								setOptionValue('month',month1);							
							//-->
         			  </script></td>
       		        <td class="whiteMedium">JOB GRADE </td>
       		        <td class="whiteMedium"><select name="jobgrade" class="formText135" id="jobgrade" onChange="loadDemand('0')">
            	<option value="0">All</option>            	
            	<option value="Top">Group-1</option>
            	<option value="Middle">Group-2</option>
            	<option value="Bottom">Group-3</option>
                </select></td>
       		        <td class="whiteMedium">STATUS</td>
       		        <td class="whiteMedium"><select name="status" class="formText135" id="status" onChange="loadDemand('0')">
                      <option value="0">All</option>
                      <option value="N">Pending</option>
                      <option value="Y">Approved</option>
                      <option value="R">Rejected</option>
                   </select></td>
       		    </tr>
        </table>        </td>
      </tr>         
           
          <tr bgcolor="#FFFFFF">
          <td height="28" valign="top">
          	<div  id="demandTable" style="OVERFLOW: auto;width:100%;height:250px"></div>
			<br>
		  <div align="center" id="noID" class='boldEleven'><font color='red'></font></div><br>	  </td></tr>
      </table></td>
  </tr>        
  <tr>
    <td height="17">&nbsp;</td>
  </tr>
  <tr>
      <td height="17">
      <input name="filename" type="hidden" id="filename" value="Demand">
      <input name="actionS" type="hidden" id="actionS" value="HRMdemandDelete">
		<table width="90%" border="0" align="center" cellpadding="1" cellspacing="1" class="TableDesign0">
        <tr class="para">
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('0')">All</a></div></td>	
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('A')">A</a></div></td>
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('B')">B</a></div></td>
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('C')">C</a></div></td>
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('D')">D</a></div></td>
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('E')">E</a></div></td>
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('F')">F</a></div></td>
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('G')">G</a></div></td>
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('H')">H</a></div></td>
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('I')">I</a></div></td>
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('J')">J</a></div></td>
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('K')">K</a></div></td>
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('L')">L</a></div></td>
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('M')">M</a></div></td>
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('N')">N</a></div></td>
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('O')">O</a></div></td>
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('P')">P</a></div></td>
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('Q')">Q</a></div></td>
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('R')">R</a></div></td>
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('S')">S</a></div></td>
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('T')">T</a></div></td>
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('U')">U</a></div></td>
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('V')">V</a></div></td>
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('W')">W</a></div></td>
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('X')">X</a></div></td>
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('Y')">Y</a></div></td>
          <td class="whiteMedium"><div align="center"><a   class="whiteMedium" href="javascript:loadDemand('Z')">Z</a></div></td>
        </tr>
      </table>    </td>
  </tr>
  <tr>
    <td height="17" align="center">  </td></tr>
  <tr>
      <td height="17" align="center"><div align="center">
        <%
			out.println("<table   border='0' align='center' cellpadding='1' cellspacing='1'>");
			out.println("<tr>");
			 
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_ADD_HRM FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='Add()' name='action1' id='action1' value='Add'>");
			else	
				out.println("<input type='hidden' name='action1' id='action1' value='Add'>");
			out.println("</td>");
			
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_EDIT_HRM FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
			 out.println("<input class='ButtonHead' type='submit' onClick='return Edit()' name='action1' id='action1' value='Edit'>");
			else	
				out.println("<input type='hidden'  name='Edit' id='Edit' value='Edit'>");
			out.println("</td>");
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_DELETE_HRM FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='return  Delete()' name='Submit' id='Submit' value='Delete'>");
			else	
				out.println("<input type='hidden'  name='Delete' id='Delete' value='Delete'>");
			out.println("</td>");	
			
			out.println("<td ' valign='top'>");
			out.println("<input type='button' class='ButtonHead' name='Button' value='Close' onClick=\"redirect('HRMmain.jsp')\" />");
			out.println("</td>");
			
			out.println("</tr>");	
			out.println("</table>");
			
			%>
      </div></td>
  </tr>
	  <tr><td height="20" ><%@ include file="../footer.jsp"%></td></tr>
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

