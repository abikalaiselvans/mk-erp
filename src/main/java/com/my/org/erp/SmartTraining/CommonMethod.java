package com.my.org.erp.SmartTraining;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

import com.my.org.erp.common.CommonFunctions;
@SuppressWarnings("serial")
public class CommonMethod extends HttpServlet
{ 
	




	public static void loadTestType(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	{
		 try 
		 {    		 	
			 	String sql ="";		 	
	  		 	String startLetter = request.getParameter("startLetter");	
				sql= " SELECT INT_TESTTYPEID,CHR_TESTNAME,CHR_DESC,INT_NO_OF_QUESTION, INT_DURATION,INT_PECENTAGE FROM internal_training_m_testtype    WHERE INT_TESTTYPEID >0  ";
				if(!"0".equals(startLetter))
	      			 sql = sql + " AND CHR_TESTNAME LIKE '"+startLetter+"%'";
	      		sql = sql +" ORDER BY CHR_TESTNAME";
				
				String readData[][] =CommonFunctions.QueryExecute(sql);
		     	StringBuffer sb = new StringBuffer(); 
		     	if(readData.length>0)
		     	{	
		     		for(int u=0; u<readData.length;u++)
		     		{   	     			
			     		sb.append("<Row>");			     		
			     		sb.append("<ID>"+readData[u][0]+"</ID>");
			     		sb.append("<Name>"+readData[u][1].replaceAll("&"," AND ")+"</Name>");
			     		sb.append("<Desc>"+readData[u][2].replaceAll("&"," AND ")+"</Desc>");
			     		sb.append("<Noofquestion>"+readData[u][3]+"</Noofquestion>");
			     		sb.append("<Duration>"+readData[u][4]+"</Duration>");
			     		sb.append("<Percentage>"+readData[u][5]+"</Percentage>");
			     		sb.append("</Row>"); 
			     		
		     		}   	     		
		     	
		     		response.setContentType("text/xml");
		     		response.setHeader("Cache-Control", "no-cache");
		     		response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
		     	} 
		     	else 
		     	{
		     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
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




	public static void loadTestTypeQuestion(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	{
		 try 
		 {    		 	
			 
			 	 
			 	String sql ="";		 	
			 	String typeid=request.getParameter("typeid");
	  		 	String startLetter = request.getParameter("startLetter");	
				sql = " SELECT a.INT_ROWID,b.CHR_TESTNAME,a.CHR_QUESTION,a.CHR_ANSWER1,a.CHR_ANSWER2,a.CHR_ANSWER3,a.CHR_ANSWER4,a.CHR_ACTUAL_ANSWER"; 
				sql = sql +" FROM internal_training_m_testquestion a,internal_training_m_testtype b WHERE a.INT_TESTTYPEID = b.INT_TESTTYPEID  ";
				if(!"0".equals(typeid))
					sql = sql +" AND a.INT_TESTTYPEID ="+typeid;
				if(!"0".equals(startLetter))
	      			 sql = sql + " AND b.CHR_TESTNAME LIKE '"+startLetter+"%'";
				sql = sql +" ORDER BY b.CHR_TESTNAME ";

				 System.out.println("sql..."+sql);
			 	String readData[][] = CommonFunctions.QueryExecute(sql);
		     	StringBuffer sb = new StringBuffer(); 
		     	if(readData.length>0)
		     	{	
		     		for(int u=0; u<readData.length;u++)
		     		{   	     			
			     		sb.append("<Row>");			     		
			     		sb.append("<ID>"+readData[u][0]+"</ID>");
			     		sb.append("<Type>"+(readData[u][1].replaceAll("&"," 9629314396 ")).replaceAll("<", "9865043008")+"</Type>");
			     		sb.append("<Question>"+(readData[u][2].replaceAll("&"," 9629314396 ")).replaceAll("<", "9865043008")+"</Question>");
			     		sb.append("<Answer1>"+(readData[u][3].replaceAll("&"," 9629314396 ")).replaceAll("<", "9865043008")+"</Answer1>");
			     		sb.append("<Answer2>"+(readData[u][4].replaceAll("&"," 9629314396 ")).replaceAll("<", "9865043008")+"</Answer2>");
			     		sb.append("<Answer3>"+(readData[u][5].replaceAll("&"," 9629314396 ")).replaceAll("<", "9865043008")+"</Answer3>");
			     		sb.append("<Answer4>"+(readData[u][6].replaceAll("&"," 9629314396 ")).replaceAll("<", "9865043008")+"</Answer4>");
			     		sb.append("<CorrectAnswer>"+(readData[u][7].replaceAll("&"," 9629314396 ")).replaceAll(">", "9865043008")+"</CorrectAnswer>");
			     		sb.append("</Row>"); 
			     		
		     		}   	     		
		     	
		     		response.setContentType("text/xml");
		     		response.setHeader("Cache-Control", "no-cache");
		     		response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
		     	} 
		     	else 
		     	{
		     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
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


	public static void loadTrainingDetails(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	{
		 try 
		 {    		 	
			 
			 	 
			 	String sql ="";		 	
			 	String type= request.getParameter("type");
			 	String office= request.getParameter("office");
			 	String day= request.getParameter("day");
			 	String month= request.getParameter("month");
			 	String year= request.getParameter("year");
	  		 	String startLetter = request.getParameter("startLetter");	
			 	System.out.println(type+""+office+""+day+""+month+""+year);
			 	sql = " select a.INT_TRAINIGID,b.CHR_TESTNAME,FIND_A_EMPLOYEE_ID_NAME(a.CHR_EMPID), ";  
			 	sql = sql +" DATE_FORMAT(a.DAT_FROM,'%d-%b-%Y'),DATE_FORMAT(a.DAT_TO,'%d-%b-%Y') , ";  
			 	sql = sql +" FIND_A_EMPLOYEE_ID_NAME(a.CHR_CONDUCTEDBY),if(a.CHR_TESTREQUIRED='Y' ,'Yes' , 'No' ) , ";  
			 	sql = sql +" DATE_FORMAT(a.DAT_CREATION,'%d-%b-%Y')  from internal_training_m_traningdetails a, internal_training_m_testtype b, ";  
			 	sql = sql +" com_m_staff c ";  
			 	sql = sql +" WHERE a.INT_TESTTYPEID = b.INT_TESTTYPEID AND a.CHR_EMPID = c.CHR_EMPID ";
			 	if(!"0".equals(type))
			 		sql = sql +" AND a.INT_TESTTYPEID="+type;
			 	
			 	if(!"0".equals(office))
			 		sql = sql +" AND c.INT_OFFICEID="+office;
			 	
			 	if(!"0".equals(day))
			 		sql = sql +" AND DAY(a.DAT_CREATION)="+day;
			 	
			 	if(!"0".equals(month))
			 		sql = sql +" AND MONTH(a.DAT_CREATION)="+month;
			 	
			 	if(!"0".equals(year))
			 		sql = sql +" AND YEAR(a.DAT_CREATION)="+year;
			 	
			 	if(!"0".equals(startLetter))
	      			 sql = sql + " AND b.CHR_TESTNAME LIKE '"+startLetter+"%'";
			 	System.out.println("sql...."+sql);
			 	
			 	String readData[][] = CommonFunctions.QueryExecute(sql);
		     	StringBuffer sb = new StringBuffer(); 
		     	if(readData.length>0)
		     	{	
		     		for(int u=0; u<readData.length;u++)
		     		{   	     			
			     		sb.append("<Row>");			     		
			     		sb.append("<ID>"+readData[u][0]+"</ID>");
			     		sb.append("<Type>"+(readData[u][1].replaceAll("&"," 9629314396 ")).replaceAll("<", "9865043008")+"</Type>");
			     		sb.append("<Emp>"+(readData[u][2].replaceAll("&"," 9629314396 ")).replaceAll("<", "9865043008")+"</Emp>");
			     		sb.append("<From>"+(readData[u][3].replaceAll("&"," 9629314396 ")).replaceAll("<", "9865043008")+"</From>");
			     		sb.append("<To>"+(readData[u][4].replaceAll("&"," 9629314396 ")).replaceAll("<", "9865043008")+"</To>");
			     		sb.append("<Conducted>"+(readData[u][5].replaceAll("&"," 9629314396 ")).replaceAll("<", "9865043008")+"</Conducted>");
			     		sb.append("<Test>"+(readData[u][6].replaceAll("&"," 9629314396 ")).replaceAll("<", "9865043008")+"</Test>");
			     		sb.append("<Creation>"+(readData[u][7].replaceAll("&"," 9629314396 ")).replaceAll("<", "9865043008")+"</Creation>");
			     		sb.append("</Row>"); 
			     		
		     		}   	     		
		     	
		     		response.setContentType("text/xml");
		     		response.setHeader("Cache-Control", "no-cache");
		     		response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
		     	} 
		     	else 
		     	{
		     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
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



	
	
	
	public static void loadOnlineTestDetails(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	{
		 try 
		 {    		 	
			 
			 	 
			 	String sql ="";	
			 	String month= request.getParameter("mon");
			 	String year= request.getParameter("yr");
			 	String startLetter= request.getParameter("startLetter");
			 	String type= request.getParameter("type");
			 	String result= request.getParameter("result");
			 	
			 	sql = sql +"  SELECT b.CHR_EMPID, b.CHR_STAFFNAME , c.CHR_TESTNAME,a.INT_NO_OF_QUESTION, ";
			 	sql = sql +"  a.INT_DURATION,a.INT_PECENTAGE,DATE_FORMAT(a.DAT_WRITTEN ,'%d-%b-%Y %h:%m:%s'), ";
			 	sql = sql +"  a.CHR_RESULT,a.INT_NOOF_ATTEMPT,a.INT_TESTTYPEID ";
			 	sql = sql +"  FROM internal_training_t_testemployeelist a, com_m_staff b, internal_training_m_testtype c ";
			 	sql = sql +"  WHERE a.CHR_EMPID = b.CHR_EMPID ";
			 	sql = sql +"  AND a.INT_TESTTYPEID = c.INT_TESTTYPEID ";
			 	 
			 	if(!"0".equals(type))
			 		sql = sql +" AND a.INT_TESTTYPEID="+type;
			 	if(!"0".equals(month))
			 		sql = sql +" AND MONTH(a.DAT_WRITTEN)="+month;
			 	
			 	if(!"0".equals(year))
			 		sql = sql +" AND YEAR(a.DAT_WRITTEN)="+year;
			 	
			 	if(!"0".equals(result))
			 		sql = sql +" AND a.CHR_RESULT = '"+result+"' ";
			 	
			 	if(!"0".equals(startLetter))
			 		sql = sql +" AND  b.CHR_STAFFNAME LIKE '"+startLetter+"%' ";
			 	
			 	sql = sql +"  ORDER BY b.CHR_STAFFNAME ";
			 	
			 	System.out.println(sql);;
			 	
			 	String readData[][] = CommonFunctions.QueryExecute(sql);
		     	StringBuffer sb = new StringBuffer(); 
		     	if(readData.length>0)
		     	{	
		     		for(int u=0; u<readData.length;u++)
		     		{   	     			
			     		sb.append("<Row>");			     		
			     		sb.append("<empid>"+readData[u][0]+"</empid>");
			     		sb.append("<empname>"+(readData[u][1].replaceAll("&"," 9629314396 ")).replaceAll("<", "9865043008")+"</empname>");
			     		sb.append("<testname>"+(readData[u][2].replaceAll("&"," 9629314396 ")).replaceAll("<", "9865043008")+"</testname>");
			     		sb.append("<noofquestion>"+(readData[u][3].replaceAll("&"," 9629314396 ")).replaceAll("<", "9865043008")+"</noofquestion>");
			     		sb.append("<duration>"+(readData[u][4].replaceAll("&"," 9629314396 ")).replaceAll("<", "9865043008")+"</duration>");
			     		sb.append("<percentage>"+(readData[u][5].replaceAll("&"," 9629314396 ")).replaceAll("<", "9865043008")+"</percentage>");
			     		sb.append("<date>"+(readData[u][6].replaceAll("&"," 9629314396 ")).replaceAll("<", "9865043008")+"</date>");
			     		sb.append("<result>"+(readData[u][7].replaceAll("&"," 9629314396 ")).replaceAll("<", "9865043008")+"</result>");
			     		sb.append("<noofattempt>"+(readData[u][8].replaceAll("&"," 9629314396 ")).replaceAll("<", "9865043008")+"</noofattempt>");
			     		sb.append("<testid>"+(readData[u][9].replaceAll("&"," 9629314396 ")).replaceAll("<", "9865043008")+"</testid>");
			     		sb.append("</Row>"); 
			     		
		     		}   	     		
		     	
		     		response.setContentType("text/xml");
		     		response.setHeader("Cache-Control", "no-cache");
		     		response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
		     	} 
		     	else 
		     	{
		     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
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