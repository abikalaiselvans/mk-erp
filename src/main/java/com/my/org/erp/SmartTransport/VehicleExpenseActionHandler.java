package com.my.org.erp.SmartTransport;
import java.io.IOException;
 
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 
public class VehicleExpenseActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{		
		try
		{
				String action=""+request.getParameter("actionS").trim();
				HttpSession session=request.getSession();			
				String user = session.getAttribute("USRID").toString();
				 
				Statement st = con.createStatement();
				String sql="";
				if("TRSVehicleExpenseAdd".equals(action))
				{
					
					
					String saleDate = request.getParameter("saleDate");
					saleDate= com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(saleDate);
					
					String memo = request.getParameter("memo");
					String param[] = request.getParameter("param").split(",");
					String vehileno="";
					for(int u=0;u<param.length;u++)
						vehileno=vehileno+request.getParameter("vehileno"+param[u])+",";
					
					String salary="";
					for(int u=0;u<param.length;u++)
						salary=salary+request.getParameter("salary"+param[u])+",";
					
					String bata="";
					for(int u=0;u<param.length;u++)
						bata=bata+request.getParameter("bata"+param[u])+",";
					
					
					String otherdesc="";
					for(int u=0;u<param.length;u++)
						otherdesc=otherdesc+request.getParameter("otherdesc"+param[u])+",";
					
					
					String otheramount="";
					for(int u=0;u<param.length;u++)
						otheramount=otheramount+request.getParameter("otheramount"+param[u])+",";
					
					
					String total="";
					for(int u=0;u<param.length;u++)
						total=total+request.getParameter("total"+param[u])+",";
					
					
					String nettotal = request.getParameter("nettotal");
					
					
					sql = " INSERT INTO veh_t_expense  ( DAT_EXPENSEDATE,CHR_DESC,CHR_VEHICLEID," +
							"CHR_SALARY,CHR_BATA,CHR_OTHERDESC,CHR_OTHERAMOUNT,CHR_TOTAL,DOU_NETAMOUNT," +
							"CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS  )";
					sql = sql +"VALUES (";
					sql = sql+"'"+saleDate+"' ,";
					sql = sql+"'"+ memo+"',";
					sql = sql+"'"+vehileno+"' ,";
					sql = sql+"'"+salary+"' ,";
					sql = sql+"' "+bata+" ',  ";
					sql = sql+"'"+otherdesc+"' ,";
					sql = sql+"'"+otheramount+"' ,";
					sql = sql+"'"+total+"' ,";
					sql = sql+""+nettotal+" ,";
					sql = sql+"'"+user+"',now(),'Y' )";
					// System.out.println(request.getRealPath("/"),sql);
					st.execute(sql);
					 
					
					 
					response.sendRedirect("Smart Transport/VehicleExpense.jsp");
					 
					 
					
				}
				else if("TRSVehicleExpenseEdit".equals(action))
				{

					String id = request.getParameter("id");
					String saleDate = request.getParameter("saleDate");
					saleDate= com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(saleDate);
					
					String memo = request.getParameter("memo");
					String param[] = request.getParameter("param").split(",");
					String vehileno="";
					for(int u=0;u<param.length;u++)
						vehileno=vehileno+request.getParameter("vehileno"+param[u])+",";
					
					String salary="";
					for(int u=0;u<param.length;u++)
						salary=salary+request.getParameter("salary"+param[u])+",";
					
					String bata="";
					for(int u=0;u<param.length;u++)
						bata=bata+request.getParameter("bata"+param[u])+",";
					
					
					String otherdesc="";
					for(int u=0;u<param.length;u++)
						otherdesc=otherdesc+request.getParameter("otherdesc"+param[u])+",";
					
					
					String otheramount="";
					for(int u=0;u<param.length;u++)
						otheramount=otheramount+request.getParameter("otheramount"+param[u])+",";
					
					
					String total="";
					for(int u=0;u<param.length;u++)
						total=total+request.getParameter("total"+param[u])+",";
					
					
					String nettotal = request.getParameter("nettotal");
					
					
					sql = " UPDATE  veh_t_expense SET  ";
					sql = sql+" DAT_EXPENSEDATE = '"+saleDate+"' ,";
					sql = sql+" CHR_DESC = '"+ memo+"',";
					sql = sql+" CHR_VEHICLEID = '"+vehileno+"' ,";
					sql = sql+" CHR_SALARY = '"+salary+"' ,";
					sql = sql+" CHR_BATA = ' "+bata+" ',  ";
					sql = sql+" CHR_OTHERDESC = '"+otherdesc+"' ,";
					sql = sql+" CHR_OTHERAMOUNT = '"+otheramount+"' ,";
					sql = sql+" CHR_TOTAL = '"+total+"' ,";
					sql = sql+" DOU_NETAMOUNT = "+nettotal+" ,";
					sql = sql+" CHR_USRNAME = '"+user+"',DT_UPDATEDATE= now(),CHR_UPDATESTATUS='Y'  ";
					sql = sql +" WHERE INT_EXPENSEID= "+id+"  ";
					st.execute(sql);
					 
					response.sendRedirect("Smart Transport/VehicleExpense.jsp");
				}	
				else if("TRSVehicleExpenseDelete".equals(action))
				{
					String ids[] = request.getParameterValues("id");
					for(int u=0;u<ids.length;u++)
					{
						sql = " DELETE FROM veh_t_expense WHERE INT_EXPENSEID= "+ids[u]+"  ";
						st.execute(sql);
					}
					 
					response.sendRedirect("Smart Transport/VehicleExpense.jsp");
				}
				
				 
				 
				st.close();
						
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


