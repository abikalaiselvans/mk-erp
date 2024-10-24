<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ include file="index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!

	Connection con ;
	Statement st ;
	ResultSet rs;
	String OptDepartment,OptDesignation,month;
	int year;
%>
<%
String  Advance=request.getParameter("Advance");
String OptDepartment=request.getParameter("OptDepartment"); 
String OptDesignation=request.getParameter("OptDesignation");
String month=request.getParameter("month");
int year=Integer.parseInt(request.getParameter("year"));
String sql="";
 %>
<html>
<body  onpaste='return false;'>
<table width="866" border="1" cellpadding="0" cellspacing="1">
	<!--DWLayoutTable-->
	<tr>
		<td height="39" colspan="8" align="center" valign="middle"><strong>Advance
		Details </strong></td>
	</tr>
	<tr>
		<td width="69" height="24">
		<div align="center"><strong>Emp Id</strong></div>
		</td>
		<td width="103">
		<div align="center"><strong>Name</strong></div>
		</td>
		<td width="111">
		<div align="center"><strong>Balance Amount</strong></div>
		</td>
		<td width="107">
		<div align="center"><strong>Due Amount</strong></div>
		</td>
		<td width="108">
		<div align="center"><strong>Balance Due</strong></div>
		</td>
		<td width="110">
		<div align="center"><strong>Status</strong></div>
		</td>
		<td width="112">
		<div align="center"><strong>Month</strong></div>
		</td>
		<td width="119">
		<div align="center"><strong>Year</strong></div>
		</td>
	</tr>
	<%
        try{
     	   if(Advance.equalsIgnoreCase("OptDepartment"))
     	   {
     		 sql="SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.Int_DueAmt,B.Int_Balance,B.Chr_Month,B.Int_year ";
  			sql=sql+" from  com_m_staff  A,PAY_T_ADVANCE B WHERE A.CHR_EMPID=B.CHR_EMPID AND A.INT_DEPARTID="+OptDepartment;
       	  
     	   }
     	   else if(Advance.equalsIgnoreCase("OptDesignation"))
     	   {
     		 sql="SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.Int_DueAmt,B.Int_Balance,B.Chr_Month,B.Int_year ";
			sql=sql+" from  com_m_staff  A,PAY_T_ADVANCE B WHERE A.CHR_EMPID=B.CHR_EMPID AND A.INT_DESIGID="+OptDesignation;
     	   }
     	   else if(Advance.equalsIgnoreCase("month"))
     	   {}
     	   else if(Advance.equalsIgnoreCase("year"))
     	   {}
     	   con=conbean.getConnection();
     	   st=con.createStatement();
     	   rs=st.executeQuery(sql);
     		while(rs.next())	 
    
    %>
	<tr>
		<td height="19" align="center" valign="middle">
		<% out.println(rs.getString("CHR_EMPID")); %>
		</td>
		<td align="center" valign="middle"><span class="style54 style52">
		<% out.println(rs.getString("CHR_STAFFNAME")); %> </span></td>
		<td align="center" valign="middle"><span class="style54 style52">
		<% out.println(rs.getString("CHR_STAFFFNAME")); %> </span></td>
		<td align="center" valign="middle"><span class="style54 style52">
		<% out.println(rs.getString("CHR_GENDER")); %> </span></td>
		<td align="center" valign="top""><span class="style54 style52">
		<% out.println(rs.getString("CHR_MartialSTATUS")); %> </span></td>
		<% 
		 
		StringTokenizer dts=new StringTokenizer(rs.getString("DT_WEDDATE"));
		StringTokenizer dt=new StringTokenizer(dts.nextToken(),"-");
		String y=dt.nextToken();
		String m=dt.nextToken();
		String d=dt.nextToken();
	 %>
		<td align="center" valign="middle"><span class="style54 style52">
		<% out.println(d+"-"+m+"-"+y); %> </span></td>
		<%
		
	%>
		<% 
		 
		  dts=new StringTokenizer(rs.getString("DT_DOB"));
		  dt=new StringTokenizer(dts.nextToken(),"-");
		  y=dt.nextToken();
		  m=dt.nextToken();
		  d=dt.nextToken();
	 %>
		<td align="center" valign="middle"><span class="style54 style52">
		<% out.println(d+"-"+m+"-"+y); %> </span></td>
		<%
		 
	%>
		<td align="center" valign="middle"><span class="style54 style52">
		<% out.println(rs.getString("CHR_BG")); %> </span></td>
	</tr>
	<%
		 
		rs.close();
        }
	catch(Exception e)
	{
	}
	     %>
</table>
</td>


<br>
<br>
<br>
<TABLE width="1000" border=0 align="left" cellPadding=0 cellSpacing=1>
	<!--DWLayoutTable-->
	<TBODY>
		<TR>
			<TD width="258" height="70">&nbsp;</TD>
			<TD width="93" valign="top"></TD>
			<TD width="279">&nbsp;</TD>
			<TD width="93" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</TD>
			<TD width="271">&nbsp;</TD>
		</TR>
		<TR>
			<td height="0"></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</TR>
	</TBODY>
</TABLE>
<br>
<br>
<br>
<br>
<br>
<br>


<%@ include file="../footer.jsp"%>
</body>
</html>
