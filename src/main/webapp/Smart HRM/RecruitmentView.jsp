<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*" %>
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
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="../JavaScript/HRM/HrmAjax.js"></script>
<script language="javascript">

function Edit()
{		
 	    var count=0;
 	    sel=document.forms[0].OptJobId;
 	    for(i=0;i<sel.length;i++)
 	    {
 	         if(sel[i].checked)
 	         count=count+1;  
 	    }
		 
 	    if(count==0)
 	    { 	       
		   if(document.forms[0].OptJobId.checked)
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
		document.Recruitment.action="RecruitmentEdit.jsp";
		return true;
		}
 	}	
 	
 	function Add()
 	{		
		document.Recruitment.action="RecruitmentAdd.jsp";
 	}	
	 function Delete()
 	{		
		var count;
		count=0;
		c1=document.forms[0].OptJobId
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
			if (document.forms[0].OptJobId.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.Recruitment.action="../SmartLoginAuth";				
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
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form  AUTOCOMPLETE = "off" method="get" name="Recruitment" > 
<table width="100%" height="285" align="center"  >
  <tr>
    <td height="151" align="center"><br>       
        <table width="800" height="80" border="1" align="center" cellpadding="0" cellspacing="0"    >
          <!--DWLayoutTable-->
           <tr align="center" valign="middle"  >
            <td height="28"  class="tablehead">
          <span class="style3">Job Requirements</span> </td>
          </tr>     
            
         
          <tr   >
            <td height="31" align="left" valign="middle" class="boldEleven">
            <table width="900" border="0"   >
              <tr>
              	<td width="130"><strong class="bold1">Job Grade</strong></td>
              	<td width="150"><strong class="bold1">Job Code</strong></td>               
                <td width="120"><strong class="bold1">Job Title</strong></td>
                <td width="100"><strong class="bold1">Total Marks</strong></td>                
                </tr>
            </table></td>
          </tr>
          
          
            <tr>
        <td  valign="top" class="footermenu">
		<table width="900" height="200">
		<tr><td>

		</td>
		</tr>
		<tr><td>  
		<div id="divscroll" style="OVERFLOW:auto;width:900px;height:130px" class="boldEleven">
		  <%
		  	
			String query ="";			
			String req =(""+request.getParameter("startLetter")).trim();
			if("null".equals(req) || "AL".equals(req)){
				query ="SELECT A.CHR_JOBGRADE,A.CHR_JOBCODE,A.CHR_JOBTITLE,B.INT_JOBID,B.INT_TEST,B.INT_INTERVIEW,B.INT_MEDICAL,B.INT_REFERENCE, B.INT_GD ";
				query=query+"FROM hrm_m_jobdesign A,hrm_m_jobperformance B WHERE A.INT_JOBID=B.INT_JOBID ";
			}
			else 
			{
				query ="SELECT A.CHR_JOBGRADE,A.CHR_JOBCODE,A.CHR_JOBTITLE,B.INT_JOBID,B.INT_TEST,B.INT_INTERVIEW,B.INT_MEDICAL,B.INT_REFERENCE, B.INT_GD ";
			query=query+"FROM hrm_m_jobdesign A,hrm_m_jobperformance B WHERE A.INT_JOBID=B.INT_JOBID AND A.CHR_JOBTITLE LIKE '"+req+"%' ";
			}	
			
			String tableData[][] =com.my.org.erp.common.CommonInfo.RecordSetArray(query);
			int totrec=0;
			totrec = tableData.length;
			
			out.print("<table width='100%' id='myTable' align=center    cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
			boolean bgflag = false;
			boolean buttonflag=false;
			
			 for(int u=0; u<tableData.length; u++)
			 {
				if(bgflag)
				{
					bgflag = false;
					out.print("<tr class='MRow1'>");
				}
				else
				{
					bgflag = true;
					out.print("<tr  class='MRow2'>");
				}	

				int tot = Integer.parseInt(tableData[u][4])+ Integer.parseInt(tableData[u][5])+ Integer.parseInt(tableData[u][6])+	Integer.parseInt(tableData[u][7])+Integer.parseInt(tableData[u][8]);
//				System.out.println("Test Scrore : " + tot);				
				out.print("<td width='160' class='boldEleven'><input name='OptJobId' type='checkbox' value='"+tableData[u][3].trim()+"'><a href='RecruitmentEdit.jsp?OptJobId="+tableData[u][3].trim()+"'>&nbsp;<font class='boldEleven'><font color='blue'>"+tableData[u][0]+" Management</font></a></div></td>");
				out.print("<td width='194' class='boldEleven'>&nbsp;"+tableData[u][1]+"</td>");
				out.print("<td width='184' class='boldEleven'>&nbsp;"+tableData[u][2]+"</td>");
				out.print("<td width='190' class='boldEleven' align='center'>&nbsp;&nbsp;"+tot+"</td>");				
				out.print("</tr>");
			  }				
			 
			out.print("</table>");
			 
		  %>
		</div>
		
		<div align="center" class='boldEleven'><font color='red'>Total no of Records :: <%= totrec %></font> </div>
			
		</td>
		</tr>
		</table>		</td>
      </tr>
    </table></td>
  </tr>         
          
         
  <tr>
      <td height="17">
      <input name="filename" type="hidden" id="filename" value="Recruitment">
      <input name="actionS" type="hidden" id="actionS" value="HRMRecruitmentDelete">
		<table width="900" border="0" align="center" cellpadding="1" cellspacing="1"  >
        <tr class="para">
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=AL">All</a></div></td>	
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=A">A</a></div></td>
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=B">B</a></div></td>
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=C">C</a></div></td>
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=D">D</a></div></td>
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=E">E</a></div></td>
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=F">F</a></div></td>
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=G">G</a></div></td>
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=H">H</a></div></td>
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=I">I</a></div></td>
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=J">J</a></div></td>
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=K">K</a></div></td>
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=L">L</a></div></td>
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=M">M</a></div></td>
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=N">N</a></div></td>
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=O">O</a></div></td>
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=P">P</a></div></td>
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=Q">Q</a></div></td>
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=R">R</a></div></td>
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=S">S</a></div></td>
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=T">T</a></div></td>
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=U">U</a></div></td>
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=V">V</a></div></td>
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=W">W</a></div></td>
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=X">X</a></div></td>
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=Y">Y</a></div></td>
          <td><div align="center"><a href="RecruitmentView.jsp?startLetter=Z">Z</a></div></td>
        </tr>
      </table>    </td>
  </tr>
  <tr>
      <td height="17" align="center"><center>
          <table  border="0" cellspacing="1" cellpadding="1">
            <tr>
              <td width="56"><input class="tMLAscreenHead" name="submit" type="submit" onClick=Add() value="Add"></td>
              <td  width="56"><input class="tMLAscreenHead" name="submit1"  type="submit" onClick=Edit() value="Edit"></td>
              <td  width="56"><input class="tMLAscreenHead" name="submit2" type="submit" onClick=Delete() value="Delete"></td>
              <td  width="56"><input class="tMLAscreenHead" type="Button" name="Button"  value="Close"   accesskey="c"  onClick="redirect('HRMmain.jsp')"></td>
            </tr>
		  </table>
		  
		  
		 <script language="javascript">
		 		
		 		var x = <%=totrec%>
		 		if (x==0) {
		 			document.Recruitment.submit1.disabled=true;
		 			document.Recruitment.submit2.disabled=true;
		 		}else	{
		 			document.Recruitment.submit1.disabled=false;
		 			document.Recruitment.submit2.disabled=false;
				}		 		
		 </script>
  		<tr><td height="20" ><%@ include file="../footer.jsp"%></td></tr>
</table>
</body>
</html>


