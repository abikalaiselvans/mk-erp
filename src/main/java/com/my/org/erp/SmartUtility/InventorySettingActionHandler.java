package com.my.org.erp.SmartUtility;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class InventorySettingActionHandler extends AbstractActionHandler
{
		public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
		{
			try
			{
					String action=request.getParameter("actionS");
					if(action.equals("UTIInventorySetting"))
					{ 
						try 
						{
							 
								String Type=request.getParameter("Type");
								String starting=request.getParameter("starting");
								ast = con.createStatement();
								 
								if("inv_m_quotationgenerate".equals(Type) || "All".equals(Type))
								{
									asql = " DROP TABLE inv_m_quotationgenerate; ";
									ast.executeUpdate(asql);
									System.out.println("Table Dropped :"+asql);
									
									asql = " CREATE TABLE inv_m_quotationgenerate ( ";
									asql = asql + "   INT_ROWID int(11) NOT NULL auto_increment, ";
									asql = asql + "   INT_QUOTATIONID bigint(11) unsigned NOT NULL default '0', ";
									asql = asql + "   INT_STATEID int(11) default '31', ";
									asql = asql + "   PRIMARY KEY  (INT_ROWID) ";
									asql = asql + " ) ENGINE=InnoDB DEFAULT CHARSET=latin1; ";
									ast.executeUpdate(asql);
									System.out.println("Table Created :"+asql);
								}
								else if("inv_m_advancepaymentgenerate".equals(Type) || "All".equals(Type))
								{
									asql = " DROP TABLE inv_m_advancepaymentgenerate ; ";
									ast.executeUpdate(asql);
									System.out.println("Table Dropped :"+asql);
									
									asql = " CREATE TABLE inv_m_advancepaymentgenerate ( ";
									asql = asql + "   INT_ROWID int(11) NOT NULL auto_increment, ";
									asql = asql + " INT_ADVANCEID bigint(11) unsigned NOT NULL default '0', ";
									asql = asql + "  INT_STATEID int(11) default '31', ";
									asql = asql + "  PRIMARY KEY  (INT_ROWID) ";
									asql = asql + "  ) ENGINE=InnoDB DEFAULT CHARSET=latin1; ";
									ast.executeUpdate(asql);
									System.out.println("Table Created :"+asql);
								}
								else if("inv_m_customersalesordergenerate".equals(Type) || "All".equals(Type))
								{
									asql = " DROP TABLE inv_m_customersalesordergenerate; ";
									ast.executeUpdate(asql);
									System.out.println("Table Dropped :"+asql);
									
									asql = "  CREATE TABLE inv_m_customersalesordergenerate ( ";
									asql = asql + "    INT_ROWID int(11) NOT NULL auto_increment, ";
									asql = asql + "    INT_SALEORDERID bigint(11) unsigned NOT NULL default '0', ";
									asql = asql + "    INT_STATEID int(11) default '31', ";
									asql = asql + "   PRIMARY KEY  (INT_ROWID), ";
									asql = asql + "   KEY INT_STATEID (INT_STATEID), ";
									asql = asql + "    CONSTRAINT inv_m_customersalesordergenerate_ibfk_1 FOREIGN KEY (INT_STATEID) REFERENCES com_m_state (INT_STATEID) ";
									asql = asql + "  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=REDUNDANT; ";
									ast.executeUpdate(asql);
									System.out.println("Table Created :"+asql);
								}
								else if("inv_m_directdcgenerate".equals(Type) || "All".equals(Type))
								{
									asql = " DROP TABLE inv_m_directdcgenerate ; ";
									ast.executeUpdate(asql);
									System.out.println("Table Dropped :"+asql);
									
									asql = " CREATE TABLE inv_m_directdcgenerate ( ";
									asql = asql + "    INT_DIRECT_DCID bigint(11) unsigned NOT NULL default '0', ";
									asql = asql + "   PRIMARY KEY  (INT_DIRECT_DCID) ";
									asql = asql + "  ) ENGINE=InnoDB DEFAULT CHARSET=latin1; ";
									ast.executeUpdate(asql);
									System.out.println("Table Created :"+asql);
								}
								else if("inv_m_invoicegenerate".equals(Type) || "All".equals(Type))
								{
									asql = " DROP TABLE inv_m_invoicegenerate; ";
									ast.executeUpdate(asql);
									System.out.println("Table Dropped :"+asql);
									
									asql = "  CREATE TABLE inv_m_invoicegenerate ( ";
									asql = asql + "    INT_ROWID int(11) NOT NULL auto_increment, ";
									asql = asql + "    INT_INVOICEID bigint(11) unsigned NOT NULL default '0', ";
									asql = asql + "    INT_STATEID int(11) default '31', ";
									asql = asql + "    PRIMARY KEY  (INT_ROWID), ";
									asql = asql + "    KEY INT_STATEID (INT_STATEID), ";
									asql = asql + "    CONSTRAINT inv_m_invoicegenerate_ibfk_1 FOREIGN KEY (INT_STATEID) REFERENCES com_m_state (INT_STATEID) ";
									asql = asql + "  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=REDUNDANT; ";
									ast.executeUpdate(asql);
									System.out.println("Table Created :"+asql);
								}
								else if("inv_m_pogenerate".equals(Type) || "All".equals(Type))
								{
									asql = " DROP TABLE inv_m_pogenerate ; ";
									ast.executeUpdate(asql);
									System.out.println("Table Dropped :"+asql);
									
									asql = "  CREATE TABLE inv_m_pogenerate ( ";
									asql = asql + "    INT_ROWID int(11) NOT NULL auto_increment, ";
									asql = asql + "    INT_PURCHASEID bigint(11) unsigned NOT NULL default '0', ";
									asql = asql + "    INT_STATEID int(11) default '31', ";
									asql = asql + "    PRIMARY KEY  (INT_ROWID), ";
									asql = asql + "    KEY INT_STATEID (INT_STATEID), ";
									asql = asql + "    CONSTRAINT inv_m_pogenerate_ibfk_1 FOREIGN KEY (INT_STATEID) REFERENCES com_m_state (INT_STATEID) ";
									asql = asql + "  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=REDUNDANT; ";
									ast.executeUpdate(asql);
									System.out.println("Table Created :"+asql);
								}
								else if("inv_m_quotationgenerate".equals(Type) || "All".equals(Type))
								{
									asql = " DROP TABLE inv_m_quotationgenerate ; ";
									ast.executeUpdate(asql);
									System.out.println("Table Dropped :"+asql);
									
									asql = "  CREATE TABLE inv_m_quotationgenerate ( ";
									asql = asql + "    INT_ROWID int(11) NOT NULL auto_increment, ";
									asql = asql + "    INT_QUOTATIONID bigint(11) unsigned NOT NULL default '0', ";
									asql = asql + "    INT_STATEID int(11) default '31', ";
									asql = asql + "    PRIMARY KEY  (INT_ROWID) ";
									asql = asql + "  ) ENGINE=InnoDB DEFAULT CHARSET=latin1; ";
									ast.executeUpdate(asql);
									System.out.println("Table Created :"+asql);
								}
								else if("inv_m_servicebillgenerate".equals(Type) || "All".equals(Type))
								{
									asql = " DROP TABLE inv_m_servicebillgenerate; ";
									ast.executeUpdate(asql); 
									System.out.println("Table Dropped :"+asql);
									
									asql =  "  CREATE TABLE inv_m_servicebillgenerate ( ";
									asql = asql + "    INT_ROWID int(11) NOT NULL auto_increment, ";
									asql = asql + "    INT_SERVICEBILLID bigint(11) unsigned default NULL, ";
									asql = asql + "    INT_STATEID int(11) default '31', ";
									asql = asql + "    PRIMARY KEY  (INT_ROWID), ";
									asql = asql + "    KEY INT_STATEID (INT_STATEID), ";
									asql = asql + "    CONSTRAINT inv_m_servicebillgenerate_ibfk_1 FOREIGN KEY (INT_STATEID) REFERENCES com_m_state (INT_STATEID) ";
									asql = asql + "  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=REDUNDANT; ";
									ast.executeUpdate(asql);
									System.out.println("Table Created :"+asql);
								}
								else if("inv_m_vendorpogenerate".equals(Type) || "All".equals(Type))
								{
									asql = " DROP TABLE inv_m_vendorpogenerate ; ";
									ast.executeUpdate(asql);
									System.out.println("Table Dropped :"+asql);
									
									asql =  "  CREATE TABLE inv_m_vendorpogenerate ( ";
									asql = asql + "    INT_ROWID int(11) NOT NULL auto_increment, ";
									asql = asql + "    INT_PURCHASEID bigint(11) unsigned default NULL, ";
									asql = asql + "    INT_STATEID int(11) default '31', ";
									asql = asql + "    PRIMARY KEY  (INT_ROWID), ";
									asql = asql + "    KEY INT_STATEID (INT_STATEID), ";
									asql = asql + "    CONSTRAINT inv_m_vendorpogenerate_ibfk_1 FOREIGN KEY (INT_STATEID) REFERENCES com_m_state (INT_STATEID) ";
									asql = asql + "  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=REDUNDANT; ";
									ast.executeUpdate(asql);
									System.out.println("Table Created :"+asql);

								}
								else if("inv_t_deliverychallangenerate".equals(Type) || "All".equals(Type))
								{
									asql = " DROP TABLE inv_t_deliverychallangenerate; ";
									ast.executeUpdate(asql);
									System.out.println("Table Dropped :"+asql);
									
									asql = "  CREATE TABLE inv_t_deliverychallangenerate ( ";
									asql = asql + "    INT_ROWID int(11) NOT NULL auto_increment, ";
									asql = asql + "    INT_DCNUMBER bigint(11) unsigned NOT NULL default '0', ";
									asql = asql + "    INT_STATEID int(11) default '31', ";
									asql = asql + "    PRIMARY KEY  (INT_ROWID), ";
									asql = asql + "    KEY INT_STATEID (INT_STATEID), ";
									asql = asql + "    CONSTRAINT inv_t_deliverychallangenerate_ibfk_1 FOREIGN KEY (INT_STATEID) REFERENCES com_m_state (INT_STATEID) ";
									asql = asql + "  ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=REDUNDANT; ";
									ast.executeUpdate(asql);
									System.out.println("Table Created :"+asql);
								}
								else if("inv_t_scrabgenerate".equals(Type) || "All".equals(Type))
								{
									asql = " DROP TABLE inv_t_scrabgenerate ; ";
									ast.executeUpdate(asql);
									System.out.println("Table Dropped :"+asql);
									
									asql = "  CREATE TABLE inv_t_scrabgenerate ( ";
									asql = asql + "    INT_ROWID int(11) NOT NULL auto_increment, ";
									asql = asql + "    INT_SCRABNUMBER bigint(11) unsigned NOT NULL default '0', ";
									asql = asql + "    INT_STATEID int(11) default '31', ";
									asql = asql + "    PRIMARY KEY  (INT_ROWID) ";
									asql = asql + "  ) ENGINE=InnoDB DEFAULT CHARSET=latin1; ";
									ast.executeUpdate(asql);
									System.out.println("Table Created :"+asql);
								}
								else if("inv_m_purchaserequestnogenerate".equals(Type) || "All".equals(Type))
								{
									asql = " DROP TABLE inv_m_purchaserequestnogenerate; ";
									ast.executeUpdate(asql);
									System.out.println("Table Dropped :"+asql);
									
									asql = "  CREATE TABLE inv_m_purchaserequestnogenerate ( ";
									asql = asql + "    INT_PURCHASEREQUESTID bigint(11) unsigned NOT NULL default '0', ";
									asql = asql + "    PRIMARY KEY  (INT_PURCHASEREQUESTID) ";
									asql = asql + "  ) ENGINE=InnoDB DEFAULT CHARSET=latin1; ";
									ast.executeUpdate(asql);
									System.out.println("Table Created :"+asql);
								}
								else if("inv_m_stocktransfergenerate".equals(Type) || "All".equals(Type))
								{
									asql = " DROP TABLE inv_m_stocktransfergenerate; ";
									ast.executeUpdate(asql);
									System.out.println("Table Dropped :"+asql);
									
									asql = "  CREATE TABLE inv_m_stocktransfergenerate ( ";
									asql = asql + "    INT_TRANSFERID bigint(11) unsigned NOT NULL default '0', ";
									asql = asql + "    PRIMARY KEY  (INT_TRANSFERID) ";
									asql = asql + "  ) ENGINE=InnoDB DEFAULT CHARSET=latin1; ";
									ast.executeUpdate(asql);
									System.out.println("Table Created :"+asql);
									
								}
								System.out.println(asql);
								System.out.println();
								 
								ast.close();
								response.sendRedirect("Utility/InventoryReset.jsp");
						} 
						catch (Exception e) 
						{
							System.out.println(e.getMessage());
						}
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