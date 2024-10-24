package com.my.org.erp.SmartMarketing;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class DaillyCallsActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String userid  = (String) session.getAttribute("USRID");
			String empid  = (String) session.getAttribute("EMPID");
			 
			if (action.equals("MKTDaillyCallsAdd")) 
			{
				String customer=request.getParameter("customer");
				String calltype=request.getParameter("calltype");
				String desc=request.getParameter("desc");
				String fromdate=request.getParameter("fromdate");
				String todate=request.getParameter("todate");
				String Follows=""+request.getParameter("Follows");
				String opportunityvalue=request.getParameter("opportunityvalue");
				String funnel=""+request.getParameter("funnel");
				String department=""+request.getParameter("department");
				String designination=""+request.getParameter("designination");
				String cperson=""+request.getParameter("cperson");
				String quotationnumber=""+request.getParameter("quotationnumber");
				String reschedule ="N";
				String quotationassign="Y";
				String transactionid =CommonFunctions.QueryExecute("SELECT REPLACE(REPLACE(REPLACE(now(),'-',''),':',''),' ' ,'')")[0][0];
				if(!"Y".equals(Follows))
					Follows ="N";
				
				if(!"Y".equals(funnel))
				{
					funnel ="N"; quotationassign="N";
				}
				
				if("".equals(quotationnumber))
					quotationnumber=null;
					
				String refnumber = CommonFunctions.QueryExecute("SELECT CONCAT('SFA/', (SELECT RIGHT(CONCAT('00000', (SELECT IF( (COUNT(*)>0 ) , (MAX(INT_CALLID)+1),'1')   FROM mkt_t_daillycalls)),6)) ) ")[0][0];
				acs = con.prepareCall("{call MKT_PRO_DAILYCALLS(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				acs.setString(1, "INSERT");
				acs.setString(2, "");
				acs.setString(3, customer);
				acs.setString(4, calltype);
				acs.setString(5, empid);
				acs.setString(6, desc);
				acs.setString(7, funnel);
				acs.setString(8, DateUtil.FormateDateandTimeSQL(fromdate));
				acs.setString(9, DateUtil.FormateDateandTimeSQL(todate));
				if ("N".equals(Follows)) // no follows up
				{
					acs.setString(10, "Y");//status
					acs.setString(11, "N");//next call
					acs.setString(12, null);
					acs.setString(13, null);
					acs.setString(14, refnumber);
					acs.setString(15, opportunityvalue);
					acs.setString(16, department);
					acs.setString(17, cperson);
					acs.setString(18, quotationnumber );
					acs.setString(19, quotationassign );
					acs.setString(20,transactionid );
					acs.setString(21, "1");//funnel percentage
					acs.setString(22, "N");// funnel won or lost
					acs.setString(23, designination);
					acs.setString(24, reschedule);
					acs.setString(25, null);
					acs.setString(26, userid);
					
				}	
				else
				{
					acs.setString(10, "Y");//status
					acs.setString(11, "Y");//next call
					acs.setString(12, null);
					acs.setString(13, null);
					acs.setString(14, refnumber);
					acs.setString(15, opportunityvalue);
					acs.setString(16, department);
					acs.setString(17, cperson);
					acs.setString(18, quotationnumber );
					acs.setString(19, quotationassign );
					acs.setString(20,transactionid );
					acs.setString(21, "1");//funnel percentage
					acs.setString(22, "N");// funnel won or lost
					acs.setString(23, designination);
					acs.setString(24, reschedule);
					acs.setString(25, null);
					acs.setString(26, userid);
					
					asql = "UPDATE mkt_t_quotation SET CHR_ASSIGNED=? WHERE CHR_QUOTATIONNO =? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,"Y" );
					apstm.setString(2,quotationnumber );
					System.out.println(asql);
					apstm.execute();
					
				}
				System.out.println(""+acs);
				acs.execute();
				
				
				//If follows means
				String rowid = CommonFunctions.QueryExecute("SELECT MAX(INT_CALLID) FROM mkt_t_daillycalls")[0][0];
				if ("Y".equals(Follows))
				{

					String nfromdate=request.getParameter("nfromdate") ;
					String ntodate=request.getParameter("ntodate") ;
					String newcalltype=request.getParameter("newcalltype");
					
					acs = con.prepareCall("{call MKT_PRO_DAILYCALLS(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					acs.setString(1, "UPDATE");
					acs.setString(2, rowid);
					acs.setString(3, "");
					acs.setString(4, calltype);
					acs.setString(5, empid);
					acs.setString(6, desc);
					acs.setString(7, funnel);
					acs.setString(8, DateUtil.FormateDateandTimeSQL(fromdate));
					acs.setString(9, DateUtil.FormateDateandTimeSQL(todate));
					acs.setString(10, "Y");//status
					acs.setString(11, "Y");//next flag
					acs.setString(12, rowid);//refid
					acs.setString(13, DateUtil.FormateDateandTimeSQL(nfromdate));
					acs.setString(14, refnumber);//refnumber
					acs.setString(15,opportunityvalue);
					acs.setString(16, department);
					acs.setString(17, cperson);
					acs.setString(18, quotationnumber );
					acs.setString(19, quotationassign );
					acs.setString(20,transactionid );
					acs.setString(21, "1");//funnel percentage
					acs.setString(22, "N");// funnel won or lost
					acs.setString(23, designination);
					acs.setString(24, reschedule);
					acs.setString(25, null);
					acs.setString(26, userid);
					System.out.println(""+acs);
					acs.execute();
				
					acs = con.prepareCall("{call MKT_PRO_DAILYCALLS(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					acs.setString(1, "INSERT");
					acs.setString(2, "");
					acs.setString(3, customer);
					acs.setString(4, newcalltype);
					acs.setString(5, empid);
					acs.setString(6, desc);
					acs.setString(7, funnel);
					acs.setString(8, DateUtil.FormateDateandTimeSQL(nfromdate));
					acs.setString(9, null);
					acs.setString(10, "N");//status
					acs.setString(11, "N");//next flag
					acs.setString(12, rowid);//parent ref id
					acs.setString(13, "");//date follow
					acs.setString(14, refnumber); //refnumber
					acs.setString(15,opportunityvalue);
					acs.setString(16, department);
					acs.setString(17, cperson);
					acs.setString(18, quotationnumber );
					acs.setString(19, quotationassign );
					acs.setString(20,transactionid );
					acs.setString(21, "1");//funnel percentage
					acs.setString(22, "N");// funnel win or lost
					acs.setString(23, designination);
					acs.setString(24, reschedule);
					acs.setString(25, null);
					acs.setString(26, userid);
					System.out.println(""+acs);
					acs.execute();					
				}
				
				
				
				con.close();
				response.sendRedirect("Smart Marketing/DaillyCallsAdd.jsp?msg=added successfully...");
				 	
			}
			else if (action.equals("MKTDaillyCallsEdit")) //==================================================================================
			{
				
				String id = request.getParameter("id");
				asql = "SELECT CHR_UPDATESTATUS FROM mkt_t_daillycalls WHERE INT_CALLID="+id;
				if("N".equals(CommonFunctions.QueryExecute(asql)[0][0]))
				{	
					String customer=request.getParameter("customer");
					String calltype=request.getParameter("calltype");
					String newcalltype=request.getParameter("newcalltype");
					String desc=request.getParameter("desc");
					String fromdate=request.getParameter("fromdate") ;
					String todate=request.getParameter("todate")  ;
					String nfromdate=request.getParameter("nfromdate") ;
					String ntodate=request.getParameter("ntodate") ;
					String close=request.getParameter("close");
					String opportunityvalue=request.getParameter("opportunityvalue");
					String funnel=request.getParameter("funnel");
					String department=""+request.getParameter("department");
					String designination=""+request.getParameter("designination");
					String cperson=""+request.getParameter("cperson");
					String transactionid=""+request.getParameter("transactionid");
					String winlost=""+request.getParameter("winlost");
					String funnelpercentage=""+request.getParameter("funnelpercentage");
					String quotationnumber=""+request.getParameter("quotationnumber");
					String reschedule=""+request.getParameter("reschedule");
					String finaldescription=""+request.getParameter("finaldescription");
					
					
					
					String quotationassign="Y";
					if(!"Y".equals(funnel))
					{
						funnel ="N"; quotationassign="N";
					}
					
					if("".equals(quotationnumber))
						quotationnumber=null;
						
					if(!"Y".equals(reschedule))
						reschedule="N";
					
					
					if(!"Y".equals(close))
						winlost="N";
					
					if("Y".equals(winlost))
						funnelpercentage="100";
						
					asql = "select INT_CALLID,INT_REFID,CHR_REFNUMBER from mkt_t_daillycalls where INT_CALLID="+id;
					String call[][] =CommonFunctions.QueryExecute(asql);
					if("Y".equals(close))
					{
						acs = con.prepareCall("{call MKT_PRO_DAILYCALLS(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						acs.setString(1, "UPDATE");
						acs.setString(2, id);
						acs.setString(3, "");
						acs.setString(4, calltype);
						acs.setString(5, empid);
						acs.setString(6, desc);
						acs.setString(7, funnel);
						acs.setString(8, DateUtil.FormateDateandTimeSQL(fromdate));
						acs.setString(9, DateUtil.FormateDateandTimeSQL(todate));
						acs.setString(10, "Y");//status
						acs.setString(11, "N");//nextflag
						acs.setString(12, call[0][1]);//refid
						acs.setString(13, null);
						acs.setString(14, call[0][2]);//refnumber
						acs.setString(15,opportunityvalue);
						acs.setString(16, department);
						acs.setString(17, cperson);
						acs.setString(18, quotationnumber );
						acs.setString(19, quotationassign );
						acs.setString(20, transactionid );
						acs.setString(21, funnelpercentage);//funnel percentage
						acs.setString(22, winlost);// funnel win or lost
						acs.setString(23, designination);
						acs.setString(24, reschedule);
						acs.setString(25, finaldescription);
						acs.setString(26, userid);
						System.out.println(""+acs);
						acs.execute();
						
						
					}
					else
					{
						//call continued
						winlost ="N";
						//Update parent row
						acs = con.prepareCall("{call MKT_PRO_DAILYCALLS(?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						acs.setString(1, "UPDATE");
						acs.setString(2, id);
						acs.setString(3, "");
						acs.setString(4, calltype);
						acs.setString(5, empid);
						acs.setString(6, desc);
						acs.setString(7, funnel);
						acs.setString(8, DateUtil.FormateDateandTimeSQL(fromdate));
						acs.setString(9, DateUtil.FormateDateandTimeSQL(todate));
						acs.setString(10, "Y");//status
						acs.setString(11, "Y");//next flag
						acs.setString(12, call[0][1]);//refid
						acs.setString(13, DateUtil.FormateDateandTimeSQL(nfromdate));
						acs.setString(14, call[0][2]);//refnumber
						acs.setString(15,opportunityvalue);
						acs.setString(16, department);
						acs.setString(17, cperson);
						acs.setString(18, quotationnumber );
						acs.setString(19, quotationassign );
						acs.setString(20, transactionid );
						acs.setString(21, funnelpercentage);//funnel percentage
						acs.setString(22, winlost);// funnel win or lost
						acs.setString(23, designination);
						acs.setString(24, reschedule);
						acs.setString(25, finaldescription);
						acs.setString(26, userid);
						System.out.println(""+acs);
						acs.execute();
						
						//INSERT NEW RECORD
						reschedule = "N";
						acs = con.prepareCall("{call MKT_PRO_DAILYCALLS(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						acs.setString(1, "INSERT");
						acs.setString(2, "");
						acs.setString(3, customer);
						acs.setString(4, newcalltype);
						acs.setString(5, empid);
						acs.setString(6, desc);
						acs.setString(7, funnel);
						acs.setString(8, DateUtil.FormateDateandTimeSQL(nfromdate));
						acs.setString(9, null);
						acs.setString(10, "N");//status
						acs.setString(11, "N");//next flag
						acs.setString(12, id);//parent ref id
						acs.setString(13, "");//date follow
						acs.setString(14, call[0][2]); //refnumber
						acs.setString(15,opportunityvalue);
						acs.setString(16, department);
						acs.setString(17, cperson);
						acs.setString(18, quotationnumber );
						acs.setString(19, quotationassign );
						acs.setString(20, transactionid );
						acs.setString(21, funnelpercentage);//funnel percentage
						acs.setString(22, winlost);// funnel win or lost
						acs.setString(23, designination);
						acs.setString(24, reschedule);
						acs.setString(25, finaldescription);
						acs.setString(26, userid);
						System.out.println(""+acs);
						acs.execute();
					}
					
					
					asql = "UPDATE mkt_t_quotation SET CHR_ASSIGNED=? WHERE CHR_QUOTATIONNO =? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,"Y" );
					apstm.setString(2,quotationnumber );
					System.out.println(asql);
					apstm.execute();
					
					
					//If Win means
					if("W".equals(winlost))
					{
						String rowid = WinorLost.revisedQuotation(id, quotationnumber, con, apstm);
						con.close();
						response.sendRedirect("Smart Marketing/QuotationOrderFinalise.jsp?rowid="+rowid);
					}
					else
					{
						con.close();
						response.sendRedirect("Smart Marketing/DaillyCallsAdd.jsp?msg=added successfully...");
					}
				}
				else
				{
					con.close();
					response.sendRedirect("Smart Marketing/DaillyCalls.jsp");
				
				}
				
			}
			else if (action.equals("MKTDaillyCallsDelete")) 
			{
				String ids[] = request.getParameterValues("id");
				int customerid =0;
				String refid="";
				acs = con.prepareCall("{call MKT_PRO_DAILYCALLS(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				for (int i = 0; i < ids.length; i++) 
				{
					
					String sql1="";
					sql1="select INT_CUSTOMERID,INT_REFID from mkt_t_daillycalls where INT_CALLID= "+ids[i];
					String customer[][]=CommonFunctions.QueryExecute(sql1);
					customerid=Integer.parseInt(customer[0][0]);
					refid=customer[0][1];
					String sql ="";
					sql = "update mkt_t_daillycalls SET CHR_STATUS='N', CHR_NEXT ='N' WHERE INT_CALLID ="+refid+" AND INT_CUSTOMERID="+customerid;
					CommonFunctions.Execute(sql); 
					acs.setString(1, "DELETE");
					acs.setString(2, ids[i]);
					acs.setString(3, "");
					acs.setString(4, "");
					acs.setString(5, "");
					acs.setString(6, "");
					acs.setString(7, "");
					acs.setString(8, "");
					acs.setString(9, "");
					acs.setString(10, "");
					acs.setString(11, "");
					acs.setString(12, "");
					acs.setString(13, "");
					acs.setString(14, "");
					acs.setString(15, "");
					acs.setString(16, "");
					acs.setString(17, "");
					acs.setString(18, "");
					acs.setString(19, "");
					acs.setString(20, "");
					acs.setString(21, "");
					acs.setString(22, "");
					acs.setString(23, "");
					acs.setString(24, "");
					acs.setString(25, "");
					acs.setString(25, "");
					System.out.println(""+acs);
					acs.addBatch();
				}
				acs.executeBatch();
				acs.close();
				
				con.close();
				response.sendRedirect("Smart Marketing/DaillyCalls.jsp");
			}
			else if (action.equals("MKTDaillyCallsQuotationAssign")) 
			{
				String rowid = request.getParameter("rowid");
				String quotation = request.getParameter("quotation");
				asql = "";
				asql = asql +" SELECT  SUM(b.INT_QUANTITY * b.DOU_UNITPRICE) from mkt_t_quotation a, mkt_t_quotationitem b  "; 
				asql = asql +"  WHERE a.CHR_QUOTATIONNO = b.CHR_QUOTATIONNO ";    
				asql = asql +"  AND a.CHR_ASSIGNED = 'N' AND a.INT_QUOTATIONID='"+quotation+"'"; 
				asql = asql +"  GROUP BY a.CHR_QUOTATIONNO ";
				System.out.println(""+asql);
				String d[][] = CommonFunctions.QueryExecute(asql);
				String funnelvalue="0";
				if(d.length>0)
					funnelvalue = d[0][0];
				
				String quotationnumber = CommonFunctions.QueryExecute("SELECT  CHR_QUOTATIONNO from mkt_t_quotation  WHERE INT_QUOTATIONID="+quotation)[0][0];	
				asql = "UPDATE mkt_t_daillycalls SET CHR_QUOTATION =?, CHR_QUOTATION_ASSIGN =?, CHR_ADDEDTO_FUNNEL=?,DOU_VALUE=? WHERE INT_CALLID=? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,quotationnumber );
				apstm.setString(2,"Y" );
				apstm.setString(3,"Y" );
				apstm.setString(4,funnelvalue );
				apstm.setString(5,rowid );
				System.out.println(""+apstm);
				apstm.execute();
				
				asql = "UPDATE mkt_t_quotation SET CHR_ASSIGNED=? WHERE INT_QUOTATIONID =? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,"Y" );
				apstm.setString(2,quotation );
				System.out.println(""+apstm);
				apstm.execute();
				
				
				con.close();
				response.sendRedirect("Refresh.jsp");
			}
			else if (action.equals("MKTDaillyCallsConvertFunnel")) 
			{
				String id = request.getParameter("id");
				String calltype=request.getParameter("calltype");
				String desc=request.getParameter("desc");
				String fromdate=request.getParameter("fromdate") ;
				String todate=request.getParameter("todate")  ;
				String close=request.getParameter("close");
				String opportunityvalue=request.getParameter("opportunityvalue");
				String funnel=request.getParameter("funnel");
				if(!"Y".equals(funnel))
					funnel ="N";
				asql = "select INT_CALLID,INT_REFID,CHR_REFNUMBER from mkt_t_daillycalls where INT_CALLID="+id;
				String call[][] =CommonFunctions.QueryExecute(asql);
				asql = " UPDATE mkt_t_daillycalls SET CHR_CONFIRMATION='Y', "; 
				asql = asql + " CHR_CALLTYPE=?, CHR_EMPID=?,CHR_DESC=?, ";
				asql = asql + " DAT_START=?,DAT_END=?, DOU_VALUE=?, ";
				asql = asql + " CHR_STATUS=?,CHR_NEXT=?,INT_REFID=?,CHR_REFNUMBER=?, ";
				asql = asql + " CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),DAT_FOLLOWON=? WHERE INT_CALLID=? ";  
				apstm = con.prepareStatement(asql);
				apstm.setString(1,calltype);
				apstm.setString(2,empid);
				apstm.setString(3,desc);
				apstm.setString(4,DateUtil.FormateDateandTimeSQL(fromdate));
				apstm.setString(5,DateUtil.FormateDateandTimeSQL(todate));
				apstm.setString(6,opportunityvalue);
				apstm.setString(7, "Y");
				apstm.setString(8,"N");
				apstm.setString(9,call[0][1]);
				apstm.setString(10,call[0][2]);
				apstm.setString(11,userid);
				apstm.setString(12,null);
				apstm.setString(13,id);
				System.out.println(""+apstm);
				apstm.execute();
				
				con.close();
				response.sendRedirect("Smart Marketing/Funnel.jsp");
			}
			else if (action.equals("MKTDaillyCallsReAssign")) 
			{
				String rowid = request.getParameter("rowid");
				String fromempid = request.getParameter("fromempid");
				String othersid = request.getParameter("othersid");
				asql = "UPDATE mkt_t_daillycalls SET CHR_CALLTRANSFER =?, CHR_CALLTRANSFER_FROM =? ,CHR_CALLTRANSFER_TO=?,CHR_EMPID=? WHERE INT_CALLID=? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,"Y" );
				apstm.setString(2,fromempid );
				apstm.setString(3,othersid );
				apstm.setString(4,othersid );
				apstm.setString(5,rowid );
				System.out.println(""+apstm);
				apstm.execute();
				con.close();//RefreshExit
				response.sendRedirect("Refresh.jsp");
			}
			
 		} 
		catch (Exception e) 
   	 	{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request	.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response); 
   	 	} 
	}

}
