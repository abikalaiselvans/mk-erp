<%@ page
	import="java.sql.*,java.io.*,java.util.*,java.text.*,com.my.org.erp.bean.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />

<html>
<head>

<title> :: ATTENDANCE ::</title>


 
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<style type="text/css">
	<!--
	.style8 {
		font-family: Verdana;
		font-size: 12px;
	}
	.style78 {font-family: Verdana}
	.style79 {font-size: 10px}
	.style80 {font-family: Verdana; font-size: 10px; }
	a:visited {
		color: #663366;
	}
	a:hover {
		color: #FF0000;
	}
	a:active {
		color: #0000FF;
	}
	-->
</style>
</head>
<%@ include file="index.jsp"%>
<body  onpaste='return false;'>

<%!
	Connection con ;
	Statement st ;
	PreparedStatement pstm;
	ResultSet rs,rs1;
	ResultSetMetaData rsmd;
	String sql;	
	String month;
	int year;
	int totdays;
	int i,sno;	
	
	
	String presentType;
	String empid;
	String empname;
	
	String date1;
	String date2;
	String Fline="";
	ArrayList attdata = new ArrayList();

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
	
	
	private boolean checkAtten(String uid,String type)
	{
		////System.out.println(uid +"--"+type);
		
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
			
		}
		else if(type.equals("L"))
		{
			tsql="SELECT CHR_EMPID,DT_LDATE,CHR_LEAVETYPE,CHR_DAYTYPE ";
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
			////System.out.println(tsql);
			pstm=con.prepareStatement(tsql);
			rs=pstm.executeQuery();
			if(rs.next())
			{
				if(type.equals("O"))
				{
					presentType=rs.getString("CHR_TYPE");
				}
				if(type.equals("L"))
				{
					presentType=rs.getString("CHR_DAYTYPE");					
				}
				//System.out.println(presentType);
				return true;					
			}				
		}
		catch(Exception e)
		{
			//System.out.println("ERROR1:"+e.getMessage());
			return false;			
		}
		return false;
	}
	
