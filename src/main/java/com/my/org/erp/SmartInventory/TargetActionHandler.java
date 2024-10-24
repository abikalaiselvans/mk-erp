package com.my.org.erp.SmartInventory;
import java.io.IOException;
 
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

import com.my.org.erp.bean.inventory.*;
import com.my.org.erp.common.CommonFunctions;
public class TargetActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{		
		try
		{
				String action=""+request.getParameter("actionS").trim();
				HttpSession session=request.getSession();			
				String userid=""+session.getAttribute("USRID");
				@SuppressWarnings("unused")
				String branchid = session.getAttribute("BRANCHID").toString();
				 
				String sql="";
				if("INVTargetAssign".equals(action))
				{
					String January =request.getParameter("January");
					String February =request.getParameter("February");
					String March =request.getParameter("March");
					String April =request.getParameter("April");
					String May =request.getParameter("May");
					String June =request.getParameter("June");
					String July =request.getParameter("July");
					String August =request.getParameter("August");
					String September =request.getParameter("September");
					String October =request.getParameter("October");
					String November =request.getParameter("November");
					String December =request.getParameter("December");
					String year =request.getParameter("year");
					String empid[] =request.getParameterValues("ename");
					for(int x=0;x<empid.length;x++)
					{
						asql = "SELECT COUNT(*) FROM inv_t_targetassign WHERE CHR_EMPID='"+empid[x]+"' AND INT_YEAR="+year;
						System.out.println(asql);
						if(!CommonFunctions.RecordExist(con, sql))
						{	
							asql = " INSERT INTO inv_t_targetassign (CHR_EMPID,INT_YEAR,INT_APR,";
							asql = asql +" INT_MAY,INT_JUN,INT_JUL,INT_AUG,INT_SEP,INT_OCT,INT_NOV,";
							asql = asql +" INT_DEC,INT_JAN,INT_FEB,INT_MAR,";
							asql = asql +" CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ) VALUES ";
							asql = asql +" (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,NOW(),'Y' )";
							apstm = con.prepareStatement(asql);
							apstm.setString(1,empid[x]);
							apstm.setString(2,year);
							apstm.setString(3,April);
							apstm.setString(4,May);
							apstm.setString(5,June);
							apstm.setString(6,July);
							apstm.setString(7,August);
							apstm.setString(8,September);
							apstm.setString(9,October);
							apstm.setString(10,November);
							apstm.setString(11,December);
							apstm.setString(12,January);
							apstm.setString(13,February);
							apstm.setString(14,March);
							apstm.setString(15,userid);
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
						}	
					}
					con.close();    
					response.sendRedirect("Smart Inventory/StaffTargetAssign.jsp");
				}
				else if("INVTargetAssignDELETE".equals(action))
				{
					String targetrow[] = request.getParameterValues("target");
					asql = " DELETE FROM inv_t_targetassign WHERE INT_TARGETID = ?";
					apstm = con.prepareStatement(asql);
					for(int u=0;u<targetrow.length;u++)
					{
						apstm.setString(1,targetrow[u]);
						apstm.addBatch();
						
					}
					apstm.executeBatch();
					apstm.close();
					con.close();    
					response.sendRedirect("Smart Inventory/StaffTargetAssign.jsp");
				}
				else if("INVTargetAssignEdit".equals(action))
				{
					String target = request.getParameter("target");
					String January =request.getParameter("January");
					String February =request.getParameter("February");
					String March =request.getParameter("March");
					String April =request.getParameter("April");
					String May =request.getParameter("May");
					String June =request.getParameter("June");
					String July =request.getParameter("July");
					String August =request.getParameter("August");
					String September =request.getParameter("September");
					String October =request.getParameter("October");
					String November =request.getParameter("November");
					String December =request.getParameter("December");
					
					asql= " UPDATE  inv_t_targetassign SET INT_APR= ? ,";
					asql = asql+"	INT_MAY = ?,";
					asql = asql+"	INT_JUN = ? ,";
					asql = asql+"	INT_JUL = ? ,";
					asql = asql+"	INT_AUG = ? ,";
					asql = asql+"	INT_SEP = ? ,";
					asql = asql+"	INT_OCT = ? ,";
					asql = asql+"	INT_NOV = ? ,";
					asql = asql+"	INT_DEC = ? ,";
					asql = asql+"	INT_JAN = ? ,";
					asql = asql+"	INT_FEB = ? ,";
					asql = asql+"	INT_MAR = ?" ;
					asql = asql+"	WHERE  INT_TARGETID = ? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,April);
					apstm.setString(2,May);
					apstm.setString(3,June);
					apstm.setString(4,July);
					apstm.setString(5,August);
					apstm.setString(6,September);
					apstm.setString(7,October);
					apstm.setString(8,November);
					apstm.setString(9,December);
					apstm.setString(10,January);
					apstm.setString(11,February);
					apstm.setString(12,March);
					apstm.setString(13,target);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					con.close();    
					response.sendRedirect("Smart Inventory/StaffTargetAssign.jsp");
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
