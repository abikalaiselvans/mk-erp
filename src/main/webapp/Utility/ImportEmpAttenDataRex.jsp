<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.*"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.my.org.erp.ServiceLogin.DateUtil"%>

<%@include file="Redirect.jsp" %>

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
	String shiftIn,shiftOut;
	String morTeaIn,morTeaOut;
	String eveTeaIn,eveTeaOut;	
	int graceIn,graceOut;	
	String shiftComIn,shiftComOut,morComTeaIn,morComTeaOut,eveComTeaIn,eveComTeaOut;
	String lunchComIn,lunchComOut;
	int graceComIn,graceComOut;
	String intime;
	String outtime;
	String lunchIn,lunchOut;
	String attLunchIn,attLunchOut;
	String LATE=null;
	int i;	
	
	Calendar calDate1 = Calendar.getInstance();
	Calendar calDate2 = Calendar.getInstance();
	
	Connection con1 ;
	PreparedStatement pstm;
	ResultSet rst;	
	SimpleDateFormat dateformat=new SimpleDateFormat("yyyy-MM-dd");
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
		String date= indate.substring(0,10);
		String data[]=date.split("-");
		date= data[0];
		String month= data[1];
		String year= data[2];
		return(""+year +"-"+month+"-"+date);
	}
	private String FormateTimeSQLY(String indate)
	{
		String temp= indate.substring(11);
//		String data[]=temp.split(":");
//		String hours= indate.substring(11);
//		String min= indate.substring(14,16);
//		String sec= indate.substring(17,19);
//		return(""+hours +":"+min+":"+sec);
		return(temp);
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
		if(min2>min1){		
			min1=min2-min1;
			hours1=hours1-1;
		}
		else
	        min1=min2-min1;	
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
	private boolean checkMorTeaTime(String intime)
	{
		//System.out.println("MORNING TEA :"+morComTeaOut);
		//System.out.println("MORNING TEA INT :"+intime);
		if(morTeaIn.equals("") && morTeaOut.equals("")){
			return false;
		}
		else
		{
			String time1=FormateTimeSQLY(intime);
			String data[]=time1.split(":");
			int hours1=Integer.parseInt(data[0]);
			int mins1=Integer.parseInt(data[1]);			
			String dataLIN[]=morTeaOut.split(":");
			int hLIN=Integer.parseInt(dataLIN[0]);
			int mLIN=Integer.parseInt(dataLIN[1]);
			String dataLOUT[]=morTeaIn.split(":");
			int hOUT=Integer.parseInt(dataLOUT[0]);
			int mOUT=Integer.parseInt(dataLOUT[1]);			
			if(((hours1>=hLIN && mins1> mLIN)||(hours1>hLIN))&& ((hours1<=hOUT && mins1< mOUT)||(hours1<=hOUT))){
				return true;				
			}else{				
				return false;
			} 	
		}				
	}
	private boolean checkEveTeaTime(String intime)
	{
		if(eveTeaIn.equals("") && eveTeaOut.equals("")){
			return false;
		}
		else
		{
			String time1=FormateTimeSQLY(intime);
			String data[]=time1.split(":");
			int hours1=Integer.parseInt(data[0]);
			int mins1=Integer.parseInt(data[1]);			
			String dataLIN[]=eveTeaOut.split(":");
			int hLIN=Integer.parseInt(dataLIN[0]);
			int mLIN=Integer.parseInt(dataLIN[1]);
			String dataLOUT[]=eveTeaIn.split(":");
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
	//------------------------ Shift Time----------------------
	private boolean checkShiftTimeIn(String intime){
		LATE="";
		int hours1=Integer.parseInt(intime.substring(0,2));
		int mins1= Integer.parseInt(intime.substring(3,5));
		int shfhour=Integer.parseInt(shiftIn.substring(0,2));
		int shfmin=Integer.parseInt(shiftIn.substring(3,5));
		shfmin=shfmin+graceIn;		
		if(shfmin>60){
			shfmin=shfmin-60;
			shfhour=shfhour+1;
		}		
		if((hours1>=shfhour && mins1>shfmin)||(hours1>shfhour)){	
			LATE="L";
			return true;			
		}else{			
			LATE=null;
			return true;			
		}
	}
//	------------------------Common Shift Time-----------------------
	private void checkCommonShiftTime(){		 
		try{			
			sql = "SELECT A.CHR_SHIFTCODE,A.CHR_SHIFTNAME,A.DT_TIMEFROM,A.DT_TIMETO,";
			sql=sql+"A.INT_GRACEIN,A.INT_GRACEOUT,A.DT_LUNCH_OUT,A.DT_LUNCH_IN,";
			sql=sql+"A.DT_TEA_TIMEOUT1,A.DT_TEA_TIMEIN1,A.DT_TEA_TIMEOUT2,A.DT_TEA_TIMEIN2 ";
			sql=sql+" FROM ATT_M_SHIFT A";
			sql = sql + " WHERE A.CHR_SHIFTCODE='COMMON'";
			//System.out.println("SQL :"+sql);
			pstm = con1.prepareStatement(sql);
			rst=pstm.executeQuery();
			if(rst.next()){  
				//System.out.println("SHIFT CODE :"+rst.getString("CHR_SHIFTCODE"));
				shiftcode=rst.getString("CHR_SHIFTCODE");
				shiftComIn=rst.getString("DT_TIMEFROM");
				shiftComOut=rst.getString("DT_TIMETO");
				graceComIn=rst.getInt("INT_GRACEIN");
				graceComOut=rst.getInt("INT_GRACEOUT");
				lunchComIn=rst.getString("DT_LUNCH_OUT");
				lunchComOut=rst.getString("DT_LUNCH_IN");				
				morComTeaIn=rst.getString("DT_TEA_TIMEIN1");
				morComTeaOut=rst.getString("DT_TEA_TIMEOUT1");
				eveComTeaIn=rst.getString("DT_TEA_TIMEIN2");
				eveComTeaOut=rst.getString("DT_TEA_TIMEOUT2");
				//System.out.println("CODE :"+shiftcode);
				rst.close();				
			}else{
				rst.close();
				shiftComIn="09:00:00";
				shiftComOut="18:00:00";
				graceComIn=0;
				graceComOut=0;				
			}			
		}catch(Exception e){
			//System.out.println(e);
			message="Error - "+e;
		}finally{

		}
	}
	
	private boolean  checkShiftTime(String eID){		
		java.util.Date date=new java.util.Date();
	    String sqlstr=null;
		try{
			sql = "SELECT A.CHR_SHIFTCODE,A.CHR_SHIFTNAME,A.DT_TIMEFROM,A.DT_TIMETO,";
			sql=sql+"A.INT_GRACEIN,A.INT_GRACEOUT,A.DT_LUNCH_OUT,A.DT_LUNCH_IN, ";
			sql=sql+"A.DT_TEA_TIMEOUT1,A.DT_TEA_TIMEIN1,A.DT_TEA_TIMEOUT2,A.DT_TEA_TIMEIN2 ";
			sql=sql+"FROM ATT_M_SHIFT A,ATT_T_SHIFTALLOCATION B ";
			sql = sql + " WHERE A.CHR_SHIFTCODE=B.CHR_SHIFTCODE ";
			sql = sql + " AND B.CHR_EMPID='" + eID + "'";
			sql = sql + " AND B.DT_DATE='" + getDateSQL() + "'";	
			//System.out.println(sql);
			pstm = con1.prepareStatement(sql);
			rst=pstm.executeQuery();			
			if(rst.next()){				
				shiftcode=rst.getString("CHR_SHIFTCODE");
				shiftcode=rst.getString("CHR_SHIFTCODE");
				shiftIn=rst.getString("DT_TIMEFROM");
				shiftOut=rst.getString("DT_TIMETO");
				graceIn=rst.getInt("INT_GRACEIN");
				graceOut=rst.getInt("INT_GRACEOUT");
				lunchIn=rst.getString("DT_LUNCH_OUT");
				lunchOut=rst.getString("DT_LUNCH_IN");				
				morTeaIn=rst.getString("DT_TEA_TIMEIN1");
				morTeaOut=rst.getString("DT_TEA_TIMEOUT1");
				eveTeaIn=rst.getString("DT_TEA_TIMEIN2");
				eveTeaOut=rst.getString("DT_TEA_TIMEOUT2");			
				rst.close();
				return true;
			}else{
				rst.close();								
				message="Shift Not Allocated";
				return false;
			}						
		}catch(Exception e){
			//System.out.println(e);
			message="Error - "+e;
			return false;
		}finally{

		}
	}
%>
<%		
		fromDate=FormateDateMS(request.getParameter("fromdt"));
		toDate=FormateDateMS(request.getParameter("todt"));        
		String sfDate=request.getParameter("fromdt");
		String stDate=request.getParameter("todt");
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
			pstm=con1.prepareStatement(sql);
				
    		rst=pstm.executeQuery();
    		empid="";
    		empname="";

    		while(rst.next()){
    			if(!empid.equalsIgnoreCase("")){
    				empid=empid+"@";
    				empname=empname+"@";
    			}    				
    			empid=empid+rst.getString(1);
    			empname=empname+rst.getString(2);
    		}
    		rst.close();
    		pstm.close(); 
    		checkCommonShiftTime();
       //----------------------------------------------------------          	
           Class.forName ("sun.jdbc.odbc.JdbcOdbcDriver");
   	       con = DriverManager.getConnection(url);
           st=con.createStatement();
           String userid[]=empid.split("@");
           String username[]=empname.split("@");           
           //System.out.println("EMP ID: "+empid);
           //System.out.println("EMP NAME: "+empname);

           //System.out.println("EMP length: "+userid.length);
           //System.out.println("EMP length: "+username.length);
//--------------Date Compare----------------------------           
		   String sqlFDate=DateUtil.FormateDateSQL(sfDate);
		   String sqlTDate=DateUtil.FormateDateSQL(sfDate);           	  
		   empdata.clear();
  		   session.putValue("empdata",empdata);
    	   sqlFDate=DateUtil.FormateDateSQL(sfDate);
           while(true){
	           for(i=0;i<userid.length;i++)
	           {
	        	   
	        	    sql="SELECT USERID,CHECKTIME,CHECKTYPE FROM CHECKINOUT WHERE CDATE(MID(CHECKTIME,1,10))='"+sqlFDate+"' AND USERID='"+userid[i]+"' ORDER BY CHECKTIME";
		           	ResultSet rs=st.executeQuery(sql);
		           	if(rs.next()){
	           		   if(checkShiftTime(userid[i]))
		        	   {
		        		    attLunchIn=lunchIn;
			       		    attLunchOut=lunchOut;   
		        	   }
		        	   else
		        	   {
			       		    shiftIn=shiftComIn;
			       		    shiftOut=shiftComOut;
			       		    graceIn=graceComIn;
							graceOut=graceComOut;
		        		    morTeaIn=morComTeaIn;
			       		    morTeaOut=morComTeaOut;
			       		    eveTeaIn=eveComTeaIn;
			       		    eveTeaOut=eveComTeaOut;
		        		    attLunchIn=lunchComIn;
			       		    attLunchOut=lunchComOut;	        		   
		        	   }
		           	   EmployeeAtten emp1=new EmployeeAtten();
					   emp1.setEmpId(rs.getString(1));
					   //System.out.println(userid[i]+":"+username[i]+" : I = "+i);
					   emp1.setEmpName(username[i]);
					   intime=rs.getString(2);				       
					   emp1.setLoginDate(FormateDateSQLY(intime));
					   emp1.setTimeIn(FormateTimeSQLY(intime));
					   checkShiftTimeIn(FormateTimeSQLY(intime));
					   emp1.setLate(LATE);
					   lunchIn="";
					   lunchOut="";
					   morTeaIn="";
					   morTeaOut="";
					   eveTeaIn="";
					   eveTeaOut="";
					   boolean lin=false;					   
					   boolean morTIn=false;
					   boolean eveTIn=false;
					   while(rs.next()){
						   outtime=rs.getString(2);
						   if(checkMorTeaTime(outtime)){
							   if(morTIn){
								  morTeaOut=FormateTimeSQLY(outtime);
							   } else {
								  morTeaIn=FormateTimeSQLY(outtime);								   
							   }
							   morTIn=true;
						   }							   
						   if(checkLunchTime(outtime)){
							   if(lin){
								   lunchOut=FormateTimeSQLY(outtime); 
							   }
							   else {
								   lunchIn=FormateTimeSQLY(outtime); 
							   }
							   lin=true;
						   }
						   if(checkEveTeaTime(outtime)){
							   if(eveTIn){
								  eveTeaOut=FormateTimeSQLY(outtime);
							   } else {
								  eveTeaIn=FormateTimeSQLY(outtime);								   
							   }
							   eveTIn=true;
						   }							   
					   }
					   emp1.setMorTeaIn(morTeaOut);
					   emp1.setMorTeaOut(morTeaIn);
					   emp1.setEveTeaIn(eveTeaOut);
					   emp1.setEveTeaOut(eveTeaIn);
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
	           if(sqlFDate.equalsIgnoreCase(sqlTDate)) break;
				sqlFDate=DateUtil.addDate(sqlFDate, 1);
           }
           	st.close();
 
           if(empdata.size()>0)
        	   message= ""+ empdata.size()+" New Record are Download";
           else
        	   message="There is no new Employee to Download";
			
           session.putValue("empdata",empdata);
           session.putValue("message",message);
           response.sendRedirect("ImportEmpAttenRex.jsp?startLetter=null");
        } 
        catch(Exception e)
        {
        	message="<font color='FF0000'>"+e.getMessage()+"</font>";
            session.putValue("message",message);
            response.sendRedirect("ImportEmpAttenRex.jsp?startLetter=not");
        	//System.out.println(e);	
        }
 %>
