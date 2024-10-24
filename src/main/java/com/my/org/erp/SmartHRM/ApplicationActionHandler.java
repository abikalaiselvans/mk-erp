package com.my.org.erp.SmartHRM;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
 
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.bean.HRM.Applicant;
import com.my.org.erp.common.CommonFunctions;

public class ApplicationActionHandler extends AbstractActionHandler 
{
	 
	String userid=null;
	 
	 
	
	@SuppressWarnings("rawtypes")
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{

		try 
		{

			String action = request.getParameter("actionS");			
			HttpSession session = request.getSession();
			userid=""+session.getAttribute("USRID");
			Applicant j = new Applicant();
			Map map=request.getParameterMap();
			BeanUtils.populate(j,map);
			 
			if ("HRMapplicationAdd".equals(action)) 
			{ 
				ApplicationAdd(con, j, request, response); 
				con.close();   
				response.sendRedirect("Smart HRM/Application.jsp");
			}
			else if("HRMapplicationEdit".equals(action))
			{
				ApplicationEdit(con, j, request, response); 
				con.close();   
				response.sendRedirect("Smart HRM/Application.jsp");
			}
			else if("HRMapplicationDelete".equals(action))
			{
				ApplicationDelete(con, j, request, response); 
				con.close();   
				response.sendRedirect("Smart HRM/Application.jsp");
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
	
	
	
	private void ApplicationAdd(Connection con , Applicant d, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
	{
		
		try 
		{ 
 
			String l=""+ CommonFunctions.QueryExecute("SELECT RIGHT(CONCAT('00000', (SELECT IF( (COUNT(*)>0 ) , (MAX(INT_APPID)+1),'1')   FROM hrm_m_application)),6)")[0][0];
			//SELECT  RIGHT(CONCAT('000000',(SELECT (MAX(INT_APPID)+1) FROM  hrm_m_application ) )  ,6)
			//SELECT RIGHT(CONCAT('00000', (SELECT IF( (COUNT(*)>0 ) , (MAX(INT_APPID)+1),'1')   FROM hrm_m_application)),6)
			acs = con.prepareCall("{call HRM_PRO_JOBAPPLICANT (?,?,?,?,?,?,?,?,?,?,?," +
					"?,?,?,?,?,?,?,?,?,?," +
					"?,?,?,?,?,?,?,?,?,?," +
					"?,?,?,?,?,?,?,?,?,?," +
					"?,?,?,?,?,?,?,?,?,?," +
					"?,?,?,?,?,?,?,?)}");
			acs.setString(1, "INSERT");
			acs.setString(2,  "");
			acs.setString(3,   "APP"+l );
			acs.setString(4, d.getName());
			acs.setString(5 ,d.getFname());
			acs.setString(6, d.getAdate()  );
			acs.setString(7, d.getJobgrade()  );
			acs.setString(8, d.getJobtitle());
			acs.setString(9, d.getGender());
			acs.setString(10, d.getDob() );
			acs.setString(11, ""+d.getBg());
			acs.setString(12,  d.getMarried() );
			if("M".equals(d.getMarried()))
				acs.setString(13,  d.getWedding());
			else
				acs.setString(13,  null);
			acs.setString(14,  d.getEducation());
			acs.setString(15,  d.getEmailid());
			acs.setString(16,  ""+d.getMobilenumber());
			acs.setString(17,  d.getPassport());
			acs.setString(18, d.getPan());
			acs.setString(19, d.getBike() );
			acs.setString(20, d.getDlicence() );
			acs.setString(21, d.getPadd1());
			acs.setString(22, d.getPadd2() );
			acs.setString(23, ""+d.getPcity() );
			acs.setString(24, ""+d.getPdistrict());
			acs.setString(25, ""+d.getPstate());
			acs.setString(26, ""+d.getPcountry());
			acs.setString(27, ""+d.getPpincode());
			acs.setString(28, ""+d.getPphone());
			acs.setString(29, d.getCadd1());
			acs.setString(30, d.getCadd2());
			acs.setString(31,  ""+d.getCcity());
			acs.setString(32,  ""+d.getCdistrict());
			acs.setString(33, ""+d.getCstate());
			acs.setString(34,""+d.getCcountry() );
			acs.setString(35, ""+d.getCpincode());
			acs.setString(36, ""+d.getCphone());
			acs.setString(37, "N");
			acs.setString(38, "N");
			acs.setString(39, "N" );
			acs.setString(40,  userid);
			acs.setString(41, d.getExemployee());
			acs.setString(42, d.getLanguage1());
			acs.setString(43, d.getRead1());
			acs.setString(44, d.getWrite1());
			acs.setString(45, d.getSpeak1());
			acs.setString(46, d.getLanguage2());
			acs.setString(47, d.getRead2());
			acs.setString(48,d.getWrite2() );
			acs.setString(49,  d.getSpeak2());
			acs.setString(50, d.getLanguage3() );
			acs.setString(51, d.getRead3());
			acs.setString(52, d.getWrite3());
			acs.setString(53,  d.getSpeak3() );
			acs.setString(54 ,d.getKeyskill() );
			acs.setString(55, d.getCertificates()   );
			acs.setString(56, d.getPreviousdetails());
			acs.setString(57, d.getDescription() );
			acs.setString(58, ""+d.getOffice());
			acs.setString(59, ""+d.getOnlinetest());
			System.out.println(""+acs);
			acs.execute();
			acs.close();
			
			application.setAttribute("ERP_MESSAGE", "NEW APPLICANT ENTERED....");
			
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	
	
	
	
	private void ApplicationEdit(Connection con , Applicant d, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
	{
		
		try 
		{ 
 
			 
			
			acs = con.prepareCall("{call HRM_PRO_JOBAPPLICANT (?,?,?,?,?,?,?,?,?,?,?," +
					"?,?,?,?,?,?,?,?,?,?," +
					"?,?,?,?,?,?,?,?,?,?," +
					"?,?,?,?,?,?,?,?,?,?," +
					"?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			acs.setString(1, "UPDATE");
			acs.setString(2, d.getRowid());
			acs.setString(3, d.getAppcode());
			acs.setString(4, d.getName());
			acs.setString(5 ,d.getFname());
			acs.setString(6, d.getAdate()  );
			acs.setString(7, d.getJobgrade()  );
			acs.setString(8, d.getJobtitle());
			acs.setString(9, d.getGender());
			acs.setString(10, d.getDob());
			acs.setString(11, ""+d.getBg());
			acs.setString(12,  d.getMarried() );
			if("M".equals(d.getMarried()))
				acs.setString(13,  d.getWedding());
			else
				acs.setString(13,  null);
			acs.setString(14, d.getEducation());
			acs.setString(15, d.getEmailid());
			acs.setString(16, ""+d.getMobilenumber());
			acs.setString(17, d.getPassport());
			acs.setString(18, d.getPan());
			acs.setString(19, d.getBike() );
			acs.setString(20, d.getDlicence() );
			acs.setString(21, d.getPadd1());
			acs.setString(22, d.getPadd2() );
			acs.setString(23, ""+d.getPcity() );
			acs.setString(24, ""+d.getPdistrict());
			acs.setString(25, ""+d.getPstate());
			acs.setString(26, ""+d.getPcountry());
			acs.setString(27, ""+d.getPpincode());
			acs.setString(28, ""+d.getPphone());
			acs.setString(29, d.getCadd1());
			acs.setString(30, d.getCadd2());
			acs.setString(31, ""+d.getCcity());
			acs.setString(32, ""+d.getCdistrict());
			acs.setString(33, ""+d.getCstate());
			acs.setString(34, ""+d.getCcountry() );
			acs.setString(35, ""+d.getCpincode());
			acs.setString(36, ""+d.getCphone());
			acs.setString(37, "N");
			acs.setString(38, "N");
			acs.setString(39, "N" );
			acs.setString(40, userid);
			acs.setString(41, d.getExemployee());
			acs.setString(42, d.getLanguage1());
			acs.setString(43, d.getRead1());
			acs.setString(44, d.getWrite1());
			acs.setString(45, d.getSpeak1());
			acs.setString(46, d.getLanguage2());
			acs.setString(47, d.getRead2());
			acs.setString(48, d.getWrite2() );
			acs.setString(49, d.getSpeak2());
			acs.setString(50, d.getLanguage3() );
			acs.setString(51, d.getRead3());
			acs.setString(52, d.getWrite3());
			acs.setString(53, d.getSpeak3() );
			acs.setString(54 ,d.getKeyskill() );
			acs.setString(55, d.getCertificates()   );
			acs.setString(56, d.getPreviousdetails());
			acs.setString(57, d.getDescription() );
			acs.setString(58, ""+d.getOffice());
			acs.setString(59, ""+d.getOnlinetest());
			System.out.println(""+acs);
			acs.execute();
			acs.close();
			 
			
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	
	
	
	private void ApplicationDelete(Connection con , Applicant d, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
	{
		
		try 
		{ 
 
			 
			String[] rowid = request.getParameterValues("rowid");
			CallableStatement cs = con.prepareCall("{call HRM_PRO_JOBAPPLICANT (?,?,?,?,?,?,?,?,?,?,?," +
					"?,?,?,?,?,?,?,?,?,?," +
					"?,?,?,?,?,?,?,?,?,?," +
					"?,?,?,?,?,?,?,?,?,?," +
					"?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			for (int i = 0; i < rowid.length; i++) 
			{
				cs.setString(1, "DELETE");
				cs.setString(2, rowid[i]);
				cs.setString(3, "");
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
				cs.setString(24, "");
				cs.setString(25, "");
				cs.setString(26, "");
				cs.setString(27, "");
				cs.setString(28, "");
				cs.setString(29, "");
				cs.setString(30, "");
				cs.setString(31, "");
				cs.setString(32, "");
				cs.setString(33, "");
				cs.setString(34, "");
				cs.setString(35, "");
				cs.setString(36, "");
				cs.setString(37, "");
				cs.setString(38, "");
				cs.setString(39, "");
				cs.setString(40, "");
				cs.setString(41, " ");
				cs.setString(42, "");
				cs.setString(43, "");
				cs.setString(44, "");
				cs.setString(45, "");
				cs.setString(46, "");
				cs.setString(47, "");
				cs.setString(48, "");
				cs.setString(49, "");
				cs.setString(50, "");
				cs.setString(51, "");
				cs.setString(52, "");
				cs.setString(53, "");
				cs.setString(54, "");
				cs.setString(55, "");
				cs.setString(56, "");
				cs.setString(57, "");
				cs.setString(58, "");
				cs.setString(59, "" );
				cs.addBatch();
		}
		cs.executeBatch();
		cs.close();
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