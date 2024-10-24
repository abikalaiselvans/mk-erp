<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*" %>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 


<%
try
{
%>


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
 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/HRM/FirstInterview.js"></script>
<script language="javascript" src="../JavaScript/HRM/Applicant.js"></script>
<script language="javascript">
 	function  Edit()
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
		document.frm.action="ApplicantinterviewsheetEdit.jsp";
		document.frm.submit();
		return true;
		}
 	}
 	
	function Add()
 	{		
		document.frm.action="Applicantinterviewsheet.jsp";
		document.frm.submit();
 	}		

	function  Delete()
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

 
 
 
function buttondisable()
{
		document.getElementById('Delete').disabled=true;
     	document.getElementById('Edit').disabled=true;
		tables.style.visibility="hidden";
		
}
</script>	
 

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadFirstInterview('0'),document.getElementById('month').focus()">
<form action="../SmartLoginAuth"  method="get" name="frm"  AUTOCOMPLETE = "off"> 
<%@ include file="indexhrm.jsp"%>	
<table width="100%" height="398" align="center"  >
  <!--DWLayoutTable-->
  <tr>
    <td height="269" colspan="6" align="center">    
        <br><table width="90%" height="157" border="0" align="center" cellpadding="0" cellspacing="0" class="TableDesign">
          <!--DWLayoutTable-->
          <tr align="center" valign="middle"  >
            <td height="28" class="whiteMedium">  F<span class="whiteMedium">I</span>RST INTERVIEW INFORMATIONS </td>
          </tr>
            <tr>
       		 <td height="31" ><table width="90%" border="0" align="center" cellpadding="1" cellspacing="1" class="boldEleven">
         		 <tr>
         		   <td class="whiteMedium">OFFICE</td>
         		   <td class="whiteMedium"><select name="office" class="formText135" id="office"  onChange="loadFirstInterview('0')" >
                     <option value="0">All</option>
                     <%
				   	String offdata[][]=com.my.org.erp.common.CommonInfo.RecordSetArray(" SELECT INT_OFFICEID,CHR_OFFICENAME FROM   com_m_office ORDER BY CHR_OFFICENAME ");
					for(int c=0;c<offdata.length;c++)
						out.println("<option value='"+offdata[c][0]+"'  >"+offdata[c][1]+"</option>");	
					
				
				   %>
                   </select></td>
         		   <td class="whiteMedium">JOB GRADE </td>
            		<td class="whiteMedium"><select name="jobgrade" class="formText135" id="jobgrade" onChange="loadComboJobTitle(this)" onBlur="loadFirstInterview('0')" >
                      <option value="0">All</option>
                      <option value="Top">Group-1</option>
                      <option value="Middle">Group-2</option>
                      <option value="Bottom">Group-3</option>
                   </select></td>
            		<td class="whiteMedium">JOB TITLE </td>
            		<td class="whiteMedium"><select name="jobtitle" id="jobtitle" class="formText135"  onChange="loadFirstInterview('0')" onBlur="loadFirstInterview('0')">
                      <option value="0">All </option>
                   </select></td>
					<td class="whiteMedium">DAY</td>
						<td class="whiteMedium"><select name="day" id="day"  onBlur="loadFirstInterview('0') ">
                            <option value="0">All</option>
                            <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                   </select>                        </td>
            		<td class="whiteMedium"><span class="boldThirteen"><strong>MONTH</strong></td>
            		<td class="whiteMedium"><span class="boldThirteen">
              			<select name="month" id="month" onChange="loadFirstInterview('0')"  >
               				<option value="0">All</option>
							<%@ include file="../JavaScript/months.jsp" %>
              			</select>
       			   </span>            		</td>
            		
            		<td class="whiteMedium"><strong>YEAR</strong></td>
            		<td class="whiteMedium"><span class="boldThirteen">
              			<select name="year" id="year" onChange="loadFirstInterview('0')" >
                			
                			<%@ include file="../JavaScript/years.jsp" %>
              			</select>
           			   <script language='JavaScript' type="text/javascript">
							<!--			
								var d=new Date()
								var month1=d.getMonth() + 1
								var day=d.getDate()
						if(day<10) day="0"+day;
								if(month1<10) month1="0"+month1;
								var year1=d.getFullYear();
								setOptionValue('month',month1);
								setOptionValue('year',year1);	
								setOptionValue('day',day);								
							//-->
         			  </script>
				   </span>				  </td>
					  <td class="whiteMedium"><span class="boldThirteen">RESULT  </span></td>
					  <td class="whiteMedium"><span class="boldThirteen">
					    <select name="result" id="result"  onChange="loadFirstInterview('0')">
                          <option value="0">All</option>
                          <option value="N">Fail</option>
                          <option value="Y">Pass</option>
                        </select>
				   </span></td>
          </tr>
        </table>        </td>
      </tr>                
         
          <tr bgcolor="#FFFFFF">
          <td height="21" valign="top">          
		   <div id="applicationTable" style="OVERFLOW:auto;width:100%;height:300px" ></div> <br>
		    <div id="totalRec" align="center"  ></div>	
      </table>        
    <tr>
      <td colspan="6"><!--DWLayoutEmptyCell-->&nbsp;</td>
    </tr>
    <tr>
      <td colspan="6"><input name="filename" type="hidden" id="filename" value="InterviewSheet">
        <input name="actionS" type="hidden" id="actionS" value="HRMInterViewSheetDelete">
        <table  width="90%" border="0" align="center" cellpadding="1" cellspacing="1"   class="TableDesign">
        <tr class="para">
          <td height="22" ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('0')">ALL</a></div></td>	
		  <td ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('A')">A</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('B')">B</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('C')">C</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('D')">D</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('E')">E</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('F')">F</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('G')">G</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('H')">H</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('I')">I</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('J')">J</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('K')">K</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('L')">L</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('M')">M</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('N')">N</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('O')">O</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('P')">P</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('Q')">Q</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('R')">R</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('S')">S</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('T')">T</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('U')">U</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('V')">V</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('W')">W</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('X')">X</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('Y')">Y</a></div></td>
          <td ><div align="center"><a   class="whiteMedium" href="javascript:loadFirstInterview('Z')">Z</a></div></td>
        </tr>
      </table>      </td>
    </tr>
    <tr>
      <td height="17" colspan="6">    
    <tr>
      <td height="17" colspan="6"> <div align="center">
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
      </div>
    <tr>
        <td colspan="6"><center>
         <%
	String error=""+request.getParameter("staff");
	
	if(error.equals("") || error.equals("null"))
	{
		error ="";	
	}
	else
	{
		error ="Sorry record not found ...  Staff id := "+ error;
	}
	out.println(error);
	
	String msg=""+request.getParameter("message");
	if(!msg.equals("null"))
	out.println(msg); 
	 %>
          <%@ include file="../footer.jsp"%>
        </center>
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
