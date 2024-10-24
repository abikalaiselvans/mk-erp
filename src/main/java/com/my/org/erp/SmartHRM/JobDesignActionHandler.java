package com.my.org.erp.SmartHRM;

import java.io.IOException;
 
import java.sql.Connection;
import java.sql.PreparedStatement; 
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
 
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.bean.HRM.JobDesign;
 
import com.my.org.erp.common.CommonFunctions;
 
 

public class JobDesignActionHandler extends AbstractActionHandler 
{
	
	 

	String userid=null;
	
	@SuppressWarnings("rawtypes")
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session=request.getSession();			
			userid=""+session.getAttribute("USRID");
			JobDesign j = new JobDesign();
			Map map=request.getParameterMap();
			BeanUtils.populate(j,map);
			System.out.println(action);
			if (action.equals("HRMjobDesignDelete")) 
			{
				JobDesignDelete(request, response);
				con.close();   
				response.sendRedirect("Smart HRM/JobDesignView.jsp");
			} 
			else if (action.equals("HRMjobDesignAdd")) 
			{
				JobDesignAdd(apstm,con, j, request, response);
				con.close();   
				response.sendRedirect("Smart HRM/JobDesignView.jsp");
			}
			else if (action.equals("HRMjobDesignEdit")) 
			{
				JobDesignEdit(apstm,con, j, request, response);
				con.close();   
				response.sendRedirect("Smart HRM/JobDesignView.jsp");
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

	
	
	
	

	private void JobDesignAdd(PreparedStatement apstm, Connection con,  JobDesign d, HttpServletRequest request, HttpServletResponse response) throws IOException 
	{
		
		try 
		{ 
 
			String l="HRM"+CommonFunctions.QueryExecute("select right(concat('000000',(max(INT_JOBID)+1)),6) from hrm_m_jobdesign ")[0][0];
			String testtypeids="";
			for(int i=0;i<d.getTesttype().length;i++)
				testtypeids = testtypeids+d.getTesttype()[i]+",";
			
			
			String generalskillsids="";
			for(int i=0;i<d.getGeneralskills().length;i++)
				generalskillsids = generalskillsids+d.getGeneralskills()[i]+",";
			
			
			String technicalskillsids="";
			for(int i=0;i<d.getTechnicalskills().length;i++)
				technicalskillsids = technicalskillsids+d.getTechnicalskills()[i]+",";
			
			
			
			String qualificationids="";
			for(int i=0;i<d.getEducation().length;i++)
				qualificationids = qualificationids+d.getEducation()[i]+",";
			qualificationids=qualificationids.trim();
			qualificationids = qualificationids.substring(0,qualificationids.length()-1);
			
			
			asql = "";
			asql = " INSERT INTO hrm_m_jobdesign ";  
		    asql = asql + "  (INT_DEPARTID,CHR_JOBGRADE,CHR_JOBCODE,CHR_JOBTITLE,CHR_JOBPURPOSE,";
		    asql = asql + "  CHR_JOBDUTY,CHR_JOBAUTH, ";
		    asql = asql + "  CHR_RESPONSE,CHR_SKILLSET,CHR_TESTYPEID,CHR_NOOFQUESTION,";
		    asql = asql + "  CHR_PASSINGPERCENTAGE,INT_TESTHOURS,CHR_JOBPROMOTIONS,CHR_JOBHAZ,";
		    asql = asql + "  CHR_JOBREPORT,CHR_GENDER,INT_AGE,INT_AGE_TO,";
		    asql = asql + "  CHR_QUALIFICATIONID,INT_EXPERIENCE,INT_HEIGHT,INT_WEIGHT,INT_SALARY,INT_DA, ";
		    asql = asql + "  INT_HRA,CHR_MEMORY,CHR_CREATIVITY,CHR_TEACHING,CHR_EMOTIONAL,INT_WORKING,";
		    asql = asql + "  CHR_GENERALSKILL,CHR_TECHNICALSKILL, ";
		    asql = asql + "  CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS)";
		    asql = asql + "  VALUES ";
			asql = asql + "  (?,?,?,?,?,";
		    asql = asql + "  ?,?, ";
		    asql = asql + "  ?,?,?,?,";
		    asql = asql + "  ?,?,?,?,";
		    asql = asql + "  ?,?,?,?,";
		    asql = asql + "  ?,?,?,?,?,?, ";
		    asql = asql + "  ?,?,?,?,?,?,";
		    asql = asql + "  ?,?, ";
		    asql = asql + "  ?,DATE(NOW()),'Y')";
		    apstm  = con.prepareStatement(asql);
		    apstm.setString(1, ""+d.getDepartment() );
		    apstm.setString(2,  d.getJobGrade());
		    apstm.setString(3,  l);
			apstm.setString(4,  d.getTitle());
			apstm.setString(5,  d.getPurpose());
			apstm.setString(6,  d.getDuties() );
			apstm.setString(7,  d.getAuthority() );
			apstm.setString(8,  d.getResponse());
			apstm.setString(9,  d.getSkillset());
			apstm.setString(10, testtypeids);
			apstm.setString(11, ""+d.getNoofquestion() );
			apstm.setString(12, ""+d.getPassingpercentage());
			apstm.setString(13, ""+d.getTesthours());
			apstm.setString(14, d.getPromotion() );
			apstm.setString(15, d.getHazards()  );
			apstm.setString(16, d.getReport() );
			apstm.setString(17, d.getOpt_gender() );
			apstm.setString(18, ""+d.getAge());
			apstm.setString(19, ""+d.getAgeto());
			apstm.setString(20, qualificationids );
			apstm.setString(21, ""+d.getExperience());
			apstm.setString(22, ""+d.getHeight() );
			apstm.setString(23, ""+d.getWeight() );
			apstm.setString(24, ""+d.getScale());
			apstm.setString(25, ""+d.getDa());
			apstm.setString(26, ""+d.getHra());
			apstm.setString(27, d.getOpt_memory());
			apstm.setString(28, d.getOpt_creativity());
			apstm.setString(29, d.getOpt_teach());
			apstm.setString(30, d.getOpt_emotion());
			apstm.setString(31, ""+d.getTime());
			apstm.setString(32, generalskillsids);
			apstm.setString(33, technicalskillsids);
			apstm.setString(34, userid);
			apstm.execute();
			apstm.close();
			
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			System.out.println(""+acs);
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 
		}
	}

	
	
	private void JobDesignEdit(PreparedStatement apstm, Connection con,  JobDesign d, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException 
	{
		try 
		{			
			String testtypeids="";
			for(int i=0;i<d.getTesttype().length;i++)
				testtypeids = testtypeids+d.getTesttype()[i]+",";
			
			String qualificationids="";
			for(int i=0;i<d.getEducation().length;i++)
				qualificationids = qualificationids+d.getEducation()[i]+",";
			qualificationids=qualificationids.trim();
			qualificationids = qualificationids.substring(0,qualificationids.length()-1);
			String generalskillsids="";
			for(int i=0;i<d.getGeneralskills().length;i++)
				generalskillsids = generalskillsids+d.getGeneralskills()[i]+",";
			
			String technicalskillsids="";
			for(int i=0;i<d.getTechnicalskills().length;i++)
				technicalskillsids = technicalskillsids+d.getTechnicalskills()[i]+",";
			
		 
			asql = "UPDATE hrm_m_jobdesign SET ";  
		    asql = asql +" INT_DEPARTID=?,CHR_JOBGRADE=?,CHR_JOBCODE=?, "; 
		    asql = asql +" CHR_JOBTITLE=?,CHR_JOBPURPOSE=?, "; 
		    asql = asql +" CHR_JOBDUTY=?,CHR_JOBAUTH=?, "; 
		    asql = asql +" CHR_RESPONSE=?,CHR_SKILLSET=?,CHR_TESTYPEID=?, "; 
		    asql = asql +" CHR_NOOFQUESTION=?, "; 
		    asql = asql +" CHR_PASSINGPERCENTAGE=?,INT_TESTHOURS=?, "; 
		    asql = asql +" CHR_JOBPROMOTIONS=?,CHR_JOBHAZ=?,CHR_JOBREPORT=?, "; 
		    asql = asql +" CHR_GENDER=?,INT_AGE=?,INT_AGE_TO=?, "; 
		    asql = asql +" CHR_QUALIFICATIONID=?,INT_EXPERIENCE=?, "; 
		    asql = asql +" INT_HEIGHT=?,INT_WEIGHT=?, "; 
		    asql = asql +" INT_SALARY=?,INT_DA=?, "; 
		    asql = asql +" INT_HRA=?,CHR_MEMORY=?,CHR_CREATIVITY=?, "; 
		    asql = asql +" CHR_TEACHING=?, "; 
		    asql = asql +" CHR_EMOTIONAL=?,INT_WORKING=?, "; 
		    asql = asql +" CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y', "; 
		    asql = asql +" CHR_GENERALSKILL=?,CHR_TECHNICALSKILL=?  "; 
		    asql = asql +" WHERE INT_JOBID = ?  "; 
		    apstm = con.prepareStatement(asql);
		    apstm.setString(1, ""+d.getDepartment() );
		    apstm.setString(2,  d.getJobGrade());
		    apstm.setString(3,  d.getJobcode());
		    apstm.setString(4,  d.getTitle());
		    apstm.setString(5,  d.getPurpose());
		    apstm.setString(6,  d.getDuties() );
		    apstm.setString(7,  d.getAuthority() );
		    apstm.setString(8,  d.getResponse());
		    apstm.setString(9,  d.getSkillset());
		    apstm.setString(10, testtypeids);
		    apstm.setString(11, ""+d.getNoofquestion() );
		    apstm.setString(12, ""+d.getPassingpercentage());
		    apstm.setString(13, ""+d.getTesthours());
		    apstm.setString(14, d.getPromotion() );
		    apstm.setString(15, d.getHazards()  );
		    apstm.setString(16, d.getReport() );
		    apstm.setString(17, d.getOpt_gender() );
		    apstm.setString(18, ""+d.getAge());
		    apstm.setString(19, ""+d.getAgeto());
		    apstm.setString(20, qualificationids );
		    apstm.setString(21, ""+d.getExperience());
		    apstm.setString(22, ""+d.getHeight() );
		    apstm.setString(23, ""+d.getWeight() );
		    apstm.setString(24, ""+d.getScale());
		    apstm.setString(25, ""+d.getDa());
		    apstm.setString(26, ""+d.getHra());
		    apstm.setString(27, d.getOpt_memory());
		    apstm.setString(28, d.getOpt_creativity());
		    apstm.setString(29, d.getOpt_teach());
		    apstm.setString(30, d.getOpt_emotion());
		    apstm.setString(31, ""+d.getTime());
		    apstm.setString(32, userid);
		    apstm.setString(33, generalskillsids);
		    apstm.setString(34, technicalskillsids);
		    apstm.setString(35,  ""+d.getRowid());
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

	
	
	private void JobDesignDelete(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			
			String[] rowid = request.getParameterValues("rowid");
			asql = " DELETE FROM hrm_m_jobdesign WHERE INT_JOBID=?";
			apstm = con.prepareStatement(asql);
			for (int i = 0; i < rowid.length; i++) 
			{
				apstm.setString(1, rowid[i]);
				apstm.addBatch();
				System.out.println(""+apstm);
			}
			apstm.executeBatch();
			apstm.close();
			con.close();
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
