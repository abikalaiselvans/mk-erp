
<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.setHeader("Cache-Control", "no-store");
%>
<script language="javascript" src="../JavaScript/Servercheck.js"></script>
<script language="javascript">
loadServer()
</script>

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"  id="header"> 
  <tr  class="headerImgBackground" >
    <td><div align="right"><img src="../images/top_banner.png"  height="62" /></div></td>
  </tr>
  <tr>
    <td><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
          <tr   class="headerBackground" >
            <td width="150" height="25" align="center" valign="middle"><span class="boldgre">UTILITY </span></td>
            <td width="226" class="text_0">&nbsp;
			<%
	 String sesUserName=(""+session.getAttribute("USRID")).trim(); 
	 String EMPID=""+session.getAttribute("EMPID"); 
	if("null".equalsIgnoreCase(sesUserName) ||  sesUserName.equals("")) 
	{
	
			response.sendRedirect("../Login.jsp?loginmsg=Login Expired");
			//RequestDispatcher dispatchers = request.getRequestDispatcher("../Login.jsp?loginmsg=Login Expired");
    		//dispatchers.forward(request, response); 
			 
	
	}
	
	if( "S".equals(""+session.getAttribute("USRTYPE"))) 
			response.sendRedirect("../Login.jsp?loginmsg=Login Expired");
			
			
			
              %>
            <span class="bold1">Welcome :: <%=com.my.org.erp.common.CommonFunctions.employeeName(""+session.getAttribute("EMPID") )%>
            </span></td>
            <td width="233" align="right"   class="headerBackground" ><div align="center"><span class="bold1">
               
           </span> </div></td>
            <td width="366" align="right">
			<table width="199" border="0" cellspacing="4" cellpadding="4">
              <tr>
                <td>&nbsp;<select name="Module"  id="Module" class="formText135" ><!--onchange="GotoHome(this)"-->
				<option value="../Smart HRM/HRMmain.jsp">Smart HRM</option>
				<option value="../Smart Attendance/AttendanceMain.jsp">Smart Attendance</option>
				<option value="../Smart Payroll/Payrollmain.jsp">Smart Payroll</option>
				<option value="../Smart Management/ManagementMain.jsp">Smart Management</option>
				<option value="../Smart Marketing/MarketingMain.jspp">Smart Marketing</option>
				<option value="../Smart Inventory/Main.jsp">Smart Inventory</option>
				<option value="../Smart Accounts/Main.jsp">Smart Accounts</option>
				<option value="../Smart Utility/Utilitymain.jsp">Smart Utility</option>
				
				
			<%
				/*String datas[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULE FROM m_projectmodule ORDER BY CHR_MODULE");
				for(int u=0;u<datas.length;u++)
					out.println("<option value=''>"+datas[u][0]+"</option>");*/
			%>
			</select>
			<script language="javascript">
			/*function GotoHome(ctr)
			{
				location = ctr.value; 
			}*/
			</script>
			</td>
                <td>&nbsp;<a href="mailto:<%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MAILID FROM  m_institution WHERE INT_ID=1")[0][0]%>" ><font class="boldEleven"><b>Mail</b></font></a></td>
                <td>&nbsp;<a href="../Home.jsp" target="_parent"><font class="boldEleven"><b>Home</b></font></a></td>
                <td>&nbsp;<a href="../Logout.jsp" target="_parent"><font class="boldEleven"><b>Logout</b></font></a></td>
              </tr>
            </table>
			 
	        </td>
        </tr>
        </table></td>
  </tr>
  <tr   class="headerBackground" >
    <td  id="menutd"> </td>
  </tr>
</table>
<br><br><br>

 