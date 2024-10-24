 <script language="javascript" src="../JavaScript/comfunction.js"></script>
 <%
 
 String id= request.getParameter("rowid");
 String Amount= request.getParameter("Amount");
 String type= request.getParameter("type");
 String empid= request.getParameter("empid");
 String month= request.getParameter("month");
 String year= request.getParameter("year");
 String sql ="";
 
 sql =" SELECT COUNT(*) FROM pay_t_salary WHERE  CHR_EMPID='"+empid+"' AND CHR_MONTH='july' AND INT_YEAR="+year ;
 if("Y".equals(type)) 
 {
 	if(com.my.org.erp.common.CommonFunction.RecordExist(sql)  )
 	{
 		%>
		<script language="javascript">
			alert("<%="Advance not updated because "+month+" - " +year+"  Salary process completed..."%>");
			redirect('Payrollmain.jsp')
		</script>	
		 
		<%
 	}
 	else
 	{
 		sql = " UPDATE pay_t_advance SET INT_DUEAMT="+Amount+ " WHERE INT_ID="+id;
 		com.my.org.erp.common.CommonFunctions.Execute(sql);
		%>
		<script language="javascript">
			alert("<%=" Advance modified ..."%>");
			redirect('Payrollmain.jsp')
		</script>	
		 
		<%
		 
 	}	
 }
 else
 {
 		sql = " UPDATE pay_t_advance SET INT_DUEAMT="+Amount+ " WHERE INT_ID="+id;
 		com.my.org.erp.common.CommonFunctions.Execute(sql);
		%>
		<script language="javascript">
			alert("<%=" Advance modified ..."%>");
			redirect('Payrollmain.jsp')
		</script>	
		 
		<%
		 
 }
	
	 
	
 
 %>