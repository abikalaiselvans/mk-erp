package com.my.org.erp.SmartInventory;
import java.io.IOException;
 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.mail.Mail;
import com.my.org.erp.setting.CommonData;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class CPOVerificationActionHandler extends AbstractActionHandler
{

 	@SuppressWarnings("rawtypes")
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	 {
		try
		{
				String action=request.getParameter("actionS");
				HttpSession session=request.getSession();			
				String branchid = session.getAttribute("INVBRANCH").toString();
				String user = session.getAttribute("USRID").toString();
				String officeid=""+session.getAttribute("INVOFFICEID");
				
				if("INVCPOVerificationAdd".equals(action))
				{ 
					String division = request.getParameter("division");
					String vendorpaymentcommitment = request.getParameter("vendorpaymentcommitment");
					String vendotpayment = request.getParameter("vendotpayment");
					String rfc = request.getParameter("rfc");
					String orc = request.getParameter("orc");
					String cpostatus = request.getParameter("cpostatus");
					String orcdescription = request.getParameter("orcdescription");
					if(!"Y".equals(orc))
						orc ="N";
					
					String rfcdescription = request.getParameter("rfcdescription");
					String cporefno = request.getParameter("cporefno");
					if(!"Y".equals(rfc))
						rfc ="N";
					
					String PR = request.getParameter("PR");
					if(!"Y".equals(PR))
						PR ="N";
					
					 
					//update customer purchase order item
					int rlength = Integer.parseInt(request.getParameter("rlength"));
					String  rowid,purchaserequestflag,pqty,warranty;
					String stockblockingflag,Vendor,unitpurchaseprice,ptax,descriptions;
					String partialbill =request.getParameter("partialbill");
					String PRDescription =request.getParameter("PRDescription");
					asql = " UPDATE inv_t_customersalesorderitem SET ";
					asql = asql + " CHR_STOCK_BLOCK = ?, CHR_PR_FLAG=?,INT_PR_QTY=?,INT_PR_WARRANTY=?,INT_PR_VENDOR_ID=?,";
					asql = asql + " CHR_PR_DESC=?,DOU_PR_PRICE=? , INT_PR_TAXID=? ";
					asql = asql + " WHERE INT_ID =?";
					apstm = con.prepareStatement(asql);
					for(int u=1;u<=rlength;u++)
					{
						rowid = request.getParameter("rowid"+u);
						stockblockingflag = request.getParameter("stockblockingflag"+u);
						purchaserequestflag = request.getParameter("purchaserequestflag"+u);
						pqty = request.getParameter("pqty"+u);
						warranty = request.getParameter("warranty"+u);
						Vendor = request.getParameter("Vendor"+u);
						unitpurchaseprice = request.getParameter("unitpurchaseprice"+u);
						ptax = request.getParameter("ptax"+u);
						descriptions = request.getParameter("descriptions"+u);
						if("Y".equals(purchaserequestflag))
						{
							apstm.setString(1,stockblockingflag);
							apstm.setString(2,purchaserequestflag);
							apstm.setString(3,pqty);
							apstm.setString(4,warranty);
							apstm.setString(5,Vendor);
							apstm.setString(6,descriptions);
							apstm.setString(7,unitpurchaseprice);
							apstm.setString(8,ptax);
							apstm.setString(9,rowid);
							System.out.println(""+apstm);
							apstm.addBatch();
						}
					}
					apstm.executeBatch();
					apstm.close();
					
					asql =" UPDATE inv_t_customersalesorder  SET INT_PROGRESSBAR=30,";
					asql = asql +" CHR_PARTIAL_BILL=?, CHR_VERIFICATIED =? , CHR_VRIFIED_BY =?, ";
					asql = asql +" DAT_VERIFIED_DATE_TIME = NOW(), ";
					asql = asql +" CHR_ORC=?,	CHR_ORCDESC=?, ";
					asql = asql + " CHR_PR_MODIFICATION =?, CHR_PR_MOFICIATION_DESC=?, ";
					asql = asql + " CHR_RFC =?, ";
					asql = asql + " CHR_RFC_DESC = ?, ";
					asql = asql + " DAT_RFC_CREATIVETIME=NOW(),INT_VENDORPAYMENTID =?, ";
					asql = asql + " INT_VENDORCOMMITMENTDAYS=?, INT_CPO_STATUS=?  ";
					asql = asql + " WHERE CHR_SALESORDERNO=? ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,partialbill);
					if("Y".equals(PR))
						apstm.setString(2,"N");
					else
						apstm.setString(2,"Y");
					apstm.setString(3,""+session.getAttribute("EMPID"));
					 
					apstm.setString(4,orc);
					apstm.setString(5,orcdescription);
					apstm.setString(6,PR);
					apstm.setString(7,PRDescription);
					apstm.setString(8,rfc);
					apstm.setString(9,rfcdescription);
					apstm.setString(10,vendotpayment);
					apstm.setString(11,vendorpaymentcommitment);
					apstm.setString(12,cpostatus);
					apstm.setString(13,cporefno);
					System.out.println(""+apstm);
					apstm.execute();
					con.close();   
					
					//Mail generate
					SaleOrderMail.sendCPOVerificationMail(request,branchid,cporefno, division, Path);
					response.sendRedirect("Smart Inventory/POVerification.jsp");
					 
				}
				else if("INVCPOVerificationUpdate".equals(action))
				{ 
					String ponumber= request.getParameter("cporefno");
					String vendorpaymentcommitment = request.getParameter("vendorpaymentcommitment");
					String  noofpaymentcommitment= request.getParameter("noofpaymentcommitment");
					String vendotpayment = request.getParameter("vendotpayment");
					String payment = request.getParameter("payment");
					
					String custponumber= request.getParameter("custponumber");
					String  podate= request.getParameter("podate");
					String  deliverydate= request.getParameter("deliverydate");
					String  installation= request.getParameter("installation");
					String  multipleloaction= request.getParameter("multipleloaction");
					String  multiplebill= request.getParameter("multiplebill");
					String blockinvoice = request.getParameter("blockinvoice");
					String  bankguarantee= request.getParameter("bankguarantee");
					String  demurrage= request.getParameter("demurrage");
					String  partialbill= request.getParameter("partialbill");
					if(!"Y".equals(partialbill))
						partialbill = "N";
					String delivery = request.getParameter("delivery");
					String  demurragepercentage= request.getParameter("demurragepercentage");
					String  demurragedays= request.getParameter("demurragedays");
					String  stocktype= request.getParameter("stocktype");
					
					asql = "UPDATE inv_t_customersalesorder SET INT_PROGRESSBAR = 40,";
					asql = asql +" CHR_CUSTPURCHASENO= ?, ";
					asql = asql +" CHR_PURCHASEORDER_DATE=?, ";
					asql = asql +" CHR_DELIVERY_DATE =? , ";
					asql = asql +" INT_PAYMENT_COMMITMENT_DAYS=?,";
					asql = asql +" CHR_INSTALLATION=? , ";
					asql = asql +" CHR_MULTIPLE_LOCATION = ? , ";
					asql = asql +" CHR_MULTIPLE_BILL = ?, ";
					asql = asql +" CHR_INVOICEBLOCK = ?, ";
					asql = asql +" CHR_BG=?, ";
					asql = asql +" CHR_DEMURRAGE = ?, ";
					asql = asql +" DOU_DEMARRAGE_PERCENTAGE = ?, ";
					asql = asql +" INT_DEMARRAGE_DAYS = ?, ";
					asql = asql +" CHR_PARTIAL_BILL = ?, ";
					asql = asql +" CHR_DELIVERY =?, ";
					asql = asql +" CHR_STOCKTYPE= ?, ";
					asql = asql +" CHR_RFC= ?, ";
					asql = asql +" CHR_PR_MODIFICATION = ? , ";
					asql = asql +" DAT_RFC_UPDATETIME= NOW(), ";
					asql = asql +" CHR_VERIFICATIED =? , CHR_VRIFIED_BY =? ,  ";
					asql = asql +" INT_VENDORCOMMITMENTDAYS = ?  ";
					asql = asql +" WHERE CHR_SALESORDERNO = ?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,custponumber);
					apstm.setString(2,DateUtil.FormateDateSQL(podate));
					apstm.setString(3,DateUtil.FormateDateSQL(deliverydate)); 
					apstm.setString(4,noofpaymentcommitment); 
					apstm.setString(5,installation); 
					apstm.setString(6,multipleloaction); 
					apstm.setString(7,multiplebill); 
					apstm.setString(8,blockinvoice); 
					apstm.setString(9,bankguarantee); 
					apstm.setString(10,demurrage); 
					apstm.setString(11,demurragepercentage); 
					apstm.setString(12,demurragedays); 
					apstm.setString(13,partialbill); 
					apstm.setString(14,delivery); 
					apstm.setString(15,stocktype);
					apstm.setString(16,"N");//request for change
					apstm.setString(17,"N");//PR modification
					apstm.setString(18,"Y");
					apstm.setString(19 ,""+session.getAttribute("EMPID"));
					apstm.setString(20,vendorpaymentcommitment);
					apstm.setString(21,ponumber);
					System.out.println(""+apstm);
					apstm.execute();
					 
					//PURCHASE REQUEST MAIL
					String  rowid,purchaserequestflag,pqty, warranty,swarranty;
					String  Shipping,Vendor,unitpurchaseprice;
					int rlength = Integer.parseInt(request.getParameter("rlength"));
					String divisionid = request.getParameter("division"); 
					String cporefno = ponumber;
					String customer = request.getParameter("customer");
					Shipping = request.getParameter("Shipping");
					boolean prflag= false;
					String stax,staxpercentage,staxamount;
					String ptax,ptaxpercentage;
					for(int u=1;u<=rlength;u++)
					{
						purchaserequestflag = request.getParameter("purchaserequestflag"+u);
						if("Y".equals(purchaserequestflag))
							prflag =true;
					}
					
					if(prflag)
					{
						//if purchase request available the SOA is automatically update.
						asql =" UPDATE inv_t_customersalesorder  SET";
						asql = asql +" CHR_PR_CREATED_BY=?,DAT_PR_CREATIONTIME =NOW(), ";
						asql = asql +" CHR_SALEORDER_APPROVAL=?,DAT_SALEORDER_APPROVAL_TIME=?, ";
						asql = asql +" CHR_SALEORDER_DESC=?  ";
						asql = asql +" WHERE CHR_SALESORDERNO=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,user);
						apstm.setString(2,"Y");
						apstm.setString(3,DateUtil.getCurrentDateTime());
						apstm.setString(4,"AUTOMATIC");
						apstm.setString(5,cporefno);
						System.out.println(""+apstm);
						apstm.execute();
						
						//Mail generate for SOA approval in auotomatic
						PurchaseRequestMailTemplate.sendpurchaseRequestSOAMail(branchid,cporefno,divisionid, Path,"");
						
						//Purchase request 
						String prreqestno=  InventoryInvoiceFunctions.directPurchaseRequestGet(officeid,divisionid);
						String shippingaddress = request.getParameter("shippingaddress");
						String ref = request.getParameter("ref");
						String prdescription = request.getParameter("prdescription");
						String PRDescription = request.getParameter("PRDescription");
						asql = " INSERT INTO  inv_t_purchaserequest (";
						asql = asql +" INT_BRANCHID,INT_DIVIID,CHR_POREQUESTNO,DAT_REQUESTDATE,";
						asql = asql +" DAT_PURCHASEDATE,INT_CUSTOMERID,CHR_SHIPPING, ";
						asql = asql +" CHR_SHIPPINGADDRESS,INT_PAYMENTTERMID,INT_CUSTOMERCOMMITMENTDAYS,";
						asql = asql +" CHR_REF, CHR_DES, CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS,";
						asql = asql +" DAT_COMMITMENTDATE, CHR_MODE,CHR_CPOREF_NUMBER  ) ";
						asql = asql +" VALUES(?,?,?,DATE(NOW()),DATE(NOW()),";
						asql = asql+" ?,?,?,?,?,?,?,?,DATE(NOW()),'Y', ";
						asql = asql+" DATE_FORMAT(DATE_ADD(NOW() , INTERVAL "+vendorpaymentcommitment+" DAY),'%Y-%m-%d'), ";
						asql = asql+" ?,?) ";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,branchid);
						apstm.setString(2,divisionid);
						apstm.setString(3,prreqestno);
						apstm.setString(4,customer);
						apstm.setString(5,Shipping);//address flag
						apstm.setString(6,shippingaddress);
						apstm.setString(7, vendotpayment);//payment
						apstm.setString(8,noofpaymentcommitment );//vendorpaymentcommitment
						apstm.setString(9,ref );
						apstm.setString(10, PRDescription); 
						apstm.setString(11,user);
						apstm.setString(12,"C");
						apstm.setString(13,cporefno);
						System.out.println(""+apstm);
						apstm.execute();
						
						asql=" SELECT FUN_INV_DIRECT_PURCHASE_REQUEST_NUMBER_INSERT()";
						apstm = con.prepareStatement(asql);
						System.out.println(""+apstm);
						apstm.execute();
						
						//Purchase request item
						for(int u=1;u<=rlength;u++)
						{
							rowid = request.getParameter("rowid"+u);
							purchaserequestflag = request.getParameter("purchaserequestflag"+u);
							pqty = request.getParameter("pqty"+u);
							warranty = request.getParameter("warranty"+u);
							swarranty = request.getParameter("swarranty"+u);
							stax = request.getParameter("stax"+u);
							staxpercentage = request.getParameter("staxpercentage"+u);
							staxamount = request.getParameter("staxamount"+u);
							
							ptax = request.getParameter("ptax"+u);
							ptaxpercentage = CommonFunctions.QueryExecute("SELECT FUN_GET_TAX_PERCENTAGE('"+ptax+"')")[0][0];
							
							Vendor = request.getParameter("Vendor"+u);
							unitpurchaseprice = request.getParameter("unitpurchaseprice"+u);
							if("Y".equals(purchaserequestflag))
							{
								
								//INT_P_TAXID,DOU_P_TAX_PERCENTAGE,DOU_P_TAX_AMOUNT
								
								//INT_S_TAXID,DOU_S_TAX_PERCENTAGE,DOU_S_TAX_AMOUNT
								
								
								asql = "  INSERT INTO  inv_t_purchaserequestitem ( ";
								asql = asql +" CHR_POREQUESTNO,INT_VENDORID ,";
								asql = asql +" CHR_TYPE,CHR_ITEMID,CHR_DESC,INT_QUANTITY,DOU_UNITPRICE,";
								asql = asql +" DOU_PURCHASEPRICE, CHR_PURCHASEWARRANTY ,";
								asql = asql +"  INT_P_TAXID,DOU_P_TAX_PERCENTAGE,DOU_P_TAX_AMOUNT,";
								
								asql = asql +" DOU_UNITSALEPRICE,DOU_SALESPRICE,CHR_SALESWARRANTY,";
								asql = asql +" INT_S_TAXID,DOU_S_TAX_PERCENTAGE,DOU_S_TAX_AMOUNT, ";
								asql = asql +"  DOU_GROSSVALUE,DOU_GROSSMARGIN,DOU_MARGIN,";
								asql = asql +" DOU_CONTRIBUTION,DOU_CONTRIBUTION_PERCENTAGE,INT_CPO_ROWID,";
								asql = asql +" CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
								asql = asql +" SELECT '"+prreqestno+"', '"+Vendor+"' ,";
								asql = asql +" CHR_TYPE,CHR_ITEMID,CHR_DESC ,'"+pqty+"' , '"+unitpurchaseprice+"' , ";
								asql = asql +" ("+pqty+" * "+unitpurchaseprice+"), '"+warranty+"',";
								asql = asql + ptax +", "+ptaxpercentage+",(  ("+pqty+" * "+unitpurchaseprice+") * ("+ptaxpercentage+"/100 )  ),";
								
								asql = asql +"  DOU_UNITPRICE,("+pqty+" * DOU_UNITPRICE), '"+swarranty+"',";
								asql = asql + stax +", "+staxpercentage+","+ staxamount+",";
								asql = asql +" ( ("+pqty+" * DOU_UNITPRICE) - ("+pqty+" * "+unitpurchaseprice+") ) grossvalue,";
								asql = asql +" ( ("+pqty+" * DOU_UNITPRICE) - ("+pqty+" * "+unitpurchaseprice+") ) grossmargin ,";
								
								asql = asql +"  if( ( ("+pqty+"*DOU_UNITPRICE) -("+pqty+" * "+unitpurchaseprice+") ) >0 ,( (( ("+pqty+"*DOU_UNITPRICE)-("+pqty+" * "+unitpurchaseprice+"))/("+pqty+" * "+unitpurchaseprice+") ) *100) ,(0)  ) margin,";
								asql = asql +"  (  ("+pqty+" * DOU_UNITPRICE)-("+pqty+" * "+unitpurchaseprice+") ) Contribution ,";
								asql = asql +"  if(("+pqty+" * "+unitpurchaseprice+")>0 ,( ( ("+pqty+" * DOU_UNITPRICE)-("+pqty+" * "+unitpurchaseprice+") ) /("+pqty+" * "+unitpurchaseprice+")) *100 ,'0') Contributionpercentage ,";
							    
								asql = asql +"  INT_ID, '"+auserid+"' ,  DATE(NOW()),'Y' " ;
								asql = asql +" FROM inv_t_customersalesorderitem WHERE INT_ID ="+rowid;
								apstm = con.prepareStatement(asql);
								System.out.println(""+asql);
								apstm.execute(); 
							}
						}
						
						//UPDATE LOW CONTRIBUTION
						acs = con.prepareCall("{call  INV_PRO_LOWCONTRIBUTION_UPDATE(?)}");
						acs.setString(1, prreqestno);
						acs.execute();
						acs.close();
						String contributionmode = CommonFunctions.QueryExecute("SELECT FUN_INV_LOWCONTRIBUTION_MODE('"+prreqestno+"')")[0][0];
						
						//UPDATE PR NUMBER TO CUSTOMER SALE ORDER
						asql = " UPDATE inv_t_customersalesorder  SET ";
						asql = asql +" CHR_POREQUESTNO =?  , CHR_PR_AVAILABLE='Y' WHERE CHR_SALESORDERNO=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,prreqestno );
						apstm.setString(2,cporefno); 
						System.out.println(""+apstm);
						apstm.execute();
						
						 
						
						//PR Mail generate
						String content="";
						if("A".equals(contributionmode))
						{
							content = content+ "<br><br>";
							content = content+ "<H2  style='background-color:#FFFF33'>Kind Attention - Division Head & Super Admin <br>";
							content = content+ "<H3>The contribution of purchase request is low. so kindly will you give the acknowledge and reason as well in advance...</H3>";
							content = content+ "</H2>";
							content = content+ "<br><br>";
						}	
						else if("B".equals(contributionmode))
						{	
							content = content+ "<br><br>";
							content = content+ "<H2 style='background-color:#FFFF33'>Kind Attention - Division Head  <br>";
							content = content+ "<H3>The contribution of purchase request is low. so kindly will you give the acknowledge and reason as well in advance...</H3>";
							content = content+ "</H2>";
							content = content+ "<br><br>";
						}
						else
						{
							content = content+ "<br><br>";
							content = content+ "<H2 style='background-color:#FFFF33'>Kind Attention - This is auto approval <br>";
							content = content+ "<H3>The contribution of purchase request is ok. </H3>";
							content = content+ "</H2>";
							content = content+ "<br><br>";
						}
						PurchaseRequestMailTemplate.sendpurchaseRequestCPOMail(branchid,prreqestno, divisionid, Path, true,content) ;
				}
				else
				{
					//if PR not available BH closed CPO Number
					SaleOrderMail.sendCPOClosedBusinessHeadMail(request,branchid, ponumber, divisionid,Path) ;
				}
				response.sendRedirect("Smart Inventory/POVerification.jsp");
				
				}
				else if("INVCPOVerificationSaleOrder".equals(action))
				{
					String ponumber= request.getParameter("ponumber");
					String divisionid= request.getParameter("divisionid");
					
					String saleorderapproval= request.getParameter("saleorderapproval");
					String saleorderdescription= request.getParameter("saleorderdescription");
					if(!"Y".equals(saleorderapproval))
						saleorderapproval ="N";
					asql = "UPDATE inv_t_customersalesorder SET  INT_PROGRESSBAR =75,CHR_SALEORDER_APPROVAL=?,CHR_SALEORDER_DESC=? WHERE CHR_SALESORDERNO =?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,saleorderapproval );
					apstm.setString(2,saleorderdescription );
					apstm.setString(3,ponumber );
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					//Mail generate
					PurchaseRequestMailTemplate.sendpurchaseRequestSOAMail(branchid,ponumber,divisionid, Path,"");
					
					con.close();    
					response.sendRedirect("Smart Inventory/CPOSaleorderApproval.jsp");
				}
				else if("INVCPOVerificationCancel".equals(action))
				{
					
					String ponumber= request.getParameter("ponumber");
					String reason= request.getParameter("reason");
					asql = "UPDATE inv_t_customersalesorder SET CHR_CANCEL=?,CHR_CANCELDESC=?,";
					asql = asql+" CHR_CANCELID=?,DAT_CANCELDATE=DATE(NOW()) WHERE CHR_SALESORDERNO =? AND CHR_BILLED ='N'";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,"Y" );
					apstm.setString(2,reason );
					apstm.setString(3,user );
					apstm.setString(4,ponumber );
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
					//Send a mail for cancell invoice
					String email=request.getParameter("email");
					String a[] =(email+","+CommonData.mailid).split(",") ;
					Mail.SimpleHTMLMail(a,"CANCELLED  CUSTOMER PO :: "+ponumber,poCancellsendtoMail("CANCELLED CUSTOMER PO  :: "+ponumber,ponumber,reason, " CUSTOMER PO"));
					
					con.close();    
					response.sendRedirect("Smart Inventory/POVerification.jsp");
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
 	
 	
 	public static String  poCancellsendtoMail(String subject, String ponumber,String desc,String Type )
    {
		String content ="";
		try
    	{
    		content =" <style type='text/css'> ";
			content =content+" <!-- ";
			content =content+" .style1 {color: #FFFFFF} ";
			content =content+" .style5 {font-size: 10} ";
			content =content+" .style6 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10; } ";
			content =content+" --> ";
			content = content+" </style> ";
			content =content+" <table width='80%' border='0' cellpadding='1' cellspacing='1' bgcolor='#0000FF'> ";
			content =content+" <tr> ";
			content=content+" <td> <h2 align='center' class='style1'>"+subject; 
			content=content+" </h2></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><table width='100%' border='0' cellpadding='0' cellspacing='0' bgcolor='#FFFFFF'> ";
			content=content+" <tr> ";
			content=content+" <td width='170'><h4>&nbsp;</h4></td> ";
			content=content+" <td width='332'><span class='style5'></span></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><h4>CUSTOMER PURCHASER ORDER NUMBER </h4></td> ";
			content=content+" <td><span class='style5'>"+ponumber+"</span></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><h4>&nbsp;</h4></td> ";
			content=content+" <td><span class='style6'> </span></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><h4>Invoice Type </h4></td> ";
			content=content+" <td><span class='style5'>"+Type+"</span></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><h4>&nbsp;</h4></td> ";
			content=content+" <td><span class='style6'> </span></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><h4>Description</h4></td> ";
			content=content+" <td><span class='style5'>"+desc+"</span></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><h4>&nbsp;</h4></td> ";
			content=content+" <td><span class='style5'></span></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><h4>Date of Cancell </h4></td> ";
			content=content+" <td><span class='style5'>"+ CommonFunctions.QueryExecute("select date_format(now(),'%d-%b-%Y')")[0][0]+"</span></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><h4>&nbsp;</h4></td> ";
			content=content+" <td><span class='style5'></span></td> ";
			content=content+" </tr> ";
			content=content+" </table></td> ";
			content=content+" </tr> ";
			content=content+" </table> ";
  	       return content;
    	}
    	catch(Exception e)
    	{
    		System.out.println(e.getMessage());
    	}
		return content;
    }
	
}