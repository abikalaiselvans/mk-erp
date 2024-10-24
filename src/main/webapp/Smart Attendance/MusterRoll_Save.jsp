<%@ page
	import="java.sql.*,java.io.*,java.util.*,java.text.*,com.my.org.erp.bean.*"%>
<%-- <%@ page import="com.sun.org.apache.xerces.internal.impl.dv.xs.YearDV"%>
<%@ page
	import="com.sun.org.apache.xalan.internal.xsltc.util.IntegerArray"%>
 --%><%@ page buffer="512kb"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!
	Connection con ;
	Statement st ;
	PreparedStatement pstm;
	ResultSet rs;	
	String sql;	
	String sqlIns;
	
	String month;
	int mon;	
	int year;
	int totdays;
	int i,sno,j;		

	String presentType;
	String empid;
	String empname;
	int dat=0;
	String attValue[]=new String[31];
	double p=0; // NO Present	
	double l=0; // Leave
	double od=0; // OD
	double a=0;  // Absent
	double h=0; // Holiday
	double late=0;
	int sun=0;
	double tot;

	String date1;
	String date2;
	String ses_uname;
	SimpleDateFormat datetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.util.Date date=new java.util.Date();
	
	private int totalDays(int mon,int year)
	{
		int[] listTotalDays={0,31,28,31,30,31,30,31,31,30,31,30,31};
		if(year%4==0) listTotalDays[2]=29;
		return(listTotalDays[mon]);
	}
	private String FormateDateSQL(String indate)
	{
		String date= indate.substring(0,2);
		String month= indate.substring(3,5);
		String year= indate.substring(6);
		return(""+year +"-"+month+"-"+date);
	}
	private String getMonth(int mon)
	{	String month="";
		switch(mon)
		{
			case 01:month="January";
					break;
			case 02:month="February";
					break;
			case 03:month="March";
					break;
			case 04:month="April";
					break;
			case 05:month="May";
					break;
			case 06:month="June";
					break;
			case 07:month="July";
					break;
			case 8:month="August";
					break;
			case 9:month="September";
					break;
			case 10:month="October";
					break;
			case 11:month="November";
					break;
			case 12:month="December";
					break;
		}
		return(month);
	}
	private String addDate(String dat,int nd)
	{
		String data[]=dat.split("-");
		int y1=Integer.parseInt(data[0]);
		int m1=Integer.parseInt(data[1]);
		int d1=Integer.parseInt(data[2]);		
		int tot=totalDays(m1,y1);
		d1=d1+nd;
		if(d1>tot){
			if(m1>12){
				m1=1;
				y1=y1+1;
				d1=1;
			}
			else{				
				m1=m1+1; 
				d1=1;
			}
		}		
		if(d1<10 && m1<10)
			return(""+y1 +"-0"+m1+"-0"+d1);
		else if(d1<10)
			return(""+y1 +"-"+m1+"-0"+d1);
		else if(m1<10)
			return(""+y1 +"-0"+m1+"-"+d1);
		else
			return(""+y1 +"-"+m1+"-"+d1);
			
	}
	public void insertUserInformation(String staffid) 
	{ 
		
		try{			
			String sql_delete="DELETE FROM ATT_T_ATTENDANCEDETAIL WHERE CHR_EMPID=? AND LOGMONTH=? AND LOGYEAR=?";			
			pstm=con.prepareStatement(sql_delete);
			pstm.setString(1,staffid);
			pstm.setString(2,getMonth(mon)); 
			pstm.setInt(3,year); 
			pstm.execute();
			pstm = con.prepareStatement(sqlIns);			
			pstm.execute();
		}
		catch(NullPointerException ex)
		{
		    //System.out.println("Error 2"+ex);
		}
		catch(SQLException ex)
		{
			//System.out.println("Error1 :"+ex);
		}
	}
	private boolean checkAtten(String uid,String type)
	{
		String tsql="";
		if(type.equalsIgnoreCase("H")){
			tsql="SELECT CHR_EMPID ";
			tsql=tsql+"FROM ATT_T_HOLIDAY WHERE DT_HOLIDATE='"+date1+"' "; 
			tsql=tsql+" AND CHR_EMPID='"+uid +"'";			
		}else if(type.equals("P"))
		{
			tsql="SELECT CHR_EMPID ";
			tsql=tsql+"FROM ATT_SMART_ATTENDANCE WHERE DT_LOGIN='"+date1+"' AND ";
			tsql=tsql+"DT_LOGOUT='"+date1+"' AND CHR_EMPID='"+uid+"'";			
		}else if(type.equals("LA"))
		{
			tsql="SELECT CHR_EMPID ";
			tsql=tsql+"FROM ATT_SMART_ATTENDANCE WHERE DT_LOGIN='"+date1+"' AND ";
			tsql=tsql+"DT_LOGOUT='"+date1+"' AND CHR_EMPID='"+uid+"' AND CHR_LATE='L'";			
		}
		else if(type.equals("HF"))
		{
			tsql="SELECT CHR_EMPID ";
			tsql=tsql+"FROM ATT_SMART_ATTENDANCE WHERE DT_LOGIN='"+date1+"' AND ";
			tsql=tsql+"DT_LOGOUT='"+date1+"' AND CHR_EMPID='"+uid+"' AND (CHR_TYPE='A' OR CHR_TYPE='F')";
			//System.out.println(tsql);
		}
		else if(type.equals("L"))
		{
			tsql="SELECT CHR_EMPID,DT_LDATE,CHR_LEAVETYPE ";
			tsql=tsql+"FROM ATT_T_LEAVE WHERE DT_LDATE='"+date1+"' AND ";
			tsql=tsql+"CHR_EMPID='"+uid+"'";			
		}
		else if(type.equals("O"))
		{
			tsql="SELECT CHR_EMPID,DT_ODDATE,CHR_TYPE ";
			tsql=tsql+"FROM ATT_T_ONDUTY WHERE DT_ODDATE='"+date1+"' AND ";
			tsql=tsql+"CHR_EMPID='"+uid+"'";			
		}
		try{
		//	//System.out.println(tsql);
			pstm=con.prepareStatement(tsql);
			rs=pstm.executeQuery();
			if(rs.next())
			{
				if(type.equals("O")){
					presentType=rs.getString("CHR_TYPE");
				}else if(type.equals("L")){
					presentType=rs.getString("CHR_DAYTYPE");					
				}
				return true;					
			}				
		}
		catch(Exception e)
		{
			//System.out.println("ERROR:"+e);
			return false;			
		}
		return false;
	}
