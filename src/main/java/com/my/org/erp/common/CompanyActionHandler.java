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

import com.my.org.erp.bean.AttCompany;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class CompanyActionHandler extends AbstractActionHandler
{
	int companyId;	
	String companyName,itemName,legalName,street,city,state,postal,country;
	String areacode,phone,fax,email,website,tngstno,cstno,regno,tinno;
	String servicetax,shortname,pannumber,userid,pfnumber;
	
	private void companyList(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{	
		    ArrayList<AttCompany> companylist=new ArrayList<AttCompany>();		
			Statement st=con.createStatement();			
			String sql="SELECT a.INT_COMPANYID,a.CHR_COMPANYNAME,a.CHR_LEGALNAME,a.CHR_STREET,a.CHR_CITY,a.CHR_STATE, a.CHR_POSTAL,a.CHR_COUNTRY,a.CHR_AREACODE,a.CHR_PHONE,a.CHR_FAX,a.CHR_EMAIL,a.CHR_WEBSITE, a.CHR_TNGSTNO,a.CHR_CSTNO,a.CHR_REGNO,a.CHR_TINNO,a.CHR_SERVICETAX, a.CHR_SHORTNAME,a.CHR_PANNO,a.CHR_USRNAME,a.DT_UPDATEDATE,a.CHR_UPDATESTATUS ,b.CHR_COUNTRYNAME,a.CHR_PFNUMBER FROM com_m_company a,com_m_country b WHERE a.CHR_COUNTRY =b.INT_COUNTRYID ";
			ResultSet rs=st.executeQuery(sql);				
			while(rs.next())
			{
				companyId = rs.getInt("a.INT_COMPANYID");
				companyName=rs.getString("a.CHR_COMPANYNAME");
				legalName=rs.getString("a.CHR_LEGALNAME");
				street=rs.getString("a.CHR_STREET");
				city=rs.getString("a.CHR_CITY");
				state=rs.getString("a.CHR_STATE");
				postal=rs.getString("a.CHR_POSTAL");
				country=rs.getString("b.CHR_COUNTRYNAME");
				areacode=rs.getString("a.CHR_AREACODE");
				phone=rs.getString("a.CHR_PHONE");
				fax=rs.getString("a.CHR_FAX");
				email=rs.getString("a.CHR_EMAIL");
				website=rs.getString("a.CHR_WEBSITE");
				tngstno=rs.getString("a.CHR_TNGSTNO");
				cstno=rs.getString("a.CHR_CSTNO");
				regno=rs.getString("a.CHR_REGNO");
				tinno=rs.getString("a.CHR_TINNO");	
				servicetax=rs.getString("a.CHR_SERVICETAX");
				shortname = rs.getString("a.CHR_SHORTNAME");
				pfnumber = rs.getString("a.CHR_PFNUMBER");
				AttCompany comp=new AttCompany(companyId,companyName,legalName,street,city,state,postal,country,areacode,phone,fax,email,website,tngstno,cstno,regno,tinno,servicetax,shortname,pfnumber);
				companylist.add(comp);
			}
			rs.close();
			st.close();			
			HttpSession session=request.getSession();			
			session.setAttribute("companyList",companylist);
		}
		catch(Exception e)
		{
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 System.out.println(e.getMessage());
		}
	}
	
	
	private void companyDelete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{						
 			String []companyId= request.getParameterValues("companyId");
			CallableStatement cs = con.prepareCall("{call  COM_PRO_COMPANY (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			for(int i=0;i<companyId.length;i++)
			{				
				cs.setString(1, "DELETE");
				cs.setString(2,companyId[i]);
				cs.setString(3,"");
				cs.setString(4, "");
				cs.setString(5, "");
				cs.setString(6, "");
				cs.setString(7, "");
				cs.setString(8, "");
				cs.setString(9, "");
				cs.setString(10, "");
				cs.setString(11, "");
				cs.setString(12, "");
				cs.setString(13, "");
				cs.setString(14, "");
				cs.setString(15, "");
				cs.setString(16, "");
				cs.setString(17, "");
				cs.setString(18, "");
				cs.setString(19, "");
				cs.setString(20, "");
				cs.setString(21, "");
				cs.setString(22, "");
				cs.setString(23, "");
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
	
	
	
	private void companyAdd(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{
			companyName=""+request.getParameter("compname");
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
			servicetax=""+request.getParameter("servicetaxno");
			shortname=""+request.getParameter("shortname");
			pannumber=""+request.getParameter("pannumber");
			pfnumber=""+request.getParameter("pfnumber");
			 
			CallableStatement cs = con.prepareCall("{call  COM_PRO_COMPANY (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1,"INSERT");
			cs.setString(2,"");
			cs.setString(3,companyName);
			cs.setString(4,legalName);
			cs.setString(5,street);
			cs.setString(6,city);
			cs.setString(7,state);
			cs.setString(8,postal);
			cs.setString(9,country);
			cs.setString(10,areacode);
			cs.setString(11,phone);
			cs.setString(12,fax);
			cs.setString(13,email);
			cs.setString(14,website);
			cs.setString(15,tngstno);
			cs.setString(16,cstno);
			cs.setString(17,regno);
			cs.setString(18,tinno);
			cs.setString(19,servicetax);
			cs.setString(20,shortname);
			cs.setString(21,pannumber);
			cs.setString(22,pfnumber);
			cs.setString(23,userid);
			cs.execute();	
		   
		}
		catch(Exception e)
		{
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			
		}
	}

	
	
	private void companyEdit(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{	
			
			companyId=Integer.parseInt(request.getParameter("companyId"));
			companyName=""+request.getParameter("compname");
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
			servicetax=""+request.getParameter("servicetaxno");
			shortname=""+request.getParameter("shortname");
			pannumber=""+request.getParameter("pannumber");
			pfnumber=""+request.getParameter("pfnumber");
			CallableStatement cs = con.prepareCall("{call  COM_PRO_COMPANY (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			  
			cs.setString(1,"UPDATE");
			cs.setInt(2,companyId);
			cs.setString(3,companyName);
			cs.setString(4,legalName);
			cs.setString(5,street);
			cs.setString(6,city);
			cs.setString(7,state);
			cs.setString(8,postal);
			cs.setString(9,country);
			cs.setString(10,areacode);
			cs.setString(11,phone);
			cs.setString(12,fax);
			cs.setString(13,email);
			cs.setString(14,website);
			cs.setString(15,tngstno);
			cs.setString(16,cstno);
			cs.setString(17,regno);
			cs.setString(18,tinno);
			cs.setString(19,servicetax);
			cs.setString(20,shortname);
			cs.setString(21,pannumber);
			cs.setString(22,pfnumber);
			cs.setString(23,userid);
			
			cs.execute();
		   
		    
		}
		catch(Exception e)
		{
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
				String querypath = request.getParameter("qp");
				userid="ADMIN";
				if(action.equals("COM_ATTcompanyList"))
				{
					companyList(request,response);
					 
					response.sendRedirect("Common/CompanyView.jsp?path="+CommonInfo.packageName(querypath)+"index.jsp&qp="+querypath);
				
				}
				else if(action.equals("ATTcompanyDelete"))
				{					
					companyDelete(request, response);
					companyList(request, response);
					 
					response.sendRedirect("Common/CompanyView.jsp?path="+CommonInfo.packageName(querypath)+"index.jsp&qp="+querypath);
						 
				}
				else if(action.equals("COMcompanyAdd"))
				{					
					companyAdd(request, response);
					companyList(request, response);
					 
					response.sendRedirect("Common/CompanyView.jsp?path="+CommonInfo.packageName(querypath)+"index.jsp&qp="+querypath);
				}
				else if(action.equals("COMcompanyEdit")) 
				{					
					companyEdit(request, response);
					companyList(request, response);
					 
					response.sendRedirect("Common/CompanyView.jsp?path="+CommonInfo.packageName(querypath)+"index.jsp&qp="+querypath);
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
