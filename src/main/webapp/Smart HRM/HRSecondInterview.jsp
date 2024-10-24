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
<script language="JavaScript" src="../JavaScript/HRM/SecondInterview.js"></script>
<script language="javascript" src="../JavaScript/HRM/Applicant.js"></script>
<script language="javascript">
 	function sEdit()
 	{		
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
		document.frm.action="HRSecondInterviewEdit.jsp";
		document.frm.submit();
		return true;
		}
 	}
 	
	
	
	
	function HEdit()
 	{		
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
		document.frm.action="HRSecondInterviewUpdate.jsp";
		document.frm.submit();
		return true;
		}
 	}
 	
	
	
	
	function Add()
 	{		
		document.frm.action="Applicantinterviewsheet.jsp";
		document.frm.submit();
 	}		

	function sDelete()
 	{		
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
		
		if(count==1){			
			var name=confirm("Confirm to Cancel the sceond interview..")
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
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadSecondInterview('0'),document.getElementById('month').focus()">
<form action="../SmartLoginAuth"  method="get" name="frm"  AUTOCOMPLETE = "off"> 
<%@ include file="indexhrm.jsp"%>	
<table width="100%" height="398" align="center"  >
  <!--DWLayoutTable-->
  <tr>
    <td height="269" colspan="6" align="center">    
        <br><table width="95%" height="157" align="center" cellpadding="0" cellspacing="0" class="TableDesign">
          <!--DWLayoutTable-->
          <tr align="center" valign="middle"  >
            <td height="28" class="whiteMedium">SECOND INTERVIEW</td>
          </tr>
            <tr>
       		 <td height="31" ><table width="80%" border="0" align="center" cellpadding="1" cellspacing="1" class="boldEleven">
         		 <tr>
         		   <td class="whiteMedium">Office</td>
         		   <td class="whiteMedium"><select name="office" class="formText135" id="office"  onChange="loadSecondInterview('0')" >
                     <option value="0">All</option>
                     <%
				   	String offdata[][]=com.my.org.erp.common.CommonInfo.RecordSetArray(" SELECT INT_OFFICEID,CHR_OFFICENAME FROM   com_m_office ORDER BY CHR_OFFICENAME ");
					for(int c=0;c<offdata.length;c++)
						out.println("<option value='"+offdata[c][0]+"'  >"+offdata[c][1]+"</option>");	
					
				
				   %>
                   </select></td>
         		   <td class="whiteMedium">Job Grade</td>
            		<td class="whiteMedium"><select name="jobgrade" class="formText135" id="jobgrade" onChange="loadComboJobTitle(this)" onBlur="loadSecondInterview('0')" >
                      <option value="0">All</option>
                      <option value="Top">Group-1</option>
                      <option value="Middle">Group-2</option>
                      <option value="Bottom">Group-3</option>
                   </select></td>
            		<td class="whiteMedium">Job Title</td>
            		<td class="whiteMedium"><select name="jobtitle" id="jobtitle" class="formText135"  onChange="loadSecondInterview('0')" onBlur="loadSecondInterview('0')">
                      <option value="0">All </option>
                   </select></td>
					<td class="whiteMedium">First DOI </td>
						<td class="whiteMedium"><select name="day" id="day"  onBlur="loadSecondInterview('0') ">
                            <option value="0">All</option>
                            <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                   </select>                        </td>
            		<td class="whiteMedium"><span class="boldThirteen"><strong>Month</strong></td>
            		<td class="whiteMedium"><span class="boldThirteen">
              			<select name="month" id="month" onChange="loadSecondInterview('0')"  >
               				<option value="0">All</option>
							<%@ include file="../JavaScript/months.jsp" %>
              			</select>
       			   </span>            		</td>
            		
            		<td class="whiteMedium"><strong>Year</strong></td>
            		<td class="whiteMedium"><span class="boldThirteen">
              			<select name="year" id="year" onChange="loadSecondInterview('0')" >
                			
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
          </tr>
        </table>        </td>
      </tr>                
         
          <tr bgcolor="#FFFFFF">
          <td height="21" valign="top">          
		   <div id="applicationTable" style="OVERFLOW:auto;width:100%;height:350px" ></div><br> 
		   <div id="totalRec"></div>
      </table>        
    <tr>
      <td colspan="6"><!--DWLayoutEmptyCell-->&nbsp;</td>
    </tr>
    <tr>
      <td colspan="6"><input name="filename" type="hidden" id="filename" value="InterviewSheet">
        <input name="actionS" type="hidden" id="actionS" value="HRMSecondInterViewSheetDelete">
        <table  width="90%" border="0" align="center" cellpadding="1" cellspacing="1"   class="TableDesign">
        <tr class="para">
          <td height="22" ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('0')">ALL</a></div></td>	
		  <td ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('A')">A</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('B')">B</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('C')">C</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('D')">D</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('E')">E</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('F')">F</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('G')">G</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('H')">H</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('I')">I</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('J')">J</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('K')">K</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('L')">L</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('M')">M</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('N')">N</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('O')">O</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('P')">P</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('Q')">Q</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('R')">R</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('S')">S</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('T')">T</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('U')">U</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('V')">V</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('W')">W</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('X')">X</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('Y')">Y</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:loadSecondInterview('Z')">Z</a></div></td>
        </tr>
      </table>      </td>
    </tr>
    <tr>
      <td height="17" colspan="6"><table width="241"  border="0" align="center" cellpadding="2" cellspacing="2">
        <tr>
          <td  width="56"><input name="btnEdit" type="button" class="ButtonHead"id="Edit" onClick="sEdit()" value="Second Interview"></td>
           <td  width="56"><input name="btnEdit2" type="button" class="ButtonHead" id="btnEdit" onClick="HEdit()" value="Modify"></td> 
          <%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype)|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	  {
	  %>
				<td width="56"><input type="submit" class="ButtonHead"
					name="Delete" id="Delete" value="Cancel"
					onClick="return sDelete()" /></td>
				<%
		}
		else
		{ 
			out.println("<input type='hidden'  name ='Delete' id='Delete'>");
		}


		%>

 
          <td  width="47"><input class="ButtonHead" type="button" name="Button"  value="Close"   accesskey="c"  onClick="redirect('HRMmain.jsp')"></td>
          </tr>
      </table>    
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
