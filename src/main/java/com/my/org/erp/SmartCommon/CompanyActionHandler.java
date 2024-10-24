package com.my.org.erp.SmartCommon;
import java.io.IOException;
 
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

import org.apache.commons.beanutils.BeanUtils;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;
public class CompanyActionHandler extends AbstractActionHandler
{
	private void companyDelete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{						
			String ids[] = request.getParameterValues("id");
			asql ="DELETE FROM com_m_company Where  INT_COMPANYID = ?";
			apstm = con.prepareStatement(asql);
			for(int u=0; u<ids.length;u++)
			{
				apstm.setString(1, ids[u]);
				apstm.addBatch();
			}
			System.out.println(""+apstm);
			apstm.executeBatch();
			con.close(); 
			
			 
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}
	
	
	
	@SuppressWarnings("rawtypes")
	private void companyAdd(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{
			Company d = new Company();
			Map map=request.getParameterMap();
			BeanUtils.populate(d,map);
			asql="";
			asql = "INSERT INTO com_m_company ";
			asql = asql +" ( ";
			asql = asql +" CHR_COMPANYNAME,CHR_LEGALNAME, ";
			asql = asql +" CHR_STREET,INT_CITYID,INT_DISTRICTID,INT_STATEID,INT_COUNTRYID,INT_PINCODE, ";
			asql = asql +" CHR_AREACODE,CHR_PHONE,CHR_FAX,CHR_EMAIL,CHR_WEBSITE,CHR_TNGSTNO,CHR_CSTNO,CHR_REGNO,CHR_TINNO,";
			asql = asql +" CHR_SERVICETAX,CHR_SHORTNAME,CHR_PANNO,CHR_PFNUMBER,CHR_GSTNO,INT_ACTIVE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ";
			asql = asql +" )";
			asql = asql +" VALUES (";
			asql = asql +" ?,?, ";
			asql = asql +" ?,?,?,?,?,?, ";
			asql = asql +" ?,?,?,?,?,?,?,?,?,";
			asql = asql +" ?,?,?,?,?,?,?,DATE(NOW()),'Y' ";
			asql = asql +" )";
			apstm = con.prepareStatement(asql);
			apstm.setString(1,d.getCompname());
			apstm.setString(2,d.getLegalname());
			apstm.setString(3,d.getStreet());
			apstm.setString(4,""+d.getCity());
			apstm.setString(5,""+d.getDistrict());
			apstm.setString(6,""+d.getState());
			apstm.setString(7,""+d.getCountry());
			apstm.setString(8,""+d.getPin());
			apstm.setString(9,d.getAreacode());
			apstm.setString(10,d.getPhone());
			apstm.setString(11,d.getFax());
			apstm.setString(12,d.getEmail());
			apstm.setString(13,d.getWebsite());
			apstm.setString(14,d.getTngsno());
			apstm.setString(15,d.getCstno());
			apstm.setString(16,d.getRegno());
			apstm.setString(17,d.getTinno());
			apstm.setString(18,d.getServicetaxno());
			apstm.setString(19,d.getShortname());
			apstm.setString(20,d.getPannumber());
			apstm.setString(21,d.getPfnumber());
			apstm.setString(22,d.getGstnumber());
			apstm.setString(23,""+d.getActive());
			apstm.setString(24,auserid);
			System.out.println(""+apstm);
			apstm.execute();
			
			String companyid = CommonFunctions.QueryExecute("SELECT MAX(INT_COMPANYID) from com_m_company")[0][0];
			System.out.println("companyid------>"+companyid);
			String querytable ="CREATE TABLE com_m_staffid_"+companyid+" ( INT_ID int(6) unsigned zerofill NOT NULL DEFAULT '"+companyid+"00000' COMMENT 'UNIQUE',";
			querytable = querytable +" PRIMARY KEY (INT_ID) )";
			apstm = con.prepareStatement(querytable);	  
			System.out.println(""+querytable);
			apstm.execute();
			
			asql = "INSERT INTO com_m_staffid_"+companyid+" ";
			asql = asql +" ( INT_ID ) VALUES (?)";
			apstm = con.prepareStatement(asql);
			apstm.setString(1,companyid+"00000");
			System.out.println(""+apstm);
			apstm.execute();
			
			con.close();    
		   
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	
	
	@SuppressWarnings("rawtypes")
	private void companyEdit(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{	
			
			String rowid = request.getParameter("rowid") ;
			Company d = new Company();
			Map map=request.getParameterMap();
			BeanUtils.populate(d,map);
			asql="";
			asql = " UPDATE  com_m_company SET  CHR_COMPANYNAME=?,CHR_LEGALNAME=?, ";
			asql = asql +" CHR_STREET=?,INT_CITYID=?,INT_DISTRICTID=?,INT_STATEID=?,INT_COUNTRYID=?,INT_PINCODE=?, ";
			asql = asql +" CHR_AREACODE=?,CHR_PHONE=?,CHR_FAX=?,CHR_EMAIL=?,CHR_WEBSITE=?,CHR_TNGSTNO=?,CHR_CSTNO=?,CHR_REGNO=?,CHR_TINNO=?,";
			asql = asql +" CHR_SERVICETAX=?,CHR_SHORTNAME=?,CHR_PANNO=?,CHR_PFNUMBER=?,CHR_GSTNO=?,INT_ACTIVE=?,CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y' ";
			asql = asql +" WHERE INT_COMPANYID=? ";
			apstm = con.prepareStatement(asql);
			apstm.setString(1,d.getCompname());
			apstm.setString(2,d.getLegalname());
			apstm.setString(3,d.getStreet());
			apstm.setString(4,""+d.getCity());
			apstm.setString(5,""+d.getDistrict());
			apstm.setString(6,""+d.getState());
			apstm.setString(7,""+d.getCountry());
			apstm.setString(8,""+d.getPin());
			apstm.setString(9,d.getAreacode());
			apstm.setString(10,d.getPhone());
			apstm.setString(11,d.getFax());
			apstm.setString(12,d.getEmail());
			apstm.setString(13,d.getWebsite());
			apstm.setString(14,d.getTngsno());
			apstm.setString(15,d.getCstno());
			apstm.setString(16,d.getRegno());
			apstm.setString(17,d.getTinno());
			apstm.setString(18,d.getServicetaxno());
			apstm.setString(19,d.getShortname());
			apstm.setString(20,d.getPannumber());
			apstm.setString(21,d.getPfnumber());
			apstm.setString(22,d.getGstnumber());
			apstm.setString(23,""+d.getActive());
			apstm.setString(24,auserid);
			apstm.setString(25 ,rowid);
			System.out.println(""+apstm);
			apstm.execute();
			apstm.close();
			
			
			if(d.getActive() == 0)
			{
				asql = " UPDATE com_m_branch SET INT_ACTIVE=0 WHERE INT_COMPANYID =?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,rowid);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
			}	
			con.close();    
		    
		}
		catch(Exception e)
		{
			
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
				
		}	
	}
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
				
				String action=request.getParameter("actionS");
				if(action.equals("GENcompanyDelete"))
				{					
					companyDelete(request, response);
					con.close();    
					response.sendRedirect("Smart Common/CompanyView.jsp");
				}
				else if(action.equals("GENcompanyAdd"))
				{					
					companyAdd(request, response);
					con.close();   
					response.sendRedirect("Smart Common/CompanyView.jsp");
				}
				else if(action.equals("GENcompanyEdit")) 
				{					
					companyEdit(request, response);
					con.close();    
					response.sendRedirect("Smart Common/CompanyView.jsp");
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
