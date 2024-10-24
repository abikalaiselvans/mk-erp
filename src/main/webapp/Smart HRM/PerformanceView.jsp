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

function REdit()
{		
 	    var count=0;
 	    obj = findObj("appId");
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}	
		sel=document.frmPerformView.appId;
		
 	    for(i=0;i<sel.length;i++)
 	    {
 	         if(sel[i].checked)
 	         count=count+1;  
 	    }
		 
 	    if(count==0)
 	    { 	       
		   if(document.frmPerformView.appId.checked)
		    { 
		    	count=1;
		    }   
		    else{	    
		   	   alert("Select Record to Edit");
		   	   return false;
		   	 }
 	    }
 	    if(count>1) {
 	       alert("Select One Record to Edit");
 	       return false
 	    }

 	    if(count==1)  {
			document.frmPerformView.action="PerformanceEdit.jsp";
//			document.frmPerformView.submit();
			return true;
		}
 	}	
 	
 	function Add()
 	{		
		document.frmPerformView.action="PerformanceAdd.jsp";
 	}	

	function Delete()
 	{		
		var count;
		count=0;
		obj = findObj("appId");
		if(obj == null)
		{
			alert("Delete not available");
			return false;
		}	
		c1=document.frmPerformView.appId
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
			if (document.frmPerformView.appId.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frmPerformView.action="../SmartLoginAuth";				
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
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadPerformance('0'),document.getElementById('month').focus()">
<form  AUTOCOMPLETE = "off" method="get" name="frmPerformView" > 
<table width="100%" height="285" align="center"  >
  <tr>
    <td height="151" align="center">       
        <table width="800" height="80" border="1" align="center" cellpadding="0" cellspacing="0"    >
          <!--DWLayoutTable-->
           <tr align="center" valign="middle"   background="">
            <td height="28"     class="tablehead">
          <span class="style3">Performance</span> </td>
          </tr>     
            
          <tr class="BackGround">
       		 <td height="31" class="BackGround" ><table width="28%" border="0" align="center" cellpadding="1" cellspacing="1" class="boldEleven">
         		 <tr>
            		<td><span class="boldThirteen">Month ::</td>
            		<td><span class="boldThirteen">
              			<select name="month" id="month" onChange="loadPerformance('0')">
               				<%@ include file="../JavaScript/months.jsp" %>
              			</select>
            			</span>
            		</td>
            		<td><span class="boldThirteen">Year  ::</span></td>
            		<td><span class="boldThirteen">
              			<select name="year" id="year" onChange="loadPerformance('0')">
                			
                			<%@ include file="../JavaScript/years.jsp" %>
              			</select>
           			   <script language='JavaScript' type="text/javascript">
							<!--			
								var d=new Date()
								var month1=d.getMonth() + 1
								if(month1<10) month1="0"+month1;
								var year1=d.getFullYear();
								setOptionValue('month',month1);
								setOptionValue('year',year1);							
							//-->
         			  </script>
					  </span>
				  </td>
          </tr>
        </table>
        </td>
      </tr>         
          <tr   >
            <td height="31" align="left" valign="middle" class="boldEleven">
            <table width="900" border="0"   >
              <tr>
              	<td width="188"><div align="center"><strong class="bold1">Job Grade</strong></div></td>
              	<td width="149"><div align="center"><strong class="bold1">Application Code</strong></div></td>               
              	<td width="151"><div align="center"><strong class="bold1">Applicant Name</strong></div></td>                
                <td width="159"><div align="center"><strong class="bold1">Job Title</strong></div></td>
              	<td width="87"><div align="center"><strong class="bold1">Job Code</strong></div></td>                               
                <td width="140"><div align="center"><strong class="bold1">Status</strong></div></td>                
                <td width="140" class="bold1"><div align="center">Appoinment</div></td>
              </tr>
            </table></td>
          </tr>
          <tr>
          <td height="28" valign="top">
          	<div  id="performanceTable" style="OVERFLOW: auto;width:900px;height:200px"></div>
			<br>
			<div id ="noId" align='center' class='boldEleven'></div>
		  </td>
		  </tr>
		  <td>
		  	</td>
      </table></td>
  </tr>        
  <tr>
      <td height="17">
      <input name="filename" type="hidden" id="filename" value="Performance">
      <input name="actionS" type="hidden" id="actionS" value="HRMPerformanceDelete">
		<table width="900" border="0" align="center" cellpadding="1" cellspacing="1"  >
        <tr class="para">
          <td><div align="center"><a href="javascript:loadPerformance('0')">All</a></div></td>	
          <td><div align="center"><a href="javascript:loadPerformance('A')">A</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformance('B')">B</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformance('C')">C</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformance('D')">D</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformance('E')">E</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformance('F')">F</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformance('G')">G</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformance('H')">H</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformance('I')">I</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformance('J')">J</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformance('K')">K</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformance('L')">L</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformance('M')">M</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformance('N')">N</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformance('O')">O</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformance('P')">P</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformance('Q')">Q</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformance('R')">R</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformance('S')">S</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformance('T')">T</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformance('U')">U</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformance('V')">V</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformance('W')">W</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformance('X')">X</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformance('Y')">Y</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformance('Z')">Z</a></div></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
      <td height="17" align="center"><center>
          <table  border="0" cellspacing="1" cellpadding="1">
            <tr>
              <td width="56"><input class="tMLAscreenHead" name="submit" type="submit" onClick="Add()" value="Add"></td>
              <td  width="56"><input class="tMLAscreenHead" name="edit"  id="edit" type="submit" onClick="return REdit()" value="Edit"></td>
              <td  width="56"><input class="tMLAscreenHead" name="delete" id="delete" type="submit" onClick="Delete()" value="Delete"></td>
              <td  width="56"><input class="tMLAscreenHead" type="Button" name="Close"  value="Close"   accesskey="c"  onClick="redirect('HRMmain.jsp')"></td>
            </tr>
		  </table>
  		<tr><td height="20" ><%@ include file="../footer.jsp"%></td></tr>
</table>
</body>
</html>


