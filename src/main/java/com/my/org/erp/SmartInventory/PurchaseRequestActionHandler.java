package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class PurchaseRequestActionHandler extends AbstractActionHandler
{
	public synchronized void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{		
		try
		{
				String action=""+request.getParameter("actionS").trim();
				HttpSession session=request.getSession();			
				String branchid = session.getAttribute("INVBRANCH").toString();
				String user = session.getAttribute("USRID").toString();
				String officeid=""+session.getAttribute("INVOFFICEID");
				String empid=""+session.getAttribute("EMPID");
				
				if("INVPurchaseRequestAdd".equals(action))
				{
					
					String divis = request.getParameter("divis");
					String divisionid=divis;
					String saleDate = request.getParameter("saleDate");
					saleDate=  DateUtil.FormateDateSQL(saleDate);
					String purchasedate = request.getParameter("purchasedate");
					purchasedate=  DateUtil.FormateDateSQL(purchasedate);
					
					String customer = request.getParameter("customer");
					String Shipping = request.getParameter("Shipping");
					String shippingaddress = request.getParameter("shippingaddress");
					String payment = request.getParameter("payment");
					String noofpaymentcommitment = request.getParameter("noofpaymentcommitment");
					String ref = request.getParameter("ref");
					String memo = request.getParameter("memo");
					String byback = request.getParameter("byback");
					String salesnumber = request.getParameter("salesnumber");
					
					if(!"Y".equals(byback))
						byback="N";
					//String reqestno=  "PRN/"+InventoryInvoiceFunctions.accountYear()+InventoryInvoiceFunctions.purchaseRequestBillNumber() +"/"+InventoryInvoiceFunctions.invoiceLocation(officeid)+"/"+InventoryInvoiceFunctions.invoiceDivision(divisionid);
					String reqestno=  InventoryInvoiceFunctions.directPurchaseRequestGet(officeid,divisionid);
					
					String param[] = request.getParameter("param").split(",");
					asql=" INSERT INTO  inv_t_purchaserequest ( INT_BRANCHID,INT_DIVIID,CHR_POREQUESTNO,DAT_REQUESTDATE,DAT_PURCHASEDATE,INT_CUSTOMERID,CHR_SHIPPING, ";
					asql=asql+" CHR_SHIPPINGADDRESS,INT_PAYMENTTERMID,INT_CUSTOMERCOMMITMENTDAYS,CHR_REF, ";
					asql=asql+" CHR_DES,"; 
					asql=asql+" CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS,DAT_COMMITMENTDATE,CHR_BYBACK,CHR_SALESNO ) ";
					asql=asql+" VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,DATE(NOW()),'Y', DATE_FORMAT(DATE_ADD('"+saleDate+"' , INTERVAL "+noofpaymentcommitment+" DAY),'%Y-%m-%d'),?,?   ) ";
					 
					apstm = con.prepareStatement(asql);
					apstm.setString(1,branchid);
					apstm.setString(2,divis);
					apstm.setString(3,reqestno);
					apstm.setString(4,saleDate);
					apstm.setString(5,purchasedate);
					apstm.setString(6,customer);
					apstm.setString(7,Shipping);
					apstm.setString(8,shippingaddress);
					apstm.setString(9, payment);
					apstm.setString(10,noofpaymentcommitment);
					apstm.setString(11,ref );
					apstm.setString(12, memo);
					apstm.setString(13,user);
					apstm.setString(14,byback);
					apstm.setString(15,salesnumber);
					System.out.println(""+apstm);
					apstm.execute();
					
					
					 
					 
					/*asql=" INSERT INTO inv_m_purchaserequestnogenerate VALUES (?)";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,InventoryInvoiceFunctions.purchaseRequestBillNumber() );
					apstm.execute();
					*/
					
					asql=" SELECT FUN_INV_DIRECT_PURCHASE_REQUEST_NUMBER_INSERT()";
					apstm = con.prepareStatement(asql);
					System.out.println(""+apstm);
					apstm.execute();
					
					
					
					asql = "  INSERT INTO  inv_t_purchaserequestitem ( ";
					asql = asql +" CHR_POREQUESTNO,INT_VENDORID ,CHR_TYPE,CHR_ITEMID,CHR_DESC,INT_QUANTITY,DOU_UNITPRICE,";
					asql = asql +" INT_P_TAXID,DOU_P_TAX_PERCENTAGE,DOU_P_TAX_AMOUNT, ";
					asql = asql +" DOU_PURCHASEPRICE, CHR_PURCHASEWARRANTY ,";
					asql = asql +" DOU_UNITSALEPRICE,";
					asql = asql +" INT_S_TAXID,DOU_S_TAX_PERCENTAGE,DOU_S_TAX_AMOUNT,";
					asql = asql +" DOU_SALESPRICE,CHR_SALESWARRANTY,";
					asql = asql +" CHR_ADDITIONALWARRANTY, DOU_INSTALLATION, DOU_DELIVERY,DOU_ADDITIONALWARRANTY,DOU_GROSSVALUE,DOU_GROSSMARGIN,DOU_MARGIN,";
					asql = asql +" DOU_CONTRIBUTION,DOU_CONTRIBUTION_PERCENTAGE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
					asql=asql+" VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,DATE(NOW()),'Y' ) ";
					apstm = con.prepareStatement(asql);
					String itype="";
					String iid="";
					for(int p=0;p<param.length; p++)
					{
						
						String e =""+request.getParameter("itype"+param[p].trim());
						iid =""+request.getParameter("item"+param[p].trim());
						if(e.equals("1") )
							itype="I";
						if(e.equals("2") )
							itype="P";
						apstm.setString(1,reqestno );
						apstm.setString(2,request.getParameter("vendorid"+param[p]) );
						apstm.setString(3,itype);
						apstm.setString(4,iid);
						apstm.setString(5,request.getParameter("desc"+param[p]) );
						apstm.setString(6,request.getParameter("Quantity"+param[p]) );
						apstm.setString(7,request.getParameter("Unitprice"+param[p]) );
						apstm.setString(8,request.getParameter("ptax"+param[p]) );
						apstm.setString(9,request.getParameter("ptaxpercent"+param[p]) );
						apstm.setString(10,request.getParameter("ptaxamount"+param[p]) );
						apstm.setString(11, request.getParameter("Purchaseprice"+param[p]));
						apstm.setString(12,request.getParameter("pwarranty"+param[p]) );
						apstm.setString(13,request.getParameter("unitsalesprice"+param[p]) );
						apstm.setString(14,request.getParameter("stax"+param[p]) );
						apstm.setString(15,request.getParameter("staxpercent"+param[p]) );
						apstm.setString(16,request.getParameter("staxamount"+param[p]) );
						apstm.setString(17,request.getParameter("Salesprice"+param[p]) );
						apstm.setString(18,request.getParameter("swarranty"+param[p]) );
						if("Y".equals(request.getParameter("idayn"+param[p])))
							apstm.setString(19,"Y" );
						else
							apstm.setString(19,"N" );
						apstm.setString(20,request.getParameter("installation"+param[p]) );
						apstm.setString(21,request.getParameter("delivery"+param[p]) );
						apstm.setString(22,request.getParameter("additionalwarranty"+param[p]) );
						apstm.setString(23,request.getParameter("grosssalevalue"+param[p]) );
						 
						double pprice = Double.parseDouble(""+request.getParameter("Purchaseprice"+param[p]));
						double sprice = Double.parseDouble(""+request.getParameter("Salesprice"+param[p]));
						double tax_pprice = Double.parseDouble(""+request.getParameter("ptaxamount"+param[p]));
						double tax_sprice = Double.parseDouble(""+request.getParameter("staxamount"+param[p])); 
						
						
						pprice = pprice - tax_pprice;
						sprice = sprice - tax_sprice;
						
						double grossvalue = Double.parseDouble(""+request.getParameter("grosssalevalue"+param[p])); 
						double Contribution =  (sprice-pprice);
						
						System.out.println("============"+ sprice +"/"+pprice +"----"+Contribution);
						double Contributionpercentage =0;
						if(pprice>0)
							Contributionpercentage =  (Contribution/pprice)*100;
						else
							Contributionpercentage=0;
						 
						double grossmargin = grossvalue;
						double margin =0;
						if(grossmargin>0)
							margin = grossmargin/pprice *100;
							//margin = grossmargin/sprice *100;
						
						apstm.setString(24,""+grossmargin );
						apstm.setString(25,""+margin );
						
						apstm.setString(26,""+Contribution );
						apstm.setString(27,""+Contributionpercentage );
						apstm.setString(28, user );
						System.out.println("------"+apstm);
						System.out.println();
						apstm.addBatch();
					}
					apstm.executeBatch();
					apstm.close();
					 
					
					//UPDATE PURCHASE REQUEST
					asql = " UPDATE inv_t_purchaserequestitem SET ";
					asql = asql +" DOU_PURCHASEPRICE = (DOU_PURCHASEPRICE-DOU_P_TAX_AMOUNT) ,";
					asql = asql +" DOU_SALESPRICE =  ( DOU_SALESPRICE -DOU_S_TAX_AMOUNT) ";
					asql = asql +" WHERE CHR_POREQUESTNO= ?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,reqestno );
					System.out.println(""+apstm);
					//apstm.execute();  
		            
					
					asql = " UPDATE inv_t_purchaserequest SET ";
					asql = asql +" CHR_LOW_CONTRIBUTION1 ='Y',";
					asql = asql +" CHR_LOW_CONTRIBUTION_DESCRIPTION1='AUOMATIC',  ";
					asql = asql +" DAT_LOW_CONTRIBUTION_TIME1 = NOW(),";
					asql = asql +" CHR_LOW_CONTRIBUTION2 ='Y', ";
					asql = asql +" CHR_LOW_CONTRIBUTION_DESCRIPTION2='AUOMATIC' ,";
					asql = asql +" DAT_LOW_CONTRIBUTION_TIME2 = NOW() ";
					asql = asql +" WHERE CHR_POREQUESTNO= ?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,reqestno );
					System.out.println(""+apstm);
					apstm.execute();  
		               
					//Mail generate
					PurchaseRequestMailTemplate.sendpurchaseRequestMail(branchid,reqestno, divis, Path, true) ;
					con.close();   
					response.sendRedirect("Smart Inventory/PurchaseRequest.jsp");
					 
					 
					
				}
				else if("INVPurchaseRequestMail".equals(action))
				{
					String reqestno = request.getParameter("Requestno");
					String to = request.getParameter("mailid");
					String a[] =(to+",").split(",") ;
					String division = CommonFunctions.QueryExecute(" SELECT INT_DIVIID FROM inv_t_purchaserequest WHERE CHR_POREQUESTNO='"+reqestno+"'")[0][0];
					//Mail generate
					if(!"".equals(to) || !"null".equals(to) )
						PurchaseRequestMailTemplate.sendpurchaseRequestMail(branchid,reqestno, division, Path, false) ;
					
					response.sendRedirect("Smart Inventory/PurchaseRequest.jsp");
				}
				
				else if("INVPurchaseRequestEdit".equals(action))
				{ 
					String reqestno = request.getParameter("Requestno");
					String divis = request.getParameter("divis");
					String saleDate = request.getParameter("saleDate");
					saleDate= com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(saleDate);
					String purchasedate = request.getParameter("purchasedate");
					purchasedate= com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(purchasedate);
					
					String customer = request.getParameter("customer");
					String Shipping = request.getParameter("Shipping");
					String shippingaddress = request.getParameter("shippingaddress");
					String payment = request.getParameter("payment");
					String noofpaymentcommitment = request.getParameter("noofpaymentcommitment");
					String ref = request.getParameter("ref");
					String memo = request.getParameter("memo");
					String param[] = request.getParameter("param").split(",");
					
					asql=" UPDATE inv_t_purchaserequest  SET INT_DIVIID=?, DAT_REQUESTDATE=?,INT_CUSTOMERID=?,CHR_SHIPPING=?, ";
					asql=asql+" CHR_SHIPPINGADDRESS=?,INT_PAYMENTTERMID=?,INT_CUSTOMERCOMMITMENTDAYS=?,CHR_REF=?, ";
					asql=asql+" CHR_DES=?,"; 
					asql=asql+" CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y',DAT_PURCHASEDATE=?,   ";
					asql=asql+"  DAT_COMMITMENTDATE = DATE_FORMAT(DATE_ADD('"+saleDate+"', INTERVAL "+noofpaymentcommitment+" DAY),'%Y-%m-%d') "; 
					asql=asql+" WHERE CHR_POREQUESTNO=? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,divis);
					apstm.setString(2,saleDate);
					apstm.setString(3,customer);
					apstm.setString(4,Shipping);
					apstm.setString(5,shippingaddress);
					apstm.setString(6, payment);
					apstm.setString(7,noofpaymentcommitment);
					apstm.setString(8,ref );
					apstm.setString(9, memo);
					apstm.setString(10,user);
					apstm.setString(11,purchasedate);
					apstm.setString(12,reqestno);
					System.out.println(""+apstm);
					apstm.execute();
					
					asql=" DELETE FROM inv_t_purchaserequestitem WHERE CHR_POREQUESTNO=? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,reqestno);
					apstm.execute();
					 
					
					asql = "  INSERT INTO  inv_t_purchaserequestitem ( ";
					asql = asql +" CHR_POREQUESTNO,INT_VENDORID ,CHR_TYPE,CHR_ITEMID,CHR_DESC,INT_QUANTITY,DOU_UNITPRICE,";
					asql = asql +" INT_P_TAXID,DOU_P_TAX_PERCENTAGE,DOU_P_TAX_AMOUNT, ";
					asql = asql +" DOU_PURCHASEPRICE, CHR_PURCHASEWARRANTY ,";
					asql = asql +" DOU_UNITSALEPRICE,";
					asql = asql +" INT_S_TAXID,DOU_S_TAX_PERCENTAGE,DOU_S_TAX_AMOUNT,";
					asql = asql +" DOU_SALESPRICE,CHR_SALESWARRANTY,";
					asql = asql +" CHR_ADDITIONALWARRANTY, DOU_INSTALLATION, DOU_DELIVERY,DOU_ADDITIONALWARRANTY,DOU_GROSSVALUE,DOU_GROSSMARGIN,DOU_MARGIN,";
					asql = asql +" DOU_CONTRIBUTION,DOU_CONTRIBUTION_PERCENTAGE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
					asql = asql+" VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,DATE(NOW()),'Y' ) ";
					apstm = con.prepareStatement(asql);
					String itype="";
					String iid="";
					for(int p=0;p<param.length; p++)
					{
						
						String e =""+request.getParameter("itype"+param[p].trim());
						iid =""+request.getParameter("item"+param[p].trim());
						if(e.equals("1") )
							itype="I";
						if(e.equals("2") )
							itype="P";
						apstm.setString(1,reqestno );
						apstm.setString(2,request.getParameter("vendorid"+param[p]) );
						apstm.setString(3,itype);
						apstm.setString(4,iid);
						apstm.setString(5,request.getParameter("desc"+param[p]) );
						apstm.setString(6,request.getParameter("Quantity"+param[p]) );
						apstm.setString(7,request.getParameter("Unitprice"+param[p]) );
						apstm.setString(8,request.getParameter("ptax"+param[p]) );
						apstm.setString(9,request.getParameter("ptaxpercent"+param[p]) );
						apstm.setString(10,request.getParameter("ptaxamount"+param[p]) );
						apstm.setString(11,request.getParameter("Purchaseprice"+param[p]) );
						apstm.setString(12,request.getParameter("pwarranty"+param[p]) );
						apstm.setString(13,request.getParameter("unitsalesprice"+param[p]) );
						apstm.setString(14,request.getParameter("stax"+param[p]) );
						apstm.setString(15,request.getParameter("staxpercent"+param[p]) );
						apstm.setString(16,request.getParameter("staxamount"+param[p]) );
						apstm.setString(17,request.getParameter("Salesprice"+param[p]) );
						apstm.setString(18,request.getParameter("swarranty"+param[p]) );
						if("Y".equals(request.getParameter("idayn"+param[p])))
							apstm.setString(19,"Y" );
						else
							apstm.setString(19,"N" );
						apstm.setString(20,request.getParameter("installation"+param[p]) );
						apstm.setString(21,request.getParameter("delivery"+param[p]) );
						apstm.setString(22,request.getParameter("additionalwarranty"+param[p]) );
						apstm.setString(23,request.getParameter("grosssalevalue"+param[p]) );
						double pprice = Double.parseDouble(""+request.getParameter("Purchaseprice"+param[p]));
						double sprice = Double.parseDouble(""+request.getParameter("Salesprice"+param[p]));
						double tax_pprice = Double.parseDouble(""+request.getParameter("ptaxamount"+param[p]));
						double tax_sprice = Double.parseDouble(""+request.getParameter("staxamount"+param[p])); 
						pprice = pprice - tax_pprice;
						sprice = sprice - tax_sprice;
						
						double grossvalue = Double.parseDouble(""+request.getParameter("grosssalevalue"+param[p])); 
						double Contribution =  (sprice-pprice);
						double Contributionpercentage =0;
						if(pprice>0)
							Contributionpercentage =  (Contribution/pprice)*100;
						else
							Contributionpercentage=0;
						  
						
						double grossmargin = grossvalue;
						double margin =0;
						if(grossmargin>0)
							margin = grossmargin/sprice *100;
						
						apstm.setString(24,""+grossmargin );
						apstm.setString(25,""+margin );
						apstm.setString(26,""+Contribution );
						apstm.setString(27,""+Contributionpercentage );
						apstm.setString(28, user );
						System.out.println(""+apstm);
						apstm.addBatch();
					}
					apstm.executeBatch();
					apstm.close();
					
					
					asql = " UPDATE inv_t_purchaserequestitem SET ";
					asql = asql +" DOU_PURCHASEPRICE = (DOU_PURCHASEPRICE-DOU_P_TAX_AMOUNT) ,";
					asql = asql +" DOU_SALESPRICE =  ( DOU_SALESPRICE -DOU_S_TAX_AMOUNT) ";
					asql = asql +" WHERE CHR_POREQUESTNO= ?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,reqestno );
					System.out.println(""+apstm);
					//apstm.execute();  
		            
					
					/*//UPDATE LOW CONTRIBUTION
					acs = con.prepareCall("{call  INV_PRO_LOWCONTRIBUTION_UPDATE(?)}");
					acs.setString(1, reqestno);
					acs.execute();
					acs.close();
					String contributionmode = CommonFunctions.QueryExecute("SELECT FUN_INV_LOWCONTRIBUTION_MODE('"+reqestno+"')")[0][0];
					if("A".equals(contributionmode))
					{
						content = content+ "<br><br>";
						content = content+ "<H2  style='background-color:#FFFF33'>Kind Attention - Division Head & Super Admin <br>";
						content = content+ "<H3>The contribution of purchase request is low. so kindly will you give the acknowledge and reason as well in advance...</H3>";
						content = content+ "</H2>";
					}	
					else if("B".equals(contributionmode))
					{	
						content = content+ "<br><br>";
						content = content+ "<H2 style='background-color:#FFFF33'>Kind Attention - Division Head  <br>";
						content = content+ "<H3>The contribution of purchase request is low. so kindly will you give the acknowledge and reason as well in advance...</H3>";
						content = content+ "</H2>";
					}	
					
					
					customer=  CommonFunctions.QueryExecute("SELECT b.CHR_NAME FROM inv_m_customerinfo a, inv_m_customergroup b WHERE a.INT_CUSTOMERGROUPID=b.INT_CUSTOMERGROUPID AND a.INT_CUSTOMERID="+customer)[0][0];
					
					if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]))
					{	
						String to =  CommonFunctions.QueryExecute("SELECT CHR_EMAILID FROM inv_m_division  WHERE INT_DIVIID="+divis)[0][0];
						String approvalmail =  CommonFunctions.QueryExecute("SELECT CHR_PR_APPROVAL ,CHR_PR_CLOSED FROM m_inventorysetting WHERE INT_ROWID=1")[0][0];
						String content =PurchaseRequestMail.PurchaseRequestContent(true,reqestno);
						String a[] =(to+","+approvalmail).split(",") ;
						PurchaseRequestMail.PurchaseRequestsendtoMail(a, "MODIFIED THE PURCHASE REQUEST NUMBER  :: "+reqestno+ "      [ "+customer+" ]", content);
					}	
					*/
					
					//Mail generate
					PurchaseRequestMailTemplate.sendpurchaseRequestModifiedMail(branchid,reqestno, divis, Path, true) ;
					
					con.close();   
					response.sendRedirect("Smart Inventory/PurchaseRequest.jsp");
				}	
				else if("INVPurchaseRequestDelete".equals(action))
				{
					
					String reqestno = request.getParameter("Requestno");
					String to =  CommonFunctions.QueryExecute("SELECT INT_DIVIID FROM   inv_t_purchaserequest WHERE CHR_POREQUESTNO='"+reqestno+"'")[0][0];
					String approvalmail =  CommonFunctions.QueryExecute("SELECT CHR_PR_APPROVAL ,CHR_PR_CLOSED FROM   m_mailsetting WHERE INT_MAILID=1")[0][0];
					String content =PurchaseRequestMail.PurchaseRequestContent(true,reqestno);
					String a[] =(to+","+approvalmail).split(",") ;
					PurchaseRequestMail.PurchaseRequestsendtoMail(a, " DELETED THE PURCHASE REQUEST NUMBER  :: "+reqestno , content);
					Thread.sleep(10000);
					
					asql=" DELETE FROM inv_t_purchaserequestitem WHERE CHR_POREQUESTNO=?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,reqestno);
					apstm.execute();
					
					
					asql="DELETE FROM inv_t_purchaserequest WHERE CHR_POREQUESTNO=?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,reqestno);
					apstm.execute();
					con.close();   
					response.sendRedirect("Smart Inventory/PurchaseRequest.jsp");
				}
				else if("INVPurchaseRequestDivision".equals(action))
				{
					String reqestno = request.getParameter("Requestno");
					String Accept = request.getParameter("Accept");
					String memo = request.getParameter("memo");
					asql = "UPDATE inv_t_purchaserequest SET  INT_PROGRESSBAR =40,";
					asql = asql + " CHR_LOW_CONTRIBUTION1 =?, ";
					asql = asql + " CHR_LOW_CONTRIBUTION_DESCRIPTION1=?, ";
					asql = asql + " DAT_LOW_CONTRIBUTION_TIME1 = ?   ";
					asql = asql + " WHERE CHR_POREQUESTNO=? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,Accept);
					apstm.setString(2,memo);
					apstm.setString(3,DateUtil.getCurrentDateTime());
					apstm.setString(4,reqestno);
					System.out.println("B.H Approved :: "+apstm);
					apstm.execute();
					apstm.close();
					
					/*asql = asql + " CHR_LOW_CONTRIBUTION2 =?, ";
					asql = asql + " CHR_LOW_CONTRIBUTION_DESCRIPTION2=?, ";
					asql = asql + " DAT_LOW_CONTRIBUTION_TIME2 = ?  ";
					apstm.setString(4,Accept);
					apstm.setString(5,memo);
					apstm.setString(6,DateUtil.getCurrentDateTime());
					
					*/
					 
					
					con.close(); 
					 
					
					//Mail generate
					String division = CommonFunctions.QueryExecute(" SELECT INT_DIVIID FROM inv_t_purchaserequest WHERE CHR_POREQUESTNO='"+reqestno+"'")[0][0];
					PurchaseRequestMailTemplate.sendpurchaseRequestDivisionMail(branchid,reqestno, division, Path, "This can be closed. <br>"+memo) ;
					response.sendRedirect("Smart Inventory/PurchaseRequestDivision.jsp");
				}
				else if("INVPurchaseRequestAdmin".equals(action))
				{
					String reqestno = request.getParameter("Requestno");
					String Accept = request.getParameter("Accept");
					String memo = request.getParameter("memo");
					asql = "UPDATE inv_t_purchaserequest SET  INT_PROGRESSBAR =45,";
					asql = asql + " CHR_LOW_CONTRIBUTION2 =?, ";
					asql = asql + " CHR_LOW_CONTRIBUTION_DESCRIPTION2=?, ";
					asql = asql + " DAT_LOW_CONTRIBUTION_TIME2 = ? , ";
					asql = asql + "  CHR_APPROVEDBY=?, "; 
					asql = asql + "  CHR_APPROVEDDESCRIPTION=?, ";
					asql = asql + "  CHR_APPROVEDSTATUS=?,DAT_APPROVEDDATE= NOW()   ";
					asql = asql + " WHERE CHR_POREQUESTNO=? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,Accept);
					apstm.setString(2,memo);
					apstm.setString(3,DateUtil.getCurrentDateTime());
					apstm.setString(4,""+session.getAttribute("EMPID"));
					apstm.setString(5,"AUTOMATIC");
					apstm.setString(6,"Y");
					apstm.setString(7,reqestno);
					System.out.println("Admin - Approved ::"+apstm);
					apstm.execute();
					apstm.close();
					
					/*asql = asql + " CHR_LOW_CONTRIBUTION1 =?, ";
					asql = asql + " CHR_LOW_CONTRIBUTION_DESCRIPTION1=?, ";
					asql = asql + " DAT_LOW_CONTRIBUTION_TIME1 = ?,  ";
					apstm.setString(1,Accept);
					apstm.setString(2,memo);
					apstm.setString(3,DateUtil.getCurrentDateTime());
					*/
					
					asql = "UPDATE inv_t_purchaserequestitem SET CHR_ACCEPT=?,";
					asql = asql + " CHR_DESCRIPTION=?  WHERE  CHR_POREQUESTNO=? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,"Y");
					apstm.setString(2,"AUTOMATIC");
					apstm.setString(3,reqestno);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
									
					
					//Mail generate
					String division = CommonFunctions.QueryExecute(" SELECT INT_DIVIID FROM inv_t_purchaserequest WHERE CHR_POREQUESTNO='"+reqestno+"'")[0][0];
					PurchaseRequestMailTemplate.sendpurchaseRequestAdminMail(branchid,reqestno, division, Path, "This can be closed. <br>"+memo) ;
					
					con.close();   
					response.sendRedirect("Smart Inventory/PurchaseRequestAdmin.jsp");
				}
				else if("INVPurchaseRequestAccept".equals(action))
				{
					
					String reqestno = request.getParameter("Requestno");
					String Accept = request.getParameter("Accept");
					
					String memo = request.getParameter("memo");
					String ref = request.getParameter("ref");
					String length  = request.getParameter("dec");
					String accept="";
					String reject="";
					String rejectdec="";
					String rowid="";
					asql="";
					asql = "UPDATE inv_t_purchaserequestitem SET CHR_ACCEPT=?,CHR_DESCRIPTION=?   ";
					asql = asql + " WHERE INT_ROWID=?";
					apstm = con.prepareStatement(asql);
					for(int u=0;u<Integer.parseInt(length);u++)
					{
						asql="";
						accept = request.getParameter("accept"+u);
						reject = request.getParameter("reject"+u);
						rejectdec = request.getParameter("dec"+u);
						rowid=request.getParameter("rowid"+u);
						if("on".equals(accept))
						{
							apstm.setString(1,"Y");
							apstm.setString(2,null);
							apstm.setString(3,rowid);
						}
						else if("on".equals(reject))
						{
							apstm.setString(1,"R");
							apstm.setString(2,rejectdec);
							apstm.setString(3,rowid);
						}
						if(!"H".equals(Accept))
							apstm.addBatch();
					}
					apstm.executeBatch();
					
					
					String d[][] =  CommonFunctions.QueryExecute("SELECT CHR_ACCEPT  FROM inv_t_purchaserequestitem  WHERE CHR_POREQUESTNO='"+reqestno+"'");
					List<String> list = new ArrayList<String>();
					if(d.length>0)
						for(int i=0;i<d.length;i++)
							list.add(d[i][0]);
					String status="";
					if(list.contains("R") && list.contains("Y"))
						status="P";
					else if(list.contains("R")&& !list.contains("Y"))
						status="R"; 
					else
						status="Y"; 
					
					if(!"P".equals(status))
						status =Accept;
					
					asql=" UPDATE inv_t_purchaserequest  SET INT_PROGRESSBAR =70,CHR_APPROVEDBY=?, CHR_APPROVEDDESCRIPTION=?,";
					asql = asql + " CHR_APPROVEDSTATUS=?,DAT_APPROVEDDATE= NOW()   ";
					asql = asql + "  ";
					asql=asql+" WHERE CHR_POREQUESTNO=? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,ref);
					apstm.setString(2,memo);
					apstm.setString(3,status);
					apstm.setString(4,reqestno);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					
					String cporefnumber = request.getParameter("cporefnumber" );
					String stockmode = request.getParameter("stockmode" );
					String saleorderapproval = request.getParameter("saleorderapproval" );
					if(!"Y".equals(saleorderapproval))
						saleorderapproval ="N";
					if("C".equals(stockmode))
					{
						asql = "UPDATE inv_t_customersalesorder SET CHR_SALEORDER_APPROVAL=?,CHR_SALEORDER_DESC=? WHERE CHR_SALESORDERNO =?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,saleorderapproval );
						apstm.setString(2,"AUTOMATIC FROM PURCHASE REQUEST" );
						apstm.setString(3,cporefnumber );
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
					}
					
					
					String content ="";//PurchaseRequestMail.PurchaseRequestContent(false,reqestno);
					String customer = request.getParameter("customer");
					customer=  CommonFunctions.QueryExecute("SELECT b.CHR_NAME FROM inv_m_customerinfo a, inv_m_customergroup b WHERE a.INT_CUSTOMERGROUPID=b.INT_CUSTOMERGROUPID AND a.INT_CUSTOMERID="+customer)[0][0];
					status=""+request.getParameter("Accept");
					if("Y".equals(status ))
						content ="Approved... ";
					else if("H".equals(status ))
						content ="Holded due to "+memo;
					else if("R".equals(status ))
						content ="Rejected due to "+memo;
					
					 
					/*if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]))
					{
						String approvalmail[][] =  CommonFunctions.QueryExecute("SELECT CHR_PR_APPROVAL ,CHR_PR_CLOSED FROM   m_inventorysetting WHERE INT_ROWID=1") ;
						String a[] =(approvalmail[0][1]+",").split(",") ;
						PurchaseRequestMail.PurchaseRequestsendtoMail(a, "PURCHASE REQUEST NUMBER  :: "+reqestno+ "      [ "+customer+" ]", content);
					}	*/
					con.close();   
					
					//Mail generate
					String division = CommonFunctions.QueryExecute(" SELECT INT_DIVIID FROM inv_t_purchaserequest WHERE CHR_POREQUESTNO='"+reqestno+"'")[0][0];
					PurchaseRequestMailTemplate.sendpurchaseRequestAccountsMail(branchid,reqestno, division, Path, content) ;
					
					response.sendRedirect("Smart Inventory/PurchaseRequestAccept.jsp");
				}
				else if("INVPurchaseRequestClosed".equals(action))
				{
					String reqestno = request.getParameter("Requestno");
					String status = request.getParameter("Accept");
					String memo = request.getParameter("memo");
					asql=" UPDATE inv_t_purchaserequest  SET  INT_PROGRESSBAR =90,CHR_CLOSEDBY=?, CHR_CLOSEDDESCRIPTION=?,CHR_CLOSEDSTATUS=?,DAT_CLOSEDDATE= NOW()  ";
					asql=asql+" WHERE CHR_POREQUESTNO=? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,empid);
					apstm.setString(2,memo);
					apstm.setString(3,status);
					apstm.setString(4,reqestno);
					apstm.execute();
					apstm.close();
					
					String divis = request.getParameter("divis");
					String to =  CommonFunctions.QueryExecute("SELECT CHR_EMAILID FROM inv_m_division  WHERE INT_DIVIID="+divis)[0][0];
					String content =PurchaseRequestMail.PurchaseRequestContent(false,reqestno);
					
					content ="This can be closed.. ";//
					String customer = request.getParameter("customer");
					customer=  CommonFunctions.QueryExecute("SELECT b.CHR_NAME FROM inv_m_customerinfo a, inv_m_customergroup b WHERE a.INT_CUSTOMERGROUPID=b.INT_CUSTOMERGROUPID AND a.INT_CUSTOMERID="+customer)[0][0];
					
					status=""+request.getParameter("Accept");
					if("Y".equals(status ))
						content ="Approved... ";
					else if("N".equals(status ))
						content ="Pending due to "+memo;
					 
					/*if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]))
					{
						String a[] =(to+",").split(",") ;
						PurchaseRequestMail.PurchaseRequestsendtoMail(a, "PURCHASE REQUEST NUMBER  :: "+reqestno+ "      [ "+customer+" ]", content);
					}*/
					
					
					
					//Vendor po Automated
					if("Y".equals(status ))
						VendorPOAutomate.vendorPORaised(reqestno,con,request,response);
					
					String division = CommonFunctions.QueryExecute(" SELECT INT_DIVIID FROM inv_t_purchaserequest WHERE CHR_POREQUESTNO='"+reqestno+"'")[0][0];
					PurchaseRequestMailTemplate.sendpurchaseRequestFinanceMail(branchid,reqestno, division, Path, content) ;
					
					
					con.close();   
					response.sendRedirect("Smart Inventory/PurchaseRequestClosed.jsp");
				}
				else if("INVPurchaseRequestClosedReset".equals(action))
				{
					String reqestno = request.getParameter("reqno");
					asql=" UPDATE inv_t_purchaserequest  SET CHR_CLOSEDBY=?, CHR_CLOSEDDESCRIPTION=?,CHR_CLOSEDSTATUS=?,DAT_CLOSEDDATE=DATE(NOW()) ";
					asql=asql+" WHERE CHR_POREQUESTNO=? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,"");
					apstm.setString(2,"");
					apstm.setString(3,"N");
					apstm.setString(4,reqestno);
					apstm.execute();
					apstm.close();
					con.close();   
					response.sendRedirect("Smart Inventory/PurchaseRequestClosed.jsp");
				}
				else if("INVPurchaseRequestReceivedReset".equals(action))
				{
					String reqestno = request.getParameter("reqno");
					asql=" UPDATE inv_t_purchaserequest  SET CHR_PR_PARTIALLY_RECEIVED=? ";
					asql=asql+" WHERE CHR_POREQUESTNO=? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,"P");
					apstm.setString(2,reqestno);
					apstm.execute();
					apstm.close();
					con.close();   
					response.sendRedirect("Smart Inventory/PurchaseRequestClosed.jsp");
				}
				else if("INVPurchaseRequestModifyAfterApproval".equals(action))
				{
					 
					String reqestno = request.getParameter("Requestno");
					String divis = request.getParameter("divis");
					String customer = request.getParameter("customer");
					String cporowid="";
					String param[] = request.getParameter("param").split(",");
					String sql ="";
					if(param.length>0)
					{
						/*,CHR_TYPE=?, CHR_ITEMID=?, 
								apstm.setString(2,itype);
						apstm.setString(3,iid);
						*/		
						asql = " UPDATE inv_t_purchaserequestitem SET ";
						asql = asql +" INT_VENDORID =? ,";
						asql = asql +" CHR_DESC=?, INT_QUANTITY=?,	DOU_UNITPRICE=?, ";
						asql = asql +" INT_P_TAXID=?,DOU_P_TAX_PERCENTAGE=?, ";
						asql = asql +" DOU_P_TAX_AMOUNT=?,	DOU_PURCHASEPRICE=? ,";
						asql = asql +" CHR_PURCHASEWARRANTY=?,DOU_UNITSALEPRICE=?, ";
						asql = asql +" INT_S_TAXID=?, DOU_S_TAX_PERCENTAGE=?, DOU_S_TAX_AMOUNT =?, ";
						asql = asql +" DOU_SALESPRICE =?, CHR_SALESWARRANTY =?,CHR_ADDITIONALWARRANTY=? , "; //18
						asql = asql +" DOU_INSTALLATION=?, DOU_DELIVERY=?,"; 
						asql = asql +" DOU_ADDITIONALWARRANTY=?,DOU_GROSSVALUE=?, ";
						asql = asql +" DOU_GROSSMARGIN=?,DOU_MARGIN=?, ";//23
						asql = asql +" DOU_CONTRIBUTION=?,DOU_CONTRIBUTION_PERCENTAGE=?, ";
						asql = asql +" CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()) ";		
						asql = asql +" WHERE CHR_POREQUESTNO = ? AND INT_ROWID=?";
						apstm = con.prepareStatement(asql);
						String itype="";
						String iid="";
						for(int p=0;p<param.length; p++)
						{
							String e =""+request.getParameter("itype"+param[p].trim());
							iid =""+request.getParameter("item"+param[p].trim());
							if(e.equals("1") )
								itype="I";
							if(e.equals("2") )
								itype="P";
							apstm.setString(1,request.getParameter("vendorid"+param[p]) );
							apstm.setString(2,request.getParameter("desc"+param[p]) );
							apstm.setString(3,request.getParameter("Quantity"+param[p]) );
							apstm.setString(4,request.getParameter("Unitprice"+param[p]) );
							apstm.setString(5,request.getParameter("ptax"+param[p]) );
							apstm.setString(6,request.getParameter("ptaxpercent"+param[p]) );
							apstm.setString(7,request.getParameter("ptaxamount"+param[p]) );
							apstm.setString(8,request.getParameter("Purchaseprice"+param[p]) );
							apstm.setString(9,request.getParameter("pwarranty"+param[p]) );
							apstm.setString(10,request.getParameter("unitsalesprice"+param[p]) );
							apstm.setString(11,request.getParameter("stax"+param[p]) );
							apstm.setString(12,request.getParameter("staxpercent"+param[p]) );
							apstm.setString(13,request.getParameter("staxamount"+param[p]) );
							apstm.setString(14,request.getParameter("Salesprice"+param[p]) );
							apstm.setString(15,request.getParameter("swarranty"+param[p]) );
							if("Y".equals(request.getParameter("idayn"+param[p])))
								apstm.setString(16,"Y" );
							else
								apstm.setString(16,"N" );
							apstm.setString(17,request.getParameter("installation"+param[p]) );
							apstm.setString(18,request.getParameter("delivery"+param[p]) );
							apstm.setString(19,request.getParameter("additionalwarranty"+param[p]) );
							apstm.setString(20,request.getParameter("grosssalevalue"+param[p]) );
							double pprice = Double.parseDouble(""+request.getParameter("Purchaseprice"+param[p]));
							double sprice = Double.parseDouble(""+request.getParameter("Salesprice"+param[p])); 
							
							double tax_pprice = Double.parseDouble(""+request.getParameter("ptaxamount"+param[p]));
							double tax_sprice = Double.parseDouble(""+request.getParameter("staxamount"+param[p])); 
							pprice = pprice - tax_pprice;
							sprice = sprice - tax_sprice;
							
							double grossvalue = Double.parseDouble(""+request.getParameter("grosssalevalue"+param[p])); 
							double Contribution =  (sprice-pprice);
							double Contributionpercentage =0;
							if(pprice>0)
								Contributionpercentage =  (Contribution/pprice)*100;
							else
								Contributionpercentage=0;
							  
							
							double grossmargin = grossvalue;
							double margin =0;
							if(grossmargin>0)
								margin = grossmargin/sprice *100;
							
							apstm.setString(21,""+grossmargin );
							apstm.setString(22,""+margin );
							apstm.setString(23,""+Contribution );
							apstm.setString(24,""+Contributionpercentage );
							apstm.setString(25, user );
							apstm.setString(26,  reqestno);
							apstm.setString(27, request.getParameter("rowid"+param[p]) );
							System.out.println(""+apstm);
							apstm.addBatch();
							
							//CPO Row id modification
							cporowid=""+request.getParameter("cporowid"+param[p]);
							sql="";
							if(!"0".equals(cporowid))
							{
								sql = sql +" UPDATE inv_t_customersalesorderitem SET	INT_PR_VENDOR_ID =?, ";
								sql = sql +" INT_PR_QTY = ?,DOU_PR_PRICE =?,INT_PR_TAXID =?, ";
								sql = sql +" INT_PR_WARRANTY =? WHERE CHR_PR_FLAG='Y' AND INT_ID=? ";
								PreparedStatement ps = con.prepareStatement(sql);
								ps.setString(1,request.getParameter("vendorid"+param[p]) );
								ps.setString(2,request.getParameter("Quantity"+param[p]) );
								ps.setString(3,request.getParameter("Unitprice"+param[p]));
								ps.setString(4,request.getParameter("ptax"+param[p]));
								ps.setString(5,request.getParameter("pwarranty"+param[p]));
								ps.setString(6,cporowid);
								System.out.println(""+ps);
								ps.execute();
								ps.close();
							}

						}
						apstm.executeBatch();
						apstm.close();
						
						asql = " UPDATE inv_t_purchaserequestitem SET ";
						asql = asql +" DOU_PURCHASEPRICE = (DOU_PURCHASEPRICE-DOU_P_TAX_AMOUNT) ,";
						asql = asql +" DOU_SALESPRICE =  ( DOU_SALESPRICE -DOU_S_TAX_AMOUNT) ";
						asql = asql +" WHERE CHR_POREQUESTNO= ?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,reqestno );
						System.out.println(""+apstm);
						//apstm.execute();  
						
						
						//Delete previous vender purchase Order
						VendorPOAutomate.vendorPODeleteAfterPRModified(reqestno,con,apstm,request,response);
						Thread.sleep(2000);
						VendorPOAutomate.vendorPORaised(reqestno,con,request,response);
						
						
						PurchaseRequestMailTemplate.sendpurchaseRequestModifiedafterApprovalMail(branchid,reqestno, divis, Path, true) ;
						
						/*if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]))
						{	
							String to =  CommonFunctions.QueryExecute("SELECT CHR_EMAILID FROM inv_m_division  WHERE INT_DIVIID="+divis)[0][0];
							String approvalmail =  CommonFunctions.QueryExecute("SELECT CHR_PR_APPROVAL ,CHR_PR_CLOSED FROM m_inventorysetting WHERE INT_ROWID=1")[0][0];
							String content =PurchaseRequestMail.PurchaseRequestContent(true,reqestno);
							String a[] =(to+","+approvalmail).split(",") ;
							PurchaseRequestMail.PurchaseRequestsendtoMail(a, "purchase request  has changed after approving level   :: "+reqestno+ "      [ "+customer+" ]", content);
						}	*/
					}
					 
					 
					con.close();   
					response.sendRedirect("Smart Inventory/PurchaseRequest.jsp");
				
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


