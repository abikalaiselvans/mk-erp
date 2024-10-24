package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;


import java.util.Map;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.setting.CommonData;

public class DirectBillingActionHandler extends AbstractActionHandler
{
	@SuppressWarnings("rawtypes")
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{		
		try
		{
				String action=""+request.getParameter("actionS").trim();
				HttpSession session=request.getSession();			
				String branchid = session.getAttribute("BRANCHID").toString();
				String user = session.getAttribute("USRID").toString();
				Statement st = con.createStatement();
				String sql="";
				if("INVDirectBillingAdd".equals(action))
				{
					 
					/*
					 * Map params = request.getParameterMap();
					Iterator i = params.keySet().iterator();
					String keys=""; 
					while ( i.hasNext() )
					{
					 String key = (String) i.next();
					 keys =keys+key+",";
					// String value = ((String[]) params.get( key ))[ 0 ];
					}
					 
					
					*/
					
					DirectBilling d = new DirectBilling();
					Map map=request.getParameterMap();
					BeanUtils.populate(d,map);
					
					sql = "SELECT count(*) FROM inv_t_directbilling WHERE CHR_SALESNO='"+d.getSaleno()+"'";
					boolean f = false;
					f =CommonFunctions.RecordExist(con, sql);
					if(!f)
					{
						
						asql = " INSERT INTO inv_t_directbilling  (";
						asql = asql +" INT_BRANCHID,INT_DIVIID,CHR_SALESNO,DAT_SALESDATE,INT_CUSTOMERID,";
						asql = asql +" CHR_REF,CHR_DES,DOU_AMOUNT, DOU_CONTRIBUTION,";
						asql = asql +" INT_TAXID,DOU_TAXVALUE,DOU_NETAMOUNT,CHR_NOOFPAYMENTCOMMITMENT ,";
						asql = asql +" CHR_USRNAME,DT_UPDATEDATE ,CHR_UPDATESTATUS,";
						asql = asql +" INT_PAYMENT_COMMITMENT_DAYS )";
						asql = asql +" VALUES (";
						asql = asql+"?,";
						asql = asql+"?,";
						asql = asql+"? ,";
						asql = asql+"? ,";
						asql = asql+"?,";
						asql = asql+"? ,";
						asql = asql+"? ,";
						asql = asql+"? , ";
						asql = asql+"? , ";
						asql = asql+"? , ";
						asql = asql+"? , ";
						asql = asql+"? , ?,?,DATE(NOW()),'Y',?)";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, branchid);
						apstm.setString(2,""+ d.getDivis());
						apstm.setString(3,d.getSaleno());
						apstm.setString(4,DateUtil.FormateDateSQL(d.getSaleDate()));
						apstm.setString(5,""+d.getCustomer());
						apstm.setString(6,d.getRef() );
						apstm.setString(7,d.getMemo() );
						apstm.setString(8,""+d.getTotals());
						apstm.setString(9,""+d.getContribution());
						apstm.setString(10,""+d.getTax());
						apstm.setString(11,""+d.getTaxamounts());
						apstm.setString(12,""+d.getNetamount() );
						apstm.setString(13,""+d.getNoofpaymentcommitment() );
						apstm.setString(14,auserid );
						apstm.setString(15,""+d.getCommitmentdays() );
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						//insert into payment commitment 
						int noofpayment = (int)d.getNoofpaymentcommitment();
						for(int h=0;h<noofpayment;h++)
						{
							asql="INSERT INTO inv_t_paymentcommitment (CHR_SALESNO,CHR_INVOICETYPE,DOU_ACTUALAMOUNT) VALUE(?,'D',? )";
							apstm = con.prepareStatement(asql);
							apstm.setString(1, d.getSaleno());
							apstm.setString(2, ""+d.getNetamount());
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
							
						}
						con.close();   
						response.sendRedirect("Smart Inventory/PaymentCommitmentEdit.jsp?salno="+d.getSaleno()+"&Billinttype=D");
						
					}
					else
					{
						con.close();    
						response.sendRedirect("Smart Inventory/DirectBillingAdd.jsp?er="+d.getSaleno() +" already entered...");
					}
					
				}
				else if("INVDirectBillingEdit".equals(action))
				{
					
					System.out.println("---------------------------------------------------");
					DirectBilling d = new DirectBilling();
					Map map=request.getParameterMap();
					BeanUtils.populate(d,map);
					asql = "UPDATE inv_t_directbilling SET ";
					asql = asql +" INT_DIVIID= ?,";
					asql = asql +" DAT_SALESDATE = ? ,";
					asql = asql +" INT_CUSTOMERID = ?,";
					asql = asql +" CHR_REF =?,";
					asql = asql +" CHR_DES = ?,";
					asql = asql +" DOU_CONTRIBUTION = ?,";
					asql = asql +" INT_TAXID =?,";
					asql = asql +" DOU_TAXVALUE =?,";
					asql = asql +" DOU_NETAMOUNT = ?,";
					asql = asql +" DOU_AMOUNT = ? ,";
					asql = asql +" CHR_NOOFPAYMENTCOMMITMENT =?,";
					asql = asql +" INT_PAYMENT_COMMITMENT_DAYS =? "; 
					asql = asql +" WHERE CHR_SALESNO=? AND INT_ID=?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,""+d.getDivis());
					apstm.setString(2,DateUtil.FormateDateSQL(d.getSaleDate()));
					apstm.setString(3,""+d.getCustomer() );
					apstm.setString(4,d.getRef() );
					apstm.setString(5,d.getMemo() );
					apstm.setString(6,""+d.getContribution() );
					apstm.setString(7,""+d.getTax() );
					apstm.setString(8,""+d.getTaxamounts() );
					apstm.setString(9,""+d.getNetamount() );
					apstm.setString(10,""+d.getTotals() );
					apstm.setString(11,""+d.getNoofpaymentcommitment() );
					apstm.setString(12,""+d.getCommitmentdays()  );
					apstm.setString(13,d.getSaleno());
					apstm.setString(14,""+d.getRowid());
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					asql = " DELETE FROM inv_t_paymentcommitment WHERE CHR_SALESNO=? AND CHR_INVOICETYPE='D' ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, d.getSaleno());
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					//insert into payment commitment 
					int noofpayment = (int)d.getNoofpaymentcommitment();
					for(int h=0;h<noofpayment;h++)
					{
						asql="INSERT INTO inv_t_paymentcommitment (CHR_SALESNO,CHR_INVOICETYPE,DOU_ACTUALAMOUNT) VALUE(?,'D',?)";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, d.getSaleno());
						apstm.setString(2, ""+d.getTotals());
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
					}
					con.close();    
					response.sendRedirect("Smart Inventory/PaymentCommitmentEdit.jsp?salno="+d.getSaleno()+"&Billinttype=D");
					
				}	
				else if("INVDirectBillingDelete".equals(action))
				{
					
					String salno[] = request.getParameterValues("salesid");
					String email = request.getParameter("email");
					String reason = request.getParameter("reason");
					String salenumber="";
					for(int u=0;u<salno.length;u++)
					{
						asql = "SELECT CHR_SALESNO FROM inv_t_directbilling WHERE INT_ID= "+salno[u];
						salenumber=CommonFunctions.QueryExecute(asql)[0][0];
						
						asql = " DELETE FROM inv_t_directbilling WHERE INT_ID=? ";
						apstm = con.prepareStatement(asql);
						apstm.setString(1 ,salno[u]);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						
						asql =" INSERT INTO inv_t_directsalesdelete (INT_BRANCHID,CHR_SALESNO,CHR_DES,DAT_DELETEDATE,CHR_INVOICEMODE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) ";
						asql = asql +"VALUES ( ?, ?,'test', NOW(),'DIRECT BILLING','ADMIN',NOW(),'Y' )";
						apstm = con.prepareStatement(asql);
						apstm.setString(1 ,branchid);
						apstm.setString(2 ,salno[u]);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
							
						asql = " DELETE FROM inv_t_paymentcommitment WHERE CHR_SALESNO=? AND CHR_INVOICETYPE='D'";
						apstm = con.prepareStatement(asql);
						apstm.setString(1 ,salenumber);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
					 
						
						//Send a mail for Delete invoice
						String a[] =(email+","+CommonData.mailid).split(",") ;
						com.my.org.erp.mail.Mail.SimpleHTMLMail(  a,  "DELETE  DIRECT BILLING :: "+salno[u], InvoiceDeletetMail.InvoiceDeletesendtoMail("DELETE  DIRECT BILLING :: "+salno[u],salno[u],reason, "DIRECT BILLING"));
						 
					}
					//future coding for payment table
					con.close();   
					response.sendRedirect("Smart Inventory/DirectBilling.jsp");
				}
				
