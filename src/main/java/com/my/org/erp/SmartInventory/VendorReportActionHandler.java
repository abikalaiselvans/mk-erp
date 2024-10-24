package com.my.org.erp.SmartInventory;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class VendorReportActionHandler extends AbstractActionHandler 
{
	String repName = "";
	String repHeader="";
	
	public static StringBuffer ReportWrite(String sql,int columncount)throws IOException 
	{
		
		try 
		{
			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0)
	 		{	
				sb.append("<Fields>");
				for(int u=0; u<readData.length;u++)
	 			{
	 				sb.append("<Field>");
	 				for(int x=1; x<columncount; x++)
	 					sb.append("<Field"+x+">" +readData[u][x] +"</Field"+x+">");
	 				sb.append("</Field>");	
	 	 		}	
				sb.append("</Fields>");
				
	 		} 
			return sb;		
		}
		catch(Exception e)
		{}
		return null;
	}	
public void handle(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException 
	{
	
		try 
		{
			String action = request.getParameter("actionS");
			action = action.trim();
			String host = request.getRemoteAddr();
			if ("INVVendorReportMonth".equals(action)) 
			{
				@SuppressWarnings("unused")
				String month=request.getParameter("month");
				@SuppressWarnings("unused")
				String year=request.getParameter("year");
				String type=request.getParameter("type");
				@SuppressWarnings("unused")
				String tablename="";
				@SuppressWarnings("unused")
				String tablename1="";
				String sql="";
				int columncount = 0;
				host = host+"Report";
				if("Vendor".equals(type))
				{
					repName =" Vendor Personal Details ";
					sql =" SELECT B.CHR_BRANCHNAME,A.CHR_VENDORNAME,A.CHR_LEGALNAME,A.CHR_STREET,A.CHR_CITY,A.CHR_STATE,A.CHR_POSTAL,A.CHR_COUNTRY,A.CHR_AREACODE,A.CHR_PHONE,A.CHR_FAX,A.CHR_EMAIL,A.CHR_WEBSITE,A.INT_ACTIVE,A.DAT_SINCE,A.CHR_ACCNO,C.CHR_BANKNAME,A.DOU_BALANCE,A.DAT_BALANCEASOF FROM  inv_m_vendorsinformation  A , com_m_branch  B, com_m_bank C WHERE A.INT_BRANCHID = B.INT_BRANCHID AND A.CHR_BANKID =C.INT_BANKID";
					repHeader="BranchName,VendorName,LegalName,Street,City,State,Postal,Country,AreaCode,Phone,Fax,Email,Website,Active,Since,A/c No, Bank Name,Balance, BalanceasOf,";
					columncount=com.my.org.erp.common.CommonInfo.intGetColumnCount(sql);
				}	
				
				if("Purchase".equals(type))
				{	
					repName =" Purchase Details ";
					sql =" SELECT * FROM  inv_t_vendorpurchaseorder ";
					columncount=com.my.org.erp.common.CommonInfo.intGetColumnCount(sql);
				}	
				if("GoodsReceived".equals(type))
				{	
					repName =" Goods Received Details ";
					sql =" SELECT * FROM inv_t_vendorgoodsreceived";
					columncount=com.my.org.erp.common.CommonInfo.intGetColumnCount(sql);
				}	
				if("GoodsReturn".equals(type))
				{	
					repName =" Goods Return Details ";
					sql =" SELECT * FROM  inv_t_vendorgoodsreturn ";
					columncount=com.my.org.erp.common.CommonInfo.intGetColumnCount(sql);
				}	
				if("Payment".equals(type))
				{	
					repName =" Payment Details ";
					sql =" SELECT * FROM  inv_t_vendorpurchasepayment ";
					columncount=com.my.org.erp.common.CommonInfo.intGetColumnCount(sql);
				}
				host=host+type;
				int c=columncount;
				@SuppressWarnings("unused")
				String sdf =sql;
				StringBuffer sb =new StringBuffer();
				if(!"".equals(sql))
				{	
					sb =CommonReport.ReportWrite(sql,columncount);
					CommonReport.ReportWrite(host+".xml",sb);
				}
				con.close();   
				response.sendRedirect("Smart Inventory/Reports.jsp?type="+host+"&repName="+repName+"&repHeader="+repHeader+"c"+c);			
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
