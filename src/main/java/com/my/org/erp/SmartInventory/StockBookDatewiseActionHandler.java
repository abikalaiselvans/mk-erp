package com.my.org.erp.SmartInventory;

import java.io.IOException;
import java.util.Vector;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class StockBookDatewiseActionHandler extends AbstractActionHandler
{
		@SuppressWarnings("unchecked")
		public synchronized void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
		{
			try
			{
					String action=request.getParameter("actionS");
					HttpSession session=request.getSession();			
					String userid=""+session.getAttribute("USRID");
					System.out.println("STOCK BOOK DATE WISE IN & OUT CREATED BY :"+userid.toUpperCase());
					String sql = "";
					if(action.equals("INVStockBookDatewise"))
					{ 
						String  Branch = request.getParameter("Branch");
					 	String  fromdate = request.getParameter("fromdate");
					 	String  todate = request.getParameter("todate");
					  	String itype = request.getParameter("itype");
					  	String item = request.getParameter("item");
					  	@SuppressWarnings("rawtypes")
						Vector mn = new Vector();
						@SuppressWarnings("rawtypes")
						Vector child= null;
						if("2".equals(itype)) 
						 {
								 
								fromdate =  DateUtil.FormateDateSQL(fromdate) ;
								todate =  DateUtil.FormateDateSQL(todate) ;
								int qty1=0;
								int qty2=0;
								int qty3=0;
								int qty4=0;
								 
								double value1=0;
								double value2=0;
								double value3=0;
								double value4=0;
								double unitprice=0;
								
								sql = " SELECT a.CHR_NAME,b.CHR_PRODUCTID,b.CHR_PRODUCTCODE,b.CHR_PRODUCTDESC,b.CHR_PTYPE,  ";
								sql = sql + " INV_FIND_A_PRODUCT_BEFORE_INWARD('"+Branch+"','"+fromdate+"',b.CHR_PRODUCTID), ";
								sql = sql + " INV_FIND_A_PRODUCT_BEFORE_OUTWARD('"+Branch+"','"+fromdate+"',b.CHR_PRODUCTID), ";
								sql = sql + " INV_FIND_A_PRODUCT_INWARD('"+Branch+"','"+fromdate+"','"+todate+"',b.CHR_PRODUCTID), ";
								sql = sql + " INV_FIND_A_PRODUCT_OUTWARD('"+Branch+"','"+fromdate+"','"+todate+"',b.CHR_PRODUCTID) ";
								sql = sql + " FROM inv_m_productgroup a, inv_m_produtlist b ";
								sql = sql + "  WHERE a.INT_PRODUCTGROUPID= b.INT_PRODUCTGROUPID  AND b.INT_ACTIVE !=0  ";
								if(!"0".equals(item))
										sql = sql + " AND b.CHR_PRODUCTID ='"+item+"'";
								 
								//out.println(sql);
								String data[][] =  CommonFunctions.QueryExecute(sql);
								if(data.length>0)
								{
								    for(int u=0;u<data.length;u++)
									{
										try 
										{
											qty1=0;
											qty2=0;
											qty3=0;
											qty4=0;
											value1=0;
											value2=0;
											value3=0;
											value4=0;
											unitprice=0; 
											child = new Vector();
											child.addElement((u+1));
											child.addElement("Product");
											child.addElement(data[u][0]);
											child.addElement(data[u][2]);
											child.addElement(data[u][3]);
											if("F".equals(data[u][4]))
												child.addElement("Full Product");
											else if("C".equals(data[u][4]))
												child.addElement("Combination Product");
											else 
												child.addElement("Consumable Product");
											qty1 = Integer.parseInt(  data[u][5].split(",") [0] );
											child.addElement(qty1);
											unitprice=Double.parseDouble( data[u][5].split(",")[1] );
											value1 = Double.parseDouble( data[u][5].split(",")[2] );
											child.addElement(value1);
											 
											qty2 = Integer.parseInt(data[u][6]);
											child.addElement(qty2);
											value2 =  (qty2*unitprice) ;
											child.addElement(value2);
											child.addElement((qty1-qty2));
											child.addElement((value1-value2));
											
											
											qty3 = Integer.parseInt(  data[u][7].split(",")[0] );
											child.addElement(qty3);
											unitprice=Double.parseDouble( data[u][7].split(",")[1] );
											value3 = Double.parseDouble( data[u][7].split(",")[2] );
											child.addElement(value3);
											
											qty4 = Integer.parseInt( data[u][8] );
											child.addElement(qty4);
											value4 =  (qty4 *unitprice);
											child.addElement(value4);
											 
											child.addElement((qty1-qty2+qty3+qty4 ) );
											child.addElement( (value1-value2 +value3-value4) );
											mn.add(child);
										} 
										catch (Exception e) 
										{
											 System.out.println(e.getMessage());
										}
							      	}
								}
						} 
						request.setAttribute("table",mn);
						RequestDispatcher dispatcher = request.getRequestDispatcher("Smart Inventory/Rept_StockBookDateViewresponse.jsp");
	    				dispatcher.forward(request, response); 
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
		
		
		
		 
 
 