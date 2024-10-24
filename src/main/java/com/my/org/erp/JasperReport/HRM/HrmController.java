package com.my.org.erp.JasperReport.HRM;


import java.io.File;
import java.io.FileInputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.my.org.erp.ServiceLogin.DateUtil;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

@WebServlet("/hrmCon")
public class HrmController extends HttpServlet {
	
	public void service(HttpServletRequest request,HttpServletResponse response)
	{
		String page=request.getParameter("pageAction");
		String query="";
		String fileName="";
		String param=null;
	    HashMap<String,Object> map=new HashMap<String,Object>(); 
	
	    if(page.equalsIgnoreCase("JobDesign"))
	    {
			fileName+="jobDesign.jrxml";
			query+="SELECT (@c:=@c+1) SNO,jd.CHR_JOBGRADE,jd.CHR_JOBCODE,jd.CHR_JOBTITLE,d.CHR_DEPARTNAME,jd.CHR_JOBPURPOSE,jd.CHR_JOBDUTY,jd.CHR_JOBAUTH,jd.CHR_RESPONSE,"+
					"jd.CHR_SKILLSET,jd.CHR_JOBPROMOTIONS,jd.CHR_JOBHAZ,jd.CHR_JOBREPORT,jd.CHR_GENDER,jd.INT_AGE,jd.INT_AGE_TO,q.CHR_QUALIFICATIONNAME,jd.INT_EXPERIENCE,"+
					"jd.INT_HEIGHT,jd.INT_WEIGHT,jd.INT_SALARY,jd.INT_DA,jd.INT_HRA,jd.CHR_MEMORY,jd.CHR_CREATIVITY,jd.CHR_TEACHING,jd.CHR_EMOTIONAL,jd.INT_WORKING FROM "+
					"hrm_m_jobdesign jd,com_m_depart d,com_m_qualification q, (SELECT @c:=0) t WHERE  jd.INT_DEPARTID=d.INT_DEPARTID and "+
					" jd.CHR_QUALIFICATIONID=q.INT_QUALIFICATIONID AND CASE"+
					" WHEN  $P{grade}='Top' OR  $P{grade}='Middle' OR  $P{grade}='Bottom'"+
					" THEN jd.chr_jobgrade=$P{grade}"+" ELSE jd.chr_jobgrade IN ('Top','Middle','Bottom') END" ;
			if(request.getParameter("grade").equals("Group-1"))
			{
					map.put("grade", "Top");
			}
			else if(request.getParameter("grade").equals("Group-2"))
			{
				map.put("grade", "Middle");
			}
			else if(request.getParameter("grade").equals("Group-3"))
				map.put("grade", "Bottom");
			else map.put("grade", null);	
		}
	    else if(page.equalsIgnoreCase("jobSpecification"))
	    {
			fileName+="jobSpecification.jrxml";
			query+="SELECT (@c:=@c+1) SNO,jd.CHR_JOBCODE,jd.CHR_JOBTITLE,q.CHR_QUALIFICATIONNAME,jd.INT_SALARY,jd.INT_EXPERIENCE FROM"+
                   " hrm_m_jobdesign jd,com_m_qualification q, (SELECT @c:=0) t WHERE jd.CHR_QUALIFICATIONID=q.INT_QUALIFICATIONID";
		}
	    else if(page.equalsIgnoreCase("jobDescription"))
	    {
			fileName+="jobDescription.jrxml";
			query+="SELECT (@c:=@c+1) SNO,jd.CHR_JOBTITLE,jd.CHR_JOBCODE,jd.CHR_JOBGRADE  FROM hrm_m_jobdesign jd, (SELECT @c:=0) t";
		}
	    else if(page.equalsIgnoreCase("generalSkills"))
	    {
			fileName+="Skills.jrxml";
			query+="SELECT (@c:=@c+1) SNO,skill.CHR_SKILLNAME, skill.CHR_DESC FROM hrm_m_skilllevel skill,(SELECT @c:=0) t";
		}
	    else if(page.equalsIgnoreCase("TechnicalSkills"))
	    {
			fileName+="TechnicalSkills.jrxml";
			query+="SELECT (@c:=@c+1) SNO, techn.CHR_TECHNICALCOMPETENCYNAME,techn.CHR_DESC  FROM hrm_m_technicalcompetencylevel techn,(SELECT @c:=0) t";
		}
	    else if(page.equalsIgnoreCase("TestType"))
	    {
			fileName+="TestType.jrxml";
			query+="SELECT (@c:=@c+1) SNO,ttype.CHR_TESTNAME,ttype.CHR_DESC  FROM hrm_m_testtype ttype,(SELECT @c:=0) t";
		}
	    else if(page.equalsIgnoreCase("QualifiedResult"))
	    {
			fileName+="QualifiedResult.jrxml";
			map.put("year", Integer.parseInt(request.getParameter("year")));
			map.put("month", request.getParameter("month"));
			query+="SELECT (@c:=@c+1) SNO,app.CHR_APPCODE,app.CHR_APPNAME,jd.CHR_JOBCODE, app.CHR_JOBGRADE,jd.CHR_JOBTITLE,interview.DAT_DOI,"+
                   " interview.CHR_POSITION,interview.DOU_CSALARY,interview.DOU_ESALARY,interview.CHR_FIRSTINTERVIEWBY,interview.DAT_FIRSTINTERVIEWDATE,"+
                   "interview.CHR_FIRSTCOMMENTS,interview.CHR_SECONDINTERVIEWBY,interview.DAT_SECONDINTERVIEWDATE,interview.CHR_SECONDINTERVIEWSTATUS,"+
                   "interview.CHR_CANDIDATESTATUS FROM hrm_m_application app,hrm_m_jobdesign jd,hrm_t_interview interview, (SELECT @c:=0) t WHERE "+
                   " interview.INT_APPLICANTID=app.INT_APPID  AND app.INT_JOBID=jd.INT_JOBID AND app.CHR_MONTH=$P{month} AND app.INT_YEAR=$P{year}";
			//AND jd.CHR_JOBGRADE ='Top' 
		}
	    else if(page.equalsIgnoreCase("Question"))
	    {
			fileName+="Question.jrxml";
			String type=request.getParameter("qtype");
			System.out.println("type:"+type);
			if(type.equals("All"))
			{
				map.put("testName", null);
			}
			else
				map.put("testName",type);
			
			query+="SELECT (@c:=@c+1) SNO, ttype.CHR_TESTNAME,quest.CHR_QUESTION,quest.CHR_ANSWER1,quest.CHR_ANSWER2,quest.CHR_ANSWER3,quest.CHR_ANSWER4 "+
                   "  FROM hrm_m_testtype ttype,hrm_m_testquestion quest,(SELECT @c:=0) t WHERE ttype.INT_TESTTYPEID=quest.INT_TESTTYPEID AND CASE  "+
                   "   WHEN  $P{testName} is null OR  $P{testName}='' THEN ttype.CHR_TESTNAME IN (SELECT CHR_TESTNAME FROM hrm_m_testtype) ELSE ttype.CHR_TESTNAME=$P{testName} END ";
		}
	    else if(page.equalsIgnoreCase("JobDemand"))
	    {
			fileName="JobDemand.jrxml";
			if(request.getParameter("location").equals("All")) map.put("location", null);
			else map.put("location", request.getParameter("location"));
			if(request.getParameter("grade").equals("All")) map.put("grade", null);
			else{
				if(request.getParameter("grade").equals("Group-1")){
					map.put("grade", "Top");
					
			}else if(request.getParameter("grade").equals("Group-2")){
				map.put("grade", "Middle");
				
			}else if(request.getParameter("grade").equals("Group-3"))
				map.put("grade", "Bottom");
			
			}
			map.put("year", Integer.parseInt(request.getParameter("year")));
				
			query+="SELECT  (@c:=@c+1) SNO,jd.CHR_JOBGRADE,jd.CHR_JOBCODE,jd.CHR_JOBTITLE,office.CHR_OFFICENAME,jdemand.DAT_REGISTERDATE,jdemand.CHR_MONTH,"+
                   "jdemand.INT_YEAR,jdemand.INT_DEMAND    FROM  hrm_m_jobdesign jd, hrm_m_jobdemand jdemand, com_m_office office,(SELECT @c:=0) t  WHERE  "+
                   "jdemand.INT_OFFICEID=office.INT_OFFICEID  AND jdemand.INT_YEAR=$P{year} AND CASE  WHEN  $P{location} is null OR  $P{location}=''"+
                   " THEN office.CHR_OFFICENAME IN (SELECT CHR_OFFICENAME FROM com_m_office) ELSE office.CHR_OFFICENAME =$P{location}  END AND  CASE "+
                   " WHEN  $P{grade}='Top' OR  $P{grade}='Middle' OR  $P{grade}='Bottom'  THEN jd.chr_jobgrade=$P{grade} ELSE  jd.chr_jobgrade IN ('Top','Middle','Bottom') END  ";
		}
	    else if(page.equalsIgnoreCase("JApplication"))
	    {
			fileName="JApplication.jrxml";
			System.out.println(""+fileName);
			if(request.getParameter("location").equals("All")) 
				map.put("location", null);
			else 
				map.put("location", request.getParameter("location"));
			
			if(request.getParameter("grade").equals("All")) 
				map.put("grade", null);
			else
			{
				if(request.getParameter("grade").equals("Group-1"))
				{
					map.put("grade", "Top");
				}
				else if(request.getParameter("grade").equals("Group-2"))
				{
					map.put("grade", "Middle");
				}
				else if(request.getParameter("grade").equals("Group-3"))
					map.put("grade", "Bottom");
			}
			
			if(request.getParameter("title").equals("All"))
				map.put("title", null);
			else 
				map.put("title", request.getParameter("title"));
			
			if(request.getParameter("month").equals("All"))
				map.put("month", null);
			else 
				map.put("month", request.getParameter("month"));
			map.put("year", Integer.parseInt(request.getParameter("year")));
				
			String location = request.getParameter("location");
			String grade = request.getParameter("grade");
			String title = request.getParameter("title");
			String month = request.getParameter("month");
			String year = request.getParameter("year");
			System.out.println("location"+location);
			System.out.println("grade"+grade);
			System.out.println("title"+title);
			System.out.println("month"+month);
			System.out.println("year"+ year);
			
			query+="SELECT  (@c:=@c+1)  SNO,app.CHR_APPCODE,app.CHR_APPNAME,app.CHR_APPFATHER, ";
			query+=" app.DT_APPLICATIONDATE,app.CHR_JOBGRADE,jd.CHR_JOBCODE,jd.CHR_JOBTITLE,app.CHR_GENDER,";
			query+=" app.DT_DOB, bg.CHR_GROUPNAME, app.CHR_MARITALSTATUS,app.DT_WEDDATE,qual.CHR_QUALIFICATIONNAME, ";
			query+=" app.CHR_EMAILID,app.CHR_MOBILE, app.CHR_PASSPORT, app.CHR_PAN,app.CHR_BIKESTATUS, ";
			query+=" app.CHR_DRIVINGLIC,CONCAT(CONCAT(CONCAT(app.CHR_PADD1,app.CHR_PADD2) ,";
			query+=" city.CHR_CITYNAME), state.CHR_STATENAME) pAddress, CONCAT(CONCAT(CONCAT(app.CHR_CADD1,app.CHR_CADD2) , ";
			query+=" app.INT_CCITY), app.INT_CSTATE) cAddress FROM hrm_m_application app, hrm_m_jobdesign jd, COM_M_city city,";
			query+="  COM_M_STATE state,(SELECT @c:=0) t, com_m_office office, com_m_bloodgroup bg,com_m_qualification qual  ";
			query+=" WHERE  app.INT_JOBID=jd.INT_JOBID AND  app.CHR_QUALIFICATION  =qual.INT_QUALIFICATIONID  ";
			query+=" AND app.CHR_BG =bg.INT_BLOODGROUPID ";
			query+=" AND app.INT_YEAR=$P{year} ";
			query+=" AND app.INT_PCITY=city.INT_CITYID AND app.INT_OFFICEID=office.INT_OFFICEID ";
			query+=" AND app.INT_PSTATE=state.INT_STATEID  AND app.INT_CCITY=city.INT_CITYID AND ";
			query+=" state.INT_STATEID=app.INT_CSTATE";
			
			query+=" AND CASE  WHEN  $P{title} is null OR  $P{title}='0'  THEN app.INT_JOBID IN ($P{title} ) END ";
			
			query+=" AND CASE  WHEN  $P{grade}='Top' OR  $P{grade}='Middle' OR  $P{grade}='Bottom' ";
			query+="    THEN jd.chr_jobgrade=$P{grade}  END  ";
			
			
			/*if(!"0".equals(month))
				query+=" AND app.CHR_MONTH ='"+DateUtil.getMonth(Integer.parseInt(month))+"'";
			if(!"0".equals(location))
				query+=" AND app.INT_OFFICEID = "+location;
			if(!"0".equals(title))
				query+=" AND app.INT_JOBID = "+title;
			if(!"0".equals(grade))
				query+=" AND app.CHR_JOBGRADE = '"+grade+"' ";
			*/
			
			 
			/*query+=" AND  CASE  WHEN  $P{location} is null OR  $P{location}=''  ";
			query+=" THEN office.CHR_OFFICENAME IN (SELECT CHR_OFFICENAME FROM com_m_office ) ";
			query+=" ELSE office.CHR_OFFICENAME =$P{location}  END AND ";
			query+=" CASE  WHEN  $P{grade}='Top' OR  $P{grade}='Middle' OR  $P{grade}='Bottom' ";
			query+=" THEN jd.chr_jobgrade=$P{grade} ELSE jd.chr_jobgrade IN ('Top','Middle','Bottom') ";
			query+=" END AND CASE  WHEN  $P{title} is null OR  $P{title}='' ";
			query+=" THEN jd.CHR_JOBTITLE IN (SELECT CHR_JOBTITLE FROM hrm_m_jobdesign ) ";
			query+=" ELSE jd.CHR_JobTITLE =$P{title}  END AND CASE  WHEN  $P{month} is null OR  $P{month}='' THEN  ";
			query+=" app.CHR_MONTH IN ('January','February','March','April','May','June',";
			query+=" 'July','August','September', 'October','November','December') ELSE app.CHR_MONTH =$P{month} ";
			query+=" END AND app.INT_YEAR=$P{year} ";
		*/	
			System.out.println(query);
			System.out.println();
			System.out.println();
			System.out.println();
		
	    }
	    else if(page.equalsIgnoreCase("onlineTestView"))
	    {
			fileName+="onlineTestView.jrxml";
			if(request.getParameter("location").equals("All")) map.put("location", null);
			else map.put("location", request.getParameter("location"));
			if(request.getParameter("grade").equals("All")) map.put("grade", null);
			else map.put("grade",request.getParameter("grade"));
			if(request.getParameter("title").equals("All"))map.put("title", null);
			else map.put("title", request.getParameter("title"));
			if(request.getParameter("month").equals("All"))map.put("month", null);
			else map.put("month", request.getParameter("month"));
			map.put("year", Integer.parseInt(request.getParameter("year")));
			if(request.getParameter("result").equals("All"))map.put("result", null);
			else map.put("result",request.getParameter("result"));
			query+="SELECT (@c:=@c+1) SNO,app.CHR_APPCODE,app.CHR_APPNAME,app.CHR_JOBGRADE,jd.CHR_JOBTITLE,app.DT_APPLICATIONDATE,app.CHR_MONTH,app.INT_YEAR,app.DT_DOB,app.CHR_EMAILID,"+
                   " app.CHR_MOBILE,app.INT_ONLINETEST,app.CHR_RESULT FROM hrm_m_application app,hrm_m_jobdesign jd,(SELECT @c:=0) t, com_m_office office  WHERE app.INT_JOBID=jd.INT_JOBID "+
				   "	AND  app.INT_YEAR=$P{year}  AND app.INT_OFFICEID=office.INT_OFFICEID  AND CASE WHEN  $P{location} is null OR  $P{location}='' THEN  "+ 
                   " office.CHR_OFFICENAME IN (SELECT CHR_OFFICENAME FROM com_m_office ) ELSE office.CHR_OFFICENAME =$P{location}  END AND  CASE WHEN  $P{grade}='Group-1' THEN jd.chr_jobgrade='Top'"+
				   "  WHEN $P{grade}='Group-2'  THEN jd.chr_jobgrade='Middle'  WHEN $P{grade}='Group-3' THEN jd.chr_jobgrade='Bottom' ELSE jd.chr_jobgrade IN ('Top','Middle','Bottom') END AND CASE "+
                   " WHEN  $P{title} is null OR  $P{title}='' THEN jd.CHR_JOBTITLE IN (SELECT CHR_JOBTITLE FROM hrm_m_jobdesign ) ELSE jd.CHR_JobTITLE =$P{title}  END AND "+
				   " CASE  WHEN  $P{month} is null OR  $P{month}='' THEN app.CHR_MONTH IN ('January','February','March','April','May','June','July','August','September', 'October','November','December' )"+
                   " ELSE app.CHR_MONTH =$P{month}  END AND CASE  WHEN  $P{result}='Pass' THEN app.CHR_RESULT='P' WHEN  $P{result}='Fail' THEN app.CHR_RESULT='F' "+
                   " WHEN  $P{result}='Not Attended' THEN app.CHR_RESULT='N' ELSE app.CHR_RESULT IN ('P','N','F')  END";
		}
	    else if(page.equalsIgnoreCase("offerLetter"))
	    {
			try
			{
				System.out.println("action Start");
				fileName+="Hrmofferletter.jrxml";
				String path = getServletContext().getRealPath("/jasper_report_files/hrm");
				map.put("SUBREPORT_DIR", path+"\\");
				map.put("logopath",getServletContext().getRealPath("/images")+"\\logo.jpg");
				map.put("appid", new Integer(request.getParameter("appid")));
				query+="SELECT  offer.INT_OFFERID,ecat.CHR_CATEGORYNAME,CONCAT(year(CURRENT_TIMESTAMP),CONCAT('-',year(CURRENT_TIMESTAMP)+1)) ayear,DATE_FORMAT(CURRENT_DATE,'%d-%b-%y'),"+
	                   "  CONCAT( if(app.CHR_GENDER='Male','Mr. ', if(app.CHR_MARITALSTATUS ='M','Mrs.' ,'Ms.') ),' ',app.CHR_APPNAME) salute,office.CHR_OFFICENAME,desig.CHR_DESIGNAME, "+
	                   "   DATE_ADD(CURDATE(),INTERVAL 3 DAY) joining, FUN_GET_takehome(hal.INT_APPID) takehome FROM  hrm_t_allowance hal,hrm_m_application app,hrm_t_offerletter offer,"+
	                   " com_m_office office,com_m_desig desig,com_m_employeecategory ecat  WHERE hal.INT_APPID=offer.INT_APPID AND app.INT_APPID=offer.INT_APPID AND "+
	                   "   offer.INT_DESIGID=desig.INT_DESIGID AND offer.INT_OFFICEID=office.INT_OFFICEID AND hal.INT_APPID=$P{appid}  AND ecat.INT_EMPLOYEECATEGORYID=offer.INT_CATEGORY";
				JasperCompileManager.compileReportToFile(path+"\\"+"Hrmofferletter.jrxml", path+"\\"+"Hrmofferletter.jasper");
			    System.out.println(path+"\\"+"Hrmofferletter.jrxml / Compiled");
				JasperCompileManager.compileReportToFile(path+"\\"+"offerLetter_subreport1.jrxml", path+"\\"+"offerLetter_subreport1.jasper");
				 System.out.println(path+"\\"+"offerLetter_subreport1.jrxml / Compiled");
				System.out.println("action end");
			}
			catch(Exception e)
			{
				System.out.println("Error in offerLetter actionS :"+e.getMessage());
			}
		}
	    else if(page.equalsIgnoreCase("firstinterview"))
	    {
			try
			{
				fileName+="first.jrxml";
				query+="SELECT  app.CHR_APPNAME,DATE_FORMAT(inter.DAT_DOI,'%d/%m/%Y') doi,inter.CHR_POSITION,IF(inter.INT_TOTALEXP>1,CONCAT(inter.INT_TOTALEXP,' Yrs'),CONCAT(inter.INT_TOTALEXP,' Yr')) exp,qualif.CHR_QUALIFICATIONNAME,"+
	                   " CONCAT(inter.INT_AGE,'Yrs'),if(inter.CHR_VEHICLE='Y','Yes','No'),CONCAT(inter.DOU_CSALARY,' Rs/-'),if(inter.CHR_RELOCATION='Y','Yes','No'),CONCAT(inter.DOU_ESALARY,' Rs/-'), inter.CHR_PREFEREDLOCATION,CONCAT(inter.INT_NOTICEPERIOD,' days'),"+
	                   "inter.CHR_FIELDWORK,inter.CHR_REFERENCE FROM hrm_t_interview inter,hrm_m_application app, com_m_qualification qualif WHERE inter.INT_APPLICANTID=app.INT_APPID AND inter.INT_QUALIFICATIONID=qualif.INT_QUALIFICATIONID AND inter.INT_APPLICANTID=$P{appid}";
				String path = getServletContext().getRealPath("/jasper_report_files/hrm");
				System.out.println("Path:"+path);
				map.put("logopath",getServletContext().getRealPath("/images")+"/logo.jpg");
				map.put("SUBREPORT_DIR", path+"\\");
				map.put("appid", new Integer(request.getParameter("appid")));
				JasperCompileManager.compileReportToFile(path+"\\"+"first_sub.jrxml", path+"\\"+"first_sub.jasper");
				JasperCompileManager.compileReportToFile(path+"\\"+"first_sub1.jrxml", path+"\\"+"first_sub1.jasper");
			}
			catch(Exception e)
			{
				
			}
		}
	    else if(page.equalsIgnoreCase("secondinterview"))
	    {
			try
			{
				
				fileName+="first1.jrxml";
				query+="SELECT  app.CHR_APPNAME,DATE_FORMAT(inter.DAT_DOI,'%d/%m/%Y') doi,inter.CHR_POSITION,IF(inter.INT_TOTALEXP>1,CONCAT(inter.INT_TOTALEXP,' Yrs'),CONCAT(inter.INT_TOTALEXP,' Yr')) exp,qualif.CHR_QUALIFICATIONNAME,"+
		                   " CONCAT(inter.INT_AGE,'Yrs'),if(inter.CHR_VEHICLE='Y','Yes','No'),CONCAT(inter.DOU_CSALARY,' Rs/-'),if(inter.CHR_RELOCATION='Y','Yes','No'),CONCAT(inter.DOU_ESALARY,' Rs/-'), inter.CHR_PREFEREDLOCATION,CONCAT(inter.INT_NOTICEPERIOD,' days'),"+
		                   "inter.CHR_FIELDWORK,inter.CHR_REFERENCE FROM hrm_t_interview inter,hrm_m_application app, com_m_qualification qualif WHERE inter.INT_APPLICANTID=app.INT_APPID AND inter.INT_QUALIFICATIONID=qualif.INT_QUALIFICATIONID AND inter.INT_APPLICANTID=$P{appid}";
				String path = getServletContext().getRealPath("/jasper_report_files/hrm");
				System.out.println(path+"\\"+"second_sub.jrxml"+"  "+ path+"\\"+"second_sub.jasper");
				map.put("logopath",getServletContext().getRealPath("/images")+"/logo.jpg");
				map.put("SUBREPORT_DIR", path+"\\");
				map.put("appid", new Integer(request.getParameter("appid")));

				JasperCompileManager.compileReportToFile(path+"\\"+"first_sub.jrxml", path+"\\"+"first_sub.jasper");
				JasperCompileManager.compileReportToFile(path+"\\"+"second_sub.jrxml", path+"\\"+"second_sub.jasper");
				JasperCompileManager.compileReportToFile(path+"\\"+"second_sub1.jrxml", path+"\\"+"second_sub1.jasper");
			}
			catch(Exception e)
			{ 
				e.printStackTrace();
				System.out.println("sec: error:"+e.getMessage());
			}
		}
		else if(page.equalsIgnoreCase("appointment"))
		{
			try
			{
				fileName="";
				String path = getServletContext().getRealPath("/jasper_report_files/hrm");
				fileName+="appointment1.jrxml";
				String query1="select A.CHR_STAFFNAME,CONCAT(if(a.CHR_GENDER='Male','Mr. ',(if(a.CHR_MARITALSTATUS ='M','Mrs.' ,'Ms.'))),' ',a.CHR_STAFFNAME),DATE_FORMAT(A.DT_DOJCOLLEGE,'%d-%m-%Y'),A.CHR_SADD1,A.CHR_SADD2,A.CHR_SCITY,A.CHR_SSTATE,A.CHR_SPIN, ";
				query1+="B.CHR_DESIGNAME,C.CHR_COMPANYNAME,A.CHR_GENDER,A.CHR_MARITALSTATUS , RIGHT(CHR_EMPID,6),A.CHR_PERMAILID ,D.CHR_DEPARTNAME,E.CHR_OFFICENAME,A.CHR_PF,A.CHR_ESI  ";
				query1+="from com_m_staff A, com_m_desig B,com_m_company C,com_m_depart D,  com_m_office  E  "+" where A.CHR_EMPID=? AND A.INT_DESIGID=B.INT_DESIGID "+" AND A.INT_COMPANYID=C.INT_COMPANYID   AND A.INT_DEPARTID = D.INT_DEPARTID AND A.INT_OFFICEID = E.INT_OFFICEID ";
				HrmBean bean=new HrmBean();
				map=bean.getData(query1, request.getParameter("empid"));
				query+="SELECT staff.CHR_STAFFNAME, desig.CHR_DESIGNAME,DATE_FORMAT(staff.DT_DOJCOLLEGE,'%d-%b-%Y'),staff.INT_CTC,office.CHR_OFFICENAME FROM  "+
				       " com_m_staff staff,com_m_desig desig, com_m_office office WHERE staff.INT_DESIGID=desig.INT_DESIGID AND "+
					   " staff.INT_OFFICEID=office.INT_OFFICEID AND staff.CHR_EMPID=$P{empid}";
				
				map.put("SUBREPORT_DIR", path+"\\");
				map.put("empid", request.getParameter("empid"));
				JasperCompileManager.compileReportToFile(path+"\\"+"appointment_sub.jrxml", path+"\\"+"appointment_sub.jasper");
				JasperCompileManager.compileReportToFile(path+"\\"+"Rept_JAppointmentOrderWithAnnexureMain.jrxml", path+"\\"+"Rept_JAppointmentOrderWithAnnexureMain.jasper");   

				
			
			}catch(Exception e)
			{ 
				
				System.out.println("sec: error:"+e.getMessage());}
		}
		
			try
			{
				System.out.println("==============================");
				request.setAttribute("map", map);
				request.setAttribute("query", query);
				request.setAttribute("file", fileName);
				RequestDispatcher rd=request.getRequestDispatcher("/Smart HRM/JRept_report1.jsp");
				rd.forward(request, response);
			}
			catch(Exception e)
			{
				System.out.println("hrmcon:"+e.getMessage());
				e.printStackTrace();
			}
		
	}

}
