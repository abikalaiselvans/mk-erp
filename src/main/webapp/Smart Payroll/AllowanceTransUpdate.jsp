<%@ page import="java.sql.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>
<%!
	Connection con;
	Statement st;
	ResultSet rs;
%>
<% 
	
try{
	Connection con=null;
	String empId= request.getParameter("staffid");  	
	String month=""+session.getAttribute("Month");
	String year=""+session.getAttribute("Year");
	con=conbean.getConnection();
	st=con.createStatement();
	rs=st.executeQuery("Select * from pay_t_salaryallowance WHERE CHR_EMPID='"+empId+"' AND CHR_MONTH='"+month+"' AND INT_YEAR="+year); 
	if(rs.next())
	{
		
	}
	else
	{
		st.execute("INSERT INTO pay_t_salaryallowance(CHR_EMPID,CHR_MONTH,INT_YEAR) VALUES('"+empId+"','"+month+"',"+year+")");
	}
	
	String sqlUp="UPDATE pay_t_salaryallowance set CHR_EMPID='"+empId+"'";
	String all=null;
	int allowance=0;
	for(int j=1;j<=7;j++)
	{
	  all=""+request.getParameter("A00"+j);
	  if(all.equals("null")|| all.equals(""))
		  sqlUp=sqlUp+",A00"+j+"=0";
  	  else{
  		allowance=allowance+Integer.parseInt(all);
  		sqlUp=sqlUp+",A00"+j+"="+all;
  	  }
	}
	sqlUp=sqlUp+" WHERE CHR_EMPID='"+empId+"' AND CHR_MONTH='"+month+"' AND INT_YEAR="+year; 
	con=conbean.getConnection();
	st=con.createStatement();
	st.execute(sqlUp);
	sqlUp="UPDATE pay_t_nsalarydetailspf SET INT_ALLOWANCE="+allowance;
	sqlUp=sqlUp+" WHERE CHR_EMPID='"+empId+"' AND CHR_MONTH='"+month+"' AND INT_YEAR="+year;
}
catch(Exception e){
	//System.out.println("Error :"+e);
}
finally{
%>

<SCRIPT language="javascript">
  history.back(1)
  window.close()
</SCRIPT>
<%}%>
