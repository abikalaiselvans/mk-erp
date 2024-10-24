package com.my.org.erp.SmartPayroll;
import java.io.IOException;

import java.sql.Statement; 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException; 
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;
public class IncomeTaxValueActionHandler extends AbstractActionHandler {
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");
			String sql="",sqlsel="";
			Statement st = con.createStatement();
			if (action.equals("PAYIncomeTaxValueAdd")) 
			{
				//Taxid,GT,LT,Percentage,Amount,desc
				String Year = request.getParameter("Year");
		 		int IYear = Integer.parseInt(Year);
				String gender = request.getParameter("gender");
				String GT = request.getParameter("GT");
				String LT = request.getParameter("LT");
				String Percentage = request.getParameter("Percentage");
				String desc = request.getParameter("desc");
		 		boolean f=false;
				sqlsel ="SELECT COUNT(*) from lncome_m_taxvalue WHERE INT_ACCOUNTYEAR="+IYear +" AND CHR_GENDER ='"+gender+"'";
			 	if(CommonFunctions.RecordExist(con, sqlsel))
			 	{
			 	 	sqlsel ="SELECT INT_ACCOUNTYEAR,CHR_GENDER,INT_TO,INT_FROM from lncome_m_taxvalue WHERE INT_ACCOUNTYEAR="+IYear +" AND CHR_GENDER ='"+gender+"'";
			 		String datas[][] = CommonFunctions.QueryExecute(sqlsel);
			 		if(datas.length>0)
			 		{
				 		int dbgreaterints = 0;
				 		int dblesserints1 = 0;
				 		int GT1 = Integer.parseInt(GT);
				 		int LT1 = Integer.parseInt(LT);
				 		for(int i=0;i<datas.length;i++)
				 		{
				 			dbgreaterints = Integer.parseInt(datas[i][2]); //greater
				 			dblesserints1 = Integer.parseInt(datas[i][3]); //lesser
				 			if(((LT1>=dblesserints1) && ( LT1<=dbgreaterints)) || ((GT1>=dblesserints1) && ( LT1<=dbgreaterints)))
				 			{
				 				try{
				 				f=true;
								response.sendRedirect("Smart Payroll/IncomeTaxValueAdd.jsp?msg=exists");
								return;
				 				}catch(Exception e){
				 					e.printStackTrace();
				 				}
				 			}else{
				 				f=false;
				 			}
				 		}
			 			if(!f)
			 			{
			 			sql = "INSERT INTO lncome_m_taxvalue (INT_ACCOUNTYEAR,CHR_GENDER,INT_TO,INT_FROM,DOU_PERCENTAGE,CHR_DESC,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES (";
						sql = sql+" '"+IYear+"' , ";
						sql = sql+" '"+gender+"' , ";
						sql = sql+" "+GT+" , ";
						sql = sql+" "+LT+" , ";
						sql = sql+" "+Percentage+" , ";
						sql = sql+" '"+desc+"' , ";
						sql = sql+" '"+userid+"' , ";
						sql = sql+" now() , ";
						sql = sql+" 'Y'  ";
						sql = sql + " )";
						st.execute(sql);
						System.out.println("sql...."+sql);
						con.close();
						response.sendRedirect("Smart Payroll/IncomeTaxValue.jsp");
						return;
				 		}
			 	   }
			   }
			   else{
				sql = "INSERT INTO lncome_m_taxvalue (INT_ACCOUNTYEAR,CHR_GENDER,INT_TO,INT_FROM,DOU_PERCENTAGE,CHR_DESC,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES (";
				sql = sql+" '"+IYear+"' , ";
				sql = sql+" '"+gender+"' , ";
				sql = sql+" "+GT+" , ";
				sql = sql+" "+LT+" , ";
				sql = sql+" "+Percentage+" , ";
				sql = sql+" '"+desc+"' , ";
				sql = sql+" '"+userid+"' , ";
				sql = sql+" now() , ";
				sql = sql+" 'Y'  ";
				sql = sql + " )";
				st.execute(sql);
				con.close();
				System.out.println("sql...."+sql);
				response.sendRedirect("Smart Payroll/IncomeTaxValue.jsp");
				return;
				}
			}
		else if(action.equals("PAYIncomeTaxValueEdit")) 
		{
				
				String Year = request.getParameter("Year");
		 		int IYear = Integer.parseInt(Year);
				String gender = request.getParameter("gender");
				String GT = request.getParameter("GT");
				String LT = request.getParameter("LT");
				String Percentage = request.getParameter("Percentage");
				String desc = request.getParameter("desc");
				String rowid = request.getParameter("Incometaxvalueid");
		 		boolean f1=false;
				sqlsel ="SELECT COUNT(*) from lncome_m_taxvalue WHERE INT_ACCOUNTYEAR="+IYear +" AND CHR_GENDER ='"+gender+"'";
			 	if(CommonFunctions.RecordExist(con, sqlsel))
			 	{
				sqlsel ="SELECT INT_ACCOUNTYEAR,CHR_GENDER,INT_TO,INT_FROM from lncome_m_taxvalue WHERE INT_ACCOUNTYEAR="+Year +" AND CHR_GENDER ='"+gender+"' AND INT_ID!="+rowid+"";
				String datas[][] = CommonFunctions.QueryExecute(sqlsel);
		 			if(datas.length>0)
		 				{
		 					int dbgreaterints = 0;
		 					int dblesserints1 = 0;
		 					int GT1 = Integer.parseInt(GT);
		 					int LT1 = Integer.parseInt(LT);
		 					for(int i=0;i<datas.length;i++)
		 					{
		 						dbgreaterints = Integer.parseInt(datas[i][2]); //greater
		 						dblesserints1 = Integer.parseInt(datas[i][3]); //lesser
		 						if(((LT1>=dblesserints1) && ( LT1<=dbgreaterints)) || ((GT1>=dblesserints1) && ( LT1<=dbgreaterints)))
		 						{
		 							f1=true;
		 							response.sendRedirect("Smart Payroll/IncomeTaxValue.jsp?msg1=exists");
		 							return;
		 				
		 						}else{
		 							f1=false;
		 						}
		 					}
		 					if(!f1)
		 					{
		 						sql = "UPDATE  lncome_m_taxvalue  SET ";
		 						sql = sql+" INT_ACCOUNTYEAR ="+IYear+" , ";
		 						sql = sql+" CHR_GENDER ='"+gender+"' , ";
		 						sql = sql+" INT_TO ="+GT+" , ";
		 						sql = sql+" INT_FROM ="+LT+" , ";
		 						sql = sql+" DOU_PERCENTAGE ="+Percentage+" , ";
		 						sql = sql+" CHR_DESC='"+desc+"' , ";
		 						sql = sql+" CHR_USRNAME='"+userid+"' , ";
		 						sql = sql+" DT_UPDATEDATE= now() , ";
		 						sql = sql+" CHR_UPDATESTATUS= 'Y'  WHERE INT_ID="+rowid;
		 						System.out.println("sql..."+sql);
		 						st.execute(sql);
		 						con.close();    
		 						response.sendRedirect("Smart Payroll/IncomeTaxValue.jsp");
		 						return;
		 					}
		 				}else{
		 					sql = "UPDATE  lncome_m_taxvalue  SET ";
							sql = sql+" INT_ACCOUNTYEAR ="+IYear+" , ";
							sql = sql+" CHR_GENDER ='"+gender+"' , ";
							sql = sql+" INT_TO ="+GT+" , ";
							sql = sql+" INT_FROM ="+LT+" , ";
							sql = sql+" DOU_PERCENTAGE ="+Percentage+" , ";
							sql = sql+" CHR_DESC='"+desc+"' , ";
							sql = sql+" CHR_USRNAME='"+userid+"' , ";
							sql = sql+" DT_UPDATEDATE= now() , ";
							sql = sql+" CHR_UPDATESTATUS= 'Y'  WHERE INT_ID="+rowid;
							System.out.println("sql...."+sql);
							st.execute(sql);
							con.close();    
							response.sendRedirect("Smart Payroll/IncomeTaxValue.jsp");
							return;
		 					
		 				}
			 		}
			 		else{
			 		sql = "UPDATE  lncome_m_taxvalue  SET ";
					sql = sql+" INT_ACCOUNTYEAR ="+IYear+" , ";
					sql = sql+" CHR_GENDER ='"+gender+"' , ";
					sql = sql+" INT_TO ="+GT+" , ";
					sql = sql+" INT_FROM ="+LT+" , ";
					sql = sql+" DOU_PERCENTAGE ="+Percentage+" , ";
					sql = sql+" CHR_DESC='"+desc+"' , ";
					sql = sql+" CHR_USRNAME='"+userid+"' , ";
					sql = sql+" DT_UPDATEDATE= now() , ";
					sql = sql+" CHR_UPDATESTATUS= 'Y'  WHERE INT_ID="+rowid;
					System.out.println("sql...."+sql);
					st.execute(sql);
					con.close();    
					response.sendRedirect("Smart Payroll/IncomeTaxValue.jsp");
					return;
				}
			}
			else if(action.equals("PAYIncomeTaxValueDelete")) 
			{
				String rowid[] = request.getParameterValues("Incometaxvalueid");
				for(int u=0;u<rowid.length;u++)
				{
					sql = "DELETE FROM lncome_m_taxvalue   ";
					sql = sql+"WHERE INT_ID="+rowid[u];
					st.execute(sql);
				}	
				con.close();    
				response.sendRedirect("Smart Payroll/IncomeTaxValue.jsp");
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
