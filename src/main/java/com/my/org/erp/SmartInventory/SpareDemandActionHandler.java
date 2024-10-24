package com.my.org.erp.SmartInventory;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class SpareDemandActionHandler extends AbstractActionHandler
{
		@SuppressWarnings("rawtypes")
		public synchronized void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
		{
			try
			{
					String action=request.getParameter("actionS");
					HttpSession session=request.getSession();			
					String branchid = session.getAttribute("INVBRANCH").toString(); 
					String empid = session.getAttribute("EMPID").toString();
					SpareDemand d = new SpareDemand();
					Map map=request.getParameterMap();
					BeanUtils.populate(d,map);
					 
					if("INVSpareDemandAdd".equals(action))
					{ 
						String invoicenumber="SPR/"+InventoryInvoiceFunctions.accountYear()+InventoryInvoiceFunctions.invoiceMonth()+ InventoryInvoiceFunctions.spareNumber();
						asql = " INSERT INTO inv_t_sparedemand (CHR_DEMANDNO,INT_BRANCHID,CHR_CUSTOMER,CHR_CUSTOMER_ADDRESS,CHR_CALLTYPE,CHR_PRODUCT_SERIALNUMBER,CHR_PART_DESC,CHR_CALLNUMBER, ";
						asql = asql+ "DAT_DEMAND_RAISED_DATE,CHR_DEMAND_RAISED_BY,CHR_DESPATCH_LOCATION, ";
						asql = asql+ " CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )" ;
						asql = asql+ "  VALUES (?, ?,?,?,?,?,?,?,?,?,?,?,DATE(NOW()),'Y' )" ;
						apstm = con.prepareStatement(asql);
						apstm.setString(1,invoicenumber);
						apstm.setString(2,branchid);
						apstm.setString(3,""+d.getCustomer());
						apstm.setString(4,d.getCustomeraddress());
						apstm.setString(5,d.getCalltype());
						apstm.setString(6,d.getProductserialnumber());
						apstm.setString(7,d.getMemo());
						apstm.setString(8,d.getCallnumber());
						apstm.setString(9,d.getDemanddate());
						apstm.setString(10,empid);
						apstm.setString(11,d.getDespatchlocation());
						apstm.setString(12,auserid);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						con.close();
						response.sendRedirect("Smart Inventory/SpareDemand.jsp");
					}
					else if("INVSpareDemandEdit".equals(action))
					{ 
						asql = " UPDATE inv_t_sparedemand SET INT_BRANCHID=?, CHR_CUSTOMER=?,CHR_CUSTOMER_ADDRESS=?,CHR_CALLTYPE=?,CHR_PRODUCT_SERIALNUMBER=?,CHR_PART_DESC=?,CHR_CALLNUMBER=?, ";
						asql = asql+ "DAT_DEMAND_RAISED_DATE=?,CHR_DEMAND_RAISED_BY=?,CHR_DESPATCH_LOCATION=?, ";
						asql = asql+ " CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y' WHERE INT_DEMANID=? " ;
						apstm = con.prepareStatement(asql);
						apstm.setString(1,branchid);
						apstm.setString(2,""+d.getCustomer());
						apstm.setString(3,d.getCustomeraddress());
						apstm.setString(4,d.getCalltype());
						apstm.setString(5,d.getProductserialnumber());
						apstm.setString(6,d.getMemo());
						apstm.setString(7,d.getCallnumber());
						apstm.setString(8,d.getDemanddate());
						apstm.setString(9,empid);
						apstm.setString(10,d.getDespatchlocation());
						apstm.setString(11,auserid);
						apstm.setString(12,""+d.getId());
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						con.close();
						response.sendRedirect("Smart Inventory/SpareDemand.jsp");
					}
					else if("INVSpareDemandDelete".equals(action))
					{ 
						String []rowid= request.getParameterValues("rowid");							
						asql ="DELETE FROM inv_t_sparedemand   WHERE INT_DEMANID=?";
						apstm = con.prepareStatement(asql);
						for(int i=0;i<rowid.length;i++)
						{	
							apstm.setString(1,rowid[i]);
							apstm.addBatch();				
						}
						apstm.executeBatch();
						apstm.close();
						con.close();
						response.sendRedirect("Smart Inventory/SpareDemand.jsp");
					}
					else if("INVSpareIssueadd".equals(action))
					{
						String sparetype = request.getParameter("sparetype");
						String itype = request.getParameter("itype");
						String item = request.getParameter("item");
						String serialnumber = request.getParameter("serialnumber");
						String issueddate = request.getParameter("issueddate");
						String refno = request.getParameter("id");
						String through = request.getParameter("through");
						String description = request.getParameter("description");
						if(issueddate.length()>6)
							issueddate= DateUtil.FormateDateandTimeSQL(issueddate);
						else 
							issueddate= null;
						asql = " INSERT INTO inv_t_sparedemandissue (  ";
						asql = asql +" CHR_DEMANDNO,CHR_SPARETYPE,CHR_TYPE,CHR_PRODUCTCODE,INT_QTY,";
						asql = asql +" CHR_ISSUED_SERIALNUMBER,CHR_ISSUED_BY,DAT_ISSUED_DATE,";
						asql = asql +" CHR_ISSUE_THROUGH,CHR_ISSUE_DESC )";
						asql = asql +" VALUES ( ?,?,?,?,?,?,?,?,?,? ) ";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,refno);
						apstm.setString(2,sparetype);
						apstm.setString(3,itype);
						if("1".equals(itype))
							apstm.setString(3,"I");
						else
							apstm.setString(3,"P");
						apstm.setString(4,item);
						if("C".equals(sparetype))
							apstm.setString(5,"1");
						else
							apstm.setString(5,"0");	
						apstm.setString(6,serialnumber);
						apstm.setString(7,empid);
						apstm.setString(8,issueddate);
						apstm.setString(9,through);
						apstm.setString(10,description);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						asql = " UPDATE inv_t_vendorgoodsreceived SET ";
						asql = asql + " CHR_FLAG =?";
						asql = asql + " WHERE CHR_SERIALNO =?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,"S" );
						apstm.setString(2,serialnumber );
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						con.close();
						response.sendRedirect("Smart Inventory/SpareIssued.jsp");
					}
					else if("INVSpareIssueEdit".equals(action))
					{
						String serialnumber = request.getParameter("serialnumber");
						String dbserialnumber = request.getParameter("dbserialnumber");
						String through = request.getParameter("through");
						String description = request.getParameter("description");
						String issueddate = request.getParameter("issueddate");
						String issuestatus = request.getParameter("issuestatus");
						String id = request.getParameter("id");
						if(issueddate.length()>6)
							issueddate= DateUtil.FormateDateandTimeSQL(issueddate);
						else 
							issueddate= null;
						asql =" UPDATE inv_t_sparedemand SET CHR_ISSUED=?,";
						asql = asql +" CHR_ISSUED_SERIALNUMBER=?,";
						asql = asql +" CHR_ISSUED_BY=?, ";
						asql = asql +" DAT_ISSUED_DATE=? ,";
						asql = asql +" CHR_ISSUE_THROUGH=? ,";
						asql = asql +" CHR_ISSUE_DESC=? ";
						asql = asql +" WHERE INT_DEMANID=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,issuestatus );
						apstm.setString(2,serialnumber );
						apstm.setString(3,empid );
						apstm.setString(4,issueddate );
						apstm.setString(5,through );
						apstm.setString(6,description );
						apstm.setString(7,id );
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						asql = " UPDATE inv_t_vendorgoodsreceived SET ";
						asql = asql + " CHR_FLAG =?";
						asql = asql + " WHERE CHR_SERIALNO =?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,"N" );
						apstm.setString(2,dbserialnumber );
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						asql = " UPDATE inv_t_vendorgoodsreceived SET ";
						asql = asql + " CHR_FLAG =?";
						asql = asql + " WHERE CHR_SERIALNO =?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,"S" );
						apstm.setString(2,serialnumber );
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						con.close();
						response.sendRedirect("Smart Inventory/SpareIssued.jsp");
					}
					else if("INVSpareIssueDelete".equals(action))
					{
						String rowid= request.getParameter("rowid");
						asql = " SELECT CHR_ISSUED_SERIALNUMBER FROM inv_t_sparedemand WHERE  INT_DEMANID="+rowid;
						String serialnumber = CommonFunctions.QueryExecute(asql)[0][0];
						
						asql =" UPDATE  inv_t_sparedemand  SET CHR_ISSUED_SERIALNUMBER =null, CHR_ISSUED_BY=null,DAT_ISSUED_DATE=null,CHR_ISSUED='N' WHERE INT_DEMANID=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,rowid );
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						asql = " UPDATE inv_t_vendorgoodsreceived SET ";
						asql = asql + " CHR_FLAG =?";
						asql = asql + " WHERE CHR_SERIALNO =?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,"N" );
						apstm.setString(2,serialnumber );
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						con.close();
						response.sendRedirect("Smart Inventory/SpareIssued.jsp");
					}
					else if("INVSpareReturnadd".equals(action))
					{
						String returnstatus = request.getParameter("returnstatus");
						String returndate = request.getParameter("returndate");
						String id = request.getParameter("id");
						String returnserialnumber = request.getParameter("returnserialnumber");
						
						if(returndate.length()>6)
							returndate= DateUtil.FormateDateandTimeSQL(returndate);
						else 
							returndate= null;
						
						asql = " SELECT CHR_ISSUED_SERIALNUMBER FROM inv_t_sparedemand WHERE  INT_DEMANID="+id;
						String serialnumber = CommonFunctions.QueryExecute(asql)[0][0];
						
						asql =" UPDATE inv_t_sparedemand SET CHR_RETURN_STATUS=?,";
						asql = asql +" DAT_RETURN_DATE=?,CHR_RETURN_SERIALNUMBER=? ";
						asql = asql +" WHERE INT_DEMANID=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,returnstatus );
						apstm.setString(2,returndate );
						apstm.setString(3,returnserialnumber );
						apstm.setString(4,id );
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						if("Y".equals(returnstatus))
						{
							asql = " UPDATE inv_t_vendorgoodsreceived SET ";
							asql = asql + " CHR_FLAG =? ";
							asql = asql + " WHERE CHR_SERIALNO =?";
							apstm = con.prepareStatement(asql);
							apstm.setString(1,"N" );
							apstm.setString(2,serialnumber );
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
						}
						con.close();
						response.sendRedirect("Smart Inventory/SpareReturn.jsp");
					}
					else if("INVSpareReturnEdit".equals(action))
					{
						String returnstatus = request.getParameter("returnstatus");
						String returndate = request.getParameter("returndate");
						String id = request.getParameter("id");
						String returnserialnumber = request.getParameter("returnserialnumber");
						if(returndate.length()>6)
							returndate= DateUtil.FormateDateandTimeSQL(returndate);
						else 
							returndate= null;
						asql = " SELECT CHR_ISSUED_SERIALNUMBER FROM inv_t_sparedemand WHERE  INT_DEMANID="+id;
						String serialnumber = CommonFunctions.QueryExecute(asql)[0][0];
						asql =" UPDATE inv_t_sparedemand SET CHR_RETURN_STATUS=?,";
						asql = asql +" DAT_RETURN_DATE=?,CHR_RETURN_SERIALNUMBER=? ";
						asql = asql +" WHERE INT_DEMANID=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,returnstatus );
						apstm.setString(2,returndate );
						apstm.setString(3,returnserialnumber );
						apstm.setString(4,id );
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						if("Y".equals(returnstatus))
						{
							asql = " UPDATE inv_t_vendorgoodsreceived SET ";
							asql = asql + " CHR_FLAG =? ";
							asql = asql + " WHERE CHR_SERIALNO =?";
							apstm = con.prepareStatement(asql);
							apstm.setString(1,"N" );
							apstm.setString(2,serialnumber );
							System.out.println(""+apstm);
							apstm.execute();
							apstm.close();
						}
						
						con.close();
						response.sendRedirect("Smart Inventory/SpareReturn.jsp");
					}
					else if("INVSpareReturnDelete".equals(action))
					{
						con.close();
						response.sendRedirect("Smart Inventory/SpareReturn.jsp");
					}
			}
			catch (SQLException se) 
			{
				System.out.println(se.getMessage()); 
				request.setAttribute("error", se.getMessage() );
				RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
				dispatchers.forward(request, response); 
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