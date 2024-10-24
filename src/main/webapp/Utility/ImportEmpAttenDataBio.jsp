<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.*"%>
<%@page import="java.sql.Date"%>
<%@include file="Redirect.jsp" %>
<%
try{
%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!
	String message;
	ArrayList empdata = new ArrayList();
	Connection con=null;
	ResultSet rs=null;
	Statement st=null; 
	String url="jdbc:odbc:SmartAttendance";
	String sql=null;
	String fromDate;
	String toDate;
	String empid;
	String empname;
	String shiftcode;
	String shiftname;
	String intime;
	String outtime;
	String lunchIn,lunchOut;
	String attLunchIn,attLunchOut;	
	int i;	
	Calendar calDate1 = Calendar.getInstance();
	Calendar calDate2 = Calendar.getInstance();
	Connection con1 ;
	PreparedStatement pstm;
	ResultSet rst;	
	private String FormateDateSQL(String indate)
	{
		String date= indate.substring(0,2);
		String month= indate.substring(3,5);
		String year= indate.substring(6);
		return(""+year +"-"+month+"-"+date);
	}	
	private String FormateDateMS(String indate)
	{
		String date= indate.substring(0,2);
		String month= indate.substring(3,5);
		String year= indate.substring(6);
		return(""+date +"/"+month+"/"+year);
	}	
	private void setDate(String fDate,String tDate)
	{
   		int date= Integer.parseInt(fDate.substring(0,2));
		int month= Integer.parseInt(fDate.substring(3,5));
		int year= Integer.parseInt(fDate.substring(6));		
		calDate1.set(year,month,date);		
   		date= Integer.parseInt(tDate.substring(0,2));
		month= Integer.parseInt(tDate.substring(3,5));
		year= Integer.parseInt(tDate.substring(6));
		calDate2.set(year,month,date+1);
	}
	private String getDate()
	{
		String date=""+ calDate1.get(Calendar.DATE);
		String month=""+ calDate1.get(Calendar.MONTH);
		String year=""+calDate1.get(Calendar.YEAR);		
		if(date.length()==1) date="0"+date;
		if(month.length()==1) month="0"+month;
		return(""+date +"/"+month+"/"+year);
	}
	
	private String getDates()
	{
		String date=""+ calDate1.get(Calendar.DATE);
		String month=""+ calDate1.get(Calendar.MONTH);
		String year=""+calDate1.get(Calendar.YEAR);		
		if(date.length()==1) date="0"+date;
		if(month.length()==1) month="0"+month;
		return(""+month +"/"+date+"/"+year);
	}
	
	private String getDateSQL()
	{
		String date=""+ calDate1.get(Calendar.DATE);
		String month=""+ calDate1.get(Calendar.MONTH);
		String year=""+calDate1.get(Calendar.YEAR);		
		if(date.length()==1) date="0"+date;
		if(month.length()==1) month="0"+month;
		return(""+year +"-"+month+"-"+date);
	}
	private String FormateDateSQLY(String indate)
	{
		String date= indate.substring(0,4);
		String month= indate.substring(5,7);
		String year= indate.substring(8,10);
		return(""+year +"-"+month+"-"+date);
	}
	private String FormateTimeSQLY(String indate)
	{
		String hours= indate.substring(11,13);
		String min= indate.substring(14,16);
		String sec= indate.substring(17,19);
		return(""+hours +":"+min+":"+sec);
	}
	private String getTotalHours(String tim1,String tim2)
	{
		String intim[]=tim1.split(":");
		String outtim[]=tim2.split(":");
		int hours1=Integer.parseInt(intim[0]);
		int min1=Integer.parseInt(intim[1]);
		int hours2=Integer.parseInt(outtim[0]);
		int min2=Integer.parseInt(outtim[1]);
		hours1=hours2-hours1;
		if(min1>min2){		
			min1=min1-min2;
			hours1=hours1-1;
		}
		else
	        min1=min2-min1;
		return ""+hours1+":"+min1;		
	}
	private boolean checkLunchTime(String intime)
	{
		if(attLunchIn.equals("") && attLunchOut.equals("")){
			return false;
		}
		else
		{
			String time1=FormateTimeSQLY(intime);
			String data[]=time1.split(":");
			int hours1=Integer.parseInt(data[0]);
			int mins1=Integer.parseInt(data[1]);			
			String dataLIN[]=attLunchIn.split(":");
			int hLIN=Integer.parseInt(dataLIN[0]);
			int mLIN=Integer.parseInt(dataLIN[1]);
			String dataLOUT[]=attLunchOut.split(":");
			int hOUT=Integer.parseInt(dataLOUT[0]);
			int mOUT=Integer.parseInt(dataLOUT[1]);			
			if(((hours1>=hLIN && mins1> mLIN)||(hours1>hLIN))&& ((hours1<=hOUT && mins1< mOUT)||(hours1<=hOUT))){
				return true;				
			}else{				
				return false;
			} 	
		}				
	}
	private void ShiftCodeName(String uid)
	{    	
		try{
			sql="SELECT A.CHR_SHIFTCODE,B.CHR_SHIFTNAME,B.DT_TIMEFROM,B.DT_TIMETO ";
			sql=sql+"FROM ATT_T_EMPSHIFT A, ATT_M_SHIFT B WHERE A.CHR_SHIFTCODE=B.CHR_SHIFTCODE ";
			sql=sql+"AND DT_DATE='"+getDateSQL()+"' AND A.CHR_EMPID='"+uid+"'" ;
			pstm=con1.prepareStatement(sql);	
			rst=pstm.executeQuery();
			if(rst.next()){
				shiftcode=rst.getString(1);
				shiftname=rst.getString(2);
			}
		}
		catch(Exception e){
		}
	}
%>
<%		
		fromDate=FormateDateMS(request.getParameter("fromdt"));
		toDate=FormateDateMS(request.getParameter("todt"));        
        try
        {
        // -------------For Geting Emp NO-----------------        	
        	con1=conbean.getConnection();
			sql="SELECT TIM_LUNCHIN,TIM_LUNCHOUT FROM ATT_BASICSETTINGS WHERE TIM_LUNCHIN IS NOT NULL AND TIM_LUNCHOUT IS NOT NULL";
			//System.out.println(sql);
			pstm=con1.prepareStatement(sql);	
			rst=pstm.executeQuery();
			if(rst.next()){
				attLunchIn=rst.getString(1);
				attLunchOut=rst.getString(2);
			}
			else
			{
				attLunchIn="";
				attLunchOut="";
			}
    		sql="SELECT CHR_EMPID,CHR_STAFFNAME ";
    		sql=sql+"FROM  com_m_staff ";
    		//out.println(sql);
    		pstm=con1.prepareStatement(sql);
    		rst=pstm.executeQuery();
    		empid="";
    		empname="";
    		while(rst.next()){
    			if(!empid.equalsIgnoreCase("")){
    				empid=empid+",";
    				empname=empname+",";
    			}    				
    			empid=empid+rst.getString(1);
    			empname=empname+rst.getString(2);
    		}
			//out.println("<br><br><br>"+empid);
			//out.println("<br><br><br>"+empname);
			
    		rst.close();
    		pstm.close();  
    		con1.close();
//----------------------------------------------------------          	
           Class.forName ("sun.jdbc.odbc.JdbcOdbcDriver");
   	       con = DriverManager.getConnection(url);
           st=con.createStatement();
           String userid[]=empid.split(",");
           String username[]=empname.split(",");           
//--------------Date Compare----------------------------           
           setDate(fromDate,toDate);       	
		   empdata.clear();
  		   session.putValue("empdata",empdata);
           while(!calDate1.equals(calDate2)){
			   ////System.out.println(getDate());
	           for(i=0;i<userid.length;i++)
	           {
	        	    sql="SELECT A.USERID,A.CHECKTIME,A.CHECKTYPE,B.SSN FROM CHECKINOUT A,USERINFO B ";
	        	    sql=sql+"WHERE A.USERID=B.USERID AND  Format (A.CHECKTIME, 'dd/mm/yyyy') = ('"+getDate()+"') ";
	        	    sql=sql+"AND B.SSN='"+userid[i]+"' ORDER BY A.CHECKTIME";
					//out.println(sql);
		           	ResultSet rs=st.executeQuery(sql);
		           	if(rs.next())
					{
		           	   EmployeeAtten emp1=new EmployeeAtten();
					   emp1.setEmpId(userid[i]);
					   emp1.setEmpName(username[i]);
					   intime=rs.getString(2);					  
					   emp1.setLoginDate(FormateDateSQLY(intime));
					   emp1.setTimeIn(FormateTimeSQLY(intime));
					  // out.println(intime);
					   lunchIn="";
					   lunchOut="";
					   boolean lin=false;
					   while(rs.next()){
						   outtime=rs.getString(2);
						   if(checkLunchTime(outtime)){
						   if(lin){
							   lunchOut=FormateTimeSQLY(outtime); 
						   }
						   else {
							   lunchIn=FormateTimeSQLY(outtime); 
						   }
						   lin=true;
						   //out.println("LUNCH TIME  : "+outtime + "   EMP NAME :"+emp1.getEmpId());
					   }
					   }
					   emp1.setLunchOut(lunchOut);
					   emp1.setLunchIn(lunchIn);
					   emp1.setTimeOut(FormateTimeSQLY(outtime));
					   emp1.setLogoutDate(FormateDateSQLY(outtime));
					   String tothours=getTotalHours(FormateTimeSQLY(intime),FormateTimeSQLY(outtime));
					   String totH[]=tothours.split(":");
					   emp1.setTotalHours(Integer.parseInt(totH[0]));
					   emp1.setTotalMinutes(Integer.parseInt(totH[1]));	
			   		   empdata.add(emp1);
	           		}
	           		rs.close();
	           }
			   calDate1.add(Calendar.DATE,1);
           }
           if(empdata.size()>0)
        	   message= ""+ empdata.size()+" New Record are Download";
           else
        	   message="There is no new Employee to Download";
           
           session.putValue("empdata",empdata);
           session.putValue("message",message);
           st.close();
          
           response.sendRedirect("ImportEmpAtten.jsp?startLetter=null");
        } 
        catch(Exception e)
        {
        	st.close();
 
           out.print(e.getMessage());
            message="<font color='FF0000'>"+e.getMessage()+"</font>";
            session.putValue("message",message);
            response.sendRedirect("ImportEmpAtten.jsp?startLetter=not");
        }
 
 }
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
 %>
