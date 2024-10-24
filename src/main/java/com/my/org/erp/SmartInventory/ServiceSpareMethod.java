package com.my.org.erp.SmartInventory;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.common.CommonFunctions;

public class ServiceSpareMethod 
{

	
	public static void LoadEquipementType(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException 
	{
		try 
		{
			String StartLetter = "" + request.getParameter("startLetter");
			String sql = "";
			sql = " SELECT INT_EQUIPEMENTTYPEID,CHR_EQUIPEMENTTYPENAME FROM spare_m_equipement_type  ";
			if (!"0".equals(StartLetter))
				sql = sql + " WHERE  CHR_EQUIPEMENTTYPENAME LIKE '" + StartLetter + "%'";
			sql = sql + " ORDER BY CHR_EQUIPEMENTTYPENAME ";
			System.out.println(sql);
			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) 
			{
				for (int u = 0; u < readData.length; u++) 
				{
					sb.append("<Row>");
					sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
					sb.append("<Name>" + readData[u][1].trim() + "</Name>");
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
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
		}
	}
	
	
	public static void LoadEquipementModel(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException 
	{
		try 
		{
			String StartLetter = "" + request.getParameter("startLetter");
			String equipmenttype = "" + request.getParameter("equipmenttype");
			
			String sql = "";
			sql = "  SELECT a.INT_INT_EQUIPEMENTMODELID, b.CHR_EQUIPEMENTTYPENAME, a.CHR_MODEL,a.CHR_DESC ";
			sql = sql + " FROM spare_m_equipement_model a , spare_m_equipement_type b ";
			sql = sql + "  WHERE a.INT_EQUIPEMENTTYPEID =b.INT_EQUIPEMENTTYPEID"; 
			if (!"0".equals(equipmenttype))
				sql = sql + " AND  a.INT_EQUIPEMENTTYPEID = "+equipmenttype;
			if (!"0".equals(StartLetter))
				sql = sql + " AND  a.CHR_MODEL LIKE '" + StartLetter + "%'";
			sql = sql + " ORDER BY a.CHR_MODEL ";
			System.out.println(sql);
			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) 
			{
				for (int u = 0; u < readData.length; u++) 
				{
					sb.append("<Row>");
					sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
					sb.append("<Unit>" + readData[u][1].trim() + "</Unit>");
					sb.append("<Model>" + readData[u][2].trim() + "</Model>");
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
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
		}
	}
	
	
	public static void LoadEquipementPartNumber(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException 
	{
		try 
		{
			String StartLetter = "" + request.getParameter("startLetter");
			String sql = "";
			sql = " SELECT INT_PARTNUMBERID,UPPER(CHR_PARTNUMBER),UPPER(CHR_DESC) FROM spare_m_equipement_partnumber  ";
			if (!"0".equals(StartLetter))
				sql = sql + " WHERE  CHR_PARTNUMBER LIKE '" + StartLetter + "%'";
			sql = sql + " ORDER BY CHR_PARTNUMBER ";
			System.out.println(sql);
			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) 
			{
				for (int u = 0; u < readData.length; u++) 
				{
					sb.append("<Row>");
					sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
					sb.append("<Name>" + readData[u][1].trim() + "</Name>");
					sb.append("<Desc>" + readData[u][2].replaceAll("&", " AND ") + "</Desc>");
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
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
		}
	}
	
	public  static void loadEquipmentMaster(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try 
    	 {
    		 	String Type=request.getParameter("Type");
	    		String type=request.getParameter("type");
	    		String startLetter=""+request.getParameter("startLetter");
	    		String equipmenttype=""+request.getParameter("equipmenttype");
	    		String model=""+request.getParameter("model");
	    		String location=""+request.getParameter("location");
	    		String status=""+request.getParameter("status");
	    		
	    		String sql="";
				sql = sql + " SELECT a.INT_ROWID, FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID), b.CHR_SHORTNAME,c.CHR_EQUIPEMENTTYPENAME,e.CHR_MODEL,a.CHR_CATEGORY, ";
	 	 		sql = sql + " a.CHR_SERIALNO,DATE_FORMAT(a.DT_STARTDATE,'%d-%b-%Y'),DATE_FORMAT(a.DT_ENDDATE,'%d-%b-%Y'), ";  
	 	 		sql = sql + "  if(datediff(now(),a.DT_ENDDATE)<=0,'Live','Expired')  ";
	 	 		sql = sql + " FROM spare_m_equipement_master a ,com_m_state b, spare_m_equipement_type c ,  spare_m_equipement_model e ";
	 	 		sql = sql + " WHERE a.INT_ROWID > 0  AND a.INT_STATEID = b.INT_STATEID "; 
	 	 		sql = sql + " AND a.INT_EQUIPEMENTTYPEID  = c.INT_EQUIPEMENTTYPEID ";
	 	 		sql = sql + " AND a.INT_INT_EQUIPEMENTMODELID = e.INT_INT_EQUIPEMENTMODELID ";
	 	 		sql = sql + " AND e.INT_EQUIPEMENTTYPEID = c.INT_EQUIPEMENTTYPEID ";
	 	 		if(!"".equals(status))
	 	 			if("0".equals(status))
	 	 				sql = sql+ " AND DATEDIFF(now(),a.DT_ENDDATE) <="+status+"  ";
	 	 			else
	 	 				sql = sql+ " AND DATEDIFF(now(),a.DT_ENDDATE) >= "+status+" ";
	 	 		if(!"0".equals(Type))
	 	 			sql = sql+ " AND a.CHR_CATEGORY='"+Type+"'";
	 	 		if(!"0".equals(equipmenttype))
	 	 			sql = sql+ " AND a.INT_EQUIPEMENTTYPEID="+equipmenttype;
	 	 		if(!"0".equals(model))
	 	 			sql = sql+ " AND a.INT_INT_EQUIPEMENTMODELID="+model;
	 	 		if(!"0".equals(location))
	 	 			sql = sql+ " AND a.INT_STATEID = "+location+" ";
	 	 		if("2".equals(type))
	 	 		{
	 	 			if(!"0".equals(startLetter))
		 	 			sql = sql + " AND a.CHR_SERIALNO LIKE '%"+startLetter+"%' ";
	 	 		}
	 	 		else
	 	 		{
	 	 			if(!"0".equals(startLetter))
		 	 			sql = sql + " AND FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) LIKE '"+startLetter+"%' ";
	 	 		}
	 	 		sql = sql +" ORDER BY FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) LIMIT 2000 "; //LIMIT 1000
	 	 		System.out.println(sql);
	 	 		String readData[][] =  CommonFunctions.QueryExecute(sql);
	 	 		if(readData.length>0)
	 	 		{	
	 	 			StringBuffer sb = new StringBuffer();    	     	
	 	 			for(int u=0; u<readData.length;u++)
	 	 			{
		 					sb.append("<Row>");    	            
		 					sb.append("<Id>" +readData[u][0]+ "</Id>");
							sb.append("<CustomerName>"+readData[u][1].replaceAll("&", " AND ")+"</CustomerName>");
							sb.append("<location>" +readData[u][2].replaceAll("&", " AND ")+ "</location>");
							sb.append("<Utype>" +readData[u][3].replaceAll("&", " AND ")+ "</Utype>");
							sb.append("<Model>" +readData[u][4].replaceAll("&", " AND ")+ "</Model>");
							sb.append("<Category>" +readData[u][5].replaceAll("&", " AND ")+ "</Category>");
							sb.append("<Serialno>" +readData[u][6].replaceAll("&", " AND ")+ "</Serialno>");
							sb.append("<SDate>" +readData[u][7]+ "</SDate>");
		 					sb.append("<EDate>" +readData[u][8]+ "</EDate>");
		 					sb.append("<Status>" +readData[u][9]+ "</Status>");
		 					sb.append("</Row>");
		 			}	
	 	 			sb.toString();
					response.setContentType("text/xml");
					response.setHeader("Cache-Control", "no-cache");
					response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
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
	
	
	public  static void loadSpareCallAssign(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try 
    	 {
    		 	String type=request.getParameter("type");
	    		String startLetter=""+request.getParameter("startLetter");
	    		String customer=""+request.getParameter("customer");
	    		String day=""+request.getParameter("day");
	    		String month=""+request.getParameter("month");
	    		String year=""+request.getParameter("year");
	    		String sql="";
				sql = sql + "  SELECT a.INT_CALLASSIGNID,a.CHR_CALLASSIGNREFNO,a.INT_CALLNO,a.CHR_SERIALNO, ";
				sql = sql + "  DATE_FORMAT(a.DAT_CALLASSIGNDATE,'%d-%b-%Y  %h:%i:%s %p'), FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID), ";
				sql = sql + "  a.CHR_CONTACTPERSON,a.CHR_MOBILE,FIND_A_EMPLOYEE_NAME(a.CHR_ENGINEER) ";
				sql = sql + "  FROM spare_t_callassign a, spare_m_equipement_master b ";
				sql = sql + "  WHERE a.CHR_SERIALNO = b.CHR_SERIALNO ";
    	 		if(!"0".equals(customer))
	 	 			sql = sql+ " AND b.INT_CUSTOMERID="+customer;
	 	 		if(!"0".equals(day))
	 	 			sql = sql+ " AND DAY(a.DAT_CALLASSIGNDATE)="+day;
	 	 		if(!"0".equals(month))
	 	 			sql = sql+ " AND MONTH(a.DAT_CALLASSIGNDATE)="+month;
	 	 		if(!"0".equals(year))
	 	 			sql = sql+ " AND YEAR(a.DAT_CALLASSIGNDATE)="+year;
	 	 		if("2".equals(type))
	 	 		{
	 	 			if(!"0".equals(startLetter))
		 	 			sql = sql + " AND a.CHR_SERIALNO LIKE '%"+startLetter+"%' ";
	 	 		}
	 	 		else
	 	 		{
	 	 			if(!"0".equals(startLetter))
		 	 			sql = sql + " AND FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '"+startLetter+"%' ";
	 	 		}
	 	 		sql = sql +" ORDER BY FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIMIT 2000 "; //LIMIT 1000
	 	 		System.out.println(sql);
	 	 		String readData[][] =  CommonFunctions.QueryExecute(sql);
	 	 		
	 	 		if(readData.length>0)
	 	 		{	
	 	 			StringBuffer sb = new StringBuffer();    	     	
	 	 			for(int u=0; u<readData.length;u++)
	 	 			{
		 					sb.append("<Row>");    	            
		 					sb.append("<Id>" +readData[u][0]+ "</Id>");
							sb.append("<Ref>"+readData[u][1].replaceAll("&", " AND ")+"</Ref>");
							sb.append("<Callno>" +readData[u][2].replaceAll("&", " AND ")+ "</Callno>");
							sb.append("<Serialno>" +readData[u][3].replaceAll("&", " AND ")+ "</Serialno>");
							sb.append("<SDate>" +readData[u][4].replaceAll("&", " AND ")+ "</SDate>");
							sb.append("<CustomerName>" +readData[u][5].replaceAll("&", " AND ")+ "</CustomerName>");
							sb.append("<Cperson>" +readData[u][6].replaceAll("&", " AND ")+ "</Cperson>");
							sb.append("<Mobile>" +readData[u][7]+ "</Mobile>");
		 					sb.append("<Engineer>" +readData[u][8]+ "</Engineer>");
		 					sb.append("</Row>");
		 			}	
	 	 			sb.toString();
					response.setContentType("text/xml");
					response.setHeader("Cache-Control", "no-cache");
					response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
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
	
	
	public static void LoadSpareProduct(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException 
	{
		try 
		{
			String StartLetter = "" + request.getParameter("startLetter");
			String sql = "";
			sql = " SELECT INT_SPAREUNITID,CHR_SPAREUNITNAME FROM inv_m_spareunit  ";
			if (!"0".equals(StartLetter))
				sql = sql + " WHERE  CHR_SPAREUNITNAME LIKE '" + StartLetter + "%'";
			sql = sql + " ORDER BY CHR_SPAREUNITNAME ";
			System.out.println(sql);
			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) 
			{
				for (int u = 0; u < readData.length; u++) 
				{
					sb.append("<Row>");
					sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
					sb.append("<Name>" + readData[u][1].trim() + "</Name>");
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
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
		}
	}

	public static void LoadSpareModel(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException 
	{
		try 
		{
			String StartLetter = "" + request.getParameter("startLetter");
			String unittype = "" + request.getParameter("unittype");
			String sql = "";
			sql = "  SELECT a.INT_MODELID,b.CHR_SPAREUNITNAME, a.CHR_MODEL,a.CHR_DESC ";
			sql = sql + " FROM inv_m_spareunitmodel a , inv_m_spareunit b ";
			sql = sql + "  WHERE a.INT_SPAREUNITID =b.INT_SPAREUNITID "; 
			if (!"0".equals(unittype))
				sql = sql + " AND  a.INT_SPAREUNITID = "+unittype;
			if (!"0".equals(StartLetter))
				sql = sql + " AND  a.CHR_MODEL LIKE '" + StartLetter + "%'";
			sql = sql + " ORDER BY a.CHR_MODEL ";
			System.out.println(sql);
			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) 
			{
				for (int u = 0; u < readData.length; u++) 
				{
					sb.append("<Row>");
					sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
					sb.append("<Unit>" + readData[u][1].trim() + "</Unit>");
					sb.append("<Model>" + readData[u][2].trim() + "</Model>");
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
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
		}
	}
	
	
	public static void LoadSpareCustomer(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException 
	{
		try 
		{
			String StartLetter = "" + request.getParameter("startLetter");
			String sql = "";
			sql = " SELECT INT_CUSTOMERID,CHR_CUSTOMERNAME FROM inv_m_sparecustomer  ";
			if (!"0".equals(StartLetter))
				sql = sql + " WHERE  CHR_CUSTOMERNAME LIKE '" + StartLetter + "%'";
			sql = sql + " ORDER BY CHR_CUSTOMERNAME ";
			System.out.println(sql);
			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) 
			{
				for (int u = 0; u < readData.length; u++) 
				{
					sb.append("<Row>");
					sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
					sb.append("<Name>" + readData[u][1].trim() + "</Name>");
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
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
		}
	}
	
	
	public static void LoadSpareCustomerAddress(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException 
	{
		try 
		{
			String StartLetter = "" + request.getParameter("startLetter");
			String customer = "" + request.getParameter("customer");
			
			String sql = "";
			sql = sql + " SELECT a.INT_ADDRESSID,b.CHR_CUSTOMERNAME,a.CHR_CONTACTPERSON,a.CHR_ADDRESS1,  ";
			sql = sql + "  a.CHR_ADDRESS2,  ";
			sql = sql + "  c.CHR_COUNTRYNAME,d.CHR_STATENAME,e.CHR_DISTRICT,f.CHR_CITYNAME,  ";
			sql = sql + " a.INT_PINCODE,a.CHR_PHONE1, a.CHR_EMAIL   ";
			sql = sql + " FROM inv_m_sparecustomeraddress a , inv_m_sparecustomer b,  ";
			sql = sql + " com_m_country c , com_m_state d , com_m_district e , com_m_city f  "; 
			sql = sql + " WHERE a.INT_CUSTOMERID =b.INT_CUSTOMERID   ";
			sql = sql + " AND a.INT_COUNTRYID =c.INT_COUNTRYID  ";
			sql = sql + " AND a.INT_STATEID = d.INT_STATEID  ";
			sql = sql + " AND a.INT_DISTRICTID = e.INT_DISTRICTID  ";
			sql = sql + " AND a.INT_CITYID = f.INT_CITYID  ";
			if (!"0".equals(customer))
				sql = sql + " AND  a.INT_CUSTOMERID ="+customer;
			if (!"0".equals(StartLetter))
				sql = sql + " AND  b.CHR_CUSTOMERNAME LIKE '" + StartLetter + "%'";
			sql = sql + " ORDER BY b.CHR_CUSTOMERNAME ";
			System.out.println(sql);
			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) 
			{
				for (int u = 0; u < readData.length; u++) 
				{
					sb.append("<Row>");
					sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
					sb.append("<Name>" + readData[u][1].trim() + "</Name>");
					sb.append("<Cperson>" + readData[u][2].trim() + "</Cperson>");
					sb.append("<Address1>" + readData[u][3].trim() + "</Address1>");
					sb.append("<Address2>" + readData[u][4].trim() + "</Address2>");
					sb.append("<Country>" + readData[u][5].trim() + "</Country>");
					sb.append("<State>" + readData[u][6].trim() + "</State>");
					sb.append("<District>" + readData[u][7].trim() + "</District>");
					sb.append("<City>" + readData[u][8].trim() + "</City>");
					sb.append("<Pincocde>" + readData[u][9].trim() + "</Pincocde>");
					sb.append("<Phone>" + readData[u][10].trim() + "</Phone>");
					sb.append("<Email>" + readData[u][11].trim() + "</Email>");
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
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
		}
	}
	
	public static void LoadProblemgroups(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException 
	{
		try 
		{
			String StartLetter = "" + request.getParameter("startLetter");
			String sql = "";
			sql = " SELECT INT_PROBLEMGROUPID,CHR_PROBLEMGROUP FROM spare_m_problemgroup  ";
			if (!"0".equals(StartLetter))
				sql = sql + " WHERE  CHR_PROBLEMGROUP LIKE '" + StartLetter + "%'";
			sql = sql + " ORDER BY CHR_PROBLEMGROUP ";
			System.out.println(sql);
			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) 
			{
				for (int u = 0; u < readData.length; u++) 
				{
					sb.append("<Row>");
					sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
					sb.append("<Name>" + readData[u][1].trim() + "</Name>");
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
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
		}
	}
	
	
	public static void LoadProblems(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException 
	{
		try 
		{
			String StartLetter = "" + request.getParameter("startLetter");
			String problemgroup = "" + request.getParameter("problemgroup");
			
			String sql = "";
			sql = "  SELECT a.INT_PROBLEMID,b.CHR_PROBLEMGROUP, a.CHR_PROBLEM,a.CHR_DESC ";
			sql = sql + " FROM spare_m_problems a , spare_m_problemgroup b ";
			sql = sql + "  WHERE a.INT_PROBLEMGROUPID =b.INT_PROBLEMGROUPID "; 
			if (!"0".equals(problemgroup))
				sql = sql + " AND  a.INT_PROBLEMGROUPID = "+problemgroup;
			if (!"0".equals(StartLetter))
				sql = sql + " AND  a.CHR_PROBLEM LIKE '" + StartLetter + "%'";
			sql = sql + " ORDER BY a.CHR_PROBLEM ";
			System.out.println(sql);
			String readData[][] = CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0) 
			{
				for (int u = 0; u < readData.length; u++) 
				{
					sb.append("<Row>");
					sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
					sb.append("<Group>" + readData[u][1].trim() + "</Group>");
					sb.append("<Problem>" + readData[u][2].trim() + "</Problem>");
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
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
		}
	}
	
	
	
	public  static void LoadSpare(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try 
    	 {
    		 	String Type=request.getParameter("Type");
	    		String type=request.getParameter("type");
	    		String startLetter=""+request.getParameter("startLetter");
	    		String unittype=""+request.getParameter("unittype");
	    		String model=""+request.getParameter("model");
	    		String location=""+request.getParameter("location");
	    		String status=""+request.getParameter("status");
	    		
	    		String sql="";
				sql = sql + " SELECT a.INT_ROWID, d.CHR_CUSTOMERNAME, b.CHR_SHORTNAME,c.CHR_SPAREUNITNAME,e.CHR_MODEL,a.CHR_CATEGORY, ";
	 	 		sql = sql + " a.CHR_SERIALNO,DATE_FORMAT(a.DT_STARTDATE,'%d-%b-%Y'),DATE_FORMAT(a.DT_ENDDATE,'%d-%b-%Y'), ";  
	 	 		sql = sql + "  if(datediff(now(),a.DT_ENDDATE)<=0,'Live','Expired')  ";
	 	 		sql = sql + " FROM inv_m_sparemaster a ,com_m_state b, inv_m_spareunit c , inv_m_sparecustomer d, inv_m_spareunitmodel e ";
	 	 		sql = sql + " WHERE a.INT_ROWID > 0  AND a.INT_STATEID = b.INT_STATEID "; 
	 	 		sql = sql + " AND a.INT_SPAREUNITID  = c.INT_SPAREUNITID ";
	 	 		sql = sql + " AND a.INT_CUSTOMERID =d.INT_CUSTOMERID "; 
	 	 		sql = sql + " AND a.INT_MODELID = e.INT_MODELID ";
	 	 		sql = sql + " AND e.INT_SPAREUNITID = c.INT_SPAREUNITID ";
	 	 		if(!"".equals(status))
	 	 			if("0".equals(status))
	 	 				sql = sql+ " AND DATEDIFF(now(),a.DT_ENDDATE) <="+status+"  ";
	 	 			else
	 	 				sql = sql+ " AND DATEDIFF(now(),a.DT_ENDDATE) >= "+status+" ";
	 	 			 
	 	 		if(!"0".equals(Type))
	 	 			sql = sql+ " AND a.CHR_CATEGORY='"+Type+"'";
	 	 		
	 	 		if(!"0".equals(unittype))
	 	 			sql = sql+ " AND a.INT_SPAREUNITID="+unittype;
	 	 		if(!"0".equals(model))
	 	 			sql = sql+ " AND a.INT_MODELID="+model;
	 	 		if(!"0".equals(location))
	 	 			sql = sql+ " AND a.INT_STATEID = "+location+" ";
	 	 		
	 	 		if("2".equals(type))
	 	 		{
	 	 			if(!"0".equals(startLetter))
		 	 			sql = sql + " AND a.CHR_SERIALNO LIKE '%"+startLetter+"%' ";
	 	 		}
	 	 		else
	 	 		{
	 	 			if(!"0".equals(startLetter))
		 	 			sql = sql + " AND d.CHR_CUSTOMERNAME LIKE '"+startLetter+"%' ";
	 	 		}
	 	 		sql = sql +" ORDER BY d.CHR_CUSTOMERNAME LIMIT 2000 "; //LIMIT 1000
	 	 		System.out.println(sql);
	 	 		
	 	 		String readData[][] =  CommonFunctions.QueryExecute(sql);
	 	 		if(readData.length>0)
	 	 		{	
	 	 			StringBuffer sb = new StringBuffer();    	     	
	 	 			for(int u=0; u<readData.length;u++)
	 	 			{
		 					sb.append("<Row>");    	            
		 					sb.append("<Id>" +readData[u][0]+ "</Id>");
							sb.append("<CustomerName>"+readData[u][1].replaceAll("&", " AND ")+"</CustomerName>");
							sb.append("<location>" +readData[u][2].replaceAll("&", " AND ")+ "</location>");
							sb.append("<Utype>" +readData[u][3].replaceAll("&", " AND ")+ "</Utype>");
							sb.append("<Model>" +readData[u][4].replaceAll("&", " AND ")+ "</Model>");
							sb.append("<Category>" +readData[u][5].replaceAll("&", " AND ")+ "</Category>");
							sb.append("<Serialno>" +readData[u][6].replaceAll("&", " AND ")+ "</Serialno>");
							sb.append("<SDate>" +readData[u][7]+ "</SDate>");
		 					sb.append("<EDate>" +readData[u][8]+ "</EDate>");
		 					sb.append("<Status>" +readData[u][9]+ "</Status>");
		 					sb.append("</Row>");
		 			}	
	 	 			sb.toString();
					response.setContentType("text/xml");
					response.setHeader("Cache-Control", "no-cache");
					response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
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
