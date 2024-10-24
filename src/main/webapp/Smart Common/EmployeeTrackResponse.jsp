<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.*"%>
<%
try
{
%>
<html>
<head>

<title> :: COMMON ::</title>


 
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id,payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
 <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
 

</head>
 <body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="center"><table width="100%"   border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td align="center" valign="top">
<%
	try
	{
			String empid = request.getParameter("ename");
			String sql ="";
			sql = " SELECT MONTH(NOW()), MONTHNAME(NOW()),YEAR(NOW()),DAY(NOW())";
			String sqldata[][] =  CommonFunctions.QueryExecute(sql);
			String month =sqldata[0][0];
			String monthname =sqldata[0][1];
			String year =sqldata[0][2];
			String day =sqldata[0][3];
			
			sql = " SELECT CHR_EMPID,CHR_STAFFNAME,CHR_STAFFFNAME,CHR_MOTHERNAME,DATE_FORMAT(DT_DOJCOLLEGE,'%d-%b-%Y'), ";
			sql = sql + " FUN_GET_COMPANY_NAME(INT_COMPANYID),FUN_GET_BRANCH_NAME(INT_BRANCHID),FUN_GET_OFFICE_NAME(INT_OFFICEID), ";
			sql = sql + " FUN_GET_CATEGORYNAME(CHR_CATEGORY),FUN_GET_DEPARTNAME(INT_DEPARTID), ";
			sql = sql + " FUN_GET_DESIGNATION_NAME(INT_DESIGID),IF(CHR_TYPE='T','Resigned','Active') , ";
			sql = sql + " FIND_A_EMPLOYEE_ID_NAME(CHR_REPTO) ";
			sql = sql + " FROM com_m_staff WHERE CHR_EMPID='"+empid+"' ";
			//out.println(sql);
			String data[][] =  CommonFunctions.QueryExecute(sql);
			
			//Personnal Informations
			if(data.length>0)
			{
				out.println("<table width='90%'  class='boldEleven' cellpadding=5 cellspacing=3 bgcolor='#9900CC' >");
				out.println("<tr  class='MRow1'>");
				out.println("<td class='boldEleven' align='center' colspan='4' ><b>PERSONNAL INFORMATIONS</td>");
				out.println("</tr>");
				out.println("<tr  class='MRow1'>");
				out.println("<td class='boldEleven'  ><b>Emp ID</td>");
				out.println("<td class='boldEleven'>"+data[0][0]+"</td>");
				out.println("<td class='boldEleven'  ><b>Father</td>");
				out.println("<td class='boldEleven'>"+data[0][2]+"</td>");
				out.println("</tr>");
				out.println("<tr  class='MRow2'>");
				out.println("<td class='boldEleven'  ><b>Emp Name</td>");
				out.println("<td class='boldEleven'>"+data[0][1]+"</td>");
				out.println("<td class='boldEleven'  ><b>Mother</td>");
				out.println("<td class='boldEleven'>"+data[0][3]+"</td>");
				out.println("</tr>");
				out.println("<tr  class='MRow1'>");
				out.println("<td class='boldEleven'  ><b>DOJ</td>");
				out.println("<td class='boldEleven'>"+data[0][4]+"</td>");
				out.println("<td class='boldEleven'  ><b>Company</td>");
				out.println("<td class='boldEleven'>"+data[0][5]+"</td>");
  				out.println("</tr>");
				out.println("<tr  class='MRow2'>");
				out.println("<td class='boldEleven'  ><b>Department</td>");
				out.println("<td class='boldEleven'>"+data[0][9]+"</td>");
				out.println("<td class='boldEleven'  ><b>Branch</td>");
				out.println("<td class='boldEleven'>"+data[0][6]+"</td>");
				out.println("</tr>");
				out.println("<tr  class='MRow1'>");
				out.println("<td class='boldEleven'  ><b>Designation</td>");
				out.println("<td class='boldEleven'> "+data[0][10]+"</td>");
				out.println("<td class='boldEleven'  ><b>Office</td>");
				out.println("<td class='boldEleven'>"+data[0][7]+"</td>");
				out.println("</tr>");
				out.println("<tr  class='MRow2'>");
				out.println("<td class='boldEleven'  ><b>Status</td>");
				out.println("<td class='boldEleven'>"+data[0][11]+"</td>");
				out.println(" <td class='boldEleven'  ><b>Reporting To</td>");
				out.println("<td class='boldEleven'>"+data[0][12]+"</td>");
				out.println("</tr>");
    			out.println("</table>");
 			}
			
			
			//Leave Informations
			out.println("</br></br>");
			 sql = "SELECT INT_LEAVEID,CHR_LEAVENAME,CHR_SYMBOL FROM att_m_leavetype ORDER BY INT_LEAVEID";
			 String Leaves[][] = CommonFunctions.QueryExecute(sql);
			 if(Leaves.length>0)
			 {
				out.println("<center>");
				out.println("<table  width='90%'  class='boldEleven' cellpadding=5 cellspacing=3 bgcolor='#9900CC' >");
				out.println("<tr bgcolor='#ffffff'><td class='boldEleven' colspan='4' align='center' ><b>Leave Details for the current year</b></td></tr>");
				out.println("<tr bgcolor='#ffffff'><td class='boldEleven'  ><b>Leave name</b>");
				out.println("<td class='boldEleven'  ><b>No of Leave</b>");
				out.println("<td class='boldEleven'  ><b>Leave Taken</b>");
				out.println("<td class='boldEleven'  ><b>Balance Leave</b>");
				for(int u=0; u<Leaves.length; u++)
				{
					if(u%2==0)
						out.println("<tr  class='MRow1'>");
					else
						out.println("<tr class='MRow2'>");
					
					out.println("<td class='boldEleven' >"+Leaves[u][1]+"&nbsp;</td>");
					sql="SELECT INT_NOD"+Leaves[u][0]+",INT_NOD"+Leaves[u][0]+"BALANCE ,(INT_NOD"+Leaves[u][0]+" -INT_NOD"+Leaves[u][0]+"BALANCE) FROM att_m_leave  WHERE CHR_EMPID='"+empid+"' AND INT_YEAR =year(now())";
					String LData[][]=CommonFunctions.QueryExecute(sql);
					if(LData.length>0)
					{
						out.println("<td class='boldEleven' >"+LData[0][0]+"&nbsp;</td>");
						out.println("<td class='boldEleven' >"+LData[0][1]+"&nbsp;</td>");
						out.println("<td class='boldEleven' >"+LData[0][2]+"&nbsp;</td>");
					}
					else
					{
						out.println("<td class='boldEleven' >&nbsp;</td>");
						out.println("<td class='boldEleven' >&nbsp;</td>");
						out.println("<td class='boldEleven' >&nbsp;</td>");
					
					}	
				
				}
				out.println("</table>");
				out.println("</center>");
			}
			
			
			
			
			//Attendance Informations
			out.println("</br></br><div style=\"OVERFLOW: auto;width:1000;height:200px;\" >");
			int daysInMonth =  CommonFunctions.daysInMonth(year+"-"+month+"-01");
			String startingdate="1";
			int startingday = Integer.parseInt(startingdate);
			String endingdate=""+daysInMonth;
			int endingday = Integer.parseInt(endingdate);
			String umonth=DateUtil.getMonth(Integer.parseInt(month));
			if(startingday>daysInMonth)
				startingday =daysInMonth-1;
			if(endingday<daysInMonth)
				daysInMonth=endingday;
			String link="";
			String link1="";
			String em="";
			String tooltip="";
			String hs="";
			for(int x=startingday;x<(daysInMonth+1);x++)//32
				hs = hs+"a.CHR_MORNING"+x+","+"a.CHR_EVENING"+x+",";
			
			hs= hs+"a.DOU_PRESENT,a.DOU_ONDUTY,a.DOU_SUNDAY,a.DOU_HOLIDAY,a.DOU_LEAVE,a.DOU_ABSENT,a.INT_LATE,a.INT_PERMISSION,a.DOU_EXTRADAYS,a.DOU_TOTALDAYS,a.CHR_FLAG";
			sql = "SELECT  DISTINCT  b.CHR_EMPID,b.CHR_STAFFNAME , "+hs+" FROM att_t_register a , com_m_staff b "; 
			sql = sql+" WHERE b.CHR_EMPID=a.CHR_EMPID   AND a.CHR_MONTH ='"+umonth+"'  AND a.INT_YEAR= "+year+"  "; 
			sql = sql + "  AND a.CHR_EMPID ='"+empid +"' ";
			//out.println(sql);
			String attdata[][] = CommonFunctions.QueryExecute(sql);
			
			out.println(" <table id='myTable' ' cellpadding=5 cellspacing=1 bgcolor='#0099cc' border=0 >");
			out.println("<tr class='MRow4'>");
			out.println("<td class='newsarticlesmall'colspan=77 class='newsarticlesmall' align='center' valign='bottom'><center><h1>"+umonth+" - "+year+"</h1></td>");
			out.println("<tr class='MRow4'>");
			out.println("<td class='newsarticlesmall'>&nbsp;</td>");
			out.println("<td class='newsarticlesmall'>&nbsp;</td>");
			out.println("<td class='newsarticlesmall'>&nbsp;</td>"); 
			for(int x=startingday;x<(daysInMonth+1);x++)//32
				out.println("<td colspan=2 class='newsarticlesmall' align='center'><center><b>"+x+"</center>"); 
			out.println("</tr>");
			
			if(attdata.length>0)
			{
				out.println("<tr class='MRow4'>");
				out.println("<td class='newsarticlesmall'><b>S.No</td>");
				out.println("<td class='newsarticlesmall'><b>Empid</td>");
				out.println("<td class='newsarticlesmall' ><b>Emp Name</td>"); 
				for(int x=startingday;x<(daysInMonth+1);x++)//32
					out.println("<td class='newsarticlesmall' align=center><b>MOR</td><td class='newsarticlesmall'><b>EVE</b></td>"); 
				out.println("</tr>");
				
				for(int u=0;u<attdata.length;u++)
				{
					link="";
					link1="";
					if(u%2==0)
						out.println("<tr class='MRow3'>");
					else
						out.println("<tr class='MRow4'>");	
					out.println("<td class='newsarticlesmall'>"+(u+1)+"</td>");
					out.println("<td class='newsarticlesmall'>"+attdata[u][0]+"</td>");
					out.println("<td class='newsarticlesmall'>"+attdata[u][1]+"</td>");
					
					int date=1;
					int x=1;		
					for(int v=startingday;v<=((daysInMonth*2-startingday)+1);v++)//63
					{
						 
						
						em="";
						if("0".equals(attdata[u][(x+1)]))
							em="&nbsp;";
						else
							em =attdata[u][(x+1)];
							
						
						if("0".equals(attdata[u][(x+1)]))
							out.println("<td class='boldEleven'  bgcolor='#00FFFF' title='"+attdata[u][1]+"'>&nbsp;"+link +"</td>");
						else if("LEA".equals(attdata[u][(x+1)]))
							out.println("<td class='boldEleven'  bgcolor='#FAF0E6' title='"+attdata[u][1]+"'>&nbsp;"+link1 +"</td>");
						else if( "SUN".equals(attdata[u][(x+1)]))
							out.println("<td class='boldEleven' bgcolor='#8FBC8F' title='"+attdata[u][1]+"'> "+attdata[u][(x+1)] +"</td>");
						else if( "HOL".equals(attdata[u][(x+1)]))
							out.println("<td class='boldEleven' bgcolor='#F08080' title='"+attdata[u][1]+"'> "+attdata[u][(x+1)] +"</td>");
						else  if( "PER".equals(attdata[u][(x+1)]))
							out.println("<td class='boldEleven' bgcolor='#F08080' title='"+attdata[u][1]+"'> "+attdata[u][(x+1)] +"</td>");
						else  if( "LAT".equals(attdata[u][(x+1)]))
							out.println("<td class='newsarticlesmall' bgcolor='#F08080' title='"+attdata[u][1]+"'> "+attdata[u][(x+1)] +"</td>");
						else  if( "ABS".equals(attdata[u][(x+1)]))
							out.println("<td class='boldEleven' bgcolor='#F08080' title='"+attdata[u][1]+"'> "+attdata[u][(x+1)] +"</td>");
						else  if( "NA".equals(attdata[u][(x+1)]))
							out.println("<td class='boldEleven' bgcolor='#F0BB80' title='"+attdata[u][1]+"'> "+attdata[u][(x+1)] +"</td>");
						else  //if( "-".equals(attdata[u][(x+1)]))
							out.println("<td class='boldEleven' bgcolor='#00FFFF' title='"+attdata[u][1]+"'> "+attdata[u][(x+1)] +"</td>");
						x= x+1;
					}
 				}
 			}
			else
			{
				out.println("<tr bgcolor='#ffffff'><td colspan=66 class='newsarticlesmall'  > Data not found...</td>");
			}	
			out.println("</table></div>");

		
		
			
			//Asset Informations
			out.println("</br></br> ");
			boolean aflag = false;
			if(CommonFunction.RecordExist("SELECT COUNT(*) FROM inv_t_asset WHERE CHR_EMPID ='"+empid+"'  AND CHR_STATUS='N'"))
			{
				aflag = true;
				sql =  " SELECT  ";
				sql = sql + " if( a.CHR_TYPE ='I' ,  ";
				sql = sql + " (SELECT c.CHR_ITEMNAME FROM inv_m_item c WHERE c.CHR_ITEMID= a.CHR_ITEMID ), ";
				sql = sql + " (SELECT d.CHR_PRODUCTCODE FROM inv_m_produtlist d WHERE d.CHR_PRODUCTID= a.CHR_ITEMID ) ";
				sql = sql + " ), ";
				sql = sql + " a.CHR_SERIALNO ,a.CHR_DESCRIPTION,DATE_FORMAT(a.DAT_CREATIONDATE,'%d-%b-%Y')   ";
				sql = sql + " FROM inv_t_asset a, inv_t_vendorgoodsreceived b    ";
				sql = sql + " WHERE  b.CHR_ITEMID = a.CHR_ITEMID AND a.CHR_STATUS ='N'  AND a.CHR_SERIALNO =b.CHR_SERIALNO ";
				sql = sql + " AND a.CHR_EMPID ='"+empid+"'  ";
				sql = sql + " GROUP BY a.CHR_SERIALNO ";
				String adata[][] = CommonFunctions.QueryExecute(sql);
				if(adata.length>0)
				{
					out.println("<center>");
					out.println("<table width='90%' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
					out.println("<tr  class='MRow1'>");
					out.println("<td class='boldEleven' align='center' colspan='5' ><b>ASSET INFORMATIONS</td>");
					out.println("</tr>");
					out.println("<tr class='MRow1'>");
					out.println("<td class='boldEleven' align='center'><b>S.No<b></td>");
					out.println("<td class='boldEleven' align='center'><b>Item<b></td>");
					out.println("<td class='boldEleven' align='center'><b>Serial<b></td>");
					out.println("<td class='boldEleven' align='center'><b>Description<b></td>");
					out.println("<td class='boldEleven' align='center'><b>Date<b></td>");
					out.println("</tr>");
					
					for(int x=0;x<adata.length;x++)
					{
						if(x%2==0)
							out.println("<tr class='MRow1'>");
						else
							out.println("<tr class='MRow2'>");	
						out.println("<td class='boldEleven' >"+(x+1)+"</td>");
						out.println("<td class='boldEleven' >"+adata[x][0]+"</td>");
						out.println("<td class='boldEleven' >"+adata[x][1]+"</td>");
						out.println("<td class='boldEleven' >"+adata[x][2]+"</td>");
						out.println("<td class='boldEleven' >"+adata[x][3]+"</td>");
						out.println("</tr>");
					}
					out.println("</table>");
					out.println("</center>");
				}
			}	
	
	
	
			//Asset Informations
			out.println("</br></br>");
			sql = "SELECT FUN_PAY_GET_ADVANCE('"+empid+"')";
			String advanceData[][] = CommonFunctions.QueryExecute(sql);
			if(advanceData.length>0)
			{
				 out.println("<center><b>Advance :: "+advanceData[0][0]+"</center>");
			}
			
			//Conveyance Informations FOR REPORTING HEAD
			out.println("</br></br>");
			sql = "";
			sql = sql + " SELECT FIND_A_EMPLOYEE_ID_NAME(a.CHR_EMPID),FIND_A_EMPLOYEE_REPORTING_TO(a.CHR_EMPID), ";
			sql = sql + " COUNT(*) FROM conveyance_t_conveyance a, com_m_staff b   ";
			sql = sql + " WHERE a.CHR_EMPID = b.CHR_EMPID AND a.CHR_ACCEPT='N'   ";
			sql = sql + " AND b.CHR_REPTO='"+empid+"'  ";  
			sql = sql + " GROUP BY a.CHR_EMPID ";
			sql = sql + " ORDER BY b.CHR_STAFFNAME ";
			String conData[][] = CommonFunctions.QueryExecute(sql);
			if(conData.length>0)
			{
				out.println("<center>");
				out.println("<table width='90%' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
				out.println("<tr  class='MRow1'>");
				out.println("<td class='boldEleven' align='center' colspan='4' ><b>CONVEYANCE INFORMATIONS</td>");
				out.println("</tr>");
				out.println("<tr class='MRow1'>");
				out.println("<td class='boldEleven' align='center'><b>S.No<b></td>");
				out.println("<td class='boldEleven' align='center'><b>EMP ID<b></td>");
				out.println("<td class='boldEleven' align='center'><b>REPORTING TO<b></td>");
				out.println("<td class='boldEleven' align='center'><b>NO OF ENTRY<b></td>");
				out.println("</tr>");
				
					for(int x=0;x<conData.length;x++)
					{
						if(x%2==0)
							out.println("<tr class='MRow1'>");
						else
							out.println("<tr class='MRow2'>");	
						out.println("<td class='boldEleven' >"+(x+1)+"</td>");
						out.println("<td class='boldEleven' >"+conData[x][0]+"</td>");
						out.println("<td class='boldEleven' >"+conData[x][1]+"</td>");
						out.println("<td class='boldEleven' >"+conData[x][2]+"</td>");
						out.println("</tr>");
					}
					out.println("</table>");
					out.println("</center>");
			}
			
			
			
			
			//REPORTING SUMMARY
			out.println("</br></br>");
			sql = " SELECT   ";
			sql = sql + " FUN_GET_COMPANY_NAME(INT_COMPANYID),FUN_GET_BRANCH_NAME(INT_BRANCHID),FUN_GET_OFFICE_NAME(INT_OFFICEID),  ";
			sql = sql + " FUN_GET_CATEGORYNAME(CHR_CATEGORY),FUN_GET_DEPARTNAME(INT_DEPARTID),  ";
			sql = sql + " FUN_GET_DESIGNATION_NAME(INT_DESIGID),IF(CHR_TYPE='T','Resigned','Active') ,  ";
			sql = sql + " FIND_A_EMPLOYEE_ID_NAME(CHR_REPTO),COUNT(*)  ";
			sql = sql + " FROM com_m_staff WHERE CHR_REPTO='"+empid+"'  ";
			sql = sql + " GROUP BY CHR_CATEGORY  ";
			String reptData[][] = CommonFunctions.QueryExecute(sql);
			if(reptData.length>0)
			{
				out.println("<center>");
				out.println("<table width='90%' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
				out.println("<tr  class='MRow1'>");
				out.println("<td class='boldEleven' align='center' colspan='10' ><b>REPORTING SUMMARY</td>");
				out.println("</tr>");
				out.println("<tr class='MRow1'>");
				out.println("<td class='boldEleven' align='center'><b>S.No<b></td>");
				out.println("<td class='boldEleven' align='center'><b>COMPANY<b></td>");
				out.println("<td class='boldEleven' align='center'><b>BRANCH<b></td>");
				out.println("<td class='boldEleven' align='center'><b>OFFICE<b></td>");
				out.println("<td class='boldEleven' align='center'><b>CATEGORY<b></td>");
				out.println("<td class='boldEleven' align='center'><b>DEPARTMENT<b></td>");
				out.println("<td class='boldEleven' align='center'><b>DESIGNATION<b></td>");
				out.println("<td class='boldEleven' align='center'><b>TYPE<b></td>");
				out.println("<td class='boldEleven' align='center'><b>REPORTING TO<b></td>");
				out.println("<td class='boldEleven' align='center'><b>NO OF ENTRY<b></td>");
				out.println("</tr>");
				
					for(int x=0;x<reptData.length;x++)
					{
						if(x%2==0)
							out.println("<tr class='MRow1'>");
						else
							out.println("<tr class='MRow2'>");	
						out.println("<td class='boldEleven' >"+(x+1)+"</td>");
						out.println("<td class='boldEleven' >"+reptData[x][0]+"</td>");
						out.println("<td class='boldEleven' >"+reptData[x][1]+"</td>");
						out.println("<td class='boldEleven' >"+reptData[x][2]+"</td>");
						out.println("<td class='boldEleven' >"+reptData[x][3]+"</td>");
						out.println("<td class='boldEleven' >"+reptData[x][4]+"</td>");
						out.println("<td class='boldEleven' >"+reptData[x][5]+"</td>");
						out.println("<td class='boldEleven' >"+reptData[x][6]+"</td>");
						out.println("<td class='boldEleven' >"+reptData[x][7]+"</td>");
						out.println("<td class='boldEleven' >"+reptData[x][8]+"</td>");
						out.println("</tr>");
					}
					out.println("</table>");
					out.println("</center>");
			}
			
			
			
			 
	}
	catch(Exception e)
	{
			out.println(e.getMessage());
	}
	%></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td align="center">&nbsp;</td></tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table width="130" border="0" align="center" cellpadding="1"
									cellspacing="1">
      <tr>
         
        <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('commonmain.jsp')"></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
<%@ include file="../footer.jsp"%>

 
	<%	
	 
}
catch(Exception e)
{
}
%>
</body>
</html>