%>
<%
	String ptype=request.getParameter("muster");
	month=""+session.getAttribute("month");
	year=Integer.parseInt(""+session.getAttribute("year"));
	empid=""+session.getAttribute("empid");
	empname=""+session.getAttribute("empname");
	ses_uname=""+session.getAttribute("USRID"); 
	con=conbean.getConnection();
	
	mon=Integer.parseInt(month);
	totdays=totalDays(mon,year);
	String fdate="01-"+month+"-"+year;
	String tdate= totdays+"-"+month+"-"+year;
	date1=FormateDateSQL(fdate);
	date2=FormateDateSQL(tdate);
	String userid[]=empid.split(",");
	String username[]=empname.split(",");           	       	   	
	sno=0;	
%>
<%
try
{	
	for(i=0;i<userid.length;i++)
	{	  
	date1=FormateDateSQL(fdate);
	date2=FormateDateSQL(tdate);	
	dat=0;
    p=0; // NO Present	
    l=0; // Leave
    od=0; // OD
    a=0;  // Absent
    h=0; // Holiday
    late=0;
    sun=0;
	while(true)
	{
		String data[]=date1.split("-");
		int y= Integer.parseInt(data[0]);
		int m= Integer.parseInt(data[1]);
		int d= Integer.parseInt(data[2]);		
		java.util.Date date=new java.util.Date(y,m,d);		
		if(date.getDay()==3){
			if(checkAtten(userid[i],"P")){
				attValue[dat]="P";
				p++;
				if(checkAtten(userid[i],"L")){
					attValue[dat]="L";
					l++;
				}
			}
			else{
				attValue[dat]="S";		
			}
			sun++;
		}
		else if(checkAtten(userid[i],"H")){
			attValue[dat]="H";
			h++;
		}
		else if(checkAtten(userid[i],"L")){
			if(presentType.equalsIgnoreCase("Full Day")){
				attValue[dat]="L";
				l++;
			}
			else{
			if(checkAtten(userid[i],"HF")){
				if(presentType.equalsIgnoreCase("Forenoon"))
	 				attValue[dat]="L/P"; 
	 			else
	 				attValue[dat]="P/L";
	 			p=p+0.5;	
			}else if(checkAtten(userid[i],"O")){  
				if(presentType.equalsIgnoreCase("Forenoon"))
					attValue[dat]="O/L";
				else
					attValue[dat]="L/P";				
				od=od + 0.5;
			}else
				attValue[dat]="L/H";;
			l=l+0.5;
			}
		}else if(checkAtten(userid[i],"O")){  // On Duty Calculation
			if(presentType.equalsIgnoreCase("Full Day")){
				attValue[dat]="O";
				od++;		
			}else{		
				if(checkAtten(userid[i],"HF")){
		 			if(presentType.equalsIgnoreCase("Forenoon"))
		 				attValue[dat]="O/P"; 
		 			else
		 				attValue[dat]="P/O";
		 			p=p+0.5;	
				}
				else
					attValue[dat]="O/A";
				od=od + 0.5;
			}//-------------------------------------------------------
		}else if(checkAtten(userid[i],"P")){
			attValue[dat]="P";
			p++;
		}
		else {
			attValue[dat]="A";			
			a++;
		}
		if(checkAtten(userid[i],"LA"))
		{
			late=late+1;
		}
		dat++;
		if(date1.equalsIgnoreCase(date2)) break;
		date1=addDate(date1,1);
	}	
		sqlIns="INSERT INTO ATT_T_ATTENDANCEDETAIL VALUES(";
		sqlIns=sqlIns+"'"+userid[i]+"',";
		sqlIns=sqlIns+"'"+getMonth(mon)+"',";
		sqlIns=sqlIns+year+",";
		String attVal[]=attValue;
		for(j=0;j<totdays;j++){
			sqlIns=sqlIns+"'"+attVal[j]+"',";
		}
		for(j=totdays;j<31;j++){
			sqlIns=sqlIns+"' ',";			
		}
		tot=p+h+od;		
		sqlIns=sqlIns+p+",";
		sqlIns=sqlIns+a+",";  //ABSENT
		sqlIns=sqlIns+l +",";
		sqlIns=sqlIns+od +",";
		sqlIns=sqlIns+late +",";
		sqlIns=sqlIns+h +",";
		sqlIns=sqlIns+sun +",";
		sqlIns=sqlIns+"'"+ses_uname +"',";
		sqlIns=sqlIns+"'"+ datetime.format(date)+"',";
		sqlIns=sqlIns+"'Y')";
		insertUserInformation(userid[i]);
		System.gc();
	}
	rs.close();
	st.close();
	    
	response.sendRedirect("MusterReportView.jsp");
}
catch(Exception npe)
{
	//System.out.println(npe);
	response.sendRedirect("MusterReportView.jsp");
}
%>
