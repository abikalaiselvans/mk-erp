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

<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="../JavaScript/HRM/HrmAjax.js"></script>
<script language="javascript">
function Edit()
{		
 	    var count=0;
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
			document.frmPerformView.action="PerofrmanceDetails.jsp";
			return true;
		}
 	}	
</script>		
 
<style type="text/css">
<!--
.style3 {color: #000000}
-->
</style>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadPerformanceView('0'),document.getElementById('month').focus()">
<form  AUTOCOMPLETE = "off" method="post" name="frmPerformView" > 
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
              			<select name="month" id="month" onChange="loadPerformanceView('0')">
               				<%@ include file="../JavaScript/months.jsp" %>
              			</select>
            			</span>
            		</td>
            		<td><span class="boldThirteen">Year  ::</span></td>
            		<td><span class="boldThirteen">
              			<select name="year" id="year" onChange="loadPerformanceView('0')">
                			
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
              </tr>
            </table></td>
          </tr>
          <tr>
          <td height="28" valign="top">
          	<div  id="performanceTable" style="OVERFLOW: auto;width:900px;height:160px">		  </div>
		  </td>
		  </tr>
		  <td>
		  	<div id ="noId" align='center' class='boldEleven'></div></td>
      </table></td>
  </tr>        
  <tr>
      <td height="17">
      <input name="filename" type="hidden" id="filename" value="Performance">
      <input name="actionS" type="hidden" id="actionS" value="HRMPerformanceDelete">
		<table width="900" border="0" align="center" cellpadding="1" cellspacing="1"  >
        <tr class="para">
          <td><div align="center"><a href="javascript:loadPerformanceView('0')">All</a></div></td>	
          <td><div align="center"><a href="javascript:loadPerformanceView('A')">A</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformanceView('B')">B</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformanceView('C')">C</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformanceView('D')">D</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformanceView('E')">E</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformanceView('F')">F</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformanceView('G')">G</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformanceView('H')">H</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformanceView('I')">I</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformanceView('J')">J</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformanceView('K')">K</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformanceView('L')">L</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformanceView('M')">M</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformanceView('N')">N</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformanceView('O')">O</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformanceView('P')">P</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformanceView('Q')">Q</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformanceView('R')">R</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformanceView('S')">S</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformanceView('T')">T</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformanceView('U')">U</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformanceView('V')">V</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformanceView('W')">W</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformanceView('X')">X</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformanceView('Y')">Y</a></div></td>
          <td><div align="center"><a href="javascript:loadPerformanceView('Z')">Z</a></div></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
      <td height="17" align="center"><center>
          <table  border="0" cellspacing="2" cellpadding="2">
            <tr>
              <td  width="56"><input class="tMLAscreenHead" name="edit"  id="edit" type="submit" onClick="return Edit()" value="View"></td>
              <td  width="56"><input class="tMLAscreenHead" type="Button" name="Close"  value="Close"   accesskey="c"  onClick="redirect('HRMmain.jsp')"></td>
            </tr>
		  </table>
	<tr><td height="20" ><%@ include file="../footer.jsp"%></td></tr>
</table>
</form>
</body>
</html>


