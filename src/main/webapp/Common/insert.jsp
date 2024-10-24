
<%
	String path = request.getParameter("path");
	String qp = request.getParameter("qp");
	String file="";
	String closefile="";
	
	if("MKT".equals(qp) || "MKT".equals(path))
	{
		file = "../Smart Marketing/Index_Marketing.jsp";
		closefile="../Smart Marketing/MarketingMain.jsp";
		
	}
	if("ATT".equals(qp) ||"ATT".equals(path))
	{
		file = "../Smart Attendance/index.jsp";
		closefile="../Smart Attendance/AttendanceMain.jsp";
	}
	if("MGT".equals(qp) ||"MGT".equals(path))
	{
		file = "../Smart Management/index.jsp";
		closefile="../Smart Management/ManagementMain.jsp";
	}
	if("PAY".equals(qp) ||"PAY".equals(path))
	{
		file = "../Smart Payroll/index.jsp";
		closefile="../Smart Payroll/Payrollmain.jsp";
	}
	if("INV".equals(qp) ||"INV".equals(path))
	{
		file = "../Smart Inventory/indexinv.jsp";
		closefile="../Smart Inventory/InventoryMain.jsp";
	}
	RequestDispatcher dispatcher = request.getRequestDispatcher(file);
    dispatcher.include(request, response); 
%>
