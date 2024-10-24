package com.my.org.erp.SmartAttendance;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Calendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class AbsentActionHandler extends AbstractActionHandler 
{
	String courseName,repName,repHeader;
	int courseId;
	Statement st;
	ResultSet rs;
	ResultSet rsemp;
	String sql;
	String fline = "";
	String empid;
	String empname;
	int rcount = 0;
	String erro = "",compId,branchId,compName,branchName;
	Calendar calDate1 = Calendar.getInstance();
	Calendar calDate2 = Calendar.getInstance();
	HttpSession seesion=null;
	String sesUserId=null;
	
	private String FormatDateSQL(String indate)
	{
		String date= indate.substring(0,2);
		String month= indate.substring(3,5);
		String year= indate.substring(6);
		return(""+year +"-"+month+"-"+date);
	}
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		try
		{
				String action=""+request.getParameter("actionS").trim();
				//System.out.println("action---------------------------------------------------"+action);

				compId= request.getParameter("company");
				branchId= request.getParameter("branch");
				compName= com.my.org.erp.common.CommonInfo.stringGetAnySelectField("Select CHR_COMPANYNAME from  com_m_company  where INT_COMPANYID="+compId, "CHR_COMPANYNAME");
				sql="Select CHR_BRANCHNAME from  com_m_branch  where INT_BRANCHID="+branchId;
				//System.out.println("SQL :"+sql);
				String repName = "Company : "+compName;
				if(!branchId.equals("-1"))
				{
					branchName=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql,"CHR_BRANCHNAME");
					repName=repName+ " ~ Branch : "+branchName;
				}
				else				
					repName=repName+ " ~ Branch : All ";

					
				if(action.equals("ATTAbsentDateList"))
				{
					String fline="";
					Statement st=con.createStatement();				
					String fromDate=FormatDateSQL(request.getParameter("fromdt"));
					String toDate=FormatDateSQL(request.getParameter("todt"));											
					
					repName=repName+" Absent Details";
					repHeader="Staff Id^Staff Name^Department^Designation";
					fline="";
					fline=fline+repName+"\n";
					fline=fline+repHeader+"\n";
					
					sql="SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_DEPARTNAME,C.CHR_DESIGNAME FROM  com_m_staff  A,  com_m_depart   B,"; 
					sql=sql+" com_m_desig  C WHERE A.INT_DEPARTID=B.INT_DEPARTID AND A.INT_DESIGID=C.INT_DESIGID AND";
					sql = sql + " A.INT_COMPANYID="+compId;
					if(!branchId.equals("-1"))
						sql=sql+" AND A.INT_BRANCHID="+branchId;
					sql=sql+" AND CHR_EMPID NOT IN (SELECT CHR_EMPID FROM ATT_SMART_ATTENDANCE WHERE DT_LOGIN<='"+fromDate+"' AND DT_LOGIN>='"+toDate+"')"; 
					
				    rs=st.executeQuery(sql); 					
					int rcount=0;
					while(rs.next())
					{
						for(int y=1;y<=4;y++)
						fline = fline +" " +rs.getString(y) +"^";
						fline = fline +"^\n";
						rcount=rcount+1;
					}
					if(rcount <1)
						fline = fline +"Record not found...";					
				
					String filename="AbsentReport.sys";			
					FileWriter fws = new FileWriter(filename);
					BufferedWriter bws = new BufferedWriter(fws);					
					bws.write(fline);
					bws.close();
					con.close();   
					response.sendRedirect("Smart Attendance/ReportViewAbsent.jsp");
				}
				else if(action.equals("ATTAbsentMonthList"))
				{
					String fline="";
					Statement st=con.createStatement();
					String month=request.getParameter("month");
					String year=request.getParameter("year");
					String fDate="1-"+month+"-"+year;
					String tDate="31-"+month+"-"+year;
					String fromDate=FormatDateSQL(fDate);
					String toDate=FormatDateSQL(tDate);											
					repName=repName+" Absent Details";
					repHeader="Staff Id^Staff Name^Department^Designation";
					fline="";
					fline=fline+repName+"\n";
					fline=fline+repHeader+"\n";
					
					sql="SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_DEPARTNAME,C.CHR_DESIGNAME FROM  com_m_staff  A,  com_m_depart   B,"; 
					sql=sql+" com_m_desig  C WHERE A.INT_DEPARTID=B.INT_DEPARTID AND A.INT_DESIGID=C.INT_DESIGID AND";
					sql = sql + " A.INT_COMPANYID="+compId;
					if(!branchId.equals("-1"))
						sql=sql+" AND A.INT_BRANCHID="+branchId;
				    sql=sql+" AND CHR_EMPID NOT IN (SELECT CHR_EMPID FROM ATT_SMART_ATTENDANCE WHERE DT_LOGIN<='"+fromDate+"' AND DT_LOGIN>='"+toDate+"')"; 
					
					    rs=st.executeQuery(sql); 					
						int rcount=0;
						
						while(rs.next())
						{
							for(int y=1;y<=4;y++)
							fline = fline +" " +rs.getString(y) +"^";
							fline = fline +"^\n";
							rcount=rcount+1;
						}
						if(rcount <1)
							fline = fline +"Record not found...";					
					
					String filename="AbsentReport.sys";			
					FileWriter fws = new FileWriter(filename);
					BufferedWriter bws = new BufferedWriter(fws);					
					bws.write(fline);
					bws.close();	
					con.close();    
					response.sendRedirect("Smart Attendance/ReportViewAbsent.jsp");
				}
		
				else if(action.equals("ATTAbsentDesignationList"))
				{
					String fline="";
					Statement st=con.createStatement();
					String Desig=request.getParameter("Designation");
					String month=request.getParameter("Month");
					String year=request.getParameter("Year");
					String fDate="1-"+month+"-"+year;
					String tDate="31-"+month+"-"+year;
					String fromDate=FormatDateSQL(fDate);
					String toDate=FormatDateSQL(tDate);											
					
					repName=repName+" Absent Details";
					repHeader="Staff Id^Staff Name^Department^Designation";
					fline="";
					fline=fline+repName+"\n";
					fline=fline+repHeader+"\n";
					
					sql="SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_DEPARTNAME,C.CHR_DESIGNAME FROM  com_m_staff  A,  com_m_depart   B,"; 
					sql=sql+" com_m_desig  C WHERE A.INT_DEPARTID=B.INT_DEPARTID AND A.INT_DESIGID=C.INT_DESIGID AND C.INT_DESIGID="+Desig+" AND ";
					sql = sql + " A.INT_COMPANYID="+compId;
					if(!branchId.equals("-1"))
						sql=sql+" AND A.INT_BRANCHID="+branchId;
				
					sql=sql+" AND CHR_EMPID NOT IN (SELECT CHR_EMPID FROM ATT_SMART_ATTENDANCE WHERE DT_LOGIN<='"+fromDate+"' AND DT_LOGIN>='"+toDate+"')"; 
					
					    rs=st.executeQuery(sql); 					
						int rcount=0;
						
						while(rs.next())
						{
							for(int y=1;y<=4;y++)
							fline = fline +" " +rs.getString(y) +"^";
							fline = fline +"^\n";
							rcount=rcount+1;
						}
						if(rcount <1)
							fline = fline +"Record not found...";					
					
					String filename="AbsentReport.sys";			
					FileWriter fws = new FileWriter(filename);
					BufferedWriter bws = new BufferedWriter(fws);					
					bws.write(fline);
					bws.close();	
					con.close();   
					response.sendRedirect("Smart Attendance/ReportViewAbsent.jsp");
				}
				else if(action.equals("ATTAbsentDepartmentList"))
				{
					String fline="";
					Statement st=con.createStatement();
					String Depart=request.getParameter("Department");
					String month=request.getParameter("Month");
					String year=request.getParameter("Year");
					String fDate="1-"+month+"-"+year;
					String tDate="31-"+month+"-"+year;
					String fromDate=FormatDateSQL(fDate);
					String toDate=FormatDateSQL(tDate);											
					
					repName=repName+" Absent Details";
					repHeader="Staff Id^Staff Name^Department^Designation";
					fline="";
					fline=fline+repName+"\n";
					fline=fline+repHeader+"\n";
					
					sql="SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_DEPARTNAME,C.CHR_DESIGNAME FROM  com_m_staff  A,  com_m_depart   B,"; 
					sql=sql+" com_m_desig  C WHERE A.INT_DEPARTID=B.INT_DEPARTID AND A.INT_DESIGID=C.INT_DESIGID AND B.INT_DEPARTID="+Depart+" AND ";
					sql = sql + " A.INT_COMPANYID="+compId;
					if(!branchId.equals("-1"))
						sql=sql+" AND A.INT_BRANCHID="+branchId;
				
					sql=sql+" AND CHR_EMPID NOT IN (SELECT CHR_EMPID FROM ATT_SMART_ATTENDANCE WHERE DT_LOGIN<='"+fromDate+"' AND DT_LOGIN>='"+toDate+"')"; 
					
					    rs=st.executeQuery(sql); 					
						int rcount=0;
						
						while(rs.next())
						{
							for(int y=1;y<=4;y++)
							fline = fline +" " +rs.getString(y) +"^";
							fline = fline +"^\n";
							rcount=rcount+1;
						}
						if(rcount <1)
							fline = fline +"Record not found...";					
					
					String filename="AbsentReport.sys";			
					FileWriter fws = new FileWriter(filename);
					BufferedWriter bws = new BufferedWriter(fws);					
					bws.write(fline);
					bws.close();	
					con.close();    
					response.sendRedirect("Smart Attendance/ReportViewAbsent.jsp");
				}
	           
				
				
		}	
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}	
	

}

