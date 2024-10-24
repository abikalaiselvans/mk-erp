<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.io.*,java.text.SimpleDateFormat,java.util.*" errorPage="" %>
<%@ page import="com.my.org.erp.common.CommonFunctions" %>
<html>
<head>
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


<title> :: ATTENDANCE ::</title>


<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
  
<style type="text/css">
<!--
body {
	background-color: #dce4f9;
}
-->
</style></head>
<%
 try
 {
	

%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script type="text/javascript">
var count=0;
function startTime()
{
	try
    {
		count=count+1; 
		if(count>=10)
		{
			window.history.back(-1);
			//redirect1('proximity.jsp?type=SWOS');
		}	
		var today=new Date()
		var h=today.getHours()
		var m=today.getMinutes()
		var s=today.getSeconds()
		m=checkTime(m)
		s=checkTime(s)
		t=setTimeout('startTime()',500)
	}
	catch(err)
	{
		alert(err.description)
	}
}

function checkTime(i)
{
if (i<10) 
  {i="0" + i}
 
  return i
}
</script>
<body  onpaste="return false;" onLoad="startTime()">

 <%
	String cardno =request.getParameter("cardno");
	String type=""+request.getParameter("type");
	String title="",stimein="",stimeout="",gracetimein="",gracetimeout="",ltimeout="",ltimein="",sql="";
	String  error="";

    SimpleDateFormat dateformat=new SimpleDateFormat("yyyy-MM-dd");
	java.util.Date date=new java.util.Date();	
	String day[]=(dateformat.format(date)).split("-");
	
		
	if("SWS".equals(type)  )
		title="Single Entry With Shift";
	else
		title="";		
		
	if(com.my.org.erp.common.CommonFunction.RecordExist("SELECT COUNT(*) FROM att_m_proximitycardno  WHERE CHR_CARDNO='"+cardno+"'"))
	{	
	
		String empid=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_EMPID FROM att_m_proximitycardno  WHERE CHR_CARDNO='"+cardno+"'")[0][0];
		
		
		sql="SELECT DAT_SHIFT"+day[2]+" FROM att_t_shiftallocation where CHR_EMPID='"+empid+"' AND CHR_MONTH=MONTHNAME('"+dateformat.format(date)+"') AND INT_YEAR=year('"+dateformat.format(date)+"')" ;
		sql = " SELECT DT_STARTINGTIME,DT_ENDINGTIME,DT_LUNCH_IN,DT_LUNCH_OUT,DT_GRACEIN,DT_GRACEOUT,CHR_ENDWITH  FROM att_m_shift  WHERE INT_SHIFTID= ( "+sql+" ) ";
		String shiftdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		if(shiftdata.length>0)
		{
			stimein=shiftdata[0][0];
			stimeout=shiftdata[0][1];
			ltimeout=shiftdata[0][2];
			ltimein=shiftdata[0][3];
			gracetimein=shiftdata[0][4];
			gracetimeout=shiftdata[0][5];
			//shiftendwith=shiftdata[0][7];
		}
		else
		{
			sql =" SELECT TIM_TIMEIN,TIM_TIMEOUT,TIM_GRACEIN,TIM_GRACEOUT,TIM_LUNCHIN,TIM_LUNCHOUT FROM att_m_basicsettings ";
			String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			stimein=data[0][0];
			stimeout=data[0][1];
			gracetimein=data[0][2];
			gracetimeout=data[0][3];
			ltimein=data[0][4];
			ltimeout=data[0][5];
		}
		 
		
sql ="SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_DEPARTNAME,C.CHR_DESIGNAME,DATE_FORMAT(NOW(),'%Y-%m-%d'),TIME(NOW()),monthname(now()),year(now()),day(now())  FROM  com_m_staff  A,  com_m_depart   B, com_m_desig  C  WHERE A.INT_DEPARTID=B.INT_DEPARTID AND A.INT_DESIGID=C.INT_DESIGID AND A.CHR_EMPID='"+empid+"'";
		String empdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		String slot = com.my.org.erp.common.CommonFunctions.TimeSlot(stimein, stimeout, gracetimein, gracetimeout, ltimeout, ltimein);
		
 		sql="SELECT count(*) FROM ATT_SMART_ATTENDANCE WHERE CHR_EMPID ='"+empid +"' AND DT_LOGIN ='"+empdata[0][4]+"'";
		boolean flag = com.my.org.erp.common.CommonFunction.RecordExist(sql);
		boolean processflag=false;
		
		if(("1".equals(slot))&&(!flag))
		{
			error="";
			sql="INSERT INTO ATT_SMART_ATTENDANCE(CHR_EMPID,DT_TIMEIN,DT_LOGIN,";
			sql=sql+"CHR_LOGMONTH,INT_LOGYEAR,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS)";
			sql=sql+" VALUES('"+empid+"','"+empdata[0][5]+"','"+empdata[0][4]+"','"+empdata[0][6]+"','"+empdata[0][7]+"','"+session.getAttribute("USRID")+"',NOW(),'Y')";
			com.my.org.erp.common.CommonFunctions.Execute(sql);
			CommonFunctions.AttendanceMark(empid, "M", empdata[0][8], empdata[0][6] ,empdata[0][7]);
			error="IN TIME :: "+empdata[0][5]+" Marked, Morning Attendance successfully marked";
		}
		else if(("1".equals(slot))&&(flag))
		{
			error="Attendance already marked....";
		}
		else if(("5".equals(slot))&&(flag))
		{
			sql="SELECT DT_TIMEIN FROM ATT_SMART_ATTENDANCE WHERE CHR_EMPID ='"+empid +"' AND DT_LOGIN ='"+empdata[0][4]+"' AND DT_LOGOUT IS Null";
			String recdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);		
			if(recdata.length>0)
			{
				error="";
				sql="SELECT timediff(current_time(),'"+recdata[0][0]+"')";
				String hrs[] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql)[0][0].split(":");
				sql="UPDATE ATT_SMART_ATTENDANCE SET DT_TIMEOUT=current_time(), ";
				sql=sql+" DT_LOGOUT='"+empdata[0][4]+"',INT_TOTALHOUR="+hrs[0]+",INT_TOTALMIN="+hrs[1]+",CHR_TYPE='P'";
				sql=sql+" ,CHR_PRESENTTYPE='PROXIMITY'";
				sql=sql+" WHERE CHR_EMPID='"+empid+"' AND DT_LOGIN='"+empdata[0][4]+"' AND DT_TIMEOUT IS Null";
				com.my.org.erp.common.CommonFunctions.Execute(sql);	
				CommonFunctions.AttendanceMark(empid, "E", empdata[0][8], empdata[0][6] ,empdata[0][7]);	
				error="OUT TIME :: "+empdata[0][5]+" Marked, Evening Attendance successfully marked";
			}
			else
				error="Attendance already marked....";
		}
		else
		{
			error="Check your time....";
		}		%>
		
