package com.my.org.erp.SmartAset;
import java.io.IOException;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
 
 
public class AssetEntryActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{		
		try
		{
				String action=""+request.getParameter("actionS").trim();
				
				if("ASSAssetEntryAdd".equals(action))
				{
					String Branch = request.getParameter("Branch");
					String divis = request.getParameter("divis");
					String vendorid = request.getParameter("vendorid");
					String invoicedate = request.getParameter("invoicedate");
					invoicedate= com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(invoicedate);
					String invoicerefno  = request.getParameter("invoicenumber");
					String ref = request.getParameter("ref");
					String invoicenumber="";
					if("0".equals(com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT COUNT(*) FROM  asset_t_assetentry")[0][0]))
						invoicenumber="1";
					else
						invoicenumber=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT (MAX(INT_ENTRYASSETID)+1)  FROM  asset_t_assetentry")[0][0];
					
					invoicenumber= invoicenumber+"/ASSET/"+com.my.org.erp.common.CommonFunctions.AccountYear()+"/"+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_DIVISHORTCODE FROM inv_m_division WHERE INT_DIVIID="+divis)[0][0];
						                                                                                                     
					acs = con.prepareCall("{call ASSET_PRO_ASSETENTRY(?,?,?,?,?,?,?,?,?,?,?)}");
					acs.setString(1, "INSERT");
					acs.setString(2, "");
					acs.setString(3, Branch);		
					acs.setString(4, divis);
					acs.setString(5, vendorid);
					acs.setString(6, invoicedate);
					acs.setString(7, invoicerefno);
					acs.setString(8, invoicenumber );
					acs.setString(9, ref);
					acs.setString(10, "N");
					acs.setString(11, auserid);
					acs.execute();
					acs.close();
					
					String param[] = request.getParameter("param").split(",");
					String  assetid = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT MAX(INT_ENTRYASSETID) FROM asset_t_assetentry")[0][0];
					acs = con.prepareCall("{call ASSET_PRO_ASSETENTRYQTY(?,?,?,?,?,?,?,? )}");
					for(int u=0;u<param.length;u++)
					{
						String Item = request.getParameter("Item"+param[u]);
						String Quantity = request.getParameter("Quantity"+param[u]);
					 	acs.setString(1, "INSERT");
						acs.setString(2, "");
						acs.setString(3, assetid);		
						acs.setString(4, Item);
						acs.setString(5, "I");
						acs.setString(6, Quantity);
						acs.setString(7, invoicenumber);
						acs.setString(8, auserid);
						acs.addBatch();
					}
					acs.executeBatch();
					acs.close();
					response.sendRedirect("Smart Asset/AssetEntrySerial.jsp?assetid="+assetid);
					
				}
				else if("ASSAssetEntrySerilaAdd".equals(action))
				{
					String key= request.getParameter("param");
					String assetentryid= request.getParameter("assetentryid");
					String Branch= request.getParameter("Branch");
					String divis= request.getParameter("divis");
					String purchasedate= request.getParameter("purchasedate");
					String purchasenumber= request.getParameter("purchasenumber");
					String ref= request.getParameter("ref");
					acs = con.prepareCall("{call ASSET_PRO_ASSETENTRYSERIAL(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					for(int u=1;u<=Integer.parseInt(key);u++)
					{
						String serial= request.getParameter("serial"+u);
						String statuss= request.getParameter("statuss"+u);
						String item= request.getParameter("item"+u);
						String returnable= request.getParameter("returnable"+u);
						acs.setString(1,"INSERT");
						acs.setString(2,"");
						acs.setString(3,assetentryid);
						acs.setString(4,Branch);
						acs.setString(5,item);
						acs.setString(6,"I");
						acs.setString(7,divis);
						acs.setString(8,DateUtil.FormateDateSQL(purchasedate));
						acs.setString(9,purchasenumber);
						acs.setString(10,ref);
						acs.setString(11,serial);
						acs.setString(12,returnable);
						acs.setString(13,statuss);
						acs.setString(14,auserid);
						acs.addBatch();
						
					}
					acs.executeBatch();
					acs.close();
					response.sendRedirect("Smart Asset/AssetEntry.jsp");
				}
				else if("ASSAssetEntryUpdate".equals(action))
				{
					String assetid = request.getParameter("assetid");
					String Branch = request.getParameter("Branch");
					String divis = request.getParameter("divis");
					String invoicedate = request.getParameter("invoicedate");
					invoicedate= com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(invoicedate);
					String invoicenumber = request.getParameter("invoicenumber");
					String ref = request.getParameter("ref");
					String Item = request.getParameter("Item");
					String ItemSerial = request.getParameter("ItemSerial");
					String statuss = request.getParameter("statuss");
					acs = con.prepareCall("{call ASSET_PRO_ASSET(?,?,?,?,?,?,?,?,?,?,?,?)}");
					acs.setString(1, "UPDATE");
					acs.setString(2, assetid);
					acs.setString(3, Branch);		
					acs.setString(4, Item);
					acs.setString(5, "I");
					acs.setString(6, divis);
					acs.setString(7, invoicedate);
					acs.setString(8, invoicenumber);
					acs.setString(9, ref);
					acs.setString(10, ItemSerial);
					acs.setString(11, statuss);
					acs.setString(12, auserid);
					acs.execute();
					acs.close();
					response.sendRedirect("Smart Asset/AssetEntry.jsp" );
				}	
				else if("ASSAssetEntryDelete".equals(action))
				{ 
					String ids[] = request.getParameterValues("assetid");
					
					acs = con.prepareCall("{call ASSET_PRO_ASSETENTRYSERIAL(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					for(int u=0;u<ids.length;u++)
					{
						acs.setString(1, "DELETE");
						acs.setString(2, ids[0]);
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
						acs.addBatch();
					}
					acs.executeBatch();
					acs.close();
					response.sendRedirect("Smart Asset/AssetEntry.jsp" );
					
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


