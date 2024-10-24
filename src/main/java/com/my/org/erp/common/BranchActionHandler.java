package com.my.org.erp.common;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import com.my.org.erp.bean.Company;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class BranchActionHandler extends AbstractActionHandler
{
	HttpSession session= null;
	int companyId,branchId,active;	
	String userid,companyName,branchName,itemName,legalName,street,city,state,postal,country;
	String areacode,phone,fax,email,website,tngstno,cstno,regno,tinno,localtax,pannumber;
	
	private void companyList(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		try{	
			
		    ArrayList<Company> companylist=new ArrayList<Company>();		
			Statement st=con.createStatement();			
			String sql="SELECT * FROM  com_m_company ";
			ResultSet rs=st.executeQuery(sql);					
			while(rs.next())
			{
				companyId = rs.getInt("INT_COMPANYID");
				companyName=rs.getString("CHR_COMPANYNAME");
				Company comp=new Company(companyId,companyName);
				companylist.add(comp);
			}
			rs.close();
			st.close();
			
			HttpSession session=request.getSession();			
			session.setAttribute("companyList",companylist);
		}
		catch(Exception e){
			
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 System.out.println(e.getMessage());
	
	}
	}
	
	private void branchDelete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{						
			String []branchId= request.getParameterValues("branchId");
			CallableStatement cs = con.prepareCall("{call  COM_PRO_BRANCH (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			for(int i=0;i<branchId.length;i++)
			{
				cs.setString(1, "DELETE");
				cs.setString(2,"0");
				cs.setString(3,branchId[i]);
				cs.setString(4, "");
				cs.setString(5, "");
				cs.setString(6, "");
				cs.setString(7, "");
				cs.setString(8, "");
				cs.setString(9, "0");
				cs.setString(10, "");
				cs.setString(11, "");
				cs.setString(12, "");
				cs.setString(13, "");
				cs.setString(14, "");
				cs.setString(15, "");
				cs.setString(16, "");
				cs.setString(17, "");
				cs.setString(18, "");
				cs.setString(19,"");
				cs.setString(20,"0");
				cs.setString(21,"");
				cs.setString(22,"");
				cs.setString(23,"");
				cs.addBatch();	
				
			}
			cs.executeBatch();
			 
		}
		catch(Exception e)
		{
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 System.out.println(e.getMessage());
		}
	}
	
	
	private void branchAdd(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{
			companyId=Integer.parseInt(request.getParameter("companyId"));
			branchName=""+request.getParameter("branchName").trim();
			legalName=""+request.getParameter("legalname");
		    street=""+request.getParameter("street");
			city=""+request.getParameter("city");
			state=""+request.getParameter("state");
			postal=""+request.getParameter("postal");
			if(postal.equals(null)||postal.equals(""))
				postal="0";
			country=""+request.getParameter("country");
			areacode=""+request.getParameter("areacode");
			phone=""+request.getParameter("phone");
			fax=""+request.getParameter("fax");
			email=""+request.getParameter("email");
			website=""+request.getParameter("website");
			tngstno=""+request.getParameter("tngsno");
			cstno=""+request.getParameter("cstno");
			regno=""+request.getParameter("regno");
			tinno=""+request.getParameter("tinno");
			active=Integer.parseInt(request.getParameter("active"));
			localtax=""+request.getParameter("localtax");
			pannumber=""+request.getParameter("pannumber");
			String sql = " SELECT COUNT(*) FROM com_m_branch WHERE INT_COMPANYID="+companyId+" AND CHR_BRANCHNAME='"+branchName.toUpperCase()+"' ";
			if(!com.my.org.erp.common.CommonFunctions.RecordExist(con, sql))	
			{
				CallableStatement cs = con.prepareCall("{call  COM_PRO_BRANCH (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				cs.setString(1,"INSERT");
				cs.setInt(2,companyId);
				cs.setInt(3,1);
				cs.setString(4,branchName.toUpperCase());
				cs.setString(5,legalName);
				cs.setString(6,street);
				cs.setString(7,city);
				cs.setString(8,state);
				cs.setString(9,postal);
				cs.setString(10,country);
				cs.setString(11,areacode);
				cs.setString(12,phone);
				cs.setString(13,fax);
				cs.setString(14,email);
				cs.setString(15,website);
				cs.setString(16,tngstno);
				cs.setString(17,cstno);
				cs.setString(18,regno);
				cs.setString(19,tinno);
				cs.setInt(20,active);
				cs.setString(21,localtax);
				cs.setString(22,pannumber);
				cs.setString(23,userid);
				cs.execute();	
				cs.close();
				
			}
			
			 
		}
		catch(Exception e)
		{
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 System.out.println(e.getMessage());
		}
	}

	
	private void branchEdit(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{	
			companyId=Integer.parseInt(request.getParameter("companyId"));
			branchId=Integer.parseInt(request.getParameter("branchId"));
			branchName=""+request.getParameter("branchName");
			legalName=""+request.getParameter("legalname");
		    street=""+request.getParameter("street");
			city=""+request.getParameter("city");
			state=""+request.getParameter("state");
			postal=""+request.getParameter("postal");
			if(postal.equals(null)||postal.equals(""))
				postal="0";
			country=""+request.getParameter("country");
			areacode=""+request.getParameter("areacode");
			phone=""+request.getParameter("phone");
			fax=""+request.getParameter("fax");
			email=""+request.getParameter("email");
			website=""+request.getParameter("website");
			tngstno=""+request.getParameter("tngsno");
			cstno=""+request.getParameter("cstno");
			regno=""+request.getParameter("regno");
			tinno=""+request.getParameter("tinno");
			localtax=""+request.getParameter("localtax");
			pannumber=""+request.getParameter("pannumber");
			active=Integer.parseInt(request.getParameter("active"));			
			CallableStatement cs = con.prepareCall("{call  COM_PRO_BRANCH (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1,"UPDATE");
			cs.setInt(2,companyId);
			cs.setInt(3,branchId);
			cs.setString(4,branchName);
			cs.setString(5,legalName);
			cs.setString(6,street);
			cs.setString(7,city);
			cs.setString(8,state);
			cs.setString(9,postal);
			cs.setString(10,country);
			cs.setString(11,areacode);
			cs.setString(12,phone);
			cs.setString(13,fax);
			cs.setString(14,email);
			cs.setString(15,website);
			cs.setString(16,tngstno);
			cs.setString(17,cstno);
			cs.setString(18,regno);
			cs.setString(19,tinno);
			cs.setInt(20,active);
			cs.setString(21,localtax);
			cs.setString(22,pannumber);
			cs.setString(23,userid);
		    cs.execute();
		
		}
		catch(Exception e)
		{
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 System.out.println(e.getMessage());
		}	
	}
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
				
				String action=request.getParameter("actionS");
				String querypath = request.getParameter("path");
				userid = "ADMIN";
				if(action.equals("ATTcompanyList"))
				{
					companyList(request,response);					
					 
					response.sendRedirect("Common/BranchView.jsp?path="+querypath);
				}
				else if(action.equals("COMbranchDelete"))
				{					
					branchDelete(request, response);
					 
					response.sendRedirect("Common/BranchView.jsp?path="+querypath);
				}
				else if(action.equals("COMbranchAdd"))
				{					
					branchAdd(request, response);
					 
					response.sendRedirect("Common/BranchView.jsp?path="+querypath);
				}
				else if(action.equals("COMbranchEdit"))
				{					
					branchEdit(request, response);
					 
					response.sendRedirect("Common/BranchView.jsp?path="+querypath);
				}
				
			} 
			catch (Exception e) 
			{
				 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
				 System.out.println(e.getMessage());	  						
			}
	}	
}
