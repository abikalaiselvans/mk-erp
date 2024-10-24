<%@include file="Redirect.jsp" %>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<table width="99%" height="500" border="0" cellpadding="0" cellspacing="0">
  <tbody>
    <tr>
      <td height="416" align="left">
	  
	  
	  <%
				 
					
					// Conveyance List alert
					String fsql= " select count(*) from conveyance_t_conveyance a, com_m_staff b     ";
					fsql = fsql + " WHERE a.CHR_EMPID in(SELECT CHR_EMPID FROM com_m_staff WHERE CHR_REPTO='"+session.getAttribute("EMPID")+"'   ";
					fsql = fsql + " AND CHR_TYPE!='T' AND CHR_HOLD!='Y' order by CHR_STAFFNAME )    ";
					fsql = fsql + " AND a.CHR_EMPID =b.CHR_EMPID AND CHR_STATUS='N'   ";  
					fsql = fsql + " group by a.CHR_EMPID ORDER BY  b.CHR_STAFFNAME  ";
					 
					fsql =   "  SELECT  count(*)    FROM com_m_staff a ,conveyance_t_conveyance b  ";
					fsql = fsql + " WHERE a.CHR_REPTO='"+session.getAttribute("EMPID")+"' AND a.CHR_TYPE!='T' AND a.CHR_HOLD!='Y'   ";
					fsql = fsql + " AND   a.CHR_EMPID =b.CHR_EMPID  AND b.CHR_STATUS='N'   ";
					fsql = fsql + " group by b.CHR_EMPID  order by a.CHR_STAFFNAME  ";
					String dconata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(fsql);
					if(dconata.length>0)
					{
						out.println("<br><br><center><font class='bolddeepred'>Please give the conveyance approval for "+dconata.length+" employee...</font></center> ");
					 
						%>
          <script language="javascript"> alert("Please give the conveyance approval for <%=dconata.length%> employee... ") 	</script>
          <%
					}

				%>    
				
	  <br>
	<div align="center">
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
		 
		 
	%> <br><marquee> <h5><%=message%></h5> </marquee>
	<br>
	<%
	  message=com.my.org.erp.alert.AlertFuntion.YearCompletionList();
	  %>
	   <br><marquee class="copyright"> <%=message%> </marquee>
		</div><br>
		
	  
	  </td>
    </tr>
  </tbody>
</table>
 