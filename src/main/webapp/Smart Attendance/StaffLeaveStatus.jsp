<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage="../error/index.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<title> :: ATTENDANCE ::</title>


 
<style type="text/css">
<!--
.style6 {font-weight: bold}
.bodys {
	 
	border:dashed;
}
.style3 {color: #FF0000}

-->
</style>
</head>
<script language="JavaScript">

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
		document.frm.action="OnlinepermissionleaveEdit.jsp";
		document.frm.submit();
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
	 
		
//-->

</script>
<body  onpaste='return false;'>
<jsp:include page="index.jsp" />
<form  AUTOCOMPLETE = "off"   name="frm" method="get" action="">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>

	<tr>
		<td><span class="tablehead"><span class="boldEleven">
		<%
			String userid = ""+session.getAttribute("USRID");
			
			String sql ="";
			sql = "SELECT * FROM M_USER WHERE CHR_USRNAME = '"+userid+"'";
			String staff  = com.my.org.erp.bean.Attendance.StaffRegistration.getAnyValue2(sql,"CHR_USRDES" );
			userid = ""+session.getAttribute("USRID");
			
			String ptype = com.my.org.erp.bean.Attendance.StaffRegistration.getAnyValue2(sql,"CHR_TYPE" );
			String staffname= com.my.org.erp.bean.Attendance.StaffRegistration.staffName(staff.trim());
			
			%> </span></span></td>
	</tr>
	<tr>
		<td>
		<table width="810" border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td valign="top">
					<table width="801" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td width="100%">
							<div align="center" class="boldEleven"><b>Leave Status
							</b></div>
							</td>
						</tr>
						<tr>
							<td>
							<div align="right"><span class="article style3">* </span><span
								class="changePos">Mandatory</span></div>
							</td>
						</tr>
						<tr>
							<td height="36">
							<table width="217" border="0" align="center" cellpadding="0"
								cellspacing="0">
								<tr>
									<td width="87" class="boldEleven">Staff id</td>
									<td width="130" class="boldEleven"><%=staff%></td>
								</tr>
								<tr>
									<td class="boldEleven">Staff Name</td>
									<td class="boldEleven"><%=staffname%></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td height="18">
							<%
			
				
				sql = "SELECT DT_PDATE,CHR_LDESC,CHR_REASON,CHR_TYPE,CHR_STATUS FROM ATT_M_ONLINEAPPLYLEAVE  ";
				sql = sql +" WHERE  CHR_EMPID ='"+staff+"' " ;
				sql = sql +" AND CHR_MONTH =monthname(now())";
				sql = sql +" AND INT_YEAR =year(now()) ";
				sql = sql +" AND CHR_STATUS <>'P'";
				String h[][]=com.my.org.erp.bean.Attendance.StaffRegistration.getTableAllValuesArray(sql); 
				int column = h.length;
				 out.println("<div  id='divscroll' style='OVERFLOW: auto;width:900px;height:190px;'>");
				out.println("<table width=900>");
				boolean bgflag=false;
				for(int u=0; u<column; u++)
				{	
					if(bgflag)
					{
						bgflag = false;
						out.println("<tr class='MRow2'>");
					}
					else
					{
						bgflag = true;
						out.println("<tr class='MRow1'>");
					}
					out.println("<td width=75 valign='top'>"+h[u][0]);
					out.println("<td width=75 valign='top'>");
					String val="";
					if (h[u][3].equals("PERMISSION"))
					{
						String sh[] = h[u][1].split("~");
						
						if(sh[0].equals("PFD"))
							val="<table width='120'><tr><td>Day  <td>Full Day ";
					
						if(sh[0].equals("PFN"))
							val="<table  width='120'><tr><td>Day <td> Fore Noon";
						
						if(sh[0].equals("PAN"))
							val="<table width='120'><tr><td>Day <td>After Noon ";
						val = val +"<tr><td>In Time<td>"+sh[1]+"<tr><td>Out Time <td >"+sh[2]+"</table>";	
					}		
					
					if (h[u][3].equals("LEAVE"))
					{
						String sh[] = h[u][1].split("~");
						val = h[u][1];
						String sq ="SELECT * FROM ATT_M_LEAVETYPE WHERE CHR_SYMBOL ='"+sh[0].trim()+"'";
						String lname=com.my.org.erp.bean.Attendance.StaffRegistration.getAnyValue2(sq,"CHR_LEAVENAME");
						val="<table width='150'><tr><td>Leave : <td>"+lname;
						val=val +"<tr><td>Day<td>"+sh[1].trim();
						val=val +"</table>";

					}		
					
					out.println(val);
					out.println("<td width=100 valign='top'>"+h[u][3]);
					out.println("<td width=100 valign='top'>");
					String adminpermission =h[u][4];
					if ("A".equals(adminpermission))
						val = "Granted";
					if ("R".equals(adminpermission))
						val = "Rejected";
					out.println(val);
					
					
				}
				out.println("</table>");
				out.println("</div>");
				%>
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
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table border="0" align="center" cellpadding="3" cellspacing="5">
			<tr>
				<td width="56"><input class="buttonbold" type="button"
					name="Button"  value="Close"   accesskey="c"  onclick="javascript:history.back()"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
<jsp:include page="../footer.jsp" />
</body>
</html>