<table width="100%" height="80%" border="0" cellpadding="0" cellspacing="0" bgcolor="DCE4F9">
<tr>
  
  <td bgcolor="014E8D">
	<div align="center"><span class="tableTITLE1"><font size="8">ATTENDANCE</font>	    </span></div>		</td>
</tr>  
  <tr>
    <td bgcolor="DCE4F9">&nbsp;</td>
  </tr>
  <tr>
    <td bgcolor="DCE4F9"><table class="BackGround" cellspacing="0" cellpadding="0" width="390"
			align="center" border="0">
      <tbody>
        <tr>
          <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
          <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
          <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
        </tr>
        <tr>
          <td height="6"><spacer height="1" width="1" type="block" /></td>
        </tr>
        <tr>
          <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
          <td width="6"><spacer height="1" width="1" type="block" /></td>
          <td width="412"><table width="600" height="400" border="0" align="center"
						  class="bolddeepblue">
              <!--DWLayoutTable-->
              <tr align="center" valign="middle">
                <td   height="28" align="center"
								valign="middle" class="boldgre"><div align="center"><h3><%=title%></h3></div></td>
              </tr>
              <tr align="center" valign="middle">
                <td height="29" valign="middle" class="BackGround"
								 ><table width="491" height="231" border="0" align="center" cellpadding="2" cellspacing="0">
                  <tr>
                    <td colspan="6" class="boldEleven"><center>
                        <h2>&nbsp;</h2>
                    </center></td>
                  </tr>
                  <tr>
                    <td colspan="3" rowspan="4" class="boldEleven"><div align="center">
                        <%
			String staffphoto = com.my.org.erp.common.CommonFunctions.ServerPath()+"StaffPhoto/"+empid.trim() +".jpg";
			String defaul = "../StaffPhoto/default.jpg" ;
			String photo="";
			File f = new File(staffphoto);
			if (f.exists())
				photo = "../StaffPhoto/"+empid.trim() +".jpg";
			else
				photo =defaul;
		%>
                        <img src="<%=photo%>" title="<%=photo%>" 	width="100" height="130" border="1" name="Photo" id="Photo" /></div></td>
                    <td valign="top" class="boldEleven"><h3><strong></strong></h3>                      <strong>
                      <h3>Emp Id</h3>
                      </strong></td>
                    <td valign="top" class="boldEleven"><h3><strong></strong></h3>                      <strong>
                      <h3><%=empdata[0][0]%></h3>
                      </strong></td>
                    <td class="boldEleven">&nbsp;</td>
                  </tr>
                  <tr>
                    <td valign="top" class="boldEleven"><h3><strong></strong></h3>                      <strong>
                      <h3>Name</h3>
                      </strong></td>
                    <td valign="top" class="boldEleven"><h3><strong></strong></h3>                      <strong>
                      <h3><%=empdata[0][1]%></h3>
                      </strong></td>
                    <td class="boldEleven">&nbsp;</td>
                  </tr>
                  <tr>
                    <td valign="top" class="boldEleven"><h3><strong></strong></h3>                      <strong>
                      <h3>Department</h3>
                      </strong></td>
                    <td valign="top" class="boldEleven"><h3><strong></strong></h3>                      <strong>
                      <h3><%=empdata[0][2]%></h3>
                      </strong></td>
                    <td class="boldEleven">&nbsp;</td>
                  </tr>
                  <tr>
                    <td valign="top" class="boldEleven"><h3><strong></strong></h3>                      <strong>
                      <h3>Designation</h3>
                      </strong></td>
                    <td valign="top" class="boldEleven"><h3><strong></strong></h3>                      <strong>
                      <h3><%=empdata[0][3]%></h3>
                      </strong></td>
                    <td class="boldEleven">&nbsp;</td>
                  </tr>
                 
                  <tr>
                    <td colspan="6" class="boldEleven"><div align="center"><font color="#FF0000"><h3><%=error%></h3></font></div></td>
                  </tr>
                  <tr>
                    <td class="boldEleven">&nbsp;</td>
                    <td class="boldEleven">&nbsp;</td>
                    <td class="boldEleven">&nbsp;</td>
                    <td class="boldEleven">&nbsp;</td>
                    <td class="boldEleven">&nbsp;</td>
                    <td class="boldEleven">&nbsp;</td>
                  </tr>
                </table></td>
              </tr>

          </table></td>
          <td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
          <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
        </tr>
        <tr>
          <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
          <td height="6"><spacer height="1" width="1" type="block" /></td>
          <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
        </tr>
        <tr>
          <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
        </tr>
      </tbody>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
<%
		
	//String sql = " INSERT INTO att_t_proximitycard_inandout  (";
	//sql = sql + " CHR_EMPID,CHR_CARDNO,DAT_DATE,DAT_INTIME ,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS)";
	//sql = sql + " VALUES ('"+empid+"','"+cardno+"',now(),now(),'"+session.getAttribute("USRID")+"',now(),'Y' )";
	//com.my.org.erp.common.CommonFunctions.Execute(sql);
		 
		
		
		//response.sendRedirect("proximity.jsp");
	}
	else
	{
	out.println("<table width='100%' height='100%' border='0' cellspacing='0' cellpadding='0' align='center'> ");
	out.println("<tr><td><center><h2><font color='red'>Invalid card ....</font></h2></center> </td>");
	out.println("</tr></table>");
	
  
  
	%>
  <script language="javascript">
		
		startTime();
		
		</script>
      <%
	}	
	
}
catch(Exception e)
{
}	
%>
<script language="javascript">
function calls()
{
	redirect1('proximity.jsp?type=SWOS');
}	
</script>
</body>
</html>
