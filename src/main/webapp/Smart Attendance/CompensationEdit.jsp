<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>
<html>
<head>
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
 function Validate()
  {
  	if(checkNull("ename","Select Staff...") 
		&& checkNull("TxtPlace","Enter Place Name...") 
		//&& checkNull("TxtReason","Enter Reason...") 
		//&& checkNull("TxtAuthorised","Enter Authorised Name...") 
		
	){
	
		return true;
	}
	return false;
  }
  
  
  
  
  function Edit()
 	{		
 	    var count=0;
 	    sel=document.forms[0].staffid;
 	    for(i=0;i<sel.length;i++)
 	    {
 	         if(sel[i].checked)
 	         count=count+1;  
 	    }
		 
 	    if(count==0)
 	    { 	       
		   if(document.forms[0].staffid.checked)
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
		document.CompensationEditfrm.action="CompensationUpdate.jsp";
		return true;
		}
 	}
 	


 function Delete()
 	{		
		var count;
		count=0;
		c1=document.forms[0].staffid
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
			if (document.forms[0].staffid.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.CompensationEditfrm.action="../SmartLoginAuth";
				//document.onDutyEditfrm.submit();
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

function checkAll()
{
	var f=document.onDutyEditfrm.staffid.checked;
	alert (f);
return true;
}
 	 	
 </script>

<title> :: ATTENDANCE ::</title>


 
<style type="text/css">
<!--
.style3 {color: #FF0000}
-->
</style>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form  AUTOCOMPLETE = "off"   name="CompensationEditfrm" method="get">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="100">
		<%
try
{
%> <%@ include file="index.jsp"%></td>
	</tr>
	<tr>
	<tr>
		<td height="68">&nbsp;</td>
	</tr>
	<td height="299">
	<table width="780" border="0" align="center" cellpadding="1"
		cellspacing="1">
		<tr>
			<td width="594" height="15">
			<%
		  		String staff  = request.getParameter("staffid");
				String staffname= com.my.org.erp.bean.Attendance.StaffRegistration.staffName(staff.trim());
				String sql ="";
				sql = "SELECT * FROM att_t_compensation where CHR_EMPID = '"+staff+"'";
				java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("yyyy-MM-dd");
				java.util.Date date = new java.util.Date();
				String updatedate = "" + datetime.format(date);
				
				int year  = Integer.parseInt(request.getParameter("year"));
				String month =com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(request.getParameter("month")));
				
				sql = "SELECT count(*) FROM att_t_compensation where CHR_EMPID = '"+staff+"'";
				sql = sql +" AND  CHR_MONTH = '" +month+"'";
				sql = sql +" AND  INT_YEAR = " +year ;
				boolean f =com.my.org.erp.bean.Attendance.StaffRegistration.getAnyRecordExisist2(sql); 
				if(f==false)
				 response.sendRedirect("Holiday.jsp?staffid="+staff);
					 
		  %>
			</td>
		</tr>
		<tr>
			<td>
			<table width="100%" border="0" align="center" cellpadding="0"
				cellspacing="0" bgcolor="#dce4f9" class="BackGround">
				<tbody>
					<tr>
						<td colspan="2" rowspan="2"><img height="7"
							src="../Image/General/TLCorner.gif" width="7" /></td>
						<td class="BorderLine" height="1"><spacer height="1"
							width="1" type="block" /></td>
						<td colspan="2" rowspan="2"><img height="7"
							src="../Image/General/TRCorner.gif" width="7" /></td>
					</tr>
					<tr>
						<td height="6"><spacer height="1" width="1" type="block" /></td>
					</tr>
					<tr>
						<td class="BorderLine" width="1"><spacer height="1" width="1"
							type="block" /></td>
						<td width="6"><spacer height="1" width="1" type="block"></td>
						<td width="577" valign="top">
						<table width="753" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100%">
								<div align="center" class="boldEleven"><strong>Compensation
								Days</strong></div>
								</td>
							</tr>
							<tr>
								<td>&nbsp; <%					  		
				sql = "SELECT DT_HOLIDATE,CHR_HOLINAME  FROM att_t_compensation where CHR_EMPID = '"+staff+"'";
				sql = sql +" AND  CHR_MONTH = '" +month +"'";
				sql = sql +" AND  INT_YEAR = " + year;				
				sql = sql +" ORDER BY DT_HOLIDATE";
					  %>
								</td>
							</tr>

							<tr>
								<td>
								<table width='101%' cellpadding="5" cellspacing="0">
									<tr class='boldEleven'>
										<td colspan="6">
										<table width="351" border="0" align="center" cellpadding="1"
											cellspacing="1">
											<tr>
												<td width="69" class="boldEleven"><strong>Staff
												Id <span class="style3">::</span></strong></td>
												<td width="72" class="boldEleven"><strong><strong><%=staff%></strong></strong></td>
												<td width="13" class="boldEleven">&nbsp;</td>
												<td width="90" class="boldEleven"><strong>Staf
												Name <span class="style3">::</span></strong></td>
												<td width="91" class="boldEleven"><strong><strong><%=staffname%></strong></strong></td>
											</tr>
										</table>
									<tr class='boldEleven'>
										<td width=14 height="29"
											 >
										<td width=54  ><b>S.No</b>
										<td width=155  ><b>Compensation
										Date</b>
										<td width=155  ><b>Compensation
										Name</b>
								</table>
								</td>
							</tr>
							<tr>
								<td>
								<div align="center">
								<%
					//String tableRow[] =com.my.org.erp.bean.Attendance.StaffRegistration.getTableAllValue(sql).split("#") ;
					String tableRow[][] =com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
					
					boolean bgflag=false;
					out.println("<div  id='divscroll' style='OVERFLOW: auto;width:760px;height:190px'>");
					out.println("<table width='100%' >");
					for(int u=0; u<tableRow.length;u++)
					{
						if(bgflag)
						{
							bgflag = false;
							out.println("<tr class='MRow2'>");
							out.print("<td width=54 ><input type='checkbox' name='staffid' id='staffid' value='"+staff+"~"+tableRow[u][0]+"~'>&nbsp"+(u+1));
//							out.println("<td width=54 >"+(u+1));
						}	
						else
						{
							bgflag = true;
							out.println("<tr class='MRow1'>");
							out.print("<td width=54 ><input type='checkbox' name='staffid' id='staffid' value='"+staff+"~"+tableRow[u][0]+"~'>&nbsp;"+(u+1));
//							out.println("<td width=54 >"+(u+1));
						}	
						
						out.println("<td width=155>&nbsp;"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(tableRow[u][0]));
						out.println("<td width=155>&nbsp;&nbsp;&nbsp;");
						out.println("<a href=CompensationUpdate.jsp?staffid="+staff+"~"+tableRow[u][0]+">"+tableRow[u][1].trim()+"</a>");
//						out.println("<td width=155>&nbsp;"+tableRow[u][1].trim());
					}
					out.println("</table>");
					out.println("</div>");
				
					
				%>
								</div>
								</div>
								</td>
							</tr>
							<tr>
								<td></td>
							</tr>
							<tr>
								<td height="28">
								<table border="0" align="center" cellpadding="1" cellspacing="1">
									<tr>
										<td width=56><input name="update" type="Submit"
											class="buttonbold" id="update" onClick="return Edit()"
											value="Update">
										<td width=56><input name="submit" type="Submit"
											class="buttonbold" id="submit" onClick=" return Delete()"
											value="Delete">
										<td width=56><input name="Submit" type="Button"
											class="buttonbold" onClick="redirect('Compensation.jsp')"
											 value="Close"   accesskey="c" ></td>
										<td><input name="filename" type="hidden" id="filename"
											value="Compensation"> <input name="actionS"
											type="hidden" id="actionS" value="ATTcompensationDelete"></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
						<td nowrap="nowrap" width="6"><spacer height="1" width="1"
							type="block" /></td>
						<td width="1" class="BorderLine"><spacer height="1" width="1"
							type="block" /></td>
					</tr>
					<tr>
						<td colspan="2" rowspan="2"><img height="7"
							src="../Image/General/BLCorner.gif" width="7" /></td>
						<td height="6"><spacer height="1" width="1" type="block" /></td>
						<td colspan="2" rowspan="2" valign="bottom">
						<div align="right"><img height="7"
							src="../Image/General/BRCorner.gif" width="7" /></div>
						</td>
					</tr>
					<tr>
						<td class="BorderLine" height="1"></td>
					</tr>
				</tbody>
			</table>
			</td>
		</tr>
	</table>
	</td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
<%
 }
 catch(Exception es)
 {
 	//System.out.println(es.getMessage());
 }
 %>
</form>
</body>
</html>
