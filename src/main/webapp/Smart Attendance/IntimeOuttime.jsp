<%@ page
	import="java.sql.*,java.util.Date,java.util.Properties,java.io.*,java.text.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!
	Connection con ;
	PreparedStatement pstm;
	ResultSet rst;	
	ResultSet rsAten;
	String sql;
	String pfilename;
	String tabletype;
	String tablename;
	String ltimeout,ltimein;   		// Lunch Time In/out varibles
	int gracetimein,gracetimeout;   // Grace Time 
	String stimein,stimeout; 			// Shift Time Varibles
	
	int pinno;
	String empid;
	String empname;
	String depname;
	String desname;
	String intime;
	String outtime;
	String tothours;
	String shiftcode;
	String shifttime;
	String message;
	String type;
	String ses_uname="";
	SimpleDateFormat datetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	SimpleDateFormat dateformat=new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat timeformat=new SimpleDateFormat("HH:mm:ss");
	SimpleDateFormat timeformat12=new SimpleDateFormat("h:mm a");
	SimpleDateFormat month=new SimpleDateFormat("MMMMM");
	SimpleDateFormat year=new SimpleDateFormat("yyyy");
	
	private void selectType(int pno){
		sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME FROM  com_m_staff  A, att_m_staffimage  B WHERE B.CHR_EMPID=A.CHR_EMPID AND B.INT_PINNO=" + pno;
		try
		{			
			pstm = con.prepareStatement(sql);
			rst = pstm.executeQuery();			
			if(rst.next()){
				empid=rst.getString("CHR_EMPID");
				empname= rst.getString("CHR_STAFFNAME");
				type="STAFF";
			}
			else
				type="NOT";
			rst.close();				
		}
		catch(Exception e){
		 	//System.out.println(e);
		}
	}	
	private boolean InTimeOutTime(){
		Date date=new Date();
		if(type.equals("STAFF")){
			sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_DEPARTNAME,C.CHR_DESIGNAME FROM  com_m_staff  A,  com_m_depart   B, com_m_desig  C ";
			sql =sql +"WHERE A.INT_DEPARTID=B.INT_DEPARTID AND A.INT_DESIGID=C.INT_DESIGID AND A.CHR_EMPID=" + empid;			
		}
		try
		{			
			pstm = con.prepareStatement(sql);
			rst = pstm.executeQuery();
			if(rst.next())
			{		
				empid=rst.getString(1);
				empname= rst.getString(2);
				depname= rst.getString(3);
				desname= rst.getString(4);
				sql="SELECT * FROM ATT_SMART_ATTENDANCE WHERE CHR_EMPID ='"+rst.getString("CHR_EMPID") +"' AND DT_LOGIN ='"+dateformat.format(date)+"' AND DT_LOGOUT IS Null";	
				pstm = con.prepareStatement(sql);
				rsAten=pstm.executeQuery();
				if(rsAten.next()){
				  boolean checkout=true;	
				  if(tabletype.equals("Single")){
					  if(checkShiftTimeOut())
						 checkout=true;
					  else
						 checkout=false;
				  }
				  if(checkout){	
					sql="UPDATE ATT_SMART_ATTENDANCE SET DT_TIMEOUT=?, DT_LOGOUT=?,INT_TOTALHOUR=?,INT_TOTALMIN=?";
					sql=sql+" WHERE CHR_EMPID='"+rst.getString("CHR_EMPID")+"'";
					pstm = con.prepareStatement(sql);
					pstm.setString(1,timeformat.format(date));
					pstm.setString(2,dateformat.format(date));
//--------------------------------------------------------------------					
					intime= rsAten.getString("DT_TIMEIN");
					int hours= Integer.parseInt(intime.substring(0,2));
					int mins= Integer.parseInt(intime.substring(3,5));
					int secs= Integer.parseInt(intime.substring(6,8));
					if(hours>12)  {
						intime= (hours-12)+":"+mins+" PM";
					}else{
						intime= hours+":"+mins+" AM";
					}
//----------------------------------------------------------------------
					int hours1=date.getHours();
					int mins1= date.getMinutes();					
					pstm.setInt(3,hours1-hours);
					pstm.setInt(4,mins1-mins);
					pstm.execute();  
					tothours=""+(hours1-hours) +  " h : " + (mins1-mins)+" m";
					outtime= timeformat12.format(date);
					message="Out Time Is Marked";
				  }	
				}else{
				  boolean checkin=true;	
				  if(tabletype.equals("Single")){				   
				    	sql="SELECT * FROM ATT_SMART_ATTENDANCE WHERE CHR_EMPID ='"+rst.getString("CHR_EMPID") +"' AND DT_LOGIN ='"+dateformat.format(date)+"' AND DT_LOGOUT IS NOT  Null";	
						pstm = con.prepareStatement(sql);
						ResultSet rschk=pstm.executeQuery();
						//System.out.println(sql);
						if(rschk.next()){	
							message="Attendance Is Already Marked";
							checkin=false;					  
						}
						else{
							if(checkShiftTimeIn())
								 checkin=true;
							 else
								checkin=false;
						}				   					  
				  }
				  if(checkin){
					sql="INSERT INTO ATT_SMART_ATTENDANCE(CHR_EMPID,DT_TIMEIN,DT_LOGIN,";
					sql=sql+"CHR_LOGMONTH,INT_LOGYEAR,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS)";
					sql=sql+" VALUES(?,?,?,?,?,?,?,?)";
					pstm = con.prepareStatement(sql);
					pstm.setString(1,rst.getString("CHR_EMPID"));
					pstm.setString(2,timeformat.format(date));
					pstm.setString(3,dateformat.format(date));
					pstm.setString(4,month.format(date));
					pstm.setString(5,year.format(date));
					pstm.setString(6,ses_uname);
					pstm.setString(7,datetime.format(date));					
					pstm.setString(8,"Y");
					pstm.execute();
					intime= timeformat12.format(date);
					outtime=" ";
					tothours=" ";
					message="In Time Is Marked";
 				  }
				}
				return true;
			}
			else{
				 empid="";
				 empname="";
				 depname="";
				 desname="";
				 intime="";
				 outtime="";
				 tothours="";
				 message="Enter Your Valid Pin Number";
				 return false;
			}
		}
		catch(Exception ex)
		{
			//System.out.println(ex);
		}
		return false;
	}
	private boolean  checkShiftTime(){		
		Date date=new Date();
	    String sqlstr=null;
		try{
			sql = "SELECT A.CHR_SHIFTCODE,A.CHR_SHIFTNAME,A.DT_TIMEFROM,A.DT_TIMETO FROM ATT_M_SHIFT A,ATT_T_SHIFTALLOCATION B ";
			sql = sql + " WHERE A.CHR_SHIFTCODE=B.CHR_SHIFTCODE ";
			sql = sql + " AND B.CHR_EMPID='" + empid + "'";
			sql = sql + " AND DT_DATE='" + dateformat.format(date) + "'";
			pstm = con.prepareStatement(sql);
			rsAten=pstm.executeQuery();
			if(rsAten.next()){  
				//System.out.println(rsAten.getString("CHR_SHIFTCODE"));
				shiftcode=rsAten.getString("CHR_SHIFTCODE");
				stimein=rsAten.getString("DT_TIMEFROM");
				stimeout=rsAten.getString("DT_TIMETO");
				shifttime=rsAten.getString("DT_TIMEFROM")+" TO "+ rsAten.getString("DT_TIMETO");
				rsAten.close();
			}else{
				rsAten.close();
				return false;
			}
			sql="SELECT * FROM ATT_M_ATTENDANCERULES WHERE CHR_EMPID ='"+ empid +"'"; 
			pstm = con.prepareStatement(sql);
			rsAten=pstm.executeQuery();
			if(rsAten.next()){  
				gracetimein=rsAten.getInt("INT_INGRACETIME");
				gracetimein=rsAten.getInt("INT_OUTGRACETIME");
				ltimeout=rsAten.getString("DT_LTIMEOUT");
				ltimein=rsAten.getString("DT_LTIMEIN");
				rsAten.close();
				return true;				
			}
			else{
				rsAten.close();
				return false;
			}
		}catch(Exception e){
			return false;
		}finally{

		}
	}
