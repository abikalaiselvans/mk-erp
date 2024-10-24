<%@ page import="java.sql.*,com.my.org.erp.ServiceLogin.DateUtil"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!

	Connection con ;
	Statement st,allst,recst,pfesist,messst,advst;
	ResultSet rs,allrs,recrs,pfesirs,messrs,advrs;
	String sql;
	String month,year;
	String date1,date2;
	String type;
	String sqlSel,empid,empname,pftype,esitype,percentpfamt,dectype;
	double preday,absday,leave,od,holiday,sunday,totalday,sub,add,onedaysal,lateday,extraloss,grosspay,netPay;
	int percentesiamt=0;	 
	int late,workingday,salary,pfamt,esiamt,messamt,advamt,dueamt,advbal,dectAmt;
%>
<html>
<head>
 

<title> :: PAYROLL ::</title>


 
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="javascript">
	function OpenAllowancWin(eid,ename)
	{
		var fname="AllowanceEntry.jsp?empid="+eid+"&ename="+ename;
		window.showModalDialog(fname,"_blank","dialogHeight:300,dialogWidth :300,scrollbars = no")
	}
 </script>
</head>
<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="salfrm">
<%
	type=request.getParameter("reportType");
	if(type.equals("Month")){
		month=request.getParameter("Month");
		year=request.getParameter("Year");		
	}else{
		date1=request.getParameter("frmdate");
		date2=request.getParameter("todate");
	}
	workingday=DateUtil.totalDays(Integer.parseInt(month),Integer.parseInt(year));
