package com.my.org.erp.bean;

 
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.common.CommonFunctions;

import DBConnection.DBCon;

@WebServlet("/autocomplete")
public class AutocompleteServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private ServletContext context;

	private ArrayList<EmployeeBean> employees = new ArrayList<EmployeeBean>();

	private HashMap<String, Department> department = new HashMap<String, Department>();

	private HashMap<String, Designation> desgnation = new HashMap<String, Designation>();
	HttpSession session  ;
	String branch="";
	String bran="";
	private int i = 1;
	String path="";
	public void init(ServletConfig config) throws ServletException {
		this.context = config.getServletContext();
		try {
			
			DBCon conbean = new DBCon();
			Connection con = null;
			PreparedStatement pst = null;
			ResultSet rs = null;
			con = conbean.getConnection();
			branch =""+session.getAttribute("BRANCHID");
			String usertype=""+session.getAttribute("USRTYPE");
			String f="";
			if(!"F".equals(usertype))
				f=" AND INT_BRANCHID= "+branch;
			else
				f="";
			f="";
			String ksql="";
			String orderdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_ORDERBY FROM m_institution WHERE INT_ID=1");
			if("I".equals(orderdata[0][0]))
				ksql=" ORDER BY CHR_EMPID ";
			else
				ksql=" ORDER BY CHR_STAFFNAME";

			
			pst = con.prepareStatement("SELECT CHR_EMPID,CHR_STAFFNAME,INT_DESIGID,INT_DEPARTID FROM  com_m_staff WHERE CHR_TYPE<>'T' "+f+"   "+ksql);
			rs = pst.executeQuery();
			while (rs.next()) {
				String empid = rs.getString(1);
				String empname = rs.getString(2);
				EmployeeBean emp = new EmployeeBean();
				emp.setId(empid);
				emp.setFirstName(empname);
				emp.setDesId(rs.getString(3));
				emp.setDepId(rs.getString(4));
				employees.add(emp);
				i++;
			}
			rs.close();
			pst = con.prepareStatement("SELECT INT_DEPARTID,CHR_DEPARTNAME FROM   com_m_depart   ORDER BY INT_DEPARTID");
			rs = pst.executeQuery();
			while (rs.next()) {
				int id = rs.getInt(1);
				String name = rs.getString(2);
				department.put("" + i, new Department(id, name, ""));
				i++;
			}
			rs.close();
			pst = con.prepareStatement("SELECT INT_DESIGID,CHR_DESIGNAME FROM  com_m_desig  ORDER BY INT_DESIGID");
			rs = pst.executeQuery();
			while (rs.next()) {
				int id = rs.getInt(1);
				String name = rs.getString(2);
				desgnation.put("" + i, new Designation(id, name, ""));
				i++;
			}
			rs.close();
			pst.close();
			 
		} catch (Exception e) {
			//System.out.println(e);
		}
	}

	 
	public void doGet(HttpServletRequest request, HttpServletResponse response) 
	{
		try 
		{
			
			
			String action = request.getParameter("action");
			String targetId = request.getParameter("id");
			path=request.getParameter("path");
			session = request.getSession();
			StringBuffer sb = new StringBuffer();
			if (targetId != null)
				targetId = targetId.trim().toLowerCase();
			
			String orderby ="";
			String orderdata[][]=CommonFunctions.QueryExecute("SELECT CHR_ORDERBY FROM m_institution WHERE INT_ID=1");
			if("I".equals(orderdata[0][0]))
				orderby=" ORDER BY CHR_EMPID ";
			else if("D".equals(orderdata[0][0]))
				orderby=" ORDER BY RIGHT(CHR_EMPID,6) ";
			else 
				orderby=" ORDER BY CHR_STAFFNAME";
			
			boolean namesAdded = false;
			if ("complete".equals(action)) {
				int i=0;
				checkNewEmployee();
				while (i<employees.size()) {					
					EmployeeBean e = (EmployeeBean) employees.get(i);i++;
					// simple matching only for start of first or last name
					if ((e.getFirstName().toLowerCase().startsWith(targetId) || e
							.getId().startsWith(targetId))
							|| targetId.equals("")) {
						sb.append("<employee>");
						sb.append("<id>" + e.getId() + "</id>");
						sb.append("<firstName>" + e.getFirstName()
								+ "</firstName>");
						sb.append("</employee>");
						namesAdded = true;
					}
				}
				if (namesAdded) {
					response.setContentType("text/xml");
					response.setHeader("Cache-Control", "no-cache");
					response.getWriter().write(
							"<employees>" + sb.toString() + "</employees>");
				} else {
					// nothing to show
					response.setStatus(HttpServletResponse.SC_NO_CONTENT);
				}
			}
			if ("complete1".equals(action)) 
			{	
				String office=request.getParameter("office");
				String search=(""+request.getParameter("search")).trim();
				String dept=request.getParameter("dept");
				String Category=request.getParameter("Category");
				String Resigned =""+request.getParameter("Resigned");
				String filterData[][] =CommonFunctions.QueryExecute("SELECT CHR_OFFICELIST,CHR_GATEGORYLIST  FROM m_user WHERE CHR_USRNAME='"+session.getAttribute("USRID")+"'");
				String filteremployee = CommonFunctions.QueryExecute("SELECT CHR_SHOW_EMPLOYEE  FROM m_institution  WHERE INT_ID=1 ")[0][0];
				String sql="";
				sql=" SELECT CHR_EMPID,CHR_STAFFNAME  FROM  com_m_staff WHERE   CHR_HOLD!='Y' AND CHR_APPROVED ='Y' ";
				if(!"0".equals(filteremployee))
					sql = sql + " AND CHR_EMPLOYEE  = '"+filteremployee+"'  ";
				
				if(!"0".equals(dept))
					sql = sql + " AND INT_DEPARTID= "+dept;
				if(Resigned.equals("N"))
					sql = sql + " AND CHR_TYPE !='T'  ";
				if(!"0".equals(office))
					sql = sql + "   AND INT_OFFICEID= "+office;
				else
					sql = sql + "   AND INT_OFFICEID IN ( "+filterData[0][0]+",0 ) ";
				
				if(!"0".equals(Category))
					sql = sql + " AND CHR_CATEGORY= "+Category;
				else
					sql = sql + "   AND CHR_CATEGORY IN ( "+filterData[0][1]+",0 ) ";
				
				if(!"".equals(search))
					sql = sql + " AND( ( CHR_STAFFNAME LIKE '%"+search.trim()+"%' ) OR ( CHR_EMPID LIKE '%"+search.trim()+"%' )  )";
				sql = sql + orderby;
				
				//System.out.println(sql);
				 
				String data[][] = CommonFunctions.QueryExecute(sql);
				PrintWriter out = response.getWriter();
				out.println("<select name=\"ename\" id=\"ename\" multiple=\"multiple\" size=\"20\"  class=\"formText135\">");				
				if(data.length>0)
				{	
					for(int x=0; x<data.length;x++)
					{
						out.println("<option value='" + data[x][0] + "'>");
						if("I".equals(orderdata[0][0]))
							out.println("" + data[x][0] + "  /   "+ data[x][1]);
						else
							out.println("" + data[x][1] + "  /   "+ data[x][0]);
						out.println("</option>");
				 	}
				}
				else 
				{
					out.println("<option value='0'>");
					out.println("Staff not found...");
					out.println("</option>");
				}
				out.println("</select>");		
				
				//-------------------------------------------------------------------
			}
			else if ("complete10".equals(action)) 
			{	
				String office=request.getParameter("office");
				targetId=(""+request.getParameter("id")).trim();
				String dept=request.getParameter("dept");
				String Resigned =""+request.getParameter("Resigned");
				String sql="";
				String f="";
				String deptid="";
				String resignstatus="";
				if(Resigned.equals("N"))
					resignstatus =" AND a.CHR_TYPE !='T'  ";
				if(!"0".equals(office))
					f=" AND a.INT_OFFICEID= "+office;
				else
					f=" ";
				if(!"0".equals(dept))
					deptid=" AND a.INT_DEPARTID= "+dept;
				else
					deptid=" ";
				if("".equals(targetId) || "null".equals(targetId))
					sql=" SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.INT_DESIGID,a.INT_DEPARTID FROM  com_m_staff a,conveyance_t_conveyance b WHERE a. CHR_HOLD!='Y' "+resignstatus+f+" "+deptid+" AND a.CHR_EMPID=b.CHR_EMPID AND b.CHR_ACCEPT='Y' AND b.CHR_ACCSTATUS='N' GROUP BY a.CHR_EMPID  " ;
				else
					sql=" SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.INT_DESIGID,a.INT_DEPARTID FROM  com_m_staff a,conveyance_t_conveyance b WHERE a.CHR_HOLD!='Y'  "+resignstatus+f+" "+deptid+"  AND a.CHR_STAFFNAME LIKE '"+targetId+"%' AND a.CHR_EMPID=b.CHR_EMPID AND b.CHR_ACCEPT='Y' AND b.CHR_ACCSTATUS='N' GROUP BY a.CHR_EMPID  " ;
				
				String data[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
				PrintWriter out = response.getWriter();
				out.println("<select name=\"ename\" id=\"ename\" multiple=\"multiple\" size=\"20\"  class=\"boldEleven\">");				
				if(data.length>0)
				{	
					for(int x=0; x<data.length;x++)
					{
						out.println("<option value=" + data[x][0] + " >");
						if("I".equals(orderdata[0][0]))
							out.println("" + data[x][0] + "  /   "+ data[x][1]);
						else
							out.println("" + data[x][1] + "  /   "+ data[x][0]);
						
						out.println("</option>");
				 	}
				}
				else 
				{
					out.println("<option value=0>");
					out.println("Staff not found...");
					out.println("</option>");
				}
				out.println("</select>");		
				
				//-------------------------------------------------------------------
			}
			else if ("complete2".equals(action))
				{				
					
					 
					PrintWriter out = response.getWriter();
					out.println("<select name='ename' id='ename' multiple='multiple' size='20'  class='boldEleven' >");
					int i=0;
					checkNewEmployee();
					while (i<employees.size()) 
					{					
						EmployeeBean e = (EmployeeBean) employees.get(i);i++;
						// simple matching only for start of first or last name
						if ((e.getFirstName().toLowerCase().startsWith(targetId) || e.getId().startsWith(targetId))	|| targetId.equals("")) 
						{
							out.println("<option value=" + e.getId() + ">");
							
							if("I".equals(orderdata[0][0]))
								out.println("" + e.getId() + "  /   "	+ e.getFirstName());
							else
								out.println("" + e.getFirstName() + "  /   "	+ e.getId());
							out.println("</option>");
						}
					}
					out.println("</select>");
				}					
			else if ("loadPrice".equals(action)) {				
				PrintWriter out = response.getWriter();
				//System.out.println("Target Id " + targetId);
				out
						.println("<select name='ename' id='ename' multiple='multiple' size='20'  class='boldEleven'>");
				int i=0;
				while (i<employees.size()) {					
					EmployeeBean e = (EmployeeBean) employees.get(i);i++;
					// simple matching only for start of first or last name
					if ((e.getFirstName().toLowerCase().startsWith(targetId) || e
							.getId().startsWith(targetId))
							|| targetId.equals("")) {
						out.println("<option value=" + e.getId() + ">");
						out.println("" + e.getFirstName() + "  /   "
								+ e.getId());
						out.println("</option>");
					}
				}
				out.println("</select>");
			}
			else //-------------------------------------------------------------------
			if (action.equals("Department")) 
			{
				Iterator it = department.keySet().iterator();
				StringBuffer sb1 = new StringBuffer();
				boolean namesAdded1 = false;
				while (it.hasNext()) {
					String id = (String) it.next();
					Department e = (Department) department.get(id);
					sb1.append("<department>");
					sb1.append("<id>" + e.getDepartId() + "</id>");
					sb1.append("<valName>" + e.getDepartName() + "</valName>");
					sb1.append("</department>");
					namesAdded1 = true;
				}
				if (namesAdded1) {
					response.setContentType("text/xml");
					response.setHeader("Cache-Control", "no-cache");
					response.getWriter()
							.write(
									"<departments>" + sb1.toString()
											+ "</departments>");
				} else {
					// nothing to show
					response.setStatus(HttpServletResponse.SC_NO_CONTENT);
				}
			}			
			//------------------------------------------------------------------
			else
			if (action.equals("basic")){
				String staffid=request.getParameter("id");
				String sql="SELECT INT_BASIC FROM  com_m_staff  WHERE CHR_EMPID='"+staffid+"'";
				String readData[][] = CommonFunctions.QueryExecute(sql);
				StringBuffer sb1 = new StringBuffer(); 
				
    	     	if(readData.length >0)
    	     	{	
    	     		for(int u=0; u<readData.length;u++)
    	     		{
    	     			sb1.append("<Basic>");    	     		
	     				sb1.append("<basicPay>"+readData[u][0]+"</basicPay>");
	     				sb1.append("</Basic>");    
    	     		}
    	     	}
    	     	
	     		response.setContentType("text/xml");
	     		response.setHeader("Cache-Control", "no-cache");
	     		response.getWriter().write("<basics>" + sb1.toString() + "</basics>");	     		     		 
			} 					
			else if (action.equals("Designation")) 
			{
				Iterator it = desgnation.keySet().iterator();
				StringBuffer sb1 = new StringBuffer();
				boolean namesAdded1 = false;
				while (it.hasNext()) 
				{
					String id = (String) it.next();
					Designation e = (Designation) desgnation.get(id);
					sb1.append("<designation>");
					sb1.append("<id>" + e.getDesigId() + "</id>");
					sb1.append("<valName>" + e.getDesigName() + "</valName>");
					sb1.append("</designation>");
					namesAdded1 = true;
				}
				if (namesAdded1) 
				{
					response.setContentType("text/xml");
					response.setHeader("Cache-Control", "no-cache");
					response.getWriter().write(	"<designations>" + sb1.toString()+ "</designations>");
				} 
				else 
				{
					// nothing to show
					response.setStatus(HttpServletResponse.SC_NO_CONTENT);
				}
			}
			else if (action.equals("StaffList")) 
			{
				String depId = request.getParameter("depId");
				String desId = request.getParameter("desId");
				String staffName = request.getParameter("staffName");
				if (staffName != null)
					staffName = staffName.trim().toLowerCase();
				else
					staffName = "";
				staffName = staffName.trim();
				boolean namesAdded1 = false;				
				StringBuffer sb1 = new StringBuffer();				
				int i=0;
				checkNewEmployee();
				while (i<employees.size()) 
				{					
					EmployeeBean e = (EmployeeBean) employees.get(i);i++;
					if ((staffName.equalsIgnoreCase("") && 
							(e.getDepId().equals(depId) || "-1".equals(depId)) && 
							(e.getDesId().equals(desId) || "-1".equals(desId)))
						|| ((e.getId().toLowerCase().startsWith(staffName) || 
							e.getFirstName().toLowerCase().startsWith(staffName)) && 
							(e.getDepId().equals(depId) || "-1".equals(depId)) && 
							(e.getDesId().equals(desId) || "-1".equals(desId)))						
						)
					{
						sb1.append("<StaffList>");
						sb1.append("<id>" + e.getId() + "</id>");
						sb1.append("<firstName>" + e.getFirstName() + " / "
								+ e.getId() + "</firstName>");
						sb1.append("</StaffList>");
						namesAdded1 = true;
					}
				}
				////System.out.println("True :" + namesAdded1);
				if (namesAdded1) {					
					response.setContentType("text/xml");
					response.setHeader("Cache-Control", "no-cache");
					response.getWriter().write(
							"<StaffLists>" + sb1.toString() + "</StaffLists>");
				}else {
					// nothing to show
					response.setStatus(HttpServletResponse.SC_NO_CONTENT);
				}
			}else
			if ("valid".equals(action)) {
				
				boolean idExists = false;
				int i=0;
				checkNewEmployee();
				while (i<employees.size()) {					
					EmployeeBean e = (EmployeeBean) employees.get(i);i++;
					if (e.getId().startsWith(targetId) && !targetId.equals("")) {
						idExists = true;
					}
				}
				if (idExists) {
					response.setContentType("text/xml");
					response.setHeader("Cache-Control", "no-cache");
					response.getWriter().write("<valid>true</valid>");
				} else {
					response.setContentType("text/xml");
					response.setHeader("Cache-Control", "no-cache");
					response.getWriter().write("<valid>false</valid>");
				}
			}
			else
			if ("advancevalid".equals(action)) {			
				checkAdvanceId(request,response,targetId);
			}
			else if ("adddata".equals(action)) 
			{
				String empname = request.getParameter("name");
				employees.add(new EmployeeBean(targetId, empname, ""));
				i++;
				String filepath = request.getParameter("filepath");
				filepath =filepath.replace("kalai", "&");
				response.sendRedirect(filepath);
			}
			else if ("lookupbyname".equals(action)) {				
				ArrayList<EmployeeBean> names = new ArrayList<EmployeeBean>();
				int i=0;
				while (i<employees.size()) {					
					EmployeeBean e = (EmployeeBean) employees.get(i);i++;
					// simple matching only for start of first or last name
					if (e.getFirstName().toLowerCase().startsWith(targetId)) {
						names.add(e);
					}
				}
				if (names.size() > 0) {
					request.setAttribute("employees", names);
				}
				context.getRequestDispatcher("/jsp/employees.jsp").forward(request, response);
			}
		} catch (Exception e) {
			//System.out.println("Error " + e.getMessage());
		}
	}

	private void checkNewEmployee() throws Exception { //For Adding New Employee...
		branch =""+session.getAttribute("BRANCHID");
		//String f="";
		String sql="";
		//String usertype=""+session.getAttribute("USRTYPE");
		/*if(!"F".equals(usertype))
		{
			f=" AND INT_BRANCHID ="+branch;
			sql = "select count(*) from com_m_staff WHERE INT_BRANCHID= "+branch;
		}	
		else
		{
			f="";
			sql = "select count(*) from com_m_staff ";
		}*/	
		sql = "select count(*) from com_m_staff WHERE INT_BRANCHID= "+bran;
		String strSize[][]=CommonFunctions.QueryExecute(sql);
		
		int rsSize=Integer.parseInt(strSize[0][0]);
		if(rsSize>employees.size()){			
			DBCon conbean = new DBCon();
			Connection con = null;
			PreparedStatement pst = null;
			ResultSet rs = null;
			
			con = conbean.getConnection();
			sql=" SELECT CHR_EMPID,CHR_STAFFNAME,INT_DESIGID,INT_DEPARTID FROM  com_m_staff WHERE  CHR_TYPE !='T' AND INT_BRANCHID= "+bran+"  ORDER BY CHR_STAFFNAME";
			//System.out.println(sql);
			pst = con.prepareStatement(sql);
			rs = pst.executeQuery();
			employees.clear();
			while (rs.next()) {
				String empid = rs.getString(1);
				String empname = rs.getString(2);
				EmployeeBean emp = new EmployeeBean();
				emp.setId(empid);
				emp.setFirstName(empname);
				emp.setDesId(rs.getString(3));
				emp.setDepId(rs.getString(4));
				employees.add(emp);
				i++;
			}
			rs.close();
		}
	}
	
	private void checkAdvanceId(HttpServletRequest request, HttpServletResponse response, String targetId) throws Exception {
		boolean idExists = false;		
		DBCon conbean = new DBCon();
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		con = conbean.getConnection();
		pst = con.prepareStatement("SELECT CHR_ADVID FROM pay_m_advance WHERE CHR_ADVID='"+targetId+"'");
		
		rs = pst.executeQuery();
		if(rs.next()) {
			idExists=true;
			//System.out.println("EXITS : "+targetId);
		}
		rs.close();
		if (idExists) {
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<valid>true</valid>");
		} else {
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<valid>false</valid>");
		}
	}

}
