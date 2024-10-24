package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.beanutils.BeanUtils;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.mail.Mail;
import com.my.org.erp.setting.CommonData;

public class QuotationOrderActionHandler extends AbstractActionHandler
{
 	public static void  itemInsert(java.sql.Connection con, HttpServletRequest request,HttpServletResponse response, String quotationnumber ,Statement st )throws ServletException, IOException 
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
			for(int p=0;p<param.length; p++)
			{
				String e =""+request.getParameter("itype"+param[p].trim());
				if(e.equals("1") )
					itype="I";
				if(e.equals("2") )
					itype="P";
			 
				field ="INT_BRANCHID,CHR_QUOTATIONNO,CHR_ITEMID,CHR_TYPE,CHR_DESC,INT_QUANTITY," ;
				field  = field  + "DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,INT_WARRANTY, ";
				field  = field  + "INT_TAXID,DOU_TAX_PERCENTAGE,DOU_TAX_AMOUNT, ";
				field  = field  + "DOU_TOTAL,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ";
				sql=" INSERT INTO  inv_t_customerquotationitem  (" +field+" ) VALUES (";
				sql = sql +"?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,DATE(NOW()),'Y' )";
				
				PreparedStatement  apstm = con.prepareStatement(sql);
				apstm.setString(1, branchid);
				apstm.setString(2, quotationnumber);
				apstm.setString(3, request.getParameter("item"+param[p].trim()));
				apstm.setString(4, itype);
				apstm.setString(5, (request.getParameter("desc"+param[p].trim()).replace("\"", "")).replaceAll("&", " and"));
				apstm.setString(6,  request.getParameter("qty"+param[p].trim()));
				apstm.setString(7, (request.getParameter("uprice"+param[p].trim())));
				apstm.setString(8, request.getParameter("discount"+param[p].trim()));
				apstm.setString(9, (request.getParameter("unitdiscount"+param[p].trim())));
				apstm.setString(10, (request.getParameter("warranty"+param[p].trim())));
				apstm.setString(11, request.getParameter("stax"+param[p].trim()));
				apstm.setString(12, request.getParameter("staxpercentage"+param[p].trim()));
				apstm.setString(13, request.getParameter("staxamount"+param[p].trim()));
				apstm.setString(14, (request.getParameter("total"+param[p].trim())));
				apstm.setString(15,userId);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				 			
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
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	 {
		try
		{
				String action=request.getParameter("actionS");
				HttpSession session=request.getSession();			
				String branchid = session.getAttribute("BRANCHID").toString();
				String user = session.getAttribute("USRID").toString();
				String officeid=""+session.getAttribute("INVOFFICEID");
				
				Statement st = con.createStatement();
				 
				if("INVQuotationAdd".equals(action))
				{
					
					
					Quotation d = new  Quotation();
					Map map=request.getParameterMap();
					BeanUtils.populate(d,map);
					CustomerQuotationMethod.addQuotation(con,d, request, response);
					String quoId=""+session.getAttribute("QUTNO");
					itemInsert(con,request,response,quoId,st);	
					con.close();    
					response.sendRedirect("Smart Inventory/Quotation.jsp?quoId="+quoId);
				}
				else if("INVQuotationEdit".equals(action))
				{
					
					String quotationnumber =""+request.getParameter("quotationId");
					Quotation d = new Quotation();
					Map map=request.getParameterMap();
					BeanUtils.populate(d,map);
					CustomerQuotationMethod.addQuotationUpdate(con,d, request, response);
					asql = "delete from  inv_t_customerquotationitem  where CHR_QUOTATIONNO=?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, quotationnumber);
					apstm.execute();
					apstm.close();
					itemInsert(con,request,response,quotationnumber,st);	
					con.close();   
					response.sendRedirect("Smart Inventory/Quotation.jsp?quoId="+quotationnumber);
				}
				else if("INVQuotationDelete".equals(action ))
				{
					String qids[]=request.getParameterValues("itemId");
					System.out.println(qids.length);
					for(int u=0;u<qids.length;u++)
					{	
						
						asql = "DELETE FROM  inv_t_customerquotationitem  WHERE CHR_QUOTATIONNO=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, qids[u]);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
						
						asql = "DELETE FROM  inv_t_customerquotation  WHERE CHR_QUOTATIONNO=?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1, qids[u]);
						System.out.println(""+apstm);
						apstm.execute();
						apstm.close();
					}
					con.close();    
					response.sendRedirect("Smart Inventory/Quotation.jsp");
				}
				else  if("INVQuotationSendMail".equals(action ))
				{ 
					//if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]))
					String quoNumber =request.getParameter("qid");
					String email =request.getParameter("email");
					String content = QuotationMail.mailContent(quoNumber, branchid);
					String a[] =(email+","+CommonData.mailid).split(",") ;
					Mail.SimpleHTMLMail(  a,  "CUSTOMER QUOTATION :: "+quoNumber, content);
					con.close();    
					response.sendRedirect("Smart Inventory/Quotation.jsp");
				}
				else if("INVCPOQuotationCancel".equals(action))
				{
					String qnumber= request.getParameter("qnumber");
					String reason= request.getParameter("reason");
					asql = "UPDATE inv_t_customerquotation SET CHR_CANCEL=?,CHR_CANCELDESC=?,";
					asql = asql+" CHR_CANCELID=?,DAT_CANCELDATE=DATE(NOW()) WHERE CHR_QUOTATIONNO =? AND CHR_STATUS ='N'";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,"Y" );
					apstm.setString(2,reason );
					apstm.setString(3,user );
					apstm.setString(4,qnumber );
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					con.close();    
					response.sendRedirect("Smart Inventory/Quotation.jsp");
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