%>
<table width="100%">
	<tr>
		<td>Month : <%= month %></td>
		<td align="center">Total No of Working Days : <%=workingday%></td>
		<td align="right">Year : <%= year %></td>
	</tr>
	<tr>
		<td colspan="3">
		<table border="1"  >
			<tr class="salaryheading" >
				<td width="1%" align="center">S.NO</td>
				<td width="2%" align="center">Emp Id</td>
				<td width="3%" align="center">EmpName</td>
				<td width="2%" align="center">Basic Salary</td>
				<td width="1%" align="center">W D</td>
				<td width="1.5%" align="center">E/LD</td>
				<td width="1.85%" align="center">E/LP</td>
				<td width="1%" align="center">L D</td>
				<td width="1%" align="center">Allo</td>
				<td width="1%" align="center">GPay</td>
				<td width="1%" align="center">Recv</td>
				<td width="1%" align="center">PF</td>
				<td width="1%" align="center">ESI</td>
				<td width="1%" align="center">Mess</td>
				<td width="1%" align="center">AdvTot</td>
				<td width="1%" align="center">AdvDec</td>
				<td width="1%" align="center">AdvLeft</td>
				<td width="1%" align="center">Dect</td>
				<td width="1%" align="center">NetPay</td>
			</tr>
			<%	   
	try
	{
      con=conbean.getConnection();
      st=con.createStatement();
      String mon=DateUtil.getMonth(Integer.parseInt(month));
      String depId=request.getParameter("Department");
      sqlSel="SELECT A.*,B.* FROM  com_m_staff  A,ATT_T_ATTENDANCEDETAIL B";
      sqlSel=sqlSel+" WHERE A.CHR_EMPID=B.CHR_EMPID AND LOGMONTH='"+mon+"' AND LOGYEAR="+year+" AND INT_SALARY>0 AND INT_DEPARTID="+depId;
      //System.out.println(sqlSel);
      rs=st.executeQuery(sqlSel);
      int i=1;
      while(rs.next())
	  {
    	empid=rs.getString("CHR_EMPID");  
    	empname=rs.getString("CHR_STAFFNAME");
    	salary=rs.getInt("INT_SALARY");
    	preday=rs.getDouble("DOU_PRESENT");  
    	absday=rs.getDouble("DOU_ABSENT");
    	leave=rs.getDouble("DOU_LEAVE");
    	od=rs.getDouble("DOU_OD");
    	late=rs.getInt("INT_LATE");
    	holiday=rs.getDouble("DOU_HOLIDAY");
    	sunday=rs.getDouble("DOU_SUNDAY");
    	//Working Day Calculation
    	add=preday+od+holiday;
    	double totalpresent=add;
    	if(leave==1)
    	{
    		leave=0;
    		add=add+1;
    	}else if(leave>1)
    	{
    		add=add+1;
    		leave=leave-1;
    	}
    	int acworkingday=(int)workingday-(int)sunday;	   	
    	double lossday=add-acworkingday;  	

    	//LOSS OF PAY EXTRA DAYS CALCULATION
    	onedaysal=salary/workingday;
    	
    	
    	//LATE DAYS CALCULATION	 
    		 lateday=late*(onedaysal/4);
       	
    	//ALLOWANCE FROM PAY_T_SALARYALLOWANCE
    	allst=con.createStatement();
        String sql_allow_query="SELECT * FROM PAY_T_ALLOWANCE WHERE CHR_EMPID='"+empid+"'";
        allrs=allst.executeQuery(sql_allow_query);
        int a=1,allowance=0;
    	while(allrs.next())
    	{	
    	  while(a<=7)
    	  {
    		allowance=allowance+allrs.getInt("A00"+a);
    		a++;
          }
    	}    	
        //RECOVERY FROM PAY_T_SALARYRECOVERY
    	recst=con.createStatement();
        String sql_recover_query="SELECT * FROM PAY_T_RECOVERY WHERE CHR_EMPID='"+empid+"'";
        recrs=recst.executeQuery(sql_recover_query);
        int r=1,recovery=0;
    	while(recrs.next())
    	{	
    	  while(r<=7)
    	  {
    		recovery=recovery+recrs.getInt("R00"+r);
    		r++;
          }
    	}    	
        //PF AND ESI CALCULATION FROM PAY_M_PF
    	pfesist=con.createStatement();
        int pfamt=0;
        int percentpfamt=0;
        String sql_pfesi_query="SELECT * FROM PAY_M_PF WHERE CHR_EMPID='"+empid+"'";
        pfesirs=pfesist.executeQuery(sql_pfesi_query);
        if(pfesirs.next())
    	{	
    	        pftype=pfesirs.getString("CHR_PFTYPE");
    	        if(pftype.equals("A"))
    	        { 	
    	          pfamt=pfesirs.getInt("INT_PFAMT");
    	          percentpfamt=pfamt;
    	        }
    	        else
    	        {	
    	          pfamt=pfesirs.getInt("INT_PFAMT");	
    	          percentpfamt=salary*pfamt/100;
    	         
    	        }
    	        esitype=pfesirs.getString("CHR_ESITYPE");
    	        if(esitype.equals("A"))
    	        {	
    	           esiamt=pfesirs.getInt("INT_ESIAMT");
    	           percentesiamt=esiamt;
    	        }
    	        else
    	        {
    	           esiamt=pfesirs.getInt("INT_ESIAMT");
     	           percentesiamt=esiamt*salary/100;
    	        }
      	}        
        //MESS BILL FROM PAY_M_MESSBILL
    	messst=con.createStatement();
        String sql_mess_query="SELECT * FROM PAY_M_MESSBILL WHERE CHR_EMPID='"+empid+"' and CHR_MONTH='"+mon+"' AND INT_YEAR="+year;
        messrs=messst.executeQuery(sql_mess_query);
        messamt=0;
        if(messrs.next())
    	{	
    	   messamt=messrs.getInt("INT_CASHAMT");
       	}        
        //ADVANCE CALCULATION FROM PAY_M_ADVANCE
    	advst=con.createStatement();
        String sql_adv_query="SELECT * FROM PAY_M_ADVANCE WHERE CHR_EMPID='"+empid+"' and CHR_MONTH='"+mon+"' AND INT_YEAR="+year;
        advrs=advst.executeQuery(sql_adv_query);
        if(advrs.next())
    	{	
    	   dectype=advrs.getString("CHR_DECTYPE");
    	   if(dectype.equals("A"))
    	   {
    		   advamt=advrs.getInt("INT_BALAMT");
    		   dueamt=advrs.getInt("INT_DUE");
    		   advbal=advamt-dueamt;
    	   } 	   
       	}          	
         // 	GROSS PAY CALCULATION
       extraloss=onedaysal*lossday *-1; 
    	grosspay=(salary+allowance)-(lateday+extraloss);
        dectAmt= recovery+percentpfamt+percentesiamt+messamt+dueamt;
        netPay=grosspay-dectAmt;        
        if(lossday<0) 
    		extraloss=onedaysal*lossday * -1;
    	else
    		extraloss=onedaysal*lossday;
        if(totalpresent==0){
        	lossday=0;
        	extraloss=0;
        	lateday=0;
        	grosspay=0;
        	advamt=0;
        	dueamt=0;
        	advbal=0;
    		dectAmt=0;    	
    		netPay=0;
        	percentesiamt=0;
        	percentpfamt=0;
        	grosspay=0;
        }
    	out.println("<tr class='salarydata'><td>"+i+"</td><td>"+empid+"</td><td>"+empname+"</td>");
    	out.println("<td align='right'>"+salary+"</td><td align='right'>"+totalpresent+"</td>");
    	out.println("<td align='right'>"+lossday+"</td><td align='right'>"+extraloss+"</td>");
    	out.println("<td align='right'>"+lateday+"</td>");
    	out.println("<td align='right'><a href=javascript:OpenAllowancWin('"+empid+"','"+empname+"')>"+allowance+"</a></td>");
    	out.println("<td align='right'>"+grosspay+"</td><td align='right'>"+recovery+"</td><td align='right'>"+percentpfamt+"</td>");
    	out.println("<td align='right'>"+percentesiamt+"</td><td align='right'>"+messamt+"</td><td align='right'>"+advamt+"</td>");
    	out.println("<td align='right'>"+dueamt+"</td><td align='right'>"+advbal+"</td>");
    	out.println("<td align='right'>"+dectAmt+"</td><td align='right'>"+netPay+"</td></tr>");    	
    	
    	dueamt=0;
    	messamt=0;
    	percentesiamt=0;
    	percentpfamt=0;
    	recovery=0;
    	advamt=0;
    	dueamt=0;
    	advbal=0;
		dectAmt=0;    	
		i=i+1;		
	  }
	  }
	  catch(Exception e)
	  {
	     //System.out.println(e);
	  }
	  st.close();
	  //rs.close();
	   	 
	 %>
		</table>
		</td>
	</tr>
</table>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>
