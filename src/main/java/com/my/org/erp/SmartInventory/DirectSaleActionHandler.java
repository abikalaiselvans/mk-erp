package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;

import com.my.org.erp.bean.inventory.DirectSale;
import com.my.org.erp.common.CommonInfo;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class DirectSaleActionHandler extends AbstractActionHandler
{
	public static void  itemInsert(HttpServletRequest request,HttpServletResponse response, String cashSaleNo ,Connection con,Statement st,String branch)throws ServletException, IOException 
	{
		try 
		{
			String field="";
			String sql="";			
			HttpSession session=request.getSession();			
			String userId=""+session.getAttribute("USRID");
			String branchid = session.getAttribute("BRANCHID").toString();
			String param[] = request.getParameter("param").split(",");
			String itype="";
			String itemid = "";
			int pqty=0;
			for(int p=0;p<param.length; p++)
			{
				String e =""+request.getParameter("itype"+param[p].trim());
				itemid =""+request.getParameter("item"+param[p].trim());
				pqty =Integer.parseInt(request.getParameter("qty"+param[p].trim()));
				if(e.equals("1") )
					itype="I";
				if(e.equals("2") )
					itype="P";
				
				//insert into total item 
				field = "INT_BRANCHID,CHR_SALESNO,CHR_ITEMID,CHR_TYPE,CHR_DESC,INT_QUANTITY,"; 
				field = field+"DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,DOU_TOTAL,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS" ;
				sql=" INSERT INTO inv_t_directsalesitem (" +field+" ) VALUES (";
				sql = sql +Integer.parseInt(branch)+" , ";
				sql = sql +" '"+cashSaleNo+"' , ";
				sql = sql +"'"+itemid+"' , ";
				sql = sql +"'"+itype+"' , ";
				sql = sql +"'"+request.getParameter("desc"+param[p].trim())+"' , ";
				sql = sql +pqty+" , ";
				sql = sql +Double.parseDouble(request.getParameter("uprice"+param[p].trim()))+" , ";
				sql = sql +"'"+request.getParameter("discount"+param[p].trim())+"' , ";
				sql = sql +Double.parseDouble(request.getParameter("unitdiscount"+param[p].trim()))+" , ";
				sql = sql +Double.parseDouble(request.getParameter("total"+param[p].trim()))+" , ";
				sql = sql +"'"+userId+"' , ";
				sql = sql +" now() , 'Y' ) ";
				Statement ts = con.createStatement();
				ts.execute(sql);
				ts.close();
				 
				
				 
				
				//insert into individual serial number and warranty
				for(int u=0; u<Integer.parseInt(request.getParameter("qty"+param[p].trim()));u++)
				{
					field =" (INT_BRANCHID,CHR_SALESNO,CHR_ITEMID,CHR_TYPE ," +
					" CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
					sql ="INSERT INTO inv_t_directsalesserialno " + field ;
					sql = sql+	" VALUES (";
					sql = sql +Integer.parseInt(branch)+" , ";
					sql = sql +"'"+cashSaleNo+"' , ";
					sql = sql +"'"+itemid+"' , ";
					sql = sql +"'"+itype+"' , ";
					sql = sql +"'"+userId+"' , ";
					sql = sql +" now() , 'Y' ) ";
					st.execute(sql);
				}
				
				//	update the stock to tobranchid
				sql ="SELECT * FROM inv_t_stock  WHERE CHR_ITEMID  = '"+itemid+"' AND CHR_TYPE='"+itype+"' AND INT_BRANCHID="+branchid;						
				int sdbrqty =CommonInfo.intGetAnySelectField(sql,"INT_STOCKINHAND" );
				sdbrqty = sdbrqty-pqty;
				sql = "UPDATE inv_t_stock SET ";
				sql = sql +" INT_STOCKINHAND ="+(sdbrqty)+" ";
				sql = sql +" WHERE CHR_ITEMID  = '"+itemid+"' AND CHR_TYPE='"+itype+"' AND INT_BRANCHID="+branchid;
				//st.execute(sql);
				
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
	
	@SuppressWarnings("rawtypes")
	public synchronized  void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	 {
		try
		{
				String action=request.getParameter("actionS");
				HttpSession session=request.getSession();			
				String userId=""+session.getAttribute("USRID");
				String branchid = session.getAttribute("BRANCHID").toString();
				Statement st = con.createStatement();
				String sql="";
				if(action.equals("INVDirectSaleAdd"))
				{					
					DirectSale d = new DirectSale();
					Map map=request.getParameterMap();
					BeanUtils.populate(d,map);
					DirectSaleMethod.addDirectSale(con,d, request, response);
					String cashSaleNo =""+request.getParameter("cashSaleNo");
					itemInsert(request,response,cashSaleNo,con,st,branchid);
					request.setAttribute("serialno", "true");
					con.close();    
					response.sendRedirect("Smart Inventory/DirectSaleSerial.jsp?salno="+cashSaleNo);
				}
				
				else if("INVDirectSaleUpdate".equals(action))
				{
					
					String param = request.getParameter("param");
					String cashSaleNo =""+request.getParameter("cashSaleNo");
					String saleDate =""+request.getParameter("saleDate");
					saleDate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(saleDate);
					String paymentterm =""+request.getParameter("payment");
					String memo =""+request.getParameter("memo");
					String ref =""+request.getParameter("ref");
					String tot =""+request.getParameter("totals");
					String totaldiscount =""+request.getParameter("totaldiscount");
					String tax =""+request.getParameter("tax");
					
					String salestaxamount =""+request.getParameter("salestaxamount");
					String nettotal =""+request.getParameter("nettotal");
					sql =" UPDATE inv_t_directsales SET";
					sql = sql +" DAT_SALESDATE = ' "+saleDate+"' , ";
					sql = sql +" INT_PAYMENTTERMID = ' "+paymentterm+"' ,";
					sql = sql +" CHR_DES = ' "+memo+"' , ";
					sql = sql +" CHR_REF = ' "+ref+"' , ";
					sql = sql +" DOU_AMOUNT =  "+tot+" , ";
					sql = sql +" DOU_DISCOUNT =  "+totaldiscount+"  , ";
					sql = sql +" INT_TAXID =  "+tax+" , ";
					sql = sql +" DOU_TAXAMOUNT =  "+salestaxamount+" ,  ";
					sql = sql +" DOU_TOTALAMOUNT =  "+nettotal+"   ";
					sql = sql +" WHERE CHR_SALESNO ='"+cashSaleNo+"' ";
					sql = sql +" AND  INT_BRANCHID ="+Integer.parseInt(branchid);
					st.execute(sql);
					
					sql = "DELETE FROM inv_t_directsalesitem WHERE CHR_SALESNO ='"+cashSaleNo.trim()+"' "; 
					sql = sql +" AND  INT_BRANCHID ="+Integer.parseInt(branchid);
					st.execute(sql);
					
					sql = "SELECT CHR_SERIALNO FROM inv_t_directsalesserialno WHERE CHR_SALESNO ='"+cashSaleNo.trim()+"' "; 
					sql = sql +" AND  INT_BRANCHID ="+Integer.parseInt(branchid);
					String readData[][] = com.my.org.erp.common.CommonInfo.KRecordSetArray(sql);
					
					for(int x=0;x<readData.length;x++)
					{
						sql = "UPDATE inv_t_vendorgoodsreceived SET";
						sql = sql+" CHR_FLAG ='N'  ";			
						sql = sql+" WHERE  CHR_SERIALNO='"+readData[x][0]+"'";
						st.execute(sql);
					}
					
					sql = "DELETE FROM inv_t_directsalesserialno WHERE CHR_SALESNO ='"+cashSaleNo.trim()+"' "; 
					sql = sql +" AND  INT_BRANCHID ="+Integer.parseInt(branchid);
					st.execute(sql);
					
					int desclength = Integer.parseInt(param);
					String itype="";
					String itemname="";
					for(int u=1; u<=desclength;u++)
					{
						
						itype="";
						itemname="";
						itemname=request.getParameter("item"+u);
						itype= request.getParameter("itype"+u);
						int dcqty =Integer.parseInt(request.getParameter("qty"+u));
						int previousqty =Integer.parseInt(request.getParameter("pstock"+u));
						
						String field = "INT_BRANCHID,CHR_SALESNO,CHR_ITEMID,CHR_TYPE,CHR_DESC,INT_QUANTITY,"; 
						field = field+"DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,DOU_TOTAL,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS" ;
						sql=" INSERT INTO inv_t_directsalesitem (" +field+" ) VALUES (";
						sql = sql +Integer.parseInt(branchid)+" , ";
						sql = sql +" '"+cashSaleNo+"' , ";
						sql = sql +"'"+request.getParameter("item"+u)+"' , ";
						sql = sql +"'"+itype+"' , ";
						sql = sql +"'"+request.getParameter("desc"+u)+"' , ";
						sql = sql +dcqty +" , ";
						sql = sql +Double.parseDouble(request.getParameter("uprice"+u))+" , ";
						sql = sql +"'"+request.getParameter("discount"+u)+"' , ";
						sql = sql +Double.parseDouble(request.getParameter("unitdiscount"+u))+" , ";
						sql = sql +Double.parseDouble(request.getParameter("total"+u))+" , ";
						sql = sql +"'"+userId+"' , ";
						sql = sql +" now() , 'Y' ) ";
						st.execute(sql);			
						for(int v=0; v<Integer.parseInt(request.getParameter("qty"+u));v++)
						{
							field =" (INT_BRANCHID,CHR_SALESNO,CHR_ITEMID,CHR_TYPE," +
							" CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
							sql ="INSERT INTO inv_t_directsalesserialno " + field ;
							sql = sql+	" VALUES (";
							sql = sql +Integer.parseInt(branchid)+" , ";
							sql = sql +"'"+cashSaleNo+"' , ";
							sql = sql +"'"+request.getParameter("item"+u)+"' , ";
							sql = sql +"'"+itype+"' , ";
							sql = sql +"'"+userId+"' , ";
							sql = sql +" now() , 'Y' ) ";
							st.execute(sql);
						}
						
						//update the stock to tobranchid
						sql ="SELECT * FROM inv_t_stock  WHERE CHR_ITEMID  = '"+itemname+"' AND CHR_TYPE='"+itype+"' AND INT_BRANCHID="+branchid;						
						int sdbrqty =CommonInfo.intGetAnySelectField(sql,"INT_STOCKINHAND" );
						sdbrqty = (sdbrqty+previousqty)-dcqty;
						sql = "UPDATE inv_t_stock SET ";
						sql = sql +" INT_STOCKINHAND ="+(sdbrqty)+" ";
						sql = sql +" WHERE CHR_ITEMID  = '"+itemname+"' AND CHR_TYPE='"+itype+"' AND INT_BRANCHID="+branchid;
						//st.execute(sql);
						 
				 	}
					request.setAttribute("serialno", "true");
					con.close();   
					response.sendRedirect("Smart Inventory/DirectSaleSerial.jsp?salno="+cashSaleNo);
				}
				else if("INVDirectSaleDelete".equals(action))
				{
					String cashsaleids[] = request.getParameterValues("itemId");
					
					for(int u=0; u<cashsaleids.length;u++)
					{	
						String cashSaleNo = cashsaleids[u].trim();
						sql ="DELETE FROM inv_t_directsales  WHERE CHR_SALESNO ='"+cashSaleNo+"' "; 
						st.execute(sql);
						sql = " select CHR_ITEMID,INT_QUANTITY,CHR_TYPE  from inv_t_directsalesitem WHERE CHR_SALESNO ='"+cashSaleNo.trim()+"' "; 
						String stockdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						sql = "DELETE FROM inv_t_directsalesitem WHERE CHR_SALESNO ='"+cashSaleNo.trim()+"' "; 
						st.execute(sql);
						String itype="";
						
						int pqty=0;
						for(int x=0;x<stockdata.length;x++)
						{	
							itype =stockdata[x][2];
							pqty =Integer.parseInt(stockdata[x][1]);
							//	update the stock to tobranchid
							sql ="SELECT * FROM inv_t_stock  WHERE CHR_ITEMID  = '"+stockdata[x][0]+"' AND CHR_TYPE='"+itype+"' AND INT_BRANCHID="+branchid;						
							int sdbrqty =CommonInfo.intGetAnySelectField(sql,"INT_STOCKINHAND" );
							sdbrqty = sdbrqty+pqty;
							sql = "UPDATE inv_t_stock SET ";
							sql = sql +" INT_STOCKINHAND ="+(sdbrqty)+" ";
							sql = sql +" WHERE CHR_ITEMID  = '"+stockdata[x][0]+"' AND CHR_TYPE='"+itype+"' AND INT_BRANCHID="+branchid;
							st.execute(sql);
					 	}
						sql = "SELECT CHR_SERIALNO FROM inv_t_directsalesserialno WHERE CHR_SALESNO ='"+cashSaleNo.trim()+"' "; 
						String readData[][] = com.my.org.erp.common.CommonInfo.KRecordSetArray(sql);
						for(int x=0;x<readData.length;x++)
						{
							sql = "UPDATE inv_t_vendorgoodsreceived SET";
							sql = sql+" CHR_FLAG ='N'  ";			
							sql = sql+" WHERE  CHR_SERIALNO='"+readData[x][0]+"'";
							st.execute(sql);
						}
						sql = "DELETE FROM inv_t_directsalesserialno WHERE CHR_SALESNO ='"+cashSaleNo.trim()+"' "; 
						st.execute(sql);
					}
					con.close();    
					response.sendRedirect("Smart Inventory/Direct Sale.jsp ");
				}
				else if("INVDirectSaleAddserial".equals(action))
				{
					String salesno =request.getParameter("salesno");
					sql ="SELECT INT_ID,CHR_SALESNO,CHR_ITEMID,CHR_TYPE FROM inv_t_directsalesserialno WHERE CHR_SALESNO ='"+salesno+"' ORDER By INT_ID";
					String recdData[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					int row=1;
					for(int v=0;v<recdData.length; v++)
					{
						int rowid = Integer.parseInt(recdData[v][0]);
						String itemid=recdData[v][2];
						String itype =recdData[v][3];
						String serail = request.getParameter("serial"+row);
						String warranty = request.getParameter("Warrantys"+row);
						sql ="UPDATE  inv_t_directsalesserialno SET " ; 
						sql = sql +" CHR_SERIALNO ='"+serail+"' ,   ";
						sql = sql +" CHR_WARRANTY ='"+warranty+"'  ";
						sql = sql +" WHERE INT_ID= "+rowid;
						st.execute(sql);
					
						sql = "UPDATE inv_t_vendorgoodsreceived SET";
						sql = sql+" CHR_FLAG ='Y'  ";			
						sql = sql+" WHERE CHR_ITEMID ='"+itemid+"' AND CHR_SERIALNO='"+serail+"'";
						st.execute(sql);
						//	update the stock to tobranchid
						sql ="SELECT * FROM inv_t_stock  WHERE CHR_ITEMID  = '"+itemid+"' AND CHR_TYPE='"+itype+"' AND INT_BRANCHID="+branchid;						
						int sdbrqty =CommonInfo.intGetAnySelectField(sql,"INT_STOCKINHAND" );
						sdbrqty = sdbrqty-1;
						sql = "UPDATE inv_t_stock SET ";
						sql = sql +" INT_STOCKINHAND ="+(sdbrqty)+" ";
						sql = sql +" WHERE CHR_ITEMID  = '"+itemid+"' AND CHR_TYPE='"+itype+"' AND INT_BRANCHID="+branchid;
						st.execute(sql);
						row = row+1;
					}	
					sql = "UPDATE inv_t_directsales SET INT_SALESSTATUS=1 WHERE CHR_SALESNO='"+salesno+"'";
					st.execute(sql);
					request.setAttribute("serialno", "false");
					con.close();    
					response.sendRedirect("Smart Inventory/Direct Sale.jsp ");
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


