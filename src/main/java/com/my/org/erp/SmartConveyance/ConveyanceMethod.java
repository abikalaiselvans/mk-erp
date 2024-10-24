package com.my.org.erp.SmartConveyance;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.file.FileFunctions;
@SuppressWarnings("serial")
public class ConveyanceMethod extends HttpServlet
{
    public static void ConveyancedateCheck(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
    	 try 
    	 {    		 	
    		 	String date=request.getParameter("claimdate");
    		 	String empid = request.getParameter("empid");
    		 	String sql = "SELECT count(*),  ROUND(FUN_GET_CONVEYANCE_LIMIT_CHECK('"+empid+"', '"+DateUtil.FormateDateSQL(date)+"'),0) , MONTHNAME('"+DateUtil.FormateDateSQL(date)+"'), YEAR('"+DateUtil.FormateDateSQL(date)+"')  FROM conveyance_t_conveyance WHERE CHR_EMPID='"+empid+"' AND DAT_CONDATE='"+DateUtil.FormateDateSQL(date)+"'";
    		 	System.out.println(sql);
    		 	String readData[][]=  CommonFunctions.QueryExecute(sql);
    		 	String conveyanceentryamount= readData[0][1];
    		 	StringBuffer sb = new StringBuffer();
    		 	sb.append("<Id>");
    		 	if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
    		 		sb.append("<Flag>TRUE</Flag>");
    		 	else
    		 		sb.append("<Flag>FALSE</Flag>");
    		 	sb.append("<CMonth>"+readData[0][2]+"</CMonth>");
    		 	sb.append("<CYear>"+readData[0][3]+"</CYear>");
    		 	sb.append("<ConveyanceEntryAmount>"+conveyanceentryamount+"</ConveyanceEntryAmount>");
    		 	String conveyancelimit = CommonFunctions.QueryExecute("SELECT INT_CONVEYANCE_LIMIT  FROM com_m_staff WHERE CHR_EMPID='"+empid+"'")[0][0]; 
    		 	sb.append("<ConveyanceLimitAmount>"+conveyancelimit+"</ConveyanceLimitAmount>");
    		 	int ceamount =Integer.parseInt(conveyanceentryamount);
    		 	int clamount=Integer.parseInt(conveyancelimit);
    		 	System.out.println(ceamount);	
    		 	System.out.println(clamount);	
    		 	if(ceamount>clamount)
    		 		sb.append("<LimitFlag>TRUE</LimitFlag>");
    		 	else
    		 		sb.append("<LimitFlag>FALSE</LimitFlag>");
    		 	sb.append("</Id>");
    	     	response.setContentType("text/xml");
    	     	response.setHeader("Cache-Control", "no-cache");
    	     	response.getWriter().write("<Ids>" + sb.toString() + "</Ids>");
    	     	System.out.println(sb);	
    	     	
    	 	} 
    	 	catch (Exception e) 
    	 	{
    	 		System.out.println(e.getMessage());
    			request.setAttribute("error", e.getMessage() );
                RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
        		dispatchers.forward(request, response); 
    	 	} 
    }	
     
    
    public static void LoadConveyanceReport(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 	HttpSession session = request.getSession();
	   		String empid = (String) session.getAttribute("EMPID");
    	 	String year=request.getParameter("year");     			
  	 		String month =request.getParameter("month");
  	 		String day=""+request.getParameter("day");
  	 		String staffid=""+request.getParameter("staffid");
  	 		String Status=""+request.getParameter("Status");
  	 		String sql ="";
  	 		
  	 		
  	 		sql="SELECT a.INT_CONID,b.CHR_EMPID,b.CHR_STAFFNAME,a.DAT_CONDATE,a.CHR_FROM,a.CHR_TO,a.CHR_CALLID,a.DOU_KM,a.DOU_TRAVEL,a.DOU_TRAIN,a.DOU_AUTO,a.DOU_LUNCH,  "; 
 			sql = sql +" a.DOU_TELEPHONE,a.CHR_OTHERDESC, a.DOU_OTHERAMT,a.DOU_TOTAL,a.CHR_STATUS,a.CHR_DESC   ";
 			sql = sql +" FROM conveyance_t_conveyance  a , com_m_staff b ";
 			sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  AND b.CHR_TYPE!='T'";
 			sql = sql +" AND b.CHR_REPTO='"+empid+"' ";
 			if(!"0".equals(month))
  	 			sql=sql+" AND MONTH(a.DAT_CONDATE) ="+month;
  	 		if(!"0".equals(day))
  	 			sql=sql+" AND DAY(a.DAT_CONDATE)="+day;
  	 		if(!"0".equals(year))
  	 			sql=sql+" AND YEAR(a.DAT_CONDATE)="+year;
  	 		 
  	 		if(!"0".equals(staffid))
  	 			sql=sql+" AND  a.CHR_EMPID= '"+staffid+"' ";
  	 		 
  	 		if(!"0".equals(Status))
  	 			sql=sql+" AND  a.CHR_STATUS= '"+Status+"' ";
  	 		 
  	 		sql=sql+" ORDER BY  b.CHR_STAFFNAME";

  		 	 
  		 	// System.out.println(sql);
  		  	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
  	     	StringBuffer sb = new StringBuffer();
  	     	for(int u=0; u<readData.length;u++)
  	     	{
   				sb.append("<Rows>");    
   				sb.append("<Rowid>" +readData[u][0]+ "</Rowid>");
  				sb.append("<EmpId>" +readData[u][1]+ "</EmpId>");
  				sb.append("<EmpName>" +readData[u][2] + "</EmpName>");  
  				sb.append("<Date>" +readData[u][3] + "</Date>");
  				sb.append("<From>" +readData[u][4] + "</From>");
  				sb.append("<To>" +readData[u][5] + "</To>");
  				sb.append("<Callid>" +readData[u][6] + "</Callid>");
  				sb.append("<KM>" +readData[u][7] + "</KM>");
  				sb.append("<Travel>" +readData[u][8] + "</Travel>");
  				sb.append("<Train>" +readData[u][9] + "</Train>");
  				sb.append("<Auto>" +readData[u][10] + "</Auto>");
  				sb.append("<Lunch>" +readData[u][11] + "</Lunch>");
  				sb.append("<Telephone>" +readData[u][12] + "</Telephone>");
  				sb.append("<Otherdesc>" +readData[u][13] + "</Otherdesc>");
  				sb.append("<Otheramount>" +readData[u][14] + "</Otheramount>");
  				sb.append("<Total>" +readData[u][15] + "</Total>");
  				sb.append("<Status>" +readData[u][16] + "</Status>");
  				sb.append("</Rows>");
  	     	}	          

  	   		response.setContentType("text/xml");
  	   		response.setHeader("Cache-Control", "no-cache");
  	   		response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");
  	   	  		     	 	 
  	 	
    	 
    	 
    	 		 
  		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		System.out.println(e.getMessage());
    			request.setAttribute("error", e.getMessage() );
                RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
        		dispatchers.forward(request, response); 
    	 	} 
    }
    
    
    public static void ConveyanceAdvance(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 	HttpSession session = request.getSession();
	   		String startLetter=request.getParameter("startLetter");
	   		String Office=request.getParameter("office"); 
	   		String day=request.getParameter("day");
	   		String month=request.getParameter("month");
	   		String year=request.getParameter("year");
	   		
	   		
	   		
    	 	String OfficeData[][] = CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b " +
		 			"WHERE b.INT_OFFICEID IN("+CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a " +
		 					"WHERE a.CHR_USRNAME='"+""+session.getAttribute("USRID")+"' ")[0][0]+" )");
		 	String officeids="";
		 	if(OfficeData.length>0)
		 	 	for(int u=0;u<OfficeData.length;u++)
		 	 		officeids=officeids+OfficeData[u][0]+",";
		 	
  	 		String sql ="";
  	 		
  	 		sql="SELECT a.INT_ADVANCEID, a.CHR_EMPID,b.CHR_STAFFNAME,";
  	 		sql = sql +" DATE_FORMAT(a.DAT_ENTRYDATE,'%d-%b-%Y'), ";
  	 		sql = sql +" a.DOU_AMOUNT ";
  	 		sql = sql +" FROM conveyance_m_advance a ,com_m_staff b WHERE a.CHR_EMPID = b.CHR_EMPID";
  	 		
  	 		if(!"0".equals(day))
	 			sql=sql+" AND DAY(a.DAT_ENTRYDATE)="+day;
  	 		
  	 		if(!"0".equals(month))
	 			sql=sql+" AND MONTH(a.DAT_ENTRYDATE)="+month;
  	 		
  	 		if(!"0".equals(year))
	 			sql=sql+" AND YEAR(a.DAT_ENTRYDATE)="+year;
  	 		
  	 		if(!"0".equals(Office))
	 			sql=sql+" AND b.INT_OFFICEID="+Office;
	 		else
	 			sql = sql + " AND b.INT_OFFICEID IN ("+officeids+"0 )";
  	 		
  	 		 
  	 		
  	 		if(!"0".equals(startLetter))
  	 			sql=sql+" AND  b.CHR_STAFFNAME LIKE  '"+startLetter+"%' ";
  	 		sql = sql +" ORDER BY  b.CHR_STAFFNAME ";
  	 		System.out.println(sql);
  	 		
  		  	String readData[][] =  CommonFunctions.QueryExecute(sql);
  	     	StringBuffer sb = new StringBuffer();
  	     	for(int u=0; u<readData.length;u++)
  	     	{
   				sb.append("<Rows>");    
   				sb.append("<Rowid>" +readData[u][0]+ "</Rowid>");
  				sb.append("<EmpId>" +readData[u][1]+ "</EmpId>");
  				sb.append("<EmpName>" +readData[u][2] + "</EmpName>");  
  				sb.append("<Date>" +readData[u][3] + "</Date>");
  				sb.append("<Amount>" +readData[u][4] + "</Amount>");
  				sb.append("</Rows>");
  				
  	     	}	          

  	   		response.setContentType("text/xml");
  	   		response.setHeader("Cache-Control", "no-cache");
  	   		response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");
  
    	 } 
    	 	catch (Exception e) 
    	 	{
    	 		System.out.println(e.getMessage());
    			request.setAttribute("error", e.getMessage() );
                RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
        		dispatchers.forward(request, response); 
    	 	} 
    }
    
    
    public static void ConveyanceManual(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 	HttpSession session = request.getSession();
	   		String startLetter=request.getParameter("startLetter");
	   		String Office=request.getParameter("office"); 
	   		 
	   		String month=request.getParameter("month");
	   		String year=request.getParameter("year");
	   		
    	 	String OfficeData[][] = CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b " +
		 			"WHERE b.INT_OFFICEID IN("+CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a " +
		 					"WHERE a.CHR_USRNAME='"+""+session.getAttribute("USRID")+"' ")[0][0]+" )");
		 	String officeids="";
		 	if(OfficeData.length>0)
		 	 	for(int u=0;u<OfficeData.length;u++)
		 	 		officeids=officeids+OfficeData[u][0]+",";
		 	
  	 		String sql ="";
  	 		
  	 		sql = sql +" SELECT a.INT_MANAUALID, a.CHR_EMPID,b.CHR_STAFFNAME,  ";
  	 		sql = sql +" a.CHR_MONTH,a.INT_YEAR ,   ";
  	 		sql = sql +" a.DOU_AMOUNT  ,FIND_A_EMPLOYEE_ID_NAME_BY_USERID(a.CHR_USRNAME),a.CHR_UPLOAD  ";
  	 		sql = sql +" FROM conveyance_m_manual a ,com_m_staff b WHERE a.CHR_EMPID = b.CHR_EMPID  "; 
  	 		
  	 		if(!"0".equals(month))
	 			sql=sql+" AND MONTH(a.DAT_ENTRYDATE)="+month;
  	 		
  	 		if(!"0".equals(year))
	 			sql=sql+" AND YEAR(a.DAT_ENTRYDATE)="+year;
  	 		
  	 		if(!"0".equals(Office))
	 			sql=sql+" AND b.INT_OFFICEID="+Office;
	 		else
	 			sql = sql + " AND b.INT_OFFICEID IN ("+officeids+"0 )";
  	 		if(!"0".equals(startLetter))
  	 			sql=sql+" AND  b.CHR_STAFFNAME LIKE  '"+startLetter+"%' ";
  	 		sql = sql +" ORDER BY  b.CHR_STAFFNAME ";
  	 		System.out.println(sql);
  	 		
  		  	String readData[][] =  CommonFunctions.QueryExecute(sql);
  	     	StringBuffer sb = new StringBuffer();
  	     	if (readData.length > 0) 
			{
				String filepath = request.getRealPath("/");
				
	  	     	for(int u=0; u<readData.length;u++)
	  	     	{
	   				sb.append("<Rows>");    
	   				sb.append("<Rowid>" +readData[u][0]+ "</Rowid>");
	  				sb.append("<EmpId>" +readData[u][1]+ "</EmpId>");
	  				sb.append("<EmpName>" +readData[u][2] + "</EmpName>");  
	  				sb.append("<Month>" +readData[u][3] + "</Month>");
	  				sb.append("<Year>" +readData[u][4] + "</Year>");
	  				sb.append("<Amount>" +readData[u][5] + "</Amount>");
	  				sb.append("<Entryby>" +readData[u][6] + "</Entryby>");
	  				sb.append("<Upload>" +readData[u][7] + "</Upload>");
	  				if(FileFunctions.fileIsThere(filepath+"uploadfiles/Conveyance_File/"+readData[u][0]+".pdf")) 
 						sb.append("<F>Y</F>");
 					else	
 						sb.append("<F>N</F>");
					
	  				sb.append("</Rows>");
	  				
	  	     	}	          

	  	   		response.setContentType("text/xml");
	  	   		response.setHeader("Cache-Control", "no-cache");
	  	   		response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");
	  	   	  		     	 	 
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
