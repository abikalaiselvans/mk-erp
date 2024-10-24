package com.my.org.erp.SmartInventory;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
public class PaymentCommitmentActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
				String action=request.getParameter("actionS");
				HttpSession session=request.getSession();			
				String userId=""+session.getAttribute("USRID");
				String branchid = session.getAttribute("INVBRANCH").toString();
				
				boolean f = false;
				if(action.equals("INVPaymentCommitmentEntry"))
				{	
					try 
					{
						String param = request.getParameter("param");
						String Billinttype = request.getParameter("Billinttype");
						asql = "UPDATE inv_t_paymentcommitment SET DT_COMMITMENTDATE=?,DOU_COMMITMENTAMOUNT=?,CHR_STATUS='Y',CHR_USRNAME=?,DT_UPDATEDATE=now() WHERE INT_PAYMENTCOMMITMENTID=? AND CHR_SALESNO =? AND CHR_STATUS='N'";
						apstm = con.prepareStatement(asql);
						for(int u=0;u<Integer.parseInt(param);u++)
						{
							String rowid = request.getParameter("rowid"+(u+1));
							String salno = request.getParameter("salno"+(u+1));
							String cdate = request.getParameter("cdate"+(u+1));
							String camount = request.getParameter("camount"+(u+1));
							apstm.setString(1, DateUtil.FormateDateSQL(cdate));
							apstm.setDouble(2, Double.parseDouble(camount));
							apstm.setString(3, auserid);	
							apstm.setString(4, rowid);
							apstm.setString(5, salno);
							System.out.println(""+apstm);
							apstm.addBatch();
							f =true;
						}
						apstm.executeBatch();
						apstm.close();
						
						if(f)
						{
							String support = request.getParameter("support");
							String installation = request.getParameter("installation");
							String transport = request.getParameter("transport");
							String desc = ""+request.getParameter("desc");
							String salno = request.getParameter("saleno");
							asql = " UPDATE inv_t_contribution SET DOU_SUPPORT=?, DOU_INSTALLATION=? , DOU_TRANSPORT=? ,CHR_DESC=? WHERE CHR_SALESNO=?";
							apstm = con.prepareStatement(asql);
							apstm.setString(1, support);
							apstm.setString(2, installation);
							apstm.setString(3, transport);
							apstm.setString(4, desc);
							apstm.setString(5, salno);
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
							
							/*
							//Mail trigger
							String mdata[][] = CommonFunctions.QueryExecute("SELECT  CHR_MAILENABLE ,CHR_INVOICEDELETE FROM m_inventorysetting  WHERE INT_ROWID=1");
							if(mdata.length>0){
								if(mdata[0][0].equals("Y")){
									String subject ="SALES INVOICE:";
									String email =mdata[0][1];
									String a[] =(email+",").split(",") ;
									System.out.println("======");
									String content = InvoiceHTMLMail.mailContent(salno, branchid, session, request.getRealPath("/")); 
									System.out.println("******************************************************************************");
									System.out.println(content);
									System.out.println("******************************************************************************");
									String[] attachments = new String [2];
									attachments[0] =Path+"images\\Header.png";
									attachments[1] =  Path+"images\\logo.jpg";
									if(!"".equals(email) || !"null".equals(email) )
										InvMail.sendEmailWithAttachments(a, subject+": "+salno, content, attachments);
									con.close();  
								}
							}
							*/
						}
						con.close(); 
						
						//mail alert
						if("C".equals(Billinttype))
						{
							
						}
						
						
						
						if("P".equals(Billinttype))
							response.sendRedirect("Smart Inventory/PaymentCommitment.jsp");
						else if("C".equals(Billinttype))
							response.sendRedirect("Smart Inventory/SwapSale.jsp");
						else if("D".equals(Billinttype))
							response.sendRedirect("Smart Inventory/DirectBilling.jsp");
						else if("S".equals(Billinttype))
							response.sendRedirect("Smart Inventory/ServiceBilling.jsp");
						else
							response.sendRedirect("Smart Inventory/InventoryMain.jsp");
					} 
					catch (Exception e) 
					{
						System.out.println(e.getMessage());
						request.setAttribute("error", e.getMessage() );
			            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			    		dispatchers.forward(request, response); 
					}
					 
				}
				else if(action.equals("INVPaymentCommitmentUpdate"))
				{
					
					String rowid = request.getParameter("rowid" );
					String saleno = request.getParameter("saleno" );
					String rdate = request.getParameter("rdate" );
					String desc = request.getParameter("desc"  );
					String ramount = request.getParameter("ramount" );
					asql = "UPDATE inv_t_paymentcommitment SET DT_RECIEVEDDATE=?,DOU_RECEIVEDAMOUNT=?,CHR_DESCRIPTION=?,";
					asql = asql + " CHR_PAYMENTFLAG='Y',CHR_USRNAME=?,DT_UPDATEDATE=now() WHERE INT_PAYMENTCOMMITMENTID=? AND ";
					asql = asql + " CHR_SALESNO =? AND CHR_STATUS='Y' AND CHR_NEXTFLAG='N'";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, DateUtil.FormateDateSQL(rdate));
					apstm.setString(2, ramount);
					apstm.setString(3, desc);
					apstm.setString(4, auserid);	
					apstm.setString(5, rowid);
					apstm.setString(6, saleno);
					apstm.execute();
					con.close();    
					response.sendRedirect("Smart Inventory/PaymentCommitment.jsp");
				}
				else if(action.equals("INVPaymentCommitmentreset"))
				{
					
					String rowid = request.getParameter("rowid" );
					String saleno = request.getParameter("saleno" );
					asql = "UPDATE inv_t_paymentcommitment SET DT_RECIEVEDDATE=?,DOU_RECEIVEDAMOUNT=?,CHR_DESCRIPTION=?,";
					asql = asql + " CHR_PAYMENTFLAG='N',CHR_USRNAME=?,DT_UPDATEDATE=now() WHERE INT_PAYMENTCOMMITMENTID=? AND ";
					asql = asql + " CHR_SALESNO =? AND CHR_STATUS='Y' AND CHR_NEXTFLAG='N'";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, null);
					apstm.setString(2, "0");
					apstm.setString(3, "");
					apstm.setString(4, auserid);	
					apstm.setString(5, rowid);
					apstm.setString(6, saleno);
					apstm.execute();
					con.close();    
					response.sendRedirect("Smart Inventory/PaymentCommitmentUpdate.jsp?salno="+saleno);
				}
				else if("INVPaymentCommitmentPostpone".equals(action))
				{
					String rowid = request.getParameter("rowid" );
					String ppdate = request.getParameter("ppdate" );
					ppdate= DateUtil.FormateDateSQL(ppdate);
					String cdate=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DATE_FORMAT(now(),'%Y-%m-%d')")[0][0];
					String ppamount = request.getParameter("ppamount" );
					asql=" SELECT  CHR_SALESNO,CHR_INVOICETYPE,DOU_ACTUALAMOUNT,DATE_FORMAT(DT_COMMITMENTDATE,'%d-%m-%Y'),DOU_COMMITMENTAMOUNT ";
					asql = asql + "  FROM inv_t_paymentcommitment  WHERE INT_PAYMENTCOMMITMENTID= "+rowid;
					String data[][] =CommonFunctions.QueryExecute(asql);
					if(data.length>0)
					{
						asql = " UPDATE inv_t_paymentcommitment SET CHR_NEXTFLAG='Y' WHERE INT_PAYMENTCOMMITMENTID= "+rowid;
						CommonFunctions.Execute(asql);
						asql = " INSERT INTO inv_t_paymentcommitment (CHR_SALESNO,CHR_INVOICETYPE,DOU_ACTUALAMOUNT,DT_COMMITMENTDATE,DOU_COMMITMENTAMOUNT,CHR_STATUS,CHR_PAYMENTFLAG,CHR_NEXTFLAG,INT_PREVIOUSROWID,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS)";
						asql = asql +"VALUES ( ?,?,?,?,?,?,?,?,?,?,?,? )";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, data[0][0]);
						apstm.setString(2, data[0][1]);
						apstm.setString(3, data[0][2]);
						apstm.setString(4,ppdate);	
						apstm.setString(5, ppamount);
						apstm.setString(6, "Y");
						apstm.setString(7, "N");
						apstm.setString(8, "N");
						apstm.setString(9, rowid);
						apstm.setString(10, auserid);	
						apstm.setString(11, cdate);
						apstm.setString(12, "Y");
						apstm.execute();
						apstm.close();
					}
					con.close();    
					response.sendRedirect("Smart Inventory/PaymentCommitmentPostponseResponse.jsp");
				}
				else if("INVPaymentCommitmentDelete".equals(action))
				{
					String rowid = request.getParameter("rowid" );
					String salno = request.getParameter("salno" );
					String priviousrowid=  com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT INT_PREVIOUSROWID FROM inv_t_paymentcommitment WHERE INT_PAYMENTCOMMITMENTID="+rowid)[0][0];
					asql=" DELETE FROM inv_t_paymentcommitment WHERE INT_PAYMENTCOMMITMENTID= ?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, rowid);
					apstm.execute();
					apstm.close();
					asql = " UPDATE inv_t_paymentcommitment SET CHR_NEXTFLAG ='N' WHERE INT_PAYMENTCOMMITMENTID="+priviousrowid;
					CommonFunctions.Execute(asql);
					con.close();   
					response.sendRedirect("Smart Inventory/PaymentCommitmentUpdate.jsp?salno="+salno);
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

