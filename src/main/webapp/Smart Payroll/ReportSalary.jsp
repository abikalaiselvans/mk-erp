<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title> :: PAYROLL ::</title>


 
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script type="text/javascript">
	function OpenAllowanceWindow(id)
	{
		var url="AllowanceModify.jsp?empId="+id;
		window.open(url,"_blank","channelmode =0,scrollbars = yes,left=300,top=200,height =365,width=400,toolbar=no,resizable=no")				
	}
	
	function OpenRecoveryWindow(id)
	{
		var url="RecoveryModify.jsp?empId="+id;
		window.open(url,"_blank","channelmode =0,scrollbars = yes,left=300,top=200,height =365,width=400,toolbar=no,resizable=no")		
	}
	function OpenAdvanceWindow(id)
	{
		var url="AdvanceModify.jsp?empId="+id;
		window.open(url,"_blank","channelmode =0,scrollbars = yes,left=300,top=250,height =300,width=450,toolbar=no,resizable=no")		
	}
	function LoadWindow(url)
	{
		alert(url);
		document.salary.action=url;
		document.salary.submit();
	}
</script>
 

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
.style52 {font-size: 10px}
.style54 {font-family: Verdana}
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
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%@ include file="index.jsp"%>
<br>
<form  AUTOCOMPLETE = "off"   name="salary" action="../SmartLoginAuth">

<table width="100%" border="0" cellspacing="5" cellpadding="0">
	<tr>
		<td>
		<%
	String month=""+request.getParameter("month");
	String year=""+session.getAttribute("Year");
	String Department=""+request.getParameter("depid");
	String update=""+session.getAttribute("update");
	String url="";
	String stafid="";
	//System.out.println("afsf");