				//Billing payment
				else if("INVDirectBillingPaymen".equals(action))
				{
					String Invoiceno= request.getParameter("salesOrderId");
		 		 		 		 	
		 		 	String paymentMethod= request.getParameter("paymentMethod");
		 		 	String payment[]=paymentMethod.split(",");
		 		 	String Bank= request.getParameter("Bank");
		 		 	String customerid= request.getParameter("customerid");
		 		 	sql="SELECT INT_CUSTOMERID,INT_BRANCHID FROM inv_t_directbilling WHERE CHR_SALESNO='"+Invoiceno+"'";
		 		 	String data[][] = CommonFunctions.QueryExecute(sql);
		 		 	customerid = data[0][0];
		 		 	String branch="";
		 		 	branch=data[0][1];
		 		 	if("Select".equals(Bank)|| "".equals(Bank))
		 		 		Bank = "1";
		 		 	
		 		 	String Challanno= request.getParameter("Challanno");
		 		 	String chequeDate = request.getParameter("chequeDate");
		 		 	String paymentDate= request.getParameter("paymentDate");
		 		 	paymentDate =DateUtil.FormateDateSQL(paymentDate);
		 		 	String salesAmount= request.getParameter("salesAmount");
		 		 
		 		 	String Paid= request.getParameter("Paid");
		 		 
		 		 	String remarks=request.getParameter("remarks");
		 		 	String ref=request.getParameter("ref");
		 		 	
		 		 	sql = "INSERT INTO inv_t_directbillingpayment ( ";
		 		 	sql = sql+ " INT_BRANCHID,CHR_SALESNO,INT_CUSTOMERID,INT_PAYMENTTERMID ,";
		 		 	sql = sql+ " INT_BANKID,CHR_REFNO,CHR_CHKDATE,DAT_PAYMENTDATE,DOU_PAIDAMOUNT,";
		 		 	sql = sql+ " CHR_REMARK,CHR_PAYEMENTCOLLECTEDBY,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ) VALUES (";
		 		 	sql = sql+branch+",";
		 		 	sql = sql+"'"+Invoiceno+"' ,";
		 		 	sql = sql+""+customerid+" ,";
		 		 	sql = sql+""+payment[0]+" ,";
		 		 	sql = sql+""+Bank+" ,";
		 		 	sql = sql+"'"+Challanno+"' ,";
		 		 	sql = sql+"'"+DateUtil.FormateDateSQL(chequeDate)+"' , now() ,";
		 		 	sql = sql+""+Paid+" ,";
		 		 	sql = sql+"'"+remarks+"','"+ref+"' ,'"+user+"',now(),'Y')";
		 		 	st.execute(sql);
		 		 	String  paymentid=  CommonFunctions.QueryExecute(" SELECT MAX(INT_PAYMENTID) FROM inv_t_directbillingpayment")[0][0];
		 		 	
		 		 	
		 		 	//	Payment commitment Block start..
		 		 	String rowid = request.getParameter("checkboxs" );
					sql = "UPDATE inv_t_paymentcommitment SET INT_PAYMENTID=?,DT_RECIEVEDDATE=?,DOU_RECEIVEDAMOUNT=?,";
					sql = sql + " CHR_PAYMENTFLAG='Y',CHR_USRNAME=?,DT_UPDATEDATE=now() WHERE CHR_INVOICETYPE ='D' AND INT_PAYMENTCOMMITMENTID=? AND ";
					sql = sql + " CHR_SALESNO =? AND CHR_STATUS='Y' AND CHR_NEXTFLAG='N'";
					PreparedStatement pstm = con.prepareStatement(sql);
					pstm.setString(1, paymentid);//Payment received date
					pstm.setString(2, paymentDate);//Payment received date
					pstm.setString(3, Paid);//Received Amount
					pstm.setString(4, ""+session.getAttribute("USRID"));	
					pstm.setString(5, rowid);
					pstm.setString(6, Invoiceno);
					pstm.execute();
		 		 	pstm.close();
		 		 	// Payment Commitment Block End..
		 		 	
		 		 	
		 		 	
		 		 	
		 		 	
		 		 	
		 		 	double invoiceamount = Double.parseDouble(salesAmount);
		 		 	sql = "SELECT SUM(DOU_PAIDAMOUNT )FROM inv_t_directbillingpayment WHERE CHR_SALESNO='"+Invoiceno+"' AND INT_BRANCHID="+branch;
		 		 	String datas[][] = CommonFunctions.QueryExecute(sql);
		 		 	double paid=0.0;
		 		 	if(datas.length>0)
		 		 		paid = Double.parseDouble(datas[0][0]);
		 		 	
		 		 	
		 		 	if((invoiceamount -paid)>0)
		 		 	{
		 		 		sql = "UPDATE inv_t_directbilling SET CHR_PAYMENTSTATUS='P' WHERE CHR_SALESNO='"+Invoiceno+"' AND INT_BRANCHID="+branch;
		 		 		st.execute(sql);
		 		 		
		 		 		String newcomitmentdate = CommonFunctions.QueryExecute("SELECT DATE_FORMAT(DATE_ADD(DT_COMMITMENTDATE, INTERVAL 7 DAY),'%Y-%m-%d') FROM inv_t_paymentcommitment  WHERE INT_PAYMENTCOMMITMENTID ="+ rowid)[0][0];
						asql = "INSERT INTO inv_t_paymentcommitment (CHR_SALESNO,CHR_INVOICETYPE,DOU_ACTUALAMOUNT,DT_COMMITMENTDATE,DOU_COMMITMENTAMOUNT,CHR_STATUS) ";
						asql = asql + " VALUES(?,?,?,?,?,'Y')";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, Invoiceno);
						apstm.setString(2, "D");
						apstm.setString(3, salesAmount);
						apstm.setString(4, "" + newcomitmentdate);
						apstm.setString(5, "" + (invoiceamount -paid));
						System.out.println("" + apstm);
						apstm.execute();
						apstm.close();
				
				
		 		 	}
		 		 	if((invoiceamount -paid) == 0)
		 		 	{
		 		 		sql = "UPDATE inv_t_directbilling SET CHR_PAYMENTSTATUS='Y' WHERE CHR_SALESNO='"+Invoiceno+"' AND INT_BRANCHID="+branch;
		 		 		st.execute(sql);
		 		 	}
		 		 	con.close();    
		 		 	response.sendRedirect("Smart Inventory/DirectBillingPayment.jsp");
		 		 	
				}
				//Direct Billing Payment Deletion
				else if("INVDirectBillingPaymentDelete".equals(action))
				{
					String invoicenos[]=request.getParameterValues("salesid");
					for(int u=0;u<invoicenos.length;u++)
					{
						String invoiceno = invoicenos[u];
						sql = "DELETE FROM inv_t_directbillingpayment WHERE CHR_SALESNO='"+invoiceno+"' ";
						st.execute(sql);
						sql = "UPDATE inv_t_directbilling SET CHR_PAYMENTSTATUS='N' WHERE CHR_SALESNO='"+invoiceno+"' ";
		 		 		st.execute(sql);
		 		 		
		 		 		//===========================
		 		 		
		 		 		// Delete from Second Commitment to end 
						asql = " SELECT INT_PAYMENTCOMMITMENTID FROM inv_t_paymentcommitment ";
						asql = asql	+ " WHERE  CHR_INVOICETYPE='D' AND CHR_SALESNO='"+ invoiceno + "' ";
						System.out.println("" + apstm);
						String crow = CommonFunctions.QueryExecute(asql)[0][0];

						asql = "DELETE FROM inv_t_paymentcommitment WHERE INT_PAYMENTCOMMITMENTID >? ";
						asql = asql + " AND   CHR_SALESNO=? AND  CHR_INVOICETYPE=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, crow);
						apstm.setString(2, invoiceno);
						apstm.setString(3, "D");
						System.out.println("\n\n" + apstm);
						apstm.execute();
						apstm.close();

						asql = "UPDATE inv_t_paymentcommitment  SET DT_RECIEVEDDATE=null , ";
						asql = asql	+ " DOU_RECEIVEDAMOUNT=0, CHR_PAYMENTFLAG='N' ,CHR_STATUS='Y' ,INT_PAYMENTID =null ";
						asql = asql + " WHERE INT_PAYMENTCOMMITMENTID = ?";
						asql = asql + " AND   CHR_SALESNO = ?";
						asql = asql + " AND  CHR_INVOICETYPE = ?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, crow);
						apstm.setString(2, invoiceno);
						apstm.setString(3, "D");
						System.out.println("\n\n" + apstm);
						apstm.execute();
						apstm.close();

						// reduce the No of commitment
						asql = " UPDATE inv_t_directbilling SET CHR_NOOFPAYMENTCOMMITMENT = (CHR_NOOFPAYMENTCOMMITMENT-1) WHERE CHR_SALESNO =? ";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, invoiceno);
						System.out.println("" + apstm);
						apstm.execute();
						apstm.close();
		 		 		//============================
		 		 		
		 		 		
		 		 		
					}
					con.close();    
					response.sendRedirect("Smart Inventory/DirectBillingPayment.jsp");
				}
				else if("INVDirectBillingPaymentEditDelete".equals(action))
				{
					String invoiceno = request.getParameter("invoiceno");
					String row = request.getParameter("row");
					sql = "DELETE FROM inv_t_directbillingpayment WHERE CHR_SALESNO='"+invoiceno+"' AND INT_PAYMENTID="+row;
					st.execute(sql);
					sql = "SELECT DOU_AMOUNT FROM inv_t_directbilling  WHERE CHR_SALESNO='"+invoiceno+"' ";
					String amounts[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					double invoiceamount = 0.0;
					if(amounts.length>0)
						invoiceamount=Double.parseDouble(amounts[0][0]);
					
		 		 	sql = "SELECT SUM(DOU_PAIDAMOUNT )FROM inv_t_directbillingpayment WHERE CHR_SALESNO='"+invoiceno+"'";
		 		 	String datas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 		 	
		 		 	double paid=0.0;
		 		 	if(datas.length>0)
		 		 		if(!"-".equals(datas[0][0]))
		 		 			paid = Double.parseDouble(datas[0][0]);
		 		 	
		 		 	if(((invoiceamount -paid)>1 ) )
		 		 	{
		 		 		sql = "UPDATE inv_t_directbilling SET CHR_PAYMENTSTATUS='P' WHERE CHR_SALESNO='"+invoiceno+"'";
		 		 		st.execute(sql);
		 		 	}
		 		 	if(paid==0 )
		 		 	{
		 		 		sql = "UPDATE inv_t_directbilling SET CHR_PAYMENTSTATUS='N' WHERE CHR_SALESNO='"+invoiceno+"'";
		 		 		st.execute(sql);
		 		 	}
		 		 	
		 		 	if((invoiceamount -paid) == 0)
		 		 	{
		 		 		sql = "UPDATE inv_t_directbilling SET CHR_PAYMENTSTATUS='Y' WHERE CHR_SALESNO='"+invoiceno+"'";
		 		 		st.execute(sql);
		 		 	}
		 		 	
		 		 	
		 		 	sql = "UPDATE inv_t_paymentcommitment  SET DT_RECIEVEDDATE=null , DOU_RECEIVEDAMOUNT=0, CHR_PAYMENTFLAG='N' WHERE INT_PAYMENTID="+row +" AND   CHR_SALESNO='"+invoiceno+"' AND  CHR_INVOICETYPE='D'"; 
		 		 	com.my.org.erp.common.CommonFunctions.Execute(sql);
					
		 		  
		 		 			 
		 		 	con.close();    
					response.sendRedirect("Smart Inventory/DirectBillingPayment.jsp");
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


