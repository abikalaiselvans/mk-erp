package com.my.org.erp.SmartMarketing;

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
import com.my.org.erp.ServiceLogin.DateUtil;
 
public class QuoteConversionActionHandler extends AbstractActionHandler {
	
	 
	 

	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{

		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			Statement st = con.createStatement();
			if (action.equals("MKTQuoteConversionAdd")) 
			{ 
				QuoteConversion d = new QuoteConversion();
				Map map=request.getParameterMap();
				BeanUtils.populate(d,map);
				QuoteConversionMethod.addQuotation(con,d, request, response);
				String quoId=""+session.getAttribute("QUTNO");
				itemInsert(con,request,response,quoId,st);	
				
				asql = "UPDATE mkt_t_quotation SET CHR_MOVING_TO_CPO ='Y', CHR_CPOQUOTENUMBER= ? WHERE CHR_QUOTATIONNO=? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1, quoId);
				apstm.setString(2, d.sfno);
				apstm.execute();
				apstm.close();
				
				con.close();    
				response.sendRedirect("Smart Marketing/MovetoCPO.jsp");
			}
			 
			//response.sendRedirect("Smart Marketing/CustomerGroup.jsp");
				
			
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
		}
	}

	
	
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
				System.out.println("====3"+apstm);
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
	
}
