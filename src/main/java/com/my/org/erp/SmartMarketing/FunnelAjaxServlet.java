package com.my.org.erp.SmartMarketing;

import com.google.gson.Gson;
import com.my.org.erp.SmartAutocompleteServlet.Funnel;
import com.my.org.erp.bean.SmartMarketing.MyDailyCall;
import com.my.org.erp.bean.SmartMarketing.MyFunnel;
import com.my.org.erp.common.CommonFunctions;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/FunnelAjax")
public class FunnelAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("actionS");
		String searchText = request.getParameter("query");
		String sql = "";
		if("Loadfunnelinfos".equals(action) )
		 {
			String actions=request.getParameter("day");
    		String day=request.getParameter("day");
    		String month=request.getParameter("month");
    		String year=request.getParameter("year");
    		String search=request.getParameter("search");
    		String status=request.getParameter("status");
    		
    		String me=request.getParameter("me");
    		System.out.println(search);
    		
    		HttpSession session = request.getSession();
			String usertype  = (""+session.getAttribute("USERTYPE")).toUpperCase();
			String empid [] = CommonFunctions.getReportingEmployeeIds(""+session.getAttribute("EMPID"));
			String empids ="'"+session.getAttribute("EMPID")+"', ";
			if(empid.length>0)
				for(int i=0;i<empid.length;i++)
					empids = empids +" '"+empid[i]+"' , ";
					
			 
			sql =  " SELECT INT_FUNNELID, FIND_A_EMPLOYEE_NAME_ONLY(CHR_EMPID), CHR_CLIENT_NAME, CHR_LOCATION, CHR_ACCOUNTTYPE, CHR_VERTICAL, CHR_LOB_TYPE, CHR_OEM, DATE_FORMAT(DT_APPR_CLOSURE,'%d-%M-%Y') ,CHR_WINNING,";
			sql = sql + " INT_UNITVALUE, INT_QTY, DOU_TOTAL_VALUE, DOU_BOTTOM_VALUE, CHR_STAGE, CHR_SATUS, CHR_REMARK, DATE_FORMAT(DT_ENTRY,'%d-%M-%Y'), "; 
			sql = sql + " DT_UPDATEDATE  from mkt_t_funnel   WHERE INT_FUNNELID >0  ";
			 
			if(!"0".equals(day))
				sql = sql + " AND DAY(DT_ENTRY) = "+day;
			if(!"0".equals(month))
				sql = sql + " AND MONTH(DT_ENTRY) = "+month;
			if(!"0".equals(year))
				sql = sql + " AND YEAR(DT_ENTRY) = "+year;
			if(!"0".equals(status))
				sql = sql + " AND CHR_SATUS = '"+status +"' ";
			
			if(!"F".equals(""+session.getAttribute("USRTYPE")) )
				sql = sql + " AND  CHR_EMPID IN ("+empids+" '') ";
			 
			if(!"0".equals(search) || search.length()>2) // 
				sql = sql + " AND CHR_CLIENT_NAME LIKE '"+search+"%' " ;
			
 	 		sql = sql +" ORDER BY DT_ENTRY DESC ";
 	 		System.out.println(sql);
 	 		
 	 		String jsondata = getFunnelJsonObject(sql);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(jsondata);
		 }
		else if("LoadMyDailyCall".equals(action))
		{
			String actions=request.getParameter("day");
    		String day=request.getParameter("day");
    		String month=request.getParameter("month");
    		String year=request.getParameter("year");
    		String search=request.getParameter("search");
    		String status=request.getParameter("status");
    		String me=request.getParameter("me");
    		System.out.println("Search:"+search);
    		 
    		HttpSession session = request.getSession();
			String usertype  = (""+session.getAttribute("USERTYPE")).toUpperCase();
			String empid [] = CommonFunctions.getReportingEmployeeIds(""+session.getAttribute("EMPID"));
			String empids ="'"+session.getAttribute("EMPID")+"', ";
			if(empid.length>0)
				for(int i=0;i<empid.length;i++)
					empids = empids +" '"+empid[i]+"' , ";
			  
			sql = sql + " SELECT a.INT_CALLID, FIND_A_EMPLOYEE_NAME_ONLY(a.CHR_EMPID),FIND_A_MKT_CUSTOMER_NAME_ONLY(a.INT_CUSTOMERNAMEID), a.CHR_LOCATION, a.CHR_CONTACTPERSON, a.CHR_DESIGNATION, a.INT_CONTACTNUMBER,  ";
			sql = sql + " a.CHR_TYPEOFCALL,   DATE_FORMAT(a.DT_ENTRY,'%d-%m-%Y'), a.CHR_DESCRIPTION,   DATE_FORMAT(a.DT_FOLLOWUP,'%d-%m-%Y'), a.CHR_STATUS , a.CHR_CLIENT_NAME ";
			sql = sql + "  from mkt_t_mydailycall  a  WHERE   a.INT_CALLID >0 ";  
			 
			if(!"0".equals(day))
				sql = sql + " AND DAY(a.DT_ENTRY) = "+day;
			if(!"0".equals(month))
				sql = sql + " AND MONTH(a.DT_ENTRY) = "+month;
			if(!"0".equals(year))
				sql = sql + " AND YEAR(a.DT_ENTRY) = "+year;
			if(!"0".equals(status))
				sql = sql + " AND a.CHR_TYPEOFCALL = '"+status +"' ";
			
			if(!"F".equals(""+session.getAttribute("USRTYPE")) )
				sql = sql + " AND  a.CHR_EMPID IN ("+empids+" '') ";
			 
			if(!"0".equals(search)  || !"".equals(search) )  
				sql = sql + " AND ( ( FIND_A_MKT_CUSTOMER_NAME_ONLY(a.INT_CUSTOMERNAMEID) LIKE '"+search+"%')  OR  (a.CHR_CLIENT_NAME LIKE '"+search+"%' ) )" ;
			
 	 		sql = sql +" ORDER BY a.DT_ENTRY DESC ";
 	 		System.out.println(sql);
 	 		
 	 		String jsondata = getMyDailyCallObject(sql);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(jsondata);
		 
			
		}
		 else
			response.setStatus(HttpServletResponse.SC_NO_CONTENT);

	} 


	
	 static String getMyDailyCallObject(String sql) {
			String data[][] = CommonFunctions.QueryExecute(sql);
			List<MyDailyCall> listdata = new ArrayList<MyDailyCall>();
			if (data.length > 0) {
				for (int i = 0; i < data.length; i++) {
					MyDailyCall n = new MyDailyCall();
					n.setRowid(data[i][0]); 
					n.setMename(data[i][1]);
					n.setClientname(data[i][2] +"/" + data[i][12]);
					n.setLocation(data[i][3]);
					n.setContactperson(data[i][4]);
					n.setDesignation(data[i][5]);
					n.setContactnumber(data[i][6]);
					n.setTypeofcall(data[i][7]);
					n.setEntrydate(data[i][8]);
					n.setDescription(data[i][9]);
					n.setNextfollowdate(data[i][10]);
					n.setStatus(data[i][11]);
					listdata.add(n);
					 
				}
			}
			System.out.println("Record size:"+listdata.size());
			Gson gson = new Gson();
			String jsondata = gson.toJson(listdata);
			return jsondata;
		}
	 
	 static String getFunnelJsonObject(String sql) {
			String data[][] = CommonFunctions.QueryExecute(sql);
			List<MyFunnel> listdata = new ArrayList<MyFunnel>();
			if (data.length > 0) {
				for (int i = 0; i < data.length; i++) {
					MyFunnel n = new MyFunnel();
					n.setRowid(data[i][0]);
					n.setMename(data[i][1]);
					n.setClientname(data[i][2]);
					n.setLocation(data[i][3]);
					n.setAccouttype(data[i][4]);
					n.setVertical(data[i][5]);
					n.setLob(data[i][6]);
					n.setOem(data[i][7]);
					n.setApproxclosure(data[i][8]);
					n.setProbabilitywinning(data[i][9]);
					n.setUnitvalue(Double.parseDouble(data[i][10]));
					n.setQty(Integer.parseInt(data[i][11]));
					n.setTotalvalue(Double.parseDouble(data[i][12]));
					n.setBottomlinevalue(Double.parseDouble(data[i][13]));
					n.setStage(data[i][14]);
					n.setStatus(data[i][15]);
					n.setRemarks(data[i][16]);
					n.setEntrydate(data[i][17]);
					listdata.add(n);
					 
				}
			}
			System.out.println("Record size:"+listdata.size());
			Gson gson = new Gson();
			String jsondata = gson.toJson(listdata);
			return jsondata;
		}


}
