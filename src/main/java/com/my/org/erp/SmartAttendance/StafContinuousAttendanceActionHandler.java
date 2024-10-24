package com.my.org.erp.SmartAttendance;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import com.my.org.erp.bean.Attendance.Attinfo;
import com.my.org.erp.bean.Attendance.ContinuousEntry;
import com.my.org.erp.common.CommonFunctions;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.beanutils.BeanUtils;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class StafContinuousAttendanceActionHandler extends AbstractActionHandler 
{
	 
		 
	String userid=null;
	boolean flag = false;
	ArrayList<Attinfo> attinfo = new ArrayList<Attinfo>();

@SuppressWarnings({ "deprecation", "rawtypes" })
public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session=request.getSession();			
			userid=""+session.getAttribute("USRID");
			ContinuousEntry c = new ContinuousEntry();
			Map map=request.getParameterMap();
			BeanUtils.populate(c,map);
			 
			session.removeAttribute("attinfo"); 
			System.out.println("CONTROLLER FROM CONTINUOUS ENTRY ACTION HANDLER  : "+action);
			if (action.equals("ATTContinuousEntry")) 
			{
				try 
				{
					String staffids[] = c.getEname();
					String mont = c.getMonth();
					int year = c.getYear();
					 
					String month = DateUtil.getMonth(Integer.parseInt(mont));
					int totaldays = Integer.parseInt(CommonFunctions.QueryExecute("SELECT DAY(LAST_DAY('"+year+"-"+mont+"-01'))")[0][0]);
					 
					
					acs = con.prepareCall("{call ATT_PRO_CONTINUOUSENTRY (?,?,?,?,?,?,?  )}"); 			
					for(int u=0; u<staffids.length;u++)
						if(CommonFunctions.RecordExist(con,"SELECT COUNT(*) FROM att_t_register WHERE CHR_EMPID='"+staffids[u]+"' AND CHR_MONTH='"+month+"' AND INT_YEAR="+year))
						{
							System.out.println("Continuous Entry :"+u+" of "+staffids.length +"  / "+staffids[u]); 
							String field ="";
							field =" UPDATE att_t_register a SET CHR_USRNAME='"+userid+"', DAT_MODIFIEDDATE=NOW(), ";
							boolean f = false;
							for(int day=1;day<=totaldays;day++)
							{
								 
								String dayname= CommonFunctions.QueryExecute(" SELECT DAYNAME('"+year+"-"+mont+"-"+day+"') ")[0][0];
								if(!"Sunday".equals(dayname))
								{
									f = true;
									acs.setString(1, "INSERT");
									acs.setString(2,  "");
									acs.setString(3, staffids[u]);
									if(day<10)
										acs.setString(4,  year+"-"+mont+"-0"+day);
									else
										acs.setString(4,  year+"-"+mont+"-"+day);
									acs.setString(5,  "Full Day");
									acs.setString(6,  "1.0");
									acs.setString(7,  userid );
									//System.out.println("callable statement---"+acs);
									acs.addBatch();
									field = field+"  a.CHR_MORNING"+day+" = 'PRE' , a.CHR_EVENING"+day+"='PRE' , ";
								}
								 
							}
							
							
							field = field+" CHR_UPDATESTATUS='Y' ,";
							field=field.trim();
							field = field.substring(0,field.length()-1);
							field = field +" WHERE a.CHR_EMPID=? AND a.CHR_MONTH=? AND a.INT_YEAR=?";
							//System.out.println(field);
							// System.out.println(""+field +"/"+f);
							if(f)
							{
								apstm = con.prepareStatement(field);
								apstm.setString(1, staffids[u]);
								apstm.setString(2, month);
								apstm.setString(3, ""+year);
								//System.out.println(""+apstm);
								apstm.execute();
								apstm.close();
							}
							 
						}
					acs.executeBatch();
					acs.close();
					con.close();    
					response.sendRedirect("Smart Attendance/ContinuousEntryView.jsp");
					
				} 
				catch (Exception e) 
				{
					System.out.println(e.getMessage());
					request.setAttribute("error", e.getMessage() );
			        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			    	dispatchers.forward(request, response); 

				}	
				
			}
			else if("ATTContinuousEntryDelete".equals(action))
			{
				 
				String[] rowid = request.getParameterValues("rowid");
				acs = con.prepareCall("{call ATT_PRO_CONTINUOUSENTRY (?,?,?,?,?,?,?  )}");
				
				 
				for (int i = 0; i < rowid.length; i++) 
				{
					asql = "SELECT CHR_EMPID,DAY(DT_CONTINUOUSDATE),MONTHNAME( DT_CONTINUOUSDATE ),YEAR(DT_CONTINUOUSDATE) FROM att_t_continuousentry WHERE INT_CONTINUOUSID= "+rowid[i];
					String Data[][] = CommonFunctions.QueryExecute(asql);
					
					asql=" UPDATE att_t_register   SET CHR_USRNAME='"+userid+"',DAT_MODIFIEDDATE=NOW(), CHR_MORNING"+Data[0][1]+" =   null, CHR_EVENING"+Data[0][1]+" =   null WHERE CHR_EMPID='"+Data[0][0]+"' AND CHR_MONTH='"+Data[0][2]+"' AND INT_YEAR="+Data[0][3]+"";
					CommonFunctions.Execute(asql);
					
					acs.setString(1, "DELETE");
					acs.setString(2, rowid[i]);
					acs.setString(3, "");
					acs.setString(4, "");
					acs.setString(5, "");
					acs.setString(6, "");
					acs.setString(7, "");
					acs.addBatch();
				}
				acs.executeBatch();
				acs.close();
				con.close();   
				response.sendRedirect("Smart Attendance/ContinuousEntryView.jsp");
			}
			else if("ATTContinuousEntryinUploadedExcel".equals(action))
			{
				
				String filename =""+request.getParameter("xlsfilename");
 				String month=""+request.getParameter("month");
 				String year=""+request.getParameter("year");
 				String monthname = DateUtil.getMonth(Integer.parseInt(month));
 				int totaldays = Integer.parseInt(CommonFunctions.QueryExecute("SELECT DAY(LAST_DAY('"+year+"-"+month+"-01'))")[0][0]);
				
 				String filepath = request.getRealPath("/")+"UploadExcelFile/"+filename+"_"+month+"_"+year+".xls" ;
 				Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
 				String myDB ="jdbc:odbc:Driver={Microsoft Excel Driver (*.xls)};DBQ="+filepath+";DriverID=22;READONLY=false";
 				Connection cona = DriverManager.getConnection(myDB,"","");
 				Statement sts = cona.createStatement();
 				ResultSet rss = sts.executeQuery("SELECT * FROM [Sheet1$]");
 				boolean flag =false;
 				System.out.println("totaldays "+totaldays);
 				int i=3;
 				//rss.next();
				//asql = asql+ " CHR_MORNING"+u+"='"+("null".equals(rss.getString(i))?"":rss.getString(i))+"',  CHR_EVENING"+u+"='"+("null".equals(rss.getString(i+1))?"":rss.getString(i+1))+"', ";
 				Outer:
 				while(rss.next())
 				{
 					i=3;
 					if(flag)
 					{	
	 					 asql = " UPDATE att_t_register SET ";
	 					for(int u=1;u<=totaldays;u++)
	 					{
	 						try
	 						{
	 							asql = asql+ " CHR_MORNING"+u+"='"+rss.getString(i)+"',  CHR_EVENING"+u+"='"+rss.getString(i+1)+"', ";
	 							i = i+2;
	 						}
	 						catch(Exception e)
	 						{
	 							System.out.println(e.getMessage()+" error for "+rss.getString(1) );
	 							continue Outer;
	 						}
	 					}	
	 					asql = asql+ " DT_UPDATEDATE = DATE(NOW()), CHR_USRNAME=?, CHR_UPDATESTATUS='Y' ";
	 					asql = asql+ " WHERE CHR_EMPID=? AND CHR_MONTH=? AND INT_YEAR=?";
	 					asql = asql.replaceAll("'null'", " '0' ");
	 					apstm = con.prepareStatement(asql);
	 					apstm.setString(1,userid );
	 					apstm.setString(2,rss.getString(1) );
	 					apstm.setString(3,monthname );
	 					apstm.setString(4,year );
	 					System.out.println(""+apstm);
	 					apstm.execute();
	 					apstm.close(); 
 					}
 					if(!flag)
 						flag = true; 
	 			}
				rss.close();
				sts.close();
				cona.close(); 
				con.close();   
				response.sendRedirect("Common/exit.jsp");
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
