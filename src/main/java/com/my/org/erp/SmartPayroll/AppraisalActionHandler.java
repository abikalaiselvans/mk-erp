package com.my.org.erp.SmartPayroll;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;
 

public class AppraisalActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			String ename = request.getParameter("ename");
			 
			if("PAYAppraisalAdd".equals(action))
			{
				
				
				String allowancefield[][] =  CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME,CHR_FLAG FROM  pay_m_allowance ORDER BY INT_ALLOWANCEID");
				String sumgrossallowancefield="";
				String sumothersallowancefield="";
				String allowancefields="";
				String grossallowancefield="";
				String othersallowancefield="";
				if(allowancefield.length>0)
				{
					for(int u=0;u<allowancefield.length;u++)
					{
						if("Y".equals(allowancefield[u][2]))
						{
							sumgrossallowancefield =sumgrossallowancefield+ " b."+allowancefield[u][0]+"+";
							grossallowancefield =grossallowancefield+ " b."+allowancefield[u][0]+",";
							
						}
						else
						{
							sumothersallowancefield =sumothersallowancefield+ " b."+allowancefield[u][0]+"+";
							othersallowancefield =othersallowancefield+ " b."+allowancefield[u][0]+",";	
						}	
						allowancefields =allowancefields+ " b."+allowancefield[u][0]+",";
					}
			 	}
				
				String recoveryfield[][] = CommonFunctions.QueryExecute("SELECT CHR_RCODE,CHR_RNAME  FROM  pay_m_recovery ORDER BY INT_RECOVERYID");
				String sumrecoveryfield="";
				String recoveryfields="";
				if(recoveryfield.length>0)
				{
					for(int u=0;u<recoveryfield.length;u++)
					{
						sumrecoveryfield =sumrecoveryfield+ " c."+recoveryfield[u][0]+"+";
						recoveryfields =recoveryfields+ " c."+recoveryfield[u][0]+",";
						
					}
			 	}
			
				String bsql="SELECT INT_PFAMT,INT_ESIAMT,INT_CPY_PFAMT,INT_CPY_PENSIONAMT,INT_CPY_ESIAMT,INT_PFLIMITMINIMUM ,  INT_PFLIMIT,INT_ESILIMIT FROM m_institution WHERE INT_ID=1";
				String basicdata[][] = CommonFunctions.QueryExecute(bsql);
				
				double pf=Double.parseDouble(basicdata[0][0]);
				double esi=Double.parseDouble(basicdata[0][1]);
				double cpypf=Double.parseDouble(basicdata[0][2]);
				double cpypension=Double.parseDouble(basicdata[0][3]);
				double cpyesi=Double.parseDouble(basicdata[0][4]);
				double dbminimumpflimit=Double.parseDouble(basicdata[0][5]);
				double dbpmaximumflimit=Double.parseDouble(basicdata[0][6]);
				double dbesilimit=Double.parseDouble(basicdata[0][7]);
				String sql = "";
				
				sql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%m-%Y'),  ";
				sql = sql + " a.CHR_PF,a.CHR_PFTYPE,a.CHR_ESI,a.CHR_ESITYPE,  ";
				sql = sql + " a.INT_SALARY,  ";
				sql = sql + "  "+grossallowancefield;
				sql = sql + " ("+sumgrossallowancefield+"0),  ";
				sql = sql + " (a.INT_SALARY + "+sumgrossallowancefield+"0),  ";
				sql = sql + " "+othersallowancefield;
				sql = sql + " ("+sumothersallowancefield+"0) ,  ";
				sql = sql + " (a.INT_SALARY+"+sumgrossallowancefield+sumothersallowancefield+"0),  ";
				sql = sql + "  "+recoveryfields;
				sql = sql + " ("+sumrecoveryfield+"0),  ";

				sql = sql + " if(  (a.CHR_PF ='C'),  ";
				sql = sql + "                          ( CASE   WHEN ((a.INT_SALARY <"+dbpmaximumflimit+") AND (a.INT_SALARY>"+dbminimumpflimit+") ) THEN (a.INT_SALARY*"+pf+"/100)  ";
				sql = sql + "                                  WHEN ( a.INT_SALARY >"+dbpmaximumflimit+") THEN  ( "+dbpmaximumflimit+"*"+pf+"/100)   ";
				sql = sql + "                                   ELSE ("+dbminimumpflimit+"*"+pf+"/100) END)  ";
				sql = sql + "               ,0  ";
				sql = sql + "  ),  ";


				 
				sql = sql + " if(  (a.CHR_ESI ='C'),  ";
				sql = sql + "                      (  ";
				sql = sql + "                      CASE WHEN ( (a.INT_SALARY + b.A001+b.A002+b.A003+b.A004+b.A005+b.A006+b.A0011)<= "+dbesilimit+" )  THEN ((a.INT_SALARY + b.A001+b.A002+b.A003+b.A004+b.A005+b.A006+b.A0011)*"+esi+"/100)  ";
				sql = sql + "                       else  0 END  ";
				sql = sql + "                       )  ";
				sql = sql + "                      ,0  ";
				sql = sql + "      ),  ";






				sql = sql + " if(  (a.CHR_PF ='C'),  ";
				sql = sql + "                       (    ";
				sql = sql + "                        CASE   WHEN ((a.INT_SALARY <"+dbpmaximumflimit+") AND (a.INT_SALARY>"+dbminimumpflimit+") ) THEN (a.INT_SALARY*"+cpypf+"/100)  ";
				sql = sql + "                         WHEN ( a.INT_SALARY >"+dbpmaximumflimit+") THEN  ( "+dbpmaximumflimit+"*"+cpypf+"/100)   ";
				sql = sql + "                          ELSE ("+dbminimumpflimit+"*"+cpypf+"/100) END  ";
				sql = sql + "                       )  ";
				sql = sql + "                      ,0  ";
				sql = sql + " ),  ";


				sql = sql + " if(  (a.CHR_PF ='C'),  ";
				sql = sql + "                      (    ";
				sql = sql + "                         CASE   WHEN ((a.INT_SALARY <"+dbpmaximumflimit+") AND (a.INT_SALARY>"+dbminimumpflimit+") ) THEN (a.INT_SALARY*"+cpypension+"/100)  ";
				sql = sql + "                                WHEN ( a.INT_SALARY >"+dbpmaximumflimit+") THEN  ( "+dbpmaximumflimit+"*"+cpypension+"/100)  "; 
				sql = sql + "                                ELSE ("+dbminimumpflimit+"*"+cpypension+"/100)   ";
				sql = sql + "                                END  ";
				sql = sql + "                      )  ";
				sql = sql + "                      ,0  ";
				sql = sql + " ),  ";


				sql = sql + " if(  (a.CHR_ESI ='C'),  ";
				sql = sql + "                       (  ";
				sql = sql + "                           CASE WHEN ( (a.INT_SALARY + b.A001+b.A002+b.A003+b.A004+b.A005+b.A006+b.A0011)<= "+dbesilimit+" )  THEN ((a.INT_SALARY + b.A001+b.A002+b.A003+b.A004+b.A005+b.A006+b.A0011)*"+cpyesi+"/100)  ";
				sql = sql + "                           else  0 END  ";
				sql = sql + "                       )  ";
				sql = sql + "                       ,0  ";
				sql = sql + " )    ";



				sql = sql + " FROM com_m_staff a,pay_t_allowance b,pay_t_recovery c  ";
				sql = sql + " WHERE  a.CHR_EMPID =  b.CHR_EMPID  ";
				sql = sql + " AND a.CHR_EMPID =  c.CHR_EMPID  ";
				sql = sql + " AND  a.CHR_EMPID='"+ename+"'  ";
				 System.out.println(sql);



				
				 con.close();   
				response.sendRedirect("Smart Payroll/Payrollmain.jsp");
				
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