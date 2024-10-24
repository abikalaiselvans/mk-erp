package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

import com.my.org.erp.bean.inventory.*;
public class BudgetAssignActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{		
		try
		{
				String action=""+request.getParameter("actionS").trim();
				HttpSession session=request.getSession();			
				String userid=""+session.getAttribute("USRID");
				
				Statement st = con.createStatement();
				String sql="";
				if("INVBudgetAssign".equals(action))
				{
					String amount =request.getParameter("amount");
					String access =request.getParameter("select");
					String year =request.getParameter("year");
					String dept = request.getParameter("dept");
				 	sql = "SELECT COUNT(*) FROM inv_t_budgetassign " +
				 			"WHERE INT_DEPARTID="+dept+" AND INT_YEAR="+year+" AND INT_GROUPID="+access;
					if(!com.my.org.erp.common.CommonFunctions.RecordExist(con, sql))
					{	
						sql = " INSERT INTO inv_t_budgetassign (INT_DEPARTID,INT_GROUPID,INT_YEAR,DOU_AMOUNT,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ) VALUES ";
						sql = sql +" ( ";
						sql = sql +" "+dept+" , ";
						sql = sql +" "+access+" , ";
						sql = sql +"  "+year+" , ";
						sql = sql +"  "+amount+" , ";
						sql = sql +" '"+userid+"' ,NOW(),'Y' ";
						sql = sql +" ) ";
						st.execute(sql);
					}	
					 
					st.close();
					con.close();    
					response.sendRedirect("Smart Inventory/BudgetAssign.jsp");
				}
				else if("INVBudgetAssignDELETE".equals(action))
				{
					String targetrow[] = request.getParameterValues("id");
					for(int u=0;u<targetrow.length;u++)
					{
						sql=" DELETE FROM inv_t_budgetassign WHERE INT_TARGETID="+targetrow[u];
						st.execute(sql);
					}
					con.close();    
					response.sendRedirect("Smart Inventory/BudgetAssign.jsp");
				}
				else if("INVBudgetAssignEdit".equals(action))
				{
					String id = request.getParameter("id");
					String amount =request.getParameter("amount");
					String access =request.getParameter("select");
					String year =request.getParameter("year");
					String dept = request.getParameter("dept");
					 
					sql= " UPDATE  inv_t_budgetassign SET INT_DEPARTID= "+dept+" ,";
					sql = sql+"	INT_GROUPID = "+access+" ,";
					sql = sql+"	INT_YEAR = "+year+" ,";
					sql = sql+"	DOU_AMOUNT = "+amount+"  ";
					sql = sql+"	WHERE  INT_TARGETID="+id;
					st.execute(sql);
					
					con.close();    
					response.sendRedirect("Smart Inventory/BudgetAssign.jsp");
				}
				else if("INVTargetAssignReport".equals(action))
				{
					ArrayList<TargetAchieveBeanList> rept=new ArrayList<TargetAchieveBeanList>();				
					//INT_TARGETID	CHR_EMPID	INT_YEAR	INT_APR	INT_MAY	INT_JUN	INT_JUL	INT_AUG	INT_SEP	INT_OCT	INT_NOV	INT_DEC	INT_JAN	INT_FEB	INT_MAR	CHR_USRNAME	DT_UPDATEDATE	CHR_UPDATESTATUS
					String period = request.getParameter("period");
					int year = Integer.parseInt(request.getParameter("year"));
					sql="";
					String type="";
					if("5".equals(period))
					{	
						type=" ALL ";
						sql=" SELECT a.CHR_EMPID,INT_APR,INT_MAY,INT_JUN,INT_JUL,INT_AUG,INT_SEP,INT_OCT,INT_NOV,INT_DEC,INT_JAN,INT_FEB,INT_MAR ,(INT_APR+INT_MAY+INT_JUN+INT_JUL+INT_AUG+INT_SEP+INT_OCT+INT_NOV+INT_DEC+INT_JAN+INT_FEB+INT_MAR),b.CHR_STAFFNAME";
						sql=sql+" FROM inv_t_targetassign a, com_m_staff b WHERE a.CHR_EMPID =b.CHR_EMPID AND INT_YEAR= "+year;
						String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						double salessum=0;
						for(int u=0;u<data.length;u++)
						{
							//This is for Direct Sales
							sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-04-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
							if(com.my.org.erp.common.CommonFunctions.RecordExist(con, sql))
							{	
								sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-04-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
								String salesdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								salessum = Double.parseDouble(salesdata[0][0]);
								TargetAchieveBeanList rep = new TargetAchieveBeanList();
								rep.setEmpid(data[u][0]);
								rep.setEmpname(data[u][14]);
								rep.setSalesamount(Math.round(salessum));
								rep.setTarget(Double.parseDouble(data[u][13]));
								rep.setAchieve(Math.round(salessum/100000));
								rept.add(rep);
							}
						}
						//request.setAttribute("rep", rept);
						session.setAttribute("rep",rept);
					}	
					else if("1".equals(period))
					{	
						type = "First Quarter";
						sql=" SELECT a.CHR_EMPID,INT_APR,INT_MAY,INT_JUN,(INT_APR+INT_MAY+INT_JUN),b.CHR_STAFFNAME FROM inv_t_targetassign a, com_m_staff b WHERE b.CHR_EMPID=a.CHR_EMPID AND INT_YEAR= "+year;
						String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						double salessum=0;
						for(int u=0;u<data.length;u++)
						{
							//This is for Direct Sales
							sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-04-01' AND DAT_SALESDATE <='"+(year)+"-06-31' AND CHR_PAYMENTSTATUS !='S'";
							if(com.my.org.erp.common.CommonFunctions.RecordExist(con, sql))
							{	
								sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-04-01' AND DAT_SALESDATE <='"+(year)+"-06-31' AND CHR_PAYMENTSTATUS !='S'";
								String salesdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								salessum = salessum+Double.parseDouble(salesdata[0][0]);
								TargetAchieveBeanList rep = new TargetAchieveBeanList();
								rep.setEmpid(data[u][0]);
								rep.setEmpname(data[u][5]);
								rep.setSalesamount(Math.round(salessum));
								rep.setTarget(Double.parseDouble(data[u][4]));
								rep.setAchieve(Math.round((salessum)/100000));
								rept.add(rep);
							}
						}
						session.setAttribute("rep",rept);
					}
					else if("2".equals(period))
					{	
						type= "Second Quarter";
						sql= "SELECT a.CHR_EMPID,INT_JUL,INT_AUG,INT_SEP,(INT_JUL+INT_AUG+INT_SEP),b.CHR_STAFFNAME FROM inv_t_targetassign a, com_m_staff b WHERE a.CHR_EMPID = b.CHR_EMPID AND INT_YEAR= "+year;
						String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						double salessum=0;
						for(int u=0;u<data.length;u++)
						{
							//This is for Direct Sales
							sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-07-01' AND DAT_SALESDATE <='"+(year)+"-09-31' AND CHR_PAYMENTSTATUS !='S'";
							if(com.my.org.erp.common.CommonFunctions.RecordExist(con, sql))
							{	
								sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-07-01' AND DAT_SALESDATE <='"+(year)+"-09-31' AND CHR_PAYMENTSTATUS !='S'";
								String salesdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								salessum = salessum+Double.parseDouble(salesdata[0][0]);
								TargetAchieveBeanList rep = new TargetAchieveBeanList();
								rep.setEmpid(data[u][0]);
								rep.setEmpname(data[u][5]);
								rep.setSalesamount(Math.round(salessum));
								rep.setTarget(Double.parseDouble(data[u][4]));
								rep.setAchieve(Math.round((salessum)/100000));
								rept.add(rep);
							}
						}
						session.setAttribute("rep",rept);
					}
					else if("3".equals(period))
					{
						type="Third Quarter";
						sql="SELECT a.CHR_EMPID,INT_OCT,INT_NOV,INT_DEC,(INT_OCT+INT_NOV+INT_DEC),b.CHR_STAFFNAME FROM inv_t_targetassign a, com_m_staff b WHERE a.CHR_EMPID =b.CHR_EMPID AND INT_YEAR= "+year;
						String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						double salessum=0;
						for(int u=0;u<data.length;u++)
						{
							//This is for Direct Sales
							sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-10-01' AND DAT_SALESDATE <='"+(year)+"-12-31' AND CHR_PAYMENTSTATUS !='S'";
							if(com.my.org.erp.common.CommonFunctions.RecordExist(con, sql))
							{	
								sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-10-01' AND DAT_SALESDATE <='"+(year)+"-12-31' AND CHR_PAYMENTSTATUS !='S'";
								String salesdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								salessum = salessum+Double.parseDouble(salesdata[0][0]);
								TargetAchieveBeanList rep = new TargetAchieveBeanList();
								rep.setEmpid(data[u][0]);
								rep.setEmpname(data[u][5]);
								rep.setSalesamount(Math.round(salessum));
								rep.setTarget(Double.parseDouble(data[u][4]));
								rep.setAchieve(Math.round((salessum)/100000));
								rept.add(rep);
							}
						}
						session.setAttribute("rep",rept);
					}
					else if("4".equals(period))
					{	
						type="Fourth Quarter";
						sql=" SELECT a.CHR_EMPID,INT_JAN,INT_FEB,INT_MAR,(INT_JAN+INT_FEB+INT_MAR),b.CHR_STAFFNAME  FROM inv_t_targetassign a, com_m_staff b  WHERE a.CHR_EMPID =b.CHR_EMPID AND INT_YEAR="+year;
						String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						double salessum=0;
						for(int u=0;u<data.length;u++)
						{
							//This is for Direct Sales
							sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+(year+1)+"-01-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
							if(com.my.org.erp.common.CommonFunctions.RecordExist(con, sql))
							{	
								sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+(year+1)+"-01-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
								String salesdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								salessum = salessum+Double.parseDouble(salesdata[0][0]);
								TargetAchieveBeanList rep = new TargetAchieveBeanList();
								rep.setEmpid(data[u][0]);
								rep.setEmpname(data[u][5]);
								rep.setSalesamount(Math.round(salessum));
								rep.setTarget(Double.parseDouble(data[u][4]));
								rep.setAchieve(Math.round((salessum)/100000));
								rept.add(rep);
							}
						}
						session.setAttribute("rep",rept);
					}
					con.close();    
					response.sendRedirect("Smart Inventory/TargetAchieveResponse.jsp?type="+type);
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