%>
		</td>
	</tr>
	<tr>
		<td>
		<div align="center"><input type="hidden" name="filename"
			value="SalaryCalculation"> <input type="hidden"
			name="actionS" value="PAYSalaryCalculationNPF"> <input
			type="hidden" name="CalculationNPF" value="View"> <input
			type="hidden" name="reportType" value="Month"> <input
			type="hidden" name="Month" value="<%=month %>"> <input
			type="hidden" name="Year" value="<%=year %>"> <input
			type="hidden" name="Department" value="<%=Department %>"> <%
	
	try
	{
		FileReader fr = new FileReader("Report.sys");
		BufferedReader br  = new BufferedReader(fr);
		String strfline ="";
		StringTokenizer filecontents;
		int linecount=0;
		while((strfline=br.readLine())!= null )
		{
			linecount = linecount+1;
		}
		int noofpage;
		int nooflineperpage = 30;
		linecount = linecount-2;
		noofpage = linecount / nooflineperpage;
 		fr = new FileReader("Report.sys");
		br  = new BufferedReader(fr);
		int fline=1;
     	out.println("<div  id='divscroll' style='OVERFLOW: auto;width:100%;height:300px'>");
		 out.println("<table id='myTable' width='100%' border='0' cellpadding='0' cellspacing='2'  >");
		
		while((strfline=br.readLine())!= null )
		{	
			//System.out.println("ASAs"+fline);
			if (fline == 1 )
			{
				out.println("<tr bgcolor='#881111' class='tablehead'>");
				out.println("<td colspan=20><center><b>"+strfline+"</b></center>");
			}
			
			if (fline == 2)
			{
				filecontents = new StringTokenizer(strfline,"^");
				out.println("<tr bgcolor='FFCC00' class='bolddeepblue'>");
	  			int i=1;
				while(filecontents.hasMoreElements())
				{
			   		if(i==1)
					{ 
						out.println("<td width='15px'><b><font color='000000'>"+filecontents.nextElement() +"</font></b>");
			   	    }
					if(i==2)
					{
						out.println("<td width='100px'><b><font color='000000'>"+filecontents.nextElement() +"</font></b>");		   	    				}
					if(i==3)
					{ //EMP NAME
					out.println("<td width='150px'><b><font color='000000'>"+filecontents.nextElement() +"</font></b>");			   	    			}
					if(i==4)
					{ 
					out.println("<td width='30px'><b><font color='000000'>"+filecontents.nextElement() +"</font></b>");
					}
					if(i==5)
					{ 
					out.println("<td width='30px'><b><font color='000000'>"+filecontents.nextElement() +"</font></b>");
					}
					if(i==6)
					{ 
					out.println("<td width='30px'><b><font color='000000'>"+filecontents.nextElement() +"</font></b>");			   	    				}
					if(i==7)
					{ 
						out.println("<td width='30px'><b><font color='000000'>"+filecontents.nextElement()+"</font></b>");			   	    			}
					if(i==8)
					{ // LD
						out.println("<td width='30px'><b><font color='000000'>"+filecontents.nextElement() +"</font></b>");
					}
					if(i==9)
					{ 
					out.println("<td width='40px'><b><font color='000000'>"+filecontents.nextElement() +"</font></b>");			   	    				}
					if(i==10)
					{ 
						out.println("<td width='30px'><b><font color='000000'>"+filecontents.nextElement() +"</font></b>");			   	    			}
					if(i==11)
					{
						out.println("<td width='40px'><b><font color='000000'>"+filecontents.nextElement() +"</font></b>");			   	    			}
					if(i==12)
					{  //PF
						out.println("<td width='30px'><b><font color='000000'>"+filecontents.nextElement() +"</font></b>");			   	    			}
					if(i==13)
					{ 
						out.println("<td width='30px'><b><font color='000000'>"+filecontents.nextElement() +"</font></b>");			   	    			}
					if(i==14)
					{ 
						out.println("<td width='30px'><b><font color='000000'>"+filecontents.nextElement()+"</font></b>	");		   	    				}
					if(i==15)
					{ 
						out.println("<td width='30px'><b><font color='000000'>"+filecontents.nextElement()+"</font></b>");			   	    			}
					if(i==16)
					{ 
						out.println("<td width='30px'><b><font color='000000'>"+filecontents.nextElement()+"</font></b>	");		   	    				}
					if(i==17)
					{ 
						out.println("<td width='30px'><b><font color='000000'>"+filecontents.nextElement()+"</font></b>	");		   	    				}
					if(i==18)
					{ 
						out.println("<td width='30px'><b><font color='000000'>"+filecontents.nextElement()+"</font></b>");			   	    			}
					if(i==19)
					{ 
						out.println("<td width='35px'><b><font color='000000'>"+filecontents.nextElement() +"</font></b>");			
					}
					i=i+1;
					
			   	}
				out.println("<td width='7px'><b><font color='000000'>&nbsp;</font></b>");			
				out.println("</tr>");
				 
				
				
			}
			
			out.println("<tr colspan=20>");
			if (fline >= 3)
			{
				filecontents = new StringTokenizer(strfline,"^");
				if((fline % 2)==0)
				{
					out.println("<tr class='bolddeepblue' bgcolor='FFEEAA'>");
				}
				else
				{
					out.println("<tr class='bolddeepblue' bgcolor='FFFFFF'>");
				}
				int i=0;
				String empid=null;
				String empname=null;
				stafid="";
				while(filecontents.hasMoreElements())
				{
					
					if(i==0)
				   		out.print("<td width='15px' align='left'>"+filecontents.nextElement());
					if(i==1)
					{  //Name
						empid=""+filecontents.nextElement();
						empid=empid.trim();
						//System.out.println(empid);
						stafid=empid;
						out.print("<td width='100px' align='left'>"+empid);				   		
					}
					if(i==2)
					{  //Working Day
						empname=""+filecontents.nextElement();
				   		out.print("<td width='150px' align='left'>"+empname);
				   		empname=empname.trim();		
						empid="~"+empid+"~";
					}
					if(i==3)
					{
						out.print("<td width='30px' align='right'>"+filecontents.nextElement());
					}
					if(i==4)//Allowance
					{
						String ss=""+filecontents.nextElement();
						ss=ss.substring(0,ss.length()-2);
						out.print("<td width='40px' align='right'>"+ss);
					}
					if(i==5)
					{  //Recovery
						out.print("<td width='40px' align='right'>"+filecontents.nextElement());
					}
					if(i==6)
					{   //MESS
						out.print("<td width='40px' align='right'>"+filecontents.nextElement());
					}
					if(i==7)
					{  //ADV TOT
						out.print("<td width='30px' align='right'>"+filecontents.nextElement());
					}
					if(i==8) 
					{  
						out.print("<td width='30px' align='right'>"+filecontents.nextElement()+"</div>");
						//out.print("<td width='30px' align='right'><a href=javascript:OpenAllowanceWindow('"+empid+"');><div id='D"+empid+"'>"+filecontents.nextElement()+"</div>");
					}
					if(i==10)
					{
						out.print("<td width='30px' align='right'>"+filecontents.nextElement());
						
					}
					if(i==15)
					{
						
					String qy="SELECT CHR_DECTYPE FROM PAY_M_ADVANCE WHERE CHR_EMPID='"+stafid+"' AND DT_CLOSEDATE IS NULL"; 
					String advtype="";
						if(com.my.org.erp.common.CommonInfo.RecordExist("SELECT count(*) FROM PAY_M_ADVANCE WHERE CHR_EMPID='"+stafid+"'"))
						{
							String advanceExsist[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(qy);
							advtype =advanceExsist[0][0];
						}	
					
						if("M".equals(advtype))
					 		out.print("<td width='30px' align='right'><a href=javascript:OpenAdvanceWindow('"+empid+"');><font class='newsarticlegreen'>"+filecontents.nextElement()+"</font></a>");
						else
							out.print("<td width='30px' align='right'>"+filecontents.nextElement());
					 
					}	
					if(i==17)
						out.print("<td width='30px' align='right'>"+filecontents.nextElement());
					if(i==19)
						out.print("<td width='40px' align='right'>"+filecontents.nextElement());
					else
						out.print("<td width='30px' align='right'>"+filecontents.nextElement());
					
					
					i++;	
								
				}
		}
		fline = fline + 1;
	}
	out.println("</table></div>");
	br.close();
	fr.close();
	}
	catch(Exception e)
	{
		
	}
	
%>
		</div>
		</td>
	</tr>
	<tr>
		<td>
		<div align="center">
		<%
			//out.println("<table width=56><tr><td><input name='Update' type='submit' class='buttonbold' value='Update'></table>");
			%>
		</div>
		</td>
	</tr>
	<tr>
		<td>

		<table width="184" align="center" cellpadding="15" cellspacing="0">
			<tr>
				<td width="100" height="44" class="boldEleven"><strong>Export
				</strong></td>
				<td class="boldEleven">
				<div align="center"><a title="Excel" href=javascript:;
					onClick=" CreateExcelSheet()"><img
					src="../Image/report/Excel.png" width="15" height="14" border="0"></a>
				</div>
				</td>

				<td class="boldEleven">
				<div align="center"><a title="Text" href=javascript:;
					onClick="windowSave('SalaryReport.txt')"><img
					src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a title="Document" href=javascript:;
					onClick="windowSave('SalaryReport.doc')"><img
					src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a title="HTML" href=javascript:;
					onClick="windowSave('SalaryReport.html')"><img
					src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div>
				</td>

			</tr>
		</table>

		</td>
	</tr>
	<tr>
		<td>
		<center>
		<table cellspacing=2 cellpadding=2>
			<tr>
				<td class='bolddeepblue' align='left'><b>BPay :: </b></td>
				<td class='bolddeepblue' align='left'>Basic Pay</td>
				<td class='bolddeepblue' align='left'><b>WD :: </b></td>
				<td class='bolddeepblue' align='left'>Working Day</td>
				<td class='bolddeepblue' align='left'><b>ELD :: </b></td>
				<td class='bolddeepblue' align='left'>Extra or Losspay Days</td>
				<td class='bolddeepblue' align='left'><b>LD :: </b></td>
				<td class='bolddeepblue' align='left'>Late Days</td>
				<td class='bolddeepblue' align='left'><b>Allo :: </b></td>
				<td class='bolddeepblue' align='left'>Allowance</td>
			</tr>
			<tr>
				<td class='bolddeepblue' align='left'><b>GPay :: </b></td>
				<td class='bolddeepblue' align='left'>Gross Pay</td>
				<td class='bolddeepblue' align='left'><b>Recv :: </b></td>
				<td class='bolddeepblue' align='left'>Recovery</td>
				<td class='bolddeepblue' align='left'><b>ATot :: </b></td>
				<td class='bolddeepblue' align='left'>Total Advance</td>
				<td class='bolddeepblue' align='left'><b>ADec :: </b></td>
				<td class='bolddeepblue' align='left'>Advance Decution</td>
				<td class='bolddeepblue' align='left'><b>ALeft :: </b></td>
				<td class='bolddeepblue' align='left'>Advance Left</td>
			</tr>
			<tr>
				<td class='bolddeepblue' align='left'><b>Dect :: </b></td>
				<td class='bolddeepblue' align='left'>Dection</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</table>
		</center>
		</td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</form>

<p>
</tr>
<body  onpaste='return false;'>
</p>
</html>
