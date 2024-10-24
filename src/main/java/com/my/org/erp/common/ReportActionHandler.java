package com.my.org.erp.common;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class ReportActionHandler extends AbstractActionHandler {
	String sql = null;
	String repName = null;
	String repHeader = null;
	int totdays;
	int year;
	int i;
	String s = "";
	String compId,branchId;
	String compName,branchName;
    ResultSet rs=null;
    
	private String FormatDateSQL(String indate)
	{
		String date= indate.substring(0,2);
		String month= indate.substring(3,5);
		String year= indate.substring(6);
		return(""+year +"-"+month+"-"+date);
	}
	private int totalDays(int mon, int year) 
	{
		int[] listTotalDays = { 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30,31 };
		if (year % 4 == 0)
			listTotalDays[2] = 29;
		return (listTotalDays[mon]);
	}

	private String FormateDateSQL(String indate) 
	{
		String date = indate.substring(0, 2);
		String month = indate.substring(3, 5);
		String year = indate.substring(6);
		return ("" + year + "-" + month + "-" + date);
	}

	@SuppressWarnings("unused")
	private String getEmpName(String empid) {
		String name = "";
		String sql = "";
		try {
			sql = "SELECT CHR_STAFFNAME FROM  com_m_staff  WHERE CHR_EMPID = '" + empid + "'";
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(sql);
			while (rs.next())
				name = rs.getString("CHR_STAFFNAME");
			
		} catch (Exception e) {

		}
		return name;
	}

	private void WriteFile(HttpServletRequest request,
			HttpServletResponse response, int noField) throws ServletException,
			IOException {
		try {

			
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(sql);
			String fline = "";
			String filename = "Report.sys";
			FileWriter fw = new FileWriter(filename);
			BufferedWriter bw = new BufferedWriter(fw);
			fline = fline + repName + "\n";
			fline = fline + repHeader + "\n";
			int rcount = 0;
			for (int i = 1; i < 2; i++);
				//System.out.println();
			while (rs.next()) {
				for (int i = 1; i <= noField; i++) {
					fline = fline + "   " + rs.getString(i) + "^";
				}

				fline = fline + "^\n";
				rcount = rcount + 1;
			}
			if (rcount < 1)
				fline = fline + "Record not found...";
			bw.write(fline);
			bw.close();
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private String getPath(String actionS) {
		String packType = actionS.substring(4);
		packType = packType.substring(0, 3);
		if (packType.equalsIgnoreCase("ATT")) {
			packType = "Smart Attendance/";
		} else if (packType.equalsIgnoreCase("PAY")) {
			packType = "Smart Payroll/";
		}
		return packType;
	}

	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String action = request.getParameter("actionS");
			action = action.trim();
			String path = getPath(action);
			action = action.substring(7);
			action = action.trim();
			compId= ""+request.getParameter("company");
			branchId= ""+request.getParameter("branch");
			compName= com.my.org.erp.common.CommonInfo.stringGetAnySelectField("Select CHR_COMPANYNAME from  com_m_company  where INT_COMPANYID="+compId, "CHR_COMPANYNAME");
			repName = "Company : "+compName;
			if(!branchId.equals("-1"))
			{
				sql="Select CHR_BRANCHNAME from  com_m_branch  where INT_BRANCHID="+branchId;
				branchName=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql,"CHR_BRANCHNAME");
				repName=repName+ " ~ Branch : "+branchName;
			}
			else				
				repName=repName+ " ~ Branch : All ";			
			if (action.equals("departList")) {
				String depid = request.getParameter("Department");				
				repName =repName+" Details - Department Wise";
				String viewType = request.getParameter("view");
				//System.out.println("View Type---------> :" + viewType);
				if (viewType.equalsIgnoreCase("Personal")) {
					repHeader = "Emp Id^Name^Father's Name^Depart^Desig^Gender^Martial Status^Wedding Date^Date of Birth^Blood Group";
					sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,A.CHR_STAFFFNAME,B.CHR_DEPARTNAME,C.CHR_DESIGNAME,A.CHR_GENDER,A.CHR_MartialSTATUS,A.DT_WEDDATE,A.DT_DOB,A.CHR_BG ";
					sql = sql + " FROM  com_m_staff  A,  com_m_depart   B, com_m_desig  C where A.INT_DEPARTID=B.INT_DEPARTID AND C.INT_DESIGID=A.INT_DESIGID AND ";
					if (depid.equals("-1"))
						sql = sql + " A.INT_DEPARTID IN (SELECT INT_DEPARTID FROM   com_m_depart  )";
					else
						sql = sql + " A.INT_DEPARTID=" + depid;
					sql=sql+" AND A.INT_COMPANYID="+compId;
					if(!branchId.equals("-1"))
						sql=sql+" AND A.INT_BRANCHID="+branchId;
					WriteFile(request, response, 10);
					response.sendRedirect(path + "ReportViewStaffInfo.jsp");
				} else if (viewType.equalsIgnoreCase("Offical")) {
					repHeader = "Emp Id^Name^Depart^Desig^Type^DateOfJoin^Salary^Gratutiy^PF^ESI";
					sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,D.CHR_DEPARTNAME,C.CHR_DESIGNAME,A.CHR_TYPE,";
					sql = sql
							+ "A.DT_DOJCOLLEGE,A.INT_SALARY,A.INT_GRATUITY,A.CHR_PF,A.CHR_ESI ";
					sql = sql
							+ "FROM  com_m_staff  A, com_m_desig  C,  com_m_depart   D ";
					sql = sql
							+ "WHERE A.INT_DEPARTID=D.INT_DEPARTID AND A.INT_DESIGID=C.INT_DESIGID AND ";
					if (depid.equals("-1"))
						sql = sql
								+ "A.INT_DEPARTID IN (SELECT INT_DEPARTID FROM   com_m_depart  )";
					else
						sql = sql + "A.INT_DEPARTID=" + depid;
					sql=sql+" AND A.INT_COMPANYID="+compId;
					if(!branchId.equals("-1"))
						sql=sql+" AND A.INT_BRANCHID="+branchId;
					//System.out.println("QUERY :" + sql);
					WriteFile(request, response, 10);
					response.sendRedirect(path + "ReportViewStaffOffical.jsp");
				}

			} else if (action.equals("desigList")) {
				String depid = request.getParameter("Designation");
				repName =repName+" Details - Designation Wise";
				String viewType = request.getParameter("view");
				if (viewType.equalsIgnoreCase("Personal")) {
					repHeader = "Emp Id^Name^Father's Name^Depart^Desig^Gender^Martial Status^Wedding Date^DOB^Blood Group";
					sql = "select A.CHR_EMPID,A.CHR_STAFFNAME,A.CHR_STAFFFNAME,B.CHR_DEPARTNAME,C.CHR_DESIGNAME,A.CHR_GENDER,A.CHR_MartialSTATUS,A.DT_WEDDATE,A.DT_DOB,A.CHR_BG ";
					sql = sql
							+ "FROM  com_m_staff  A,  com_m_depart   B, com_m_desig  C where A.INT_DEPARTID=B.INT_DEPARTID AND C.INT_DESIGID=A.INT_DESIGID AND ";
					if (depid.equals("-1"))
						sql = sql
								+ "A.INT_DESIGID IN (SELECT INT_DESIGID FROM  com_m_desig )";
					else
						sql = sql + "A.INT_DESIGID=" + depid;
					sql=sql+" AND A.INT_COMPANYID="+compId;
					if(!branchId.equals("-1"))
						sql=sql+" AND A.INT_BRANCHID="+branchId;
					WriteFile(request, response, 10);
					response.sendRedirect(path + "ReportViewStaffInfo.jsp");
				} else if (viewType.equalsIgnoreCase("Offical")) {
					repHeader = "Emp Id^Name^Depart^Desig^Type^DateOfJoin^Salary^Gratutiy^PF/ESI";
					sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,D.CHR_DEPARTNAME,C.CHR_DESIGNAME,A.CHR_TYPE,";
					sql = sql
							+ "A.DT_DOJCOLLEGE,A.INT_SALARY,A.INT_GRATUITY,A.CHR_PF,A.CHR_ESI ";
					sql = sql
							+ "FROM  com_m_staff  A, com_m_desig  C,  com_m_depart   D ";
					sql = sql
							+ "WHERE A.INT_DEPARTID=D.INT_DEPARTID AND A.INT_DESIGID=C.INT_DESIGID AND ";
					if (depid.equals("-1"))
						sql = sql+ "A.INT_DESIGID IN (SELECT INT_DESIGID FROM  com_m_desig )";
					else
						sql = sql + "A.INT_DESIGID=" + depid;
					sql=sql+" AND A.INT_COMPANYID="+compId;
					if(!branchId.equals("-1"))
						sql=sql+" AND A.INT_BRANCHID="+branchId;
					//System.out.println("sql :" + sql);
					WriteFile(request, response, 10);
					response.sendRedirect(path + "ReportViewStaffOffical.jsp");
				}
			} else if (action.equals("ondutyList")) {				
				String viewType = request.getParameter("view");				
				if (viewType.equalsIgnoreCase("datewise")) {
					repName =repName+" OnDuty -Date Wise";
					String fdate = request.getParameter("fromdt");
					String tdate = request.getParameter("todt");
					String date1[] = fdate.split("-");
					String date2[] = tdate.split("-");
					String fd = date1[0];
					String fm = date1[1];
					String fy = date1[2];
					fdate = fy + "-" + fm + "-" + fd;
					String td = date2[0];
					String tm = date2[1];
					String ty = date2[2];
					tdate = ty + "-" + tm + "-" + td;
					repHeader = "Emp Id^Name^Date^Place^Reason^Authorised";
					sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.DT_ODDATE,B.CHR_PLACE,B.CHR_REASON,B.CHR_AUTHNAME FROM  com_m_staff  A,ATT_T_ONDUTY B WHERE B.DT_ODDATE>='"
							+ fdate
							+ "' and B.DT_ODDATE<='"
							+ tdate
							+ "' and A.CHR_EMPID=B.CHR_EMPID ";
					sql=sql+" AND A.INT_COMPANYID="+compId;
					if(!branchId.equals("-1"))
						sql=sql+" AND A.INT_BRANCHID="+branchId;
					//System.out.println("In Onduty Query <---------> :" + sql); 				
					
					WriteFile(request, response, 6);					
				} 
				else if (viewType.equalsIgnoreCase("monthwise")) {
					repName =repName+" OnDuty -Month  Wise";
					String mth = request.getParameter("Month");
					mth = com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(mth));
					
					int yr = Integer.parseInt(request.getParameter("Year"));
					repHeader = "Emp Id^Name^Date^Place^Reason^Authorised";
					sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.DT_ODDATE,B.CHR_PLACE,B.CHR_REASON,B.CHR_AUTHNAME FROM  com_m_staff  A,ATT_T_ONDUTY B WHERE ";
					sql = sql + "A.CHR_EMPID=B.CHR_EMPID and B.CHR_MONTH='"
							+ mth + "'";
					sql = sql + "AND B.INT_YEAR=" + yr;					
					WriteFile(request, response, 6);
				}
				path=""+path;
				//System.out.println(" PATH "+path);
				response.sendRedirect(path + "ReportViewOnDuty.jsp");
			}
			else if (action.equals("ondutyStaffList"))
			{				
				HttpSession seesion=request.getSession();
				String sesUserId=""+seesion.getAttribute("USRID");
				sql = "SELECT * FROM M_USER WHERE CHR_USRNAME = '"+sesUserId+"'";
				String staff  = com.my.org.erp.bean.Attendance.StaffRegistration.getAnyValue2(sql,"CHR_USRDES");
				String viewType = request.getParameter("view");
				//System.out.println("View Type NNNN->>>>>>>>" + viewType);
				if (viewType.equalsIgnoreCase("datewise")) 
				{
					repName =repName+" OnDuty -Date Wise";
					String fdate = request.getParameter("fromdt");
					String tdate = request.getParameter("todt");
					String date1[] = fdate.split("-");
					String date2[] = tdate.split("-");
					String fd = date1[0];
					String fm = date1[1];
					String fy = date1[2];
					fdate = fy + "-" + fm + "-" + fd;
					String td = date2[0];
					String tm = date2[1];
					String ty = date2[2];
					tdate = ty + "-" + tm + "-" + td;
					repHeader = "Emp Id^Name^Date^Place^Reason^Authorised";
					sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.DT_ODDATE,B.CHR_PLACE,B.CHR_REASON,B.CHR_AUTHNAME FROM  com_m_staff  A,ATT_T_ONDUTY B WHERE B.DT_ODDATE>='"
							+ fdate
							+ "' and B.DT_ODDATE<='"
							+ tdate
							+ "' and A.CHR_EMPID=B.CHR_EMPID"
							+" and a.CHR_EMPID='"+staff+"'";
					WriteFile(request, response, 6);
				} 
				else if (viewType.equalsIgnoreCase("monthwise")) 
				{
					repName =repName+" OnDuty -Month  Wise";
					String mth = request.getParameter("month");
					//System.out.println("MONTH :"+mth);
					mth=com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(mth));
					int yr = Integer.parseInt(request.getParameter("year"));
					repHeader = "Emp Id^Name^Date^Place^Reason^Authorised";
					sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.DT_ODDATE,B.CHR_PLACE,B.CHR_REASON,B.CHR_AUTHNAME FROM  com_m_staff  A,ATT_T_ONDUTY B WHERE ";
					sql = sql + "A.CHR_EMPID=B.CHR_EMPID and B.CHR_MONTH='"
							+ mth + "'";
					sql = sql + "AND B.INT_YEAR=" + yr;
					sql=sql+" and a.CHR_EMPID='"+staff+"'";
					WriteFile(request, response, 6);
				}
				response.sendRedirect(path + "ReportViewOnDutyStaff.jsp");
			}
			else if (action.equals("leaveEntryList")) 
			{
				String viewType = request.getParameter("view");				
				//System.out.println("CONTROL FROM :: "+viewType);
				if (viewType.equalsIgnoreCase("datewise")) 
				{
					//System.out.println("Inside Datewise :::::::::::: ");
					repName =repName+" LEAVE ENTRY LIST -DATE WISE";
					String fdate = request.getParameter("fromdt");
					String tdate = request.getParameter("todt");
					fdate = com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fdate);
					tdate = com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(tdate);
					
					repHeader = "Emp Id^Name^From Date^To Date^Leave Type^";
     				sql="select a.CHR_EMPID,b.CHR_STAFFNAME ,min(a.DT_LDATE),max(a.DT_LDATE),c.CHR_LEAVENAME";
					sql=sql+" from att_t_leave a ,  com_m_staff  b ,att_m_leavetype c";
					sql=sql+" where A.DT_LDATE>='"+fdate+"' AND A.DT_LDATE<='"+tdate+"' AND a.CHR_EMPID = b.CHR_EMPID";
					sql=sql+" and c.CHR_SYMBOL = a.CHR_LEAVETYPE";
					sql=sql+" AND B.INT_COMPANYID="+compId;
                    	 if(!branchId.equals("-1"))
						sql=sql+" AND b.INT_BRANCHID="+branchId;					 
					sql=sql+" group by  a.INT_LEAVEID ORDER BY A.CHR_EMPID";
					
					//System.out.println("SQL <<<---------------In Leave Datewise: "+sql);
					Statement st = con.createStatement();
					ResultSet rs1 = st.executeQuery(sql);
					String s = "";
					int rcount=0;
					while(rs1.next())
					{
						for(int y=1;y<=5;y++)
						s = s +" " +rs1.getString(y) +"^";
						s = s +"^\n";
						rcount=rcount+1;
					}
					if(rcount <1)
						s = s +"Record not found...";		
					String filename = "Report.sys";
					String fline="";
					FileWriter fw = new FileWriter(filename);
					BufferedWriter bw = new BufferedWriter(fw);
					fline = fline + repName + "\n";
					fline = fline + repHeader + "\n";
					fline = fline + s;
					bw.write(fline);
					bw.close();
				}     
				
				else if (viewType.equalsIgnoreCase("monthwise")) 
				{
					repName =repName+" LEAVE ENTRY LIST -MONTH WISE";
					String month = request.getParameter("Month");
					//System.out.println("CONTROL FROM ::" + repName);
					year = Integer.parseInt(request.getParameter("Year"));
					int mon = Integer.parseInt(month);
					totdays = totalDays(mon, year);
					String fdate = "01-" + month + "-" + year;
					String tdate = totdays + "-" + month + "-" + year;
					fdate = FormateDateSQL(fdate);
					tdate = FormateDateSQL(tdate);
					repHeader = "Emp Id^Name^From Date^To Date^Leave Type";
					repHeader = "Emp Id^Name^From Date^To Date^Leave Type^";
     				sql="select a.CHR_EMPID,b.CHR_STAFFNAME ,min(a.DT_LDATE),max(a.DT_LDATE),c.CHR_LEAVENAME";
					sql=sql+" from att_t_leave a ,  com_m_staff  b ,att_m_leavetype c";
					sql=sql+" where A.DT_LDATE>='"+fdate+"' AND A.DT_LDATE<='"+tdate+"' AND a.CHR_EMPID = b.CHR_EMPID";
					sql=sql+" and c.CHR_SYMBOL = a.CHR_LEAVETYPE";
					sql=sql+" AND B.INT_COMPANYID="+compId;
                    	 if(!branchId.equals("-1"))
						sql=sql+" AND b.INT_BRANCHID="+branchId;					 
					sql=sql+" group by  a.INT_LEAVEID ORDER BY A.CHR_EMPID";
					
					//System.out.println("SQL <<<---------------In Leave Datewise: "+sql);
					Statement st = con.createStatement();
					ResultSet rs1 = st.executeQuery(sql);
					String s = "";
					int rcount=0;
					while(rs1.next())
					{
						for(int y=1;y<=5;y++)
						s = s +" " +rs1.getString(y) +"^";
						s = s +"^\n";
						rcount=rcount+1;
					}
					if(rcount <1)
						s = s +"Record not found...";		
					String filename = "Report.sys";
					String fline="";
					FileWriter fw = new FileWriter(filename);
					BufferedWriter bw = new BufferedWriter(fw);
					fline = fline + repName + "\n";
					fline = fline + repHeader + "\n";
					fline = fline + s;
					bw.write(fline);
					bw.close();
				}
				response.sendRedirect(path + "ReportViewLeave.jsp");
			}
			//=========
			else if (action.equals("leaveTypeReport")) 
			{
				String fline="";
				Statement st=con.createStatement();
				String compId=request.getParameter("company");
				String branchId=request.getParameter("branch");
				String ltype=request.getParameter("leave");
				String dept=request.getParameter("Department");
				String month=request.getParameter("Month");
				String year=request.getParameter("Year");
				
				String fDate="01-"+month+"-"+year;
				String tDate="31-"+month+"-"+year;
				String fromDate=FormatDateSQL(fDate);
				String toDate=FormatDateSQL(tDate);											
				
				repName=repName+" "+dept+ "Absent Details";
				repHeader = "Emp Id^Name^Department^Leave Type^From Date";
				fline="";
				fline=fline+repName+"\n";
				fline=fline+repHeader+"\n";
				
				sql="SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_DEPARTNAME,D.CHR_LEAVENAME," +
				"min(c.DT_LDATE),max(C.DT_LDATE) ";
				sql=sql+" FROM  com_m_staff  A,  com_m_depart   B,ATT_T_LEAVE C,att_m_leavetype D "; 
				sql=sql+" WHERE A.CHR_EMPID=C.CHR_EMPID AND A.INT_DEPARTID=B.INT_DEPARTID AND ";
				sql = sql + " A.INT_COMPANYID="+compId;
				if(!branchId.equals("-1"))
					sql=sql+" AND A.INT_BRANCHID="+branchId;
				if(!dept.equals("-1"))
					sql=sql+" AND A.INT_DEPARTID="+dept;
				if(!ltype.equals("-1"))
					sql=sql+" AND C.CHR_LEAVETYPE='"+ltype+"'";
				sql=sql+" AND C.DT_LDATE>='"+fromDate+"' AND C.DT_LDATE<='"+toDate+"'";
				sql=sql+" group by  C.INT_LEAVEID ORDER BY A.CHR_EMPID"; 
			    rs=st.executeQuery(sql); 					
				int rcount=0;				
				while(rs.next())
				{
					for(int y=1;y<=6;y++)
					fline = fline +" " +rs.getString(y) +"^";
					fline = fline +"^\n";
					rcount=rcount+1;
				}
				if(rcount <1)
					fline = fline +"Record not found...";					
				
				String filename="LeaveReport.txt";			
				FileWriter fws = new FileWriter(filename);
				BufferedWriter bws = new BufferedWriter(fws);					
				bws.write(fline);
				bws.close();
				response.sendRedirect(path + "ReportLeaveType.jsp");	
			}
			else if (action.equals("TotalReport")) 
			{
				
				@SuppressWarnings("unused")
				Statement st=con.createStatement();
				String compId=request.getParameter("company");
				String branchId=request.getParameter("branch");
				String sql="";
				
				String CName[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_COMPANYNAME From  com_m_company  WHERE INT_COMPANYID ="+Integer.parseInt(compId));
				String cpyname="";
				String branch="";
				cpyname=CName[0][0];
				
				if(!"-1".equals(branchId))
				{
					String BName[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_BRANCHNAME From  com_m_branch  WHERE INT_COMPANYID ="+Integer.parseInt(compId)+" AND INT_BRANCHID ="+Integer.parseInt(branchId));
					branch= BName[0][0];
				}
				else
					branch ="ALL BRANCH" ;
				
				String fline="";
				repName="";
				repHeader="";
				fline=fline+repName+" Total Leave Details \n";
				fline=fline+repHeader+cpyname+"  "+branch+" \n";
				
				sql="SELECT count(*) From att_m_leavetype ";
				String leaveName[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_SYMBOL,CHR_LEAVENAME From att_m_leavetype   ORDER BY INT_LEAVEID");
				int rcount=com.my.org.erp.common.CommonInfo.intRecordCount(sql);
				String fields= "SELECT CHR_EMPID ,";
				for(int u=1;u<=rcount; u++)
					fields = fields +"CHR_LEAVE"+u+" , " +"INT_NOD"+u+" , "+"INT_NOD"+u+"BALANCE"+" , ";
				
				fields = fields.substring(0,fields.trim().length()-1);
				fields = fields+" FROM att_m_leave";
				String leaveData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(fields);
				int ccount = com.my.org.erp.common.CommonInfo.intGetColumnCount(fields);
				for(int u=0; u<leaveData.length;u++)
				{
					int v=1;
					for(int i=0;i<ccount; i++)
					{	
						if(v==i)
						{
							for(int y=0; y<leaveName.length;y++)
							{
								if (leaveName[y][0].trim().equals(leaveData[u][i].trim()))
									fline = fline +leaveName[y][1]+" ^ ";
								
							}
							v=v+3;
						}
						else
							fline = fline +leaveData[u][i]+" ^ ";
						
					}	
					fline = fline+" \n";
				}
				
				if(leaveData.length<1)
					fline = fline +"Record not found...";
				
				String filename="Total.sys";			
				FileWriter fws = new FileWriter(filename);
				BufferedWriter bws = new BufferedWriter(fws);					
				bws.write(fline);
				bws.close();
				response.sendRedirect(path + "ReportTotal.jsp");	
			}
	    				
		}
	catch (Exception e) {
			 System.out.println(e.getMessage());
			response.sendRedirect("error/index.jsp?error="
					+ e.getLocalizedMessage().toString());
		}
	}
}
