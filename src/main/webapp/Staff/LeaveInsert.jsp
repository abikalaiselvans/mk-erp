 <%@ page import="java.lang.*,java.util.*,java.io.*,java.sql.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonFunction"%>


<jsp:useBean id="conbean" class="DBConnection.DBCon" />

<%
	String leaveid =request.getParameter("id").trim();
	String staffId =request.getParameter("staffid").trim();
	int count=0; 
	String ea="";
	 
	if(!leaveid.equals("select"))
	{
		 	 
		leaveid=  CommonFunctions.QueryExecute("SELECT INT_LEAVEID  FROM att_m_leavetype  WHERE CHR_SYMBOL='"+leaveid+"'")[0][0]; 
		String Eligible ="INT_NOD"+leaveid;
		String Available="INT_NOD"+leaveid+"BALANCE";
		String sql ="SELECT  count(*) FROM att_m_leave WHERE CHR_EMPID = '"+staffId+"' AND INT_YEAR =year(now())";
		 
		if(CommonFunction.RecordExist(sql))
		{
			 sql ="SELECT  "+ Eligible +" , " + Available+"  FROM ATT_M_LEAVE WHERE CHR_EMPID = '"+staffId+"'  AND INT_YEAR =year(now())";
			 String LreadData[][] =  CommonFunctions.QueryExecute(sql);
			 
			 if(LreadData.length>0)
			 {
				ea = "Eligible :"+LreadData[0][0] +" Leavetaken :" +LreadData[0][1];
				out.println("<input type='hidden' name='EValue'  id='EValue' value='"+LreadData[0][0]+"' />"); 
				out.println("<input type='hidden' name='AValue'  id='AValue'value='"+LreadData[0][1]+"' />"); 
			 }
			 else
			 {
				ea = "Eligible : 0  Leavetaken : 0 " ;
				out.println("<input type='hidden' name='EValue'  id='EValue' value='0' />"); 
				out.println("<input type='hidden' name='AValue'  id='AValue'value='0' />"); 
			 }
			 out.println("<div align='center' class='MRow3'>"+ea+"</div>");
		}
		else
		{
				out.println("<font color=red>Leave not found</font>");
		}
		 
 	}
%>
