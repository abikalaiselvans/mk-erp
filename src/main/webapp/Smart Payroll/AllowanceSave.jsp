<%@ include file="Connection.jsp"%>
<%
     String month,acode,empid;
	 int i=1,n,year; 
	 n=Integer.parseInt(request.getParameter("no"));
	 month=request.getParameter("month");
	 year=Integer.parseInt(request.getParameter("year"));
	 empid=request.getParameter("empid");
	 
	 
	 st.executeUpdate("update t_all set INT_YEAR="+year+" where CHR_EMPCODE='"+empid+"'");
	 st.executeUpdate("update t_all set CHR_MONTH='"+month+"' where CHR_EMPCODE='"+empid+"'");
	 
	 while(i<n)
	 {
	    acode=(request.getParameter("A00"+i));
		st.executeUpdate("update t_all set A00"+i+"="+acode+" where CHR_EMPCODE='"+empid+"'");
		i++; 
	 } 
	 
	   
	  response.sendRedirect("AllowanceView.jsp?empid="+empid);




%>
