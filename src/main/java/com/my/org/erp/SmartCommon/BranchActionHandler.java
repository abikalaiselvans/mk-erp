package com.my.org.erp.SmartCommon;
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
import com.my.org.erp.common.CommonFunctions;

public class BranchActionHandler extends AbstractActionHandler
{
	HttpSession session= null;
	int companyId,branchId,active;	
	String userid,companyName,branchName,itemName,legalName,street,city,state,postal,country;
	String areacode,phone,fax,email,website,tngstno,cstno,regno,tinno,localtax,pannumber;
	 
	private void branchDelete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{						
			
			String ids[] = request.getParameterValues("rowid");
			asql ="DELETE FROM com_m_branch Where  INT_BRANCHID = ?";
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
		catch (SQLException e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
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
	
	
	@SuppressWarnings("rawtypes")
	private void branchAdd(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{
			 
			Branch d = new Branch();
			Map map=request.getParameterMap();
			BeanUtils.populate(d,map);
			asql = " SELECT COUNT(*) FROM com_m_branch WHERE INT_COMPANYID="+d.getCompanyid()+" AND CHR_BRANCHNAME='"+d.getBranchname().toUpperCase()+"' ";
			System.out.println(asql);
			if(!CommonFunctions.RecordExist(con, asql))	
			{
				
				asql="";
				asql =" INSERT INTO com_m_branch (";
				asql =asql+ " INT_COMPANYID,CHR_BRANCHNAME,CHR_LEGALNAME,CHR_STREET,INT_CITYID,INT_DISTRICTID,INT_STATEID, ";
				asql =asql+ " INT_COUNTRYID,INT_PINCODE,CHR_AREACODE,CHR_PHONE,CHR_FAX,CHR_EMAIL,CHR_WEBSITE,CHR_TNGSTNO,CHR_CSTNO, ";
				asql =asql+ " CHR_REGNO,CHR_TINNO,CHR_LOCALTAXNO,CHR_PANNO,CHR_CIN_NUMBER,CHR_GSTNO,INT_ACTIVE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ";
				asql =asql+ " )"; 
				asql = asql +" VALUES (";
				asql =asql+ " ?,?,?,?,?,?,?, ";
				asql =asql+ " ?,?,?,?,?,?,?, ";
				asql =asql+ " ?,?,?,?,?,?,?, ?,?,";
				asql =asql+ " ?,DATE(NOW()),'Y' ";
				asql =asql+ " )"; 
				apstm = con.prepareStatement(asql);
				apstm.setString(1,""+d.getCompanyid());
				apstm.setString(2,d.getBranchname());
				apstm.setString(3,d.getLegalname());
				apstm.setString(4,d.getStreet());
				apstm.setString(5,""+d.getCity());
				apstm.setString(6,""+d.getDistrict());
				apstm.setString(7,""+d.getState());
				apstm.setString(8,""+d.getCountry());
				apstm.setString(9,""+d.getPin());
				apstm.setString(10,d.getAreacode());
				apstm.setString(11,d.getPhone());
				apstm.setString(12,d.getFax());
				apstm.setString(13,d.getEmail());
				apstm.setString(14,d.getWebsite());
				apstm.setString(15,d.getTngsno());
				apstm.setString(16,d.getCstno());
				apstm.setString(17,d.getRegno());
				apstm.setString(18,d.getTinno());
				apstm.setString(19,d.getLocaltax());
				apstm.setString(20,d.getPannumber());
				apstm.setString(21,d.getCinnumber());
				apstm.setString(22,d.getGstnumber());
				apstm.setString(23,""+d.getActive());
				apstm.setString(24,auserid);
				System.out.println(""+apstm);
				apstm.execute();
				con.close();    
				
			}
			
			 
		}
		catch (SQLException e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
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

	
	@SuppressWarnings("rawtypes")
	private void branchEdit(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{	
			 
			Branch d = new Branch();
			Map map=request.getParameterMap();
			BeanUtils.populate(d,map);
			asql="";
			asql =" UPDATE com_m_branch SET";
			asql =asql+ " INT_COMPANYID=?,CHR_BRANCHNAME=?,CHR_LEGALNAME=?,CHR_STREET=?,INT_CITYID=?,INT_DISTRICTID=?,INT_STATEID=?, ";
			asql =asql+ " INT_COUNTRYID=?,INT_PINCODE=?,CHR_AREACODE=?,CHR_PHONE=?,CHR_FAX=?,CHR_EMAIL=?,CHR_WEBSITE=?,CHR_TNGSTNO=?,CHR_CSTNO=?, ";
			asql =asql+ " CHR_REGNO=?,CHR_TINNO=?,CHR_LOCALTAXNO=?,CHR_PANNO=?,CHR_CIN_NUMBER=?,CHR_GSTNO=?,INT_ACTIVE=?,CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS ='Y' ";
			asql = asql +" WHERE INT_BRANCHID=?";
			apstm = con.prepareStatement(asql);
			apstm.setString(1,""+d.getCompanyid());
			apstm.setString(2,d.getBranchname());
			apstm.setString(3,d.getLegalname());
			apstm.setString(4,d.getStreet());
			apstm.setString(5,""+d.getCity());
			apstm.setString(6,""+d.getDistrict());
			apstm.setString(7,""+d.getState());
			apstm.setString(8,""+d.getCountry());
			apstm.setString(9,""+d.getPin());
			apstm.setString(10,d.getAreacode());
			apstm.setString(11,d.getPhone());
			apstm.setString(12,d.getFax());
			apstm.setString(13,d.getEmail());
			apstm.setString(14,d.getWebsite());
			apstm.setString(15,d.getTngsno());
			apstm.setString(16,d.getCstno());
			apstm.setString(17,d.getRegno());
			apstm.setString(18,d.getTinno());
			apstm.setString(19,d.getLocaltax());
			apstm.setString(20,d.getPannumber());
			apstm.setString(21,d.getCinnumber());
			apstm.setString(22,d.getGstnumber());
			apstm.setString(23,""+d.getActive());
			apstm.setString(24,auserid);
			apstm.setString(25,""+d.getRowid());
			System.out.println(""+apstm);
			apstm.execute();
			con.close();    
		
		}
		catch (SQLException e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
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
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
				
				String action=request.getParameter("actionS");
				System.out.println(action);
				if(action.equals("GENbranchDelete"))
				{					
					branchDelete(request, response);
					con.close();    
					response.sendRedirect("Smart Common/BranchView.jsp?companyId="+companyId);
				}
				else if(action.equals("GENbranchAdd"))
				{					
					branchAdd(request, response);
					con.close();    
					response.sendRedirect("Smart Common/BranchView.jsp");
				}
				else if(action.equals("GENbranchEdit"))
				{					
					branchEdit(request, response);
					con.close();    
					response.sendRedirect("Smart Common/BranchView.jsp?companyId="+companyId);
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
