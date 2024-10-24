package com.my.org.erp.SmartPayroll;

import java.io.IOException;
 
 
import java.sql.Statement;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import  com.my.org.erp.common.CommonFunctions;
 

public class BonusActionHandler extends AbstractActionHandler 
{
	public synchronized void  handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");
			String sql="";
			
			sql = "SELECT CHR_ACODE FROM pay_m_allowance WHERE CHR_BONUS='Y'";
			String bonusallowance[][] = CommonFunctions.QueryExecute(sql);
			
			Statement st = con.createStatement();
			String month[]={"April","May","June","July","August", "September","October", "November", "December","January", "February", "March"};
			sql="SELECT DOU_BONUS,INT_BONUSWORKINGDAYS FROM m_institution WHERE INT_ID=1";
			String bonuspercentage[][] =  CommonFunctions.QueryExecute(sql);
			double bonusper = Double.parseDouble(bonuspercentage[0][0]);
			 
			if (action.equals("PAYBonusAdd")) 
			{
				
				System.out.println();
				System.out.println();
				Date d1 = new Date();
				System.out.println(""+d1);
				System.out.println();
				System.out.println();
				
				String company =request.getParameter("company");
				String branch=request.getParameter("branch");
				String Office=request.getParameter("Office");
				String dept=request.getParameter("dept");
				String year=request.getParameter("year");
				String Category=request.getParameter("Category");
				int yr= Integer.parseInt(year);
				
				
				sql =" DELETE a.* FROM  pay_t_bonus a ,com_m_staff b WHERE a.CHR_EMPID = b.CHR_EMPID   AND a.INT_YEAR= "+yr;
				if(!"0".equals(company))
					sql = sql+" AND a.INT_COMPANYID ="+ company;
				if(!"0".equals(branch))
					sql = sql+" AND a.INT_BRANCHID ="+ branch;
				if(!"0".equals(dept))
					sql = sql+" AND a.INT_DEPARTID ="+ dept;
				if(!"0".equals(Office))
					sql = sql+" AND a.INT_OFFICEID ="+ Office;
				if(!"0".equals(Category))
					sql = sql+" AND a.CHR_CATEGORY ="+ Category;
				CommonFunctions.Execute(sql);
				
				 
				
				asql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME FROM com_m_staff a, att_t_register b ";
				asql = asql + " WHERE a.CHR_EMPID = b.CHR_EMPID "; 
				asql = asql + " AND  (     ";
				asql = asql + "      (b.CHR_MONTH in ('April','May','June','July','August','September','October','November','December') and INT_YEAR=("+yr+")) "; 
				asql = asql + "      or  ";
				asql = asql + "      (b.CHR_MONTH in ('January','February', 'March') and INT_YEAR=( "+(yr+1)+" )  ) ";
				asql = asql + "      )  ";
				if(!"0".equals(company))
					asql = asql+" AND a.INT_COMPANYID ="+ company;
				if(!"0".equals(branch))
					asql = asql+" AND a.INT_BRANCHID ="+ branch;
				if(!"0".equals(dept))
					asql = asql+" AND a.INT_DEPARTID ="+ dept;
				if(!"0".equals(Office))
					asql = asql+" AND a.INT_OFFICEID ="+ Office;
				if(!"0".equals(Category))
					asql = asql+" AND a.CHR_CATEGORY ="+ Category;
				asql = asql + " Group BY a.CHR_EMPID ORDER BY a.CHR_STAFFNAME ";
				System.out.println(asql);
				String empdata[][] =  CommonFunctions.QueryExecutecon(con, asql);
				
				 
				
				double totalbasic=0;
				double bonus = 0;
				double apr=0;
				double may=0;
				double june=0;
				double july=0;
				double aug=0;
				double sep=0;
				double oct=0;
				double nov=0;
				double dec=0;
				double jan=0;
				double feb=0;
				double mar=0;
				double noofworkingdays=0;
				double minimumwrkdays=0;
				
				if(bonuspercentage.length>0)
					minimumwrkdays=Double.parseDouble(bonuspercentage[0][1]);
				else
					minimumwrkdays=60;
				
				 
				
				asql = " INSERT INTO pay_t_bonus ( ";
				asql = asql+ " CHR_EMPID,INT_YEAR,DOU_APR,DOU_MAY,";
				asql = asql+ " DOU_JUN,DOU_JUL,DOU_AUG,DOU_SEP,DOU_OCT,";
				asql = asql+ " DOU_NOV,DOU_DEC,DOU_JAN,DOU_FEB,DOU_MAR, ";
				asql = asql+ " 	DOU_WORKDAYS,DOU_TOTALBASIC,DOU_BONUS, ";
				asql = asql+ " DOU_BONUSAMOUNT,CHR_USRNAME,DT_UPDATEDATE,";
				asql = asql+ " CHR_UPDATESTATUS )" ;
				asql = asql+ " VALUES (?,?,?,?,";
				asql = asql+ " ?,?,?,?,?,";
				asql = asql+ " ?,?,?,?,?,";
				asql = asql+ " 	?,?,?,";
				asql = asql+ " ?,?,DATE(NOW()),'Y') ";
				
				for(int u=0;u<empdata.length;u++)
				{ 
					apstm = con.prepareStatement(asql);
					totalbasic=0;
					bonus = 0;
					 
					apr=0;may=0;june=0;july=0;aug=0;sep=0;
					oct=0;nov=0;dec=0;jan=0;feb=0;mar=0;
					noofworkingdays=0;
					 
					
					sql="";
					
					
					
					//April
					sql="";
					sql=" SELECT DOU_BASIC,DOU_WORKDAYS FROM pay_t_salary WHERE INT_YEAR = "+yr+" AND CHR_MONTH ='"+month[0]+"' AND CHR_EMPID ='"+empdata[u][0]+"' ";
					 
					String aprilbasic[][] =  CommonFunctions.QueryExecutecon(con, sql);
					if(aprilbasic.length>0)
					{	
						apr=Double.parseDouble(aprilbasic[0][0]);
						noofworkingdays=noofworkingdays+=Double.parseDouble(aprilbasic[0][1]);
						sql =" SELECT "+bonusallowance[0][0]+" from pay_t_salaryallowance WHERE CHR_EMPID='"+empdata[u][0]+"' AND CHR_MONTH='"+month[0]+"' AND INT_YEAR="+yr;
						String allowdata[][] = CommonFunctions.QueryExecutecon(con, sql);
						if(allowdata.length>0)
							if((Integer.parseInt(allowdata[0][0]))==0)
								totalbasic=totalbasic+apr;
						
					}
					
					
					
					//MAY
					sql="";
					sql=" SELECT DOU_BASIC,DOU_WORKDAYS FROM pay_t_salary WHERE INT_YEAR = "+yr+" AND CHR_MONTH ='"+month[1]+"' AND CHR_EMPID ='"+empdata[u][0]+"' ";
					 
					String maybasic[][] =  CommonFunctions.QueryExecutecon(con, sql);
					if(maybasic.length>0)
					{	
						may=Double.parseDouble(maybasic[0][0]);
						noofworkingdays=noofworkingdays+=Double.parseDouble(maybasic[0][1]);
						sql =" SELECT "+bonusallowance[0][0]+" from pay_t_salaryallowance WHERE CHR_EMPID='"+empdata[u][0]+"' AND CHR_MONTH='"+month[1]+"' AND INT_YEAR="+yr;
						String allowdata[][] =  CommonFunctions.QueryExecutecon(con, sql);
						if(allowdata.length>0)
							if((Integer.parseInt(allowdata[0][0]))==0)
								totalbasic=totalbasic+may;
					
					}
					
					
					//June
					sql="";
					sql=" SELECT DOU_BASIC,DOU_WORKDAYS FROM pay_t_salary WHERE INT_YEAR = "+yr+" AND CHR_MONTH ='"+month[2]+"' AND CHR_EMPID ='"+empdata[u][0]+"' ";
					 
					String junebasic[][] =  CommonFunctions.QueryExecutecon(con, sql);
					if(junebasic.length>0)
					{	
						june=Double.parseDouble(junebasic[0][0]);
						noofworkingdays=noofworkingdays+=Double.parseDouble(junebasic[0][1]);
						sql =" SELECT "+bonusallowance[0][0]+" from pay_t_salaryallowance WHERE CHR_EMPID='"+empdata[u][0]+"' AND CHR_MONTH='"+month[2]+"' AND INT_YEAR="+yr;
						String allowdata[][] =  CommonFunctions.QueryExecutecon(con, sql);
						if(allowdata.length>0)
							if((Integer.parseInt(allowdata[0][0]))==0)
								totalbasic=totalbasic+june;
					
					}
					
					
					//July
					sql="";
					sql=" SELECT DOU_BASIC,DOU_WORKDAYS  FROM pay_t_salary WHERE INT_YEAR = "+yr+" AND CHR_MONTH ='"+month[3]+"' AND CHR_EMPID ='"+empdata[u][0]+"' ";
					 
					String julybasic[][] =  CommonFunctions.QueryExecutecon(con, sql);
					if(julybasic.length>0)
					{
						july=Double.parseDouble(julybasic[0][0]);
						noofworkingdays=noofworkingdays+=Double.parseDouble(julybasic[0][1]);
						sql =" SELECT "+bonusallowance[0][0]+" from pay_t_salaryallowance WHERE CHR_EMPID='"+empdata[u][0]+"' AND CHR_MONTH='"+month[3]+"' AND INT_YEAR="+yr;
						String allowdata[][] =  CommonFunctions.QueryExecutecon(con, sql);
						if(allowdata.length>0)
							if((Integer.parseInt(allowdata[0][0]))==0)
								totalbasic=totalbasic+july;
					
					}
					
					
					//August
					sql="";
					sql=" SELECT DOU_BASIC,DOU_WORKDAYS  FROM pay_t_salary WHERE INT_YEAR = "+yr+" AND CHR_MONTH ='"+month[4]+"' AND CHR_EMPID ='"+empdata[u][0]+"' ";
					 
					String augbasic[][] =  CommonFunctions.QueryExecutecon(con, sql);
					if(augbasic.length>0)
					{
						aug=Double.parseDouble(augbasic[0][0]);
						noofworkingdays=noofworkingdays+=Double.parseDouble(augbasic[0][1]);
						sql =" SELECT "+bonusallowance[0][0]+" from pay_t_salaryallowance WHERE CHR_EMPID='"+empdata[u][0]+"' AND CHR_MONTH='"+month[4]+"' AND INT_YEAR="+yr;
						String allowdata[][] =  CommonFunctions.QueryExecute(sql);
						if(allowdata.length>0)
							if((Integer.parseInt(allowdata[0][0]))==0)
								totalbasic=totalbasic+aug;
					
					}
					
					//September
					sql="";
					sql=" SELECT DOU_BASIC,DOU_WORKDAYS  FROM pay_t_salary WHERE INT_YEAR = "+yr+" AND CHR_MONTH ='"+month[5]+"' AND CHR_EMPID ='"+empdata[u][0]+"' ";
					 
					String sepbasic[][] =  CommonFunctions.QueryExecutecon(con, sql);
					if(sepbasic.length>0)
					{
						sep=Double.parseDouble(sepbasic[0][0]);
						noofworkingdays=noofworkingdays+=Double.parseDouble(sepbasic[0][1]);
						sql =" SELECT "+bonusallowance[0][0]+" from pay_t_salaryallowance WHERE CHR_EMPID='"+empdata[u][0]+"' AND CHR_MONTH='"+month[5]+"' AND INT_YEAR="+yr;
						String allowdata[][] =  CommonFunctions.QueryExecutecon(con, sql);
						if(allowdata.length>0)
							if((Integer.parseInt(allowdata[0][0]))==0)
								totalbasic=totalbasic+sep;
					
					}
								
					//October
					sql="";
					sql=" SELECT DOU_BASIC,DOU_WORKDAYS  FROM pay_t_salary WHERE INT_YEAR = "+yr+" AND CHR_MONTH ='"+month[6]+"' AND CHR_EMPID ='"+empdata[u][0]+"' ";
					 
					String octbasic[][] =  CommonFunctions.QueryExecutecon(con, sql);
					if(octbasic.length>0)
					{
						oct=Double.parseDouble(octbasic[0][0]);
						noofworkingdays=noofworkingdays+=Double.parseDouble(octbasic[0][1]);
						sql =" SELECT "+bonusallowance[0][0]+" from pay_t_salaryallowance WHERE CHR_EMPID='"+empdata[u][0]+"' AND CHR_MONTH='"+month[6]+"' AND INT_YEAR="+yr;
						String allowdata[][] =  CommonFunctions.QueryExecutecon(con, sql);
						if(allowdata.length>0)
							if((Integer.parseInt(allowdata[0][0]))==0)
								totalbasic=totalbasic+oct;
					
					}
					
					//November
					sql="";
					sql=" SELECT DOU_BASIC,DOU_WORKDAYS  FROM pay_t_salary WHERE INT_YEAR = "+yr+" AND CHR_MONTH ='"+month[7]+"' AND CHR_EMPID ='"+empdata[u][0]+"' ";
					 
					String novbasic[][] =  CommonFunctions.QueryExecutecon(con, sql);
					if(novbasic.length>0)
					{
						nov=Double.parseDouble(novbasic[0][0]);
						noofworkingdays=noofworkingdays+=Double.parseDouble(novbasic[0][1]);
						sql =" SELECT "+bonusallowance[0][0]+" from pay_t_salaryallowance WHERE CHR_EMPID='"+empdata[u][0]+"' AND CHR_MONTH='"+month[7]+"' AND INT_YEAR="+yr;
						String allowdata[][] =  CommonFunctions.QueryExecutecon(con, sql);
						if(allowdata.length>0)
							if((Integer.parseInt(allowdata[0][0]))==0)
								totalbasic=totalbasic+nov;
					
					}
					
					//December
					sql="";
					sql=" SELECT DOU_BASIC,DOU_WORKDAYS  FROM pay_t_salary WHERE INT_YEAR = "+yr+" AND CHR_MONTH ='"+month[8]+"' AND CHR_EMPID ='"+empdata[u][0]+"' ";
					 
					String decbasic[][] =  CommonFunctions.QueryExecutecon(con, sql);
					if(decbasic.length>0)
					{
						dec=Double.parseDouble(decbasic[0][0]);
						noofworkingdays=noofworkingdays+=Double.parseDouble(decbasic[0][1]);
						sql =" SELECT "+bonusallowance[0][0]+" from pay_t_salaryallowance WHERE CHR_EMPID='"+empdata[u][0]+"' AND CHR_MONTH='"+month[8]+"' AND INT_YEAR="+yr;
						String allowdata[][] =  CommonFunctions.QueryExecutecon(con, sql);
						if(allowdata.length>0)
							if((Integer.parseInt(allowdata[0][0]))==0)
								totalbasic=totalbasic+dec;
					
					}
					
					//Jan
					sql="";
					sql=" SELECT DOU_BASIC,DOU_WORKDAYS  FROM pay_t_salary WHERE INT_YEAR = "+(yr+1)+" AND CHR_MONTH ='"+month[9]+"' AND CHR_EMPID ='"+empdata[u][0]+"' ";
					 
					String janbasic[][] =  CommonFunctions.QueryExecutecon(con, sql);
					if(janbasic.length>0)
					{
						jan=Double.parseDouble(janbasic[0][0]);
						noofworkingdays=noofworkingdays+=Double.parseDouble(janbasic[0][1]);
						sql =" SELECT "+bonusallowance[0][0]+" from pay_t_salaryallowance WHERE CHR_EMPID='"+empdata[u][0]+"' AND CHR_MONTH='"+month[9]+"' AND INT_YEAR="+(yr+1);
						String allowdata[][] =  CommonFunctions.QueryExecutecon(con, sql);
						if(allowdata.length>0)
							if((Integer.parseInt(allowdata[0][0]))==0)
								totalbasic=totalbasic+jan;
					
					}
					
					//February
					sql="";
					sql=" SELECT DOU_BASIC,DOU_WORKDAYS  FROM pay_t_salary WHERE INT_YEAR = "+(yr+1)+" AND CHR_MONTH ='"+month[10]+"' AND CHR_EMPID ='"+empdata[u][0]+"' ";
					 
					String febbasic[][] =  CommonFunctions.QueryExecutecon(con, sql);
					if(febbasic.length>0)
					{
						feb=Double.parseDouble(febbasic[0][0]);
						noofworkingdays=noofworkingdays+=Double.parseDouble(febbasic[0][1]);
						sql =" SELECT "+bonusallowance[0][0]+" from pay_t_salaryallowance WHERE CHR_EMPID='"+empdata[u][0]+"' AND CHR_MONTH='"+month[10]+"' AND INT_YEAR="+(yr+1);
						String allowdata[][] =  CommonFunctions.QueryExecute(sql);
						if(allowdata.length>0)
							if((Integer.parseInt(allowdata[0][0]))==0)
								totalbasic=totalbasic+feb;
					
					}


					//March
					sql="";
					sql=" SELECT DOU_BASIC,DOU_WORKDAYS  FROM pay_t_salary WHERE INT_YEAR = "+(yr+1)+" AND CHR_MONTH ='"+month[11]+"' AND CHR_EMPID ='"+empdata[u][0]+"' ";
					String marbasic[][] =  CommonFunctions.QueryExecutecon(con, sql);
					if( marbasic.length>0)
					{
						mar=Double.parseDouble(marbasic[0][0]);
						noofworkingdays=noofworkingdays+=Double.parseDouble(marbasic[0][1]);
						sql =" SELECT "+bonusallowance[0][0]+" from pay_t_salaryallowance WHERE CHR_EMPID='"+empdata[u][0]+"' AND CHR_MONTH='"+month[11]+"' AND INT_YEAR="+(yr+1);
						String allowdata[][] =  CommonFunctions.QueryExecutecon(con, sql);
						if(allowdata.length>0)
							if((Integer.parseInt(allowdata[0][0]))==0)
								totalbasic=totalbasic+mar;
						 
					
					}
				  
					
					apstm.setString(1, empdata[u][0]);
					apstm.setString(2,""+yr );
					apstm.setString(3,""+apr );
					apstm.setString(4,""+may );
					apstm.setString(5,""+june );
					apstm.setString(6, ""+july);
					apstm.setString(7,""+aug );
					apstm.setString(8,""+sep );
					apstm.setString(9,""+oct );
					apstm.setString(10,""+nov );
					apstm.setString(11,""+dec );
					apstm.setString(12,""+jan );
					apstm.setString(13,""+feb );
					apstm.setString(14,""+mar );
					apstm.setString(15,""+noofworkingdays );
					apstm.setString(16,""+totalbasic );
					apstm.setString(17,""+bonusper );
					if(noofworkingdays>=minimumwrkdays)
						bonus =(totalbasic *(bonusper/100));
					apstm.setString(18,""+bonus );
					apstm.setString(19,userid );
					System.out.println("Bonus : "+apstm);
					System.out.println(u+"/"+empdata.length+"  -  "+apstm);
					apstm.execute();
					apstm.close(); 
					
				}
				 
				
				con.close();    
				System.out.println();
				System.out.println();
				System.out.println();
				Date d2 = new Date();
				System.out.println(""+d2);
				System.out.println(""+d2+"/"+d1);
				response.sendRedirect("Smart Payroll/Payrollmain.jsp");
			}
			else if(action.equals("PAYPayTaxEdit")) 
			{
				String Taxname=request.getParameter("Taxname");
				String desc = request.getParameter("desc");
				String rowid = request.getParameter("Paytaxid");
				sql = "UPDATE  pay_m_tax  SET ";
				sql = sql+" CHR_TAXNAME ='"+Taxname+"' , ";
				sql = sql+" CHR_DESC='"+desc+"' , ";
				sql = sql+" CHR_USRNAME='"+userid+"' , ";
				sql = sql+" DT_UPDATEDATE= now() , ";
				sql = sql+" CHR_UPDATESTATUS= 'Y'  WHERE INT_ID="+rowid;
				st.execute(sql);
				 
				response.sendRedirect("Smart Payroll/PayTax.jsp");
			}
			else if(action.equals("PAYPayTaxDelete")) 
			{
				String rowid[] = request.getParameterValues("Paytaxid");
				for(int u=0;u<rowid.length;u++)
				{
					sql = "DELETE FROM pay_m_tax   ";
					sql = sql+"WHERE INT_ID="+rowid[u];
					st.execute(sql);
				}	
				con.close();    
				response.sendRedirect("Smart Payroll/PayTax.jsp");
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
