<%@ page import="java.sql.*,java.util.*,java.io.*,com.my.org.erp.common.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!
	Connection con;
	Statement st;	
	String comId,branchId;
	String url;
%>
<%@ page import="com.my.org.erp.bean.Attendance.StaffRegistration"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>


<html>
<head>

<title> :: ATTENDANCE ::</title>


 
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
body {
	background-color: #0099FF;
}
.style5 {
	color: #FF0000;
	font-size: 10px;
	line-height: 15px;
	font-family: Verdana, Arial, Helvetica, Sans-Serif;
	text-decoration: none;
	font-weight: normal;
}
.style6 {color: #FFFFFF}
-->




</style>
</head>
<script language="javascript" src="../JavaScript/Servercheck.js"></script>

<script language="javascript" src="../JavaScript/comfunction.js"></script>

<script type="text/javascript">

function startTime()
{
	var today=new Date();
	var h=today.getHours();
	var m=today.getMinutes();
	var s=today.getSeconds();
	// add a zero in front of numbers<10
	m=checkTime(m);
	s=checkTime(s);
	//document.getElementById('txt').innerHTML=h+":"+m+":"+s;
	loadServer();
	t=setTimeout('startTime()',5000);
}

function checkTime(i)
{
	if (i<10)
  	{
  		i="0" + i;
  	}
	return i;
}
</script>

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" class="body"  onload="startTime()">

<%
			String sesUserId=""+session.getAttribute("USRID");
			String sql = "SELECT * FROM M_USER WHERE CHR_USRNAME = '"+sesUserId+"'";
			String staff  = com.my.org.erp.bean.Attendance.StaffRegistration.getAnyValue2(sql,"CHR_EMPID");
		    sql = "SELECT CHR_STAFFNAME,CHR_GENDER FROM  com_m_staff  WHERE CHR_EMPID = '"+staff+"'";
			String staffName  = com.my.org.erp.bean.Attendance.StaffRegistration.getAnyValue2(sql,"CHR_STAFFNAME");
			String gender  = com.my.org.erp.bean.Attendance.StaffRegistration.getAnyValue2(sql,"CHR_GENDER");

			String staffphoto = "../webapps/SmartCampus/StaffPhoto/"+staff.trim() +".jpg";
			String photo="";
			File f = new File(staffphoto);
			if (f.exists())
				photo = "../StaffPhoto/"+staff.trim() +".jpg";
			else if("Female".equals(gender))
				photo ="../StaffPhoto/Female.jpg";
			else if("Male".equals(gender))
				photo ="../StaffPhoto/Male.jpg";	
			else 
				photo ="../StaffPhoto/default.jpg";	
			
						
			sql="SELECT A.CHR_EMPID,A.CHR_STAFFNAME,A.INT_DEPARTID,A.INT_DESIGID,INT_COMPANYID,INT_BRANCHID "+
			" FROM  com_m_staff  A "+
			" WHERE A.CHR_EMPID='"+staff+"'";
			con=conbean.getConnection();
			st=con.createStatement();			
			ResultSet rs=st.executeQuery(sql);			
			String depName="";
			String desName="";
			String compName="";
			String branchName="";
			if(rs.next())
			{
				comId=rs.getString("INT_COMPANYID");
				branchId=rs.getString("INT_BRANCHID");
				url="?compId="+comId+"&branchId="+branchId;
				sql="SELECT CHR_COMPANYNAME from  com_m_company  where INT_COMPANYID="+comId;
				String datas[][]=CommonInfo.RecordSetArray(sql);			
				compName=datas[0][0];
				sql="SELECT CHR_BRANCHNAME from  com_m_branch  where INT_BRANCHID="+branchId;
				String datas1[][]=CommonInfo.RecordSetArray(sql);			
				branchName=datas1[0][0];
				depName=StaffRegistration.getDepartment(rs.getString("INT_DEPARTID"));
				desName=StaffRegistration.getDesigination(rs.getString("INT_DESIGID"));
			}

		 %>
		 
<%@ include file="index_staff.jsp"%>
 
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr valign="top">
		<td colspan="2">
		
		 
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td colspan="3" align="left" valign="top" class="boldEleven">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="bold1">Company</td>
						<td class="boldEleven"><%=compName %></td>
						<td class="bold1">RegNo</td>
						<td class="boldEleven"><%=staff %></td>
						<td class="bold1">Department</td>
						<td class="boldEleven"><%=depName %></td>
					</tr>
					<tr>
						<td class="bold1">Branch</td>
						<td class="boldEleven"><%=branchName %></td>
						<td class="bold1">Name</td>
						<td class="boldEleven"><%=staffName %></td>
						<td class="bold1">Designation</td>
						<td class="boldEleven"><%=desName %></td>
					</tr>
					<tr>
						<td colspan="6" class="bold1"><!--<jsp:include page="user_menu.jsp" flush="true" />	-->
						</td>
					</tr>
					<tr>
						<td colspan="6" class="bold1"><div id="txt"></div></td>
					</tr>
					<tr>
						<td colspan="6" class="bold1">
						<%
		String message= "";
		String empid=""+session.getAttribute("EMPID");
		message=com.my.org.erp.alert.AlertFuntion.ScrollingMessage();
		double target=com.my.org.erp.alert.MEAlertFuntion.METargetAlert(empid);
		double achieve=com.my.org.erp.alert.MEAlertFuntion.METargetCollection(empid) ;
		if(target >0.0)
		{
		%>
		<script language="javascript">
			alert(" THIS MONTH TARGET -><%=target%>(In Lakhs) AND  ACHIEVE FOR THE MONTH -> <%=achieve%>");
		</script>
		<%
	 		out.println("<center><font class='bolddeepred'>");
			out.println("TARGET FOR THE MONTH  : "+com.my.org.erp.alert.MEAlertFuntion.METargetAlert(empid)+"(In lakhs)");
			out.println("ACHIEVE FOR THE MONTH : "+achieve+"");
			out.println("</font> </center>");
		}	
		 
		 
	%> <marquee> <h5><%=message%></h5> </marquee>
	<br>
	<%
	  message=com.my.org.erp.alert.AlertFuntion.YearCompletionList();
	  %>
	   <marquee class="copyright"> <%=message%> </marquee>
	<br>
	</td>
					</tr>
				</table>
				</td>
			</tr>

		</table>
		</td>
	</tr>
	<tr  >
		<td width="10%" height="350" valign="top">
		<table width="141" border="0" align="center" cellpadding="2" cellspacing="2"
			bordercolor="#FFFFFF">
			<tr>
				<td width="170" height="130" colspan="2" align="center"
					valign="middle"><img src="<%=photo%>" width="125" height="125"
					border="0"></td>
			</tr>

			<tr>
			  <td height="15" colspan="2" align="left" class="newsarticle"><div id="rivisionTable" style="OVERFLOW:auto;width:100%;height:250px">
                <%

					if(!com.my.org.erp.common.CommonInfo.RecordExist("select * from pay_t_resignationletter where CHR_EMPID='"+staff+"' AND CHR_ACCEPTSTATUS='Y'"))
					{
					%>
                <table width='100%' align="center">
                  <!--<tr>
						<td height="15" align="left" class="newsarticle">

						
						ifOnlineApply.jsp<%=url %>ifStaffLeaveStatus.jsp<%=url %>ifReportsType.jsp<%=url %>ifReportsOnDudy.jsp<%=url %>
		ifReportsAdvance.jsp<%=url %>
		<a target="staffMain"
							href="ifOnlineApply.jsp<%=url %>"><font class="boldEleven">
						Permission / Leave Apply</font> </a></td>
					</tr>
					<tr>
						<td height="15" align="left" class="newsarticle">
						<a target="staffMain" href="ifStaffLeaveStatus.jsp<%=url %>"><font
							class="boldEleven"> Leave Status</font> </a></td>
					</tr>-->
                  <tr align="left">
                    <td height="21"  ><a href="../Smart Attendance/ifAttenMonth.jsp?<%=url %>"
							target="staffMain"   ><font
							class="bolddeepred">Attendance Report </font></a></td>
                  </tr>
                  <tr>
                    <td height="21" align="left"  ><a target="staffMain"
							href="../Smart Payroll/ifPaySlipMonth.jsp<%=url %>"><font
							class="bolddeepred">Pay Slip </font> </a></td>
                  </tr>
                  <tr>
                    <td height="21" align="left"  ><a target="staffMain"
							href="../Smart Attendance/StaffRept_LeaveBalance.jsp<%=url %>"><font
							class="bolddeepred">Leave informations</font> </a></td>
                  </tr>
                  <tr align="left">
                    <td height="21" ><a
							target="staffMain" href="../Smart Attendance/ifReportsAdvance.jsp<%=url %>"><font
							class="bolddeepred"> Staff Advance </font> </a></td>
                  </tr>
                  <%
		String cname[][] =CommonFunctions.QueryExecute("SELECT CHR_REPTO FROM com_m_staff WHERE CHR_EMPID='"+staff+"'");
		if(!"0".equals(cname[0][0].trim()))
		{	
		%>
                  <a target="staffMain" href="../Smart Inventory/ConveyanceAdd.jsp"><font
			class="bolddeepred">Conveyance</font></a>
                  <%
		}
		
		String cony[][] =CommonFunctions.QueryExecute("SELECT CHR_CONVEYANCECLEAR FROM com_m_staff WHERE CHR_EMPID='"+staff+"'");
		String clear=cony[0][0].trim();
		if(("Y".equals(clear)))
		{
			
			String fsql= " select count(*) from conveyance_t_conveyance a, com_m_staff b     ";
			fsql = fsql + " WHERE a.CHR_EMPID in(SELECT CHR_EMPID FROM com_m_staff WHERE CHR_REPTO='"+sesUserName+"'   ";
			fsql = fsql + " AND CHR_TYPE!='T' AND CHR_HOLD!='Y' order by CHR_STAFFNAME )    ";
			fsql = fsql + " AND a.CHR_EMPID =b.CHR_EMPID AND CHR_STATUS='N'   ";  
			fsql = fsql + " group by a.CHR_EMPID ORDER BY  b.CHR_STAFFNAME  ";
			String dconata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(fsql);
			if(dconata.length>0)
			{
				%>
                  <script language="javascript">
					alert("Please give the conveyance approvel for <%=dconata.length%> employee... ")
				</script>
                  <%
			}

			
			out.println("<tr><td height='21' colspan='2' align='left' class='boldEleven'>");
			out.println("<a target='staffMain' href=\"../Smart Inventory/StaffConveyanceview.jsp\"><font class='bolddeepred'>");
			out.println("Conveyance Clear</font></a>");
		}
		 
		%>
                  <tr>
                    <td height="21" align="left"  ><a target="staffMain" href="../Smart Attendance/ifChangepassword.jsp"> <font
							class="bolddeepred"> Change Password </font></a></td>
                  </tr>
                  <tr>
                    <td height="21" align="left" class="newsarticle"><a target="_blank" href="../Discipline.doc"> <font
							class="bolddeepred">Discipline</font></a></td>
                  </tr>
                  <%
				if(!com.my.org.erp.common.CommonInfo.RecordExist("select * from pay_t_resignationletter where CHR_EMPID='"+staff+"'"))
				{
				%>
                  <!--<tr>
                    <td height="21" align="left" class="boldEleven"><a target="staffMain" href="../Smart Attendance/ifResignletter.jsp"> <font
							class="bolddeepred">Resignation letter</font></a> </td>
                  </tr>-->
                  <%} 
				else
				{
				 %>
                  <tr>
                    <td height="21" align="left" class="boldEleven"><a target="staffMain" href="../Smart Attendance/ifResignStatus.jsp"> <font
							class="bolddeepred">Resignation Status</font></a> </td>
                  </tr>
                  <%}%>
                </table>
			    <%
				  }
				  else
				   {
				     %>
                <table width=109%>
                  <tr>
                    <td height="21" align="left" class="boldEleven"><a target="staffMain" href="../Smart Attendance/ifResignStatus.jsp"> <font
							class="bolddeepred">Resignation Status</font></a> </td>
                  </tr>
                  <tr>
                    <td height="21" align="left" class="boldEleven"><a target="staffMain" href="../Smart Attendance/ifExitinterview.jsp"> <font
							class="bolddeepred">Exit Interview</font></a> </td>
                  </tr>
                </table>
			    <%}%>
              </div></td>
			</tr>
		</table>
	  </td>
		<td width="80%"   align="center" valign="top">
		 <table width="100%" border="1" bordercolor="#FFFF00" bgcolor="#0099CC">
			<tr>
				<td height="405" valign="top"><iframe src="../Smart Attendance/iframeStaffMain.jsp"
					name="staffMain" width="100%" height="100%" frameborder="0"
					style="border-width: 1px; border-color: #F48442; border-style: dotted;">
				</iframe></td>
			</tr>
	  </table> 	  </td>
  </tr>
</table>

 
</body>
</html>
