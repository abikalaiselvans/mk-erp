package com.my.org.erp.SmartInventory;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.bean.inventory.CustomerInfo;


public class CustomerInfoMethod extends HttpServlet
{


	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3781319210840309132L;

	public static void addCustomerInfo(Connection con ,PreparedStatement apstm, CustomerInfo d, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
	{
		try
		{			
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");		
			String sql ="";
			sql = "INSERT INTO inv_m_customerinfo  ( ";
			sql = sql+" INT_CUSTOMERGROUPID ,CHR_ALIASNAME,CHR_CONTACTPERSON ,CHR_DEPARTYMENT,CHR_ADDRESS1 , ";
			sql = sql+" CHR_ADDRESS2 ,CHR_ADDRESS3 ,INT_CITYID ,INT_DISTRICTID ,INT_STATEID , ";
			sql = sql+" INT_COUNTRYID ,INT_PINCODE ,CHR_AREACODE ,CHR_PHONE ,CHR_MOBILE ,CHR_FAX , ";
			sql = sql+" CHR_EMAIL ,CHR_WEBSITE ,INT_ACTIVE ,DAT_SINCE ,CHR_ACCNO ,INT_BANKGROUPID , ";
			sql = sql+" DOU_BALANCE ,DAT_BALANCEASOF ,DOU_CREDITLIMIT ,INT_CUSTOMERTYPEID , ";
			sql = sql+" CHR_TIN ,CHR_CST ,CHR_PAN,CHR_BILLING,CHR_BILLINGADDRESS,CHR_TAXEXAMPTION,CHR_TAXEXAMPTIONNO,CHR_GSTNO,CHR_USRNAME ,DT_UPDATEDATE ,CHR_UPDATESTATUS, CHR_ACCOUNTTYPE ) "; 
			sql = sql+" VALUES ( ";
			sql = sql+" ? ,? ,? ,? , ? ,?,? ,? ,? ,? , ? ,? ,? ,? ,? ,? , ? ,? ,? ,? ,? ,? , ";
			sql = sql+" ? ,? ,? ,? , ? ,? ,? ,? ,? ,? ,?,? ,? ,DATE(NOW()) ,'Y', ? "; 
			sql = sql+" )"; 
			apstm = con.prepareStatement(sql);
			apstm.setString(1, d.getCustomergroup());
			apstm.setString(2, d.getAlias());
			apstm.setString(3, d.getCperson().replaceAll("&", " AND ").toUpperCase());
			apstm.setString(4, d.getDepartment().replaceAll("&", " AND ").toUpperCase());
			apstm.setString(5, d.getAddress1().replaceAll("&", " AND ").toUpperCase());
			apstm.setString(6, d.getAddress2().replaceAll("&", " AND ").toUpperCase());
			apstm.setString(7, d.getAddress3().replaceAll("&", " AND ").toUpperCase());
			apstm.setString(8, ""+d.getCity() );
			apstm.setString(9, ""+d.getDistrict());
			apstm.setString(10, ""+d.getState());
			apstm.setString(11, ""+d.getCountry());
			apstm.setString(12, ""+d.getPin());
			apstm.setString(13, d.getArea());
			apstm.setString(14, d.getPhone());
			apstm.setString(15, d.getMobile() );
			apstm.setString(16, d.getFax());
			apstm.setString(17, d.getEmail());
			apstm.setString(18, d.getWebsite());
			apstm.setString(19, d.getStatus());
			apstm.setString(20, d.getDoh() );
			apstm.setString(21, d.getAccno());
			apstm.setString(22, ""+d.getBank());
			apstm.setString(23, ""+d.getBalance());
			apstm.setString(24, "2010-12-25");//d.getBalanceasof()
			apstm.setString(25, ""+d.getClimit());
			apstm.setString(26, ""+d.getCustomertype());
			apstm.setString(27, d.getTinnumber());
			apstm.setString(28, d.getCstnumber());
			apstm.setString(29, d.getPannumber());
			apstm.setString(30, d.getBilling());
			apstm.setString(31, d.getBillingaddress());
			apstm.setString(32, d.getTaxexamption());
			apstm.setString(33, d.getTaxexamptionno() );
			apstm.setString(34, d.getGst());
			apstm.setString(35, userid);
			apstm.setString(36, d.getAccounttype());
			System.out.println(""+apstm);
			apstm.execute(); 
			apstm.close();  
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 
						
		}
	}
	
	
	public static void updateCustomerInfo(Connection con ,PreparedStatement apstm,  CustomerInfo d, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
	{
		try
		{
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");		
			String sql = "UPDATE inv_m_customerinfo  SET ";
			sql = sql+" INT_CUSTOMERGROUPID=? ,CHR_ALIASNAME=?,CHR_CONTACTPERSON=? ,CHR_DEPARTYMENT=?,CHR_ADDRESS1=? , ";
			sql = sql+" CHR_ADDRESS2=? ,CHR_ADDRESS3=? ,INT_CITYID=? ,INT_DISTRICTID=? ,INT_STATEID=? , ";
			sql = sql+" INT_COUNTRYID=? ,INT_PINCODE=? ,CHR_AREACODE=? ,CHR_PHONE=? ,CHR_MOBILE=? ,CHR_FAX =?, ";
			sql = sql+" CHR_EMAIL=? ,CHR_WEBSITE=? ,INT_ACTIVE=? ,DAT_SINCE=? ,CHR_ACCNO=? ,INT_BANKGROUPID=? , ";
			sql = sql+" DOU_BALANCE=? ,DAT_BALANCEASOF=? ,DOU_CREDITLIMIT=? ,INT_CUSTOMERTYPEID=? , ";
			sql = sql+" CHR_TIN=? ,CHR_CST =?,CHR_PAN=?,CHR_USRNAME=? ,DT_UPDATEDATE=DATE(NOW()) ,CHR_UPDATESTATUS='Y',CHR_VERIFIED=?, "; 
			sql = sql+" CHR_BILLING=?,CHR_BILLINGADDRESS=?,CHR_TAXEXAMPTION=?,CHR_TAXEXAMPTIONNO=?,CHR_GSTNO=?, CHR_ACCOUNTTYPE=? WHERE INT_CUSTOMERID = ? ";
			apstm = con.prepareStatement(sql);
			apstm.setString(1, d.getCustomergroup());
			apstm.setString(2, d.getAlias());
			apstm.setString(3, d.getCperson());
			apstm.setString(4, d.getDepartment());
			apstm.setString(5, d.getAddress1().replaceAll("&", " AND ").toUpperCase());
			apstm.setString(6, d.getAddress2().replaceAll("&", " AND ").toUpperCase());
			apstm.setString(7, d.getAddress3().replaceAll("&", " AND ").toUpperCase());
			apstm.setString(8, ""+d.getCity() );
			apstm.setString(9, ""+d.getDistrict());
			apstm.setString(10, ""+d.getState());
			apstm.setString(11, ""+d.getCountry());
			apstm.setString(12, ""+d.getPin());
			apstm.setString(13, d.getArea());
			apstm.setString(14, d.getPhone());
			apstm.setString(15, d.getMobile() );
			apstm.setString(16, d.getFax());
			apstm.setString(17, d.getEmail());
			apstm.setString(18, d.getWebsite());
			apstm.setString(19, d.getStatus());
			apstm.setString(20,  d.getDoh() );
			apstm.setString(21, d.getAccno());
			apstm.setString(22, ""+d.getBank());
			apstm.setString(23, ""+d.getBalance());
			apstm.setString(24, d.getBalanceasof()); //"2010-12-25");//d.getBalanceasof()
			apstm.setString(25, ""+d.getClimit());
			apstm.setString(26, ""+d.getCustomertype());
			apstm.setString(27, d.getTinnumber());
			apstm.setString(28, d.getCstnumber());
			apstm.setString(29, d.getPannumber());
			apstm.setString(30, userid);
			apstm.setString(31, d.getVerified());
			apstm.setString(32, d.getBilling());
			apstm.setString(33, d.getBillingaddress() );
			apstm.setString(34, ""+d.getTaxexamption());
			apstm.setString(35, ""+d.getTaxexamptionno());
			apstm.setString(36, d.getGst());
			apstm.setString(37, d.getAccounttype());
			apstm.setString(38, ""+d.getCustid());
			
			System.out.println(""+apstm);
			apstm.execute(); 
			apstm.close();  
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