%>
<%

	String ptype=request.getParameter("muster");
	month=request.getParameter("Month");
	year=Integer.parseInt(request.getParameter("Year"));
	 
	session.setAttribute("month",month);
	session.setAttribute("year",year);
	
	if(ptype.equalsIgnoreCase("month")){
		sql="SELECT CHR_EMPID,CHR_STAFFNAME ";
		sql=sql+"FROM  com_m_staff  ORDER BY CHR_EMPID";
	}
	else if(ptype.equalsIgnoreCase("Designation"))
	{
		String desid=request.getParameter("Designation");
		sql="SELECT CHR_EMPID,CHR_STAFFNAME ";
		sql=sql+"FROM  com_m_staff  WHERE INT_DESIGID="+desid+" ORDER BY CHR_EMPID";		
	}
	else if(ptype.equalsIgnoreCase("Department"))
	{
		String depid=request.getParameter("Department");
		sql="SELECT CHR_EMPID,CHR_STAFFNAME ";
    	sql=sql+"FROM  com_m_staff  WHERE INT_DEPARTID="+depid+" ORDER BY CHR_EMPID";			
	}
	con=conbean.getConnection();
	try
	{	
		st=con.createStatement();
		rs=st.executeQuery(sql);
		empid="";
		empname="";
		while(rs.next()){
			if(!empid.equalsIgnoreCase("")){
				empid=empid+",";
				empname=empname+",";
			}    				
			empid=empid+rs.getString(1);
			empname=empname+rs.getString(2);
		}
		session.setAttribute("empid",empid);
		session.setAttribute("empname",empname);
		rs.close();
		//st.close();
		
		//response.sendRedirect("MusterRollView.jsp");
	}
	catch(Exception npe)
	{
		//System.out.println(npe);
	}
	
	
	month=""+session.getAttribute("month");
	year=Integer.parseInt(""+session.getAttribute("year"));
	empid=""+session.getAttribute("empid");
	empname=""+session.getAttribute("empname");
	
	
	//con=conbean.getConnection();
	
	int mon=Integer.parseInt(month);
	totdays=totalDays(mon,year);
	String fdate="01-"+month+"-"+year;
	String tdate= totdays+"-"+month+"-"+year;
	date1=FormateDateSQL(fdate);
	date2=FormateDateSQL(tdate);
	String userid[]=empid.split(",");
	String username[]=empname.split(",");           	       	   	
	sno=0;
	

	try
	{	
		String ts=""+request.getParameter("show");
		if(ts.equalsIgnoreCase("null")) ts="0";
		int show=Integer.parseInt(ts);	
		int last=show*10+ 10;
		if(last>userid.length) last=userid.length;	
		Fline="";
		for(i=0;i<userid.length;i++)
		{			  
			date1=FormateDateSQL(fdate);
			date2=FormateDateSQL(tdate);
	
			Fline = Fline +i +"^";
			Fline = Fline +userid[i] +"^";
			Fline = Fline +username[i] +"^";
			
			String attValue[]=new String[31];
			int dat=0;
			double p=0; // NO Present			
			double l=0; // Leave
			double od=0; // OD
			double a=0;  // Absent
			double h=0; // Holiday
			double late=0;
			int sun=0;
			String dbdate="";
			int rcount=0;
			while(true)
		    {
				rcount=0;
				String data[]=date1.split("-");
				int y= Integer.parseInt(data[0]);
				int m= Integer.parseInt(data[1]);
				int d= Integer.parseInt(data[2]);				
				java.util.Date date=new java.util.Date(y,m,d);				
				
				String sql="Select * from ATT_SMART_ATTENDANCE where DT_LOGIN='"+date1+"' AND ";
				sql = sql +" CHR_EMPID='"+userid[i]+"' AND CHR_TYPE = 'P'";
				rs1 = st.executeQuery(sql);
				p=0; 
				while(rs1.next())
				{	
					rcount =rcount +1;
					p = p+1;
				}
				rs1.close();
				if(rcount == 1)
					attValue[dat]="P";
				else
					attValue[dat]="A";
				 
			/* 
				if(date.getDay()==0)
				{
					if(checkAtten(userid[i],"P"))
					{
						attValue[dat]="P";
						p++;
						if(checkAtten(userid[i],"L"))
						{
							attValue[dat]="L";
							l++;
						}
					}
					else
					{
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
					}
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
				
				*/
				
				//attValue[dat]="A";	
				late=1;
				
				dat++;
				if(date1.equalsIgnoreCase(date2)) break;
				date1=addDate(date1,1);
			}
			
			String attVale[]=attValue;
			for(int j=0;j<totdays;j++){
				if(attVale[j].equals("S"))
					Fline = Fline +attVale[j] +"^";	
				else if(attVale[j].equals("H"))
					Fline = Fline +attVale[j] +"^";		
				else if(attVale[j].equals("P"))
					Fline = Fline +attVale[j] +"^";		
				else if(attVale[j].equals("L"))
					Fline = Fline +attVale[j] +"^";		
				else if(attVale[j].equals("A"))
					Fline = Fline +attVale[j] +"^";		
				else if(attVale[j].equals("O")||attVale[j].equals("O/A")||attVale[j].equals("O/P")||attVale[j].equals("P/O"))
					Fline = Fline +attVale[j] +"^";		
			}	
			Fline = Fline +p +"^";	
			Fline = Fline +l +"^";
			Fline = Fline +od +"^";
			Fline = Fline +h +"^";
			Fline = Fline +late +"^";
			Fline = Fline +(p+h+od) +" \n";
			p=0;
	}
	//rs.close();
	st.close();
	 	
	out.println("<br><br>" +Fline);
}
  
catch(Exception npe)
{
	//System.out.println(npe);
}
	
 
%>

<%@ include file="../footer.jsp"%>

</body>
</html>