//	--------------For Checking Shift Time and System Time-------------	
	private boolean checkShiftTimeIn(){		
		Date date=new Date();
		int hours1=date.getHours();
		int mins1= date.getMinutes();
		int shfhour=Integer.parseInt(stimein.substring(0,2));
		int shfmin=Integer.parseInt(stimein.substring(3,5));
		if(hours1>shfhour && mins1> shfmin){			
			message="Late Commer-Please Contact Administrator";
			return false;
		}else{			
			return true;			
		}
	}

	private boolean checkShiftTimeOut(){
		Date date=new Date();
		int hours1=date.getHours();
		int mins1= date.getMinutes();
		int shfhour=Integer.parseInt(stimeout.substring(0,2));
		int shfmin=Integer.parseInt(stimeout.substring(3,5));
		if(hours1>shfhour && mins1> shfmin){
			return true;
		}else{
			message="Your Shift Time Is Not Completed-Please Contact Administrator";			
			return false;
		}
	}
//	------------------------------------------------------------------
	
%>
<%
pfilename=request.getParameter("file");
%>
<html>
<body  onpaste='return false;'>
<form  AUTOCOMPLETE = "off"   action="<%= pfilename %>" name="frmInOut">
<%
	con = conbean.getConnection();
	String atype=""+request.getParameter("atype");
	ses_uname=""+session.getAttribute("USRID"); 
	if(atype.equals("null"))		   {
	  
	   tabletype=request.getParameter("tablename");  
  	   String pno=request.getParameter("pinno");
	   selectType(pinno);
	   pinno=Integer.parseInt(pno);
	}
	else{
		empid=""+request.getParameter("empid");
		type="STAFF";
	}		
		
	if(type.equals("NOT")){
		 type="";	
		 empid="";
		 empname="";
		 depname="";
		 desname="";
		 shiftcode="";
		 shifttime="";
		 intime="";
		 outtime="";
		 tothours="";
		 message="Enter Your Valid Pin Number";
	}else{
		if(checkShiftTime()) {	
			InTimeOutTime();
			if(tabletype.equals("Multi")){		
				
			}	
		}
		else{
			message="Shift Not Allocated";
		}			
	}
	out.println("<input type='hidden' name='empid' value='"+ empid +"'>");
	out.println("<input type='hidden' name='empname' value='"+empname +"'>");
	out.println("<input type='hidden' name='depname' value='"+ depname +"'>");
	out.println("<input type='hidden' name='desname' value='"+ desname +"'>");
	out.println("<input type='hidden' name='shiftcode' value='"+shiftcode+"'>");	
	out.println("<input type='hidden' name='shifttime' value='"+shifttime+"'>");	
	out.println("<input type='hidden' name='intime' value='"+intime+"'>");				
	out.println("<input type='hidden' name='outtime' value='"+outtime+"'>");
	out.println("<input type='hidden' name='tothours' value='"+tothours+"'>");	
	out.println("<input type='hidden' name='message' value='"+ message +"'>");
%> <script language="javascript">
	document.frmInOut.submit();
</script></form>
</body>
</html>
