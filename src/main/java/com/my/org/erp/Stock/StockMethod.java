package com.my.org.erp.Stock;
import java.io.IOException;
 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
public class StockMethod extends HttpServlet
{
  
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;



	@SuppressWarnings("deprecation")
	public static void LoadBranchess(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try
    	 {
    		HttpSession session = request.getSession();
    		String branch = ""+session.getAttribute("BRANCHID");	
    		String type = ""+session.getAttribute("USRTYPE");
    		String company=""+request.getParameter("company");
 			int id = Integer.parseInt( company);
 			String sql="";
 			sql = " SELECT  b.INT_BRANCHID,a.CHR_COMPANYNAME,b.CHR_BRANCHNAME FROM com_m_company a ,com_m_branch b ";
 			sql = sql +" WHERE a.INT_COMPANYID=b.INT_COMPANYID ";
 			sql = sql +" AND a.INT_COMPANYID="+id;
 			if(!"F".equals(type))
 				sql = sql +" AND b.INT_BRANCHID="+branch;
 			 System.out.println(sql);
 			StringBuffer sb = new StringBuffer();
 			String readData[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
 			if (readData.length > 0)
 	 		{	
 	 			for(int u=0; u<readData.length;u++)
 	 			{	
 	 				sb.append("<branch>");
 	 				sb.append("<Branchid>" + readData[u][0]+ "</Branchid>"); 
 	 				sb.append("<CompanyName>" + readData[u][1]+ "</CompanyName>");
                    sb.append("<BranchName>" + readData[u][2]+ "</BranchName>");
                    sb.append("</branch>");	             
 	 			}
 	 			response.setContentType("text/xml");
 	            response.setHeader("Cache-Control", "no-cache");
 		        response.getWriter().write("<branches>" + sb.toString() + "</branches>");
 			} 
 	 		else 
 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }	
	
    
    public static void LoadUnits(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try
    	 {
    		 
    		 
    		
 			String startletter=""+request.getParameter("startletter");
 			if("0".equals(startletter))
 				startletter="";
 			String sql="";
 			sql = " SELECT INT_UNITID,CHR_UNITNAME,CHR_SHORTNAME FROM con_inv_m_unites  WHERE CHR_UNITNAME LIKE '"+startletter+"%' ORDER BY CHR_UNITNAME";
 			StringBuffer sb = new StringBuffer();
 			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 			if (readData.length > 0)
 	 		{	
 	 			for(int u=0; u<readData.length;u++)
 	 			{	
 	 				sb.append("<Unit>");
 	 				sb.append("<Unitid>" + readData[u][0]+ "</Unitid>"); 
 	 				sb.append("<UnitName>" + readData[u][1]+ "</UnitName>");
                    sb.append("<ShortName>" + readData[u][2]+ "</ShortName>");
                    sb.append("</Unit>");	             
 	 			}
 	 			response.setContentType("text/xml");
 	            response.setHeader("Cache-Control", "no-cache");
 		        response.getWriter().write("<Units>" + sb.toString() + "</Units>");
 			} 
 	 		else 
 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }	
	
    public static void LoadItemGroup(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try
    	 {
    		 
    		 
    		
 			String startletter=""+request.getParameter("startletter");
 			if("0".equals(startletter))
 				startletter="";
 			String sql="";
 			sql = "SELECT a.INT_GROUPID,a.CHR_GROUPNAME,a.CHR_DESC,b.CHR_SHORTNAME FROM con_inv_m_itemgroup  a, con_inv_m_unites b WHERE a.INT_UNITID=b.INT_UNITID  AND a.CHR_GROUPNAME LIKE '"+startletter+"%'  ORDER BY  a.CHR_GROUPNAME ";
 			StringBuffer sb = new StringBuffer();
 			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 			if (readData.length > 0)
 	 		{	
 	 			for(int u=0; u<readData.length;u++)
 	 			{	
 	 				sb.append("<Itemgroup>");
 	 				sb.append("<Id>" + readData[u][0]+ "</Id>"); 
 	 				sb.append("<Name>" + readData[u][1]+ "</Name>");
                    sb.append("<Description>" + readData[u][2]+ "</Description>");
                    sb.append("<Unit>" + readData[u][2]+ "</Unit>");
                    sb.append("</Itemgroup>");	             
 	 			}
 	 			response.setContentType("text/xml");
 	            response.setHeader("Cache-Control", "no-cache");
 		        response.getWriter().write("<Itemgroups>" + sb.toString() + "</Itemgroups>");
 			} 
 	 		else 
 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }	
    
    
    public static void LoadItemList(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try
    	 {
    		 
    		
 			String startletter=""+request.getParameter("startletter");
 			String itemgroup=""+request.getParameter("itemgroup");
 			
 			if("0".equals(startletter))
 				startletter="";
 			String ssql="";
 			if(!"0".equals(itemgroup))
 				ssql=" AND b.INT_GROUPID = "+itemgroup;
 			
 			String sql="";
 			sql = "SELECT a.INT_ITEMID ,a.CHR_ITEMNAME,b.CHR_GROUPNAME,a.CHR_DESC,a.DOU_PPRICE,a.DOU_SPRICE  FROM con_inv_m_itemlist a, con_inv_m_itemgroup b WHERE a.INT_GROUPID=b.INT_GROUPID "+ssql+" AND  a.CHR_ITEMNAME LIKE '"+startletter+"%'  ORDER BY  a.CHR_ITEMNAME ";
 			
 			StringBuffer sb = new StringBuffer();
 			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 			if (readData.length > 0)
 	 		{	
 	 			for(int u=0; u<readData.length;u++)
 	 			{	
 	 				sb.append("<Item>");
 	 				sb.append("<Itemid>" + readData[u][0]+ "</Itemid>"); 
 	 				sb.append("<Itemlist>" + readData[u][1]+ "</Itemlist>");
 	 				sb.append("<Itemgroup>" + readData[u][2]+ "</Itemgroup>");
 	 				sb.append("<Description>" + readData[u][3]+ "</Description>");
 	 				sb.append("<Pprice>" + readData[u][4]+ "</Pprice>");
                    sb.append("<Sprice>" + readData[u][5]+ "</Sprice>");
                    sb.append("</Item>");	       
 	 			}
 	 			response.setContentType("text/xml");
 	            response.setHeader("Cache-Control", "no-cache");
 		        response.getWriter().write("<Items>" + sb.toString() + "</Items>");
 			} 
 	 		else
 	 		{
 	 			
 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
 	 		}
 	 			
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }
    
    
    
    public static void LoadTermandCondition(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try
    	 {
    		 
    		String startletter=""+request.getParameter("startletter");
 			if("0".equals(startletter))
 				startletter="";
 			String sql="";
 			sql = "SELECT INT_CONDITIONID,CHR_CONDITIONNAME,CHR_DES FROM con_inv_m_terms_conditions WHERE CHR_CONDITIONNAME LIKE '"+startletter+"%'    ORDER BY CHR_CONDITIONNAME ";
 			
 			StringBuffer sb = new StringBuffer();
 			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 			if (readData.length > 0)
 	 		{	
 	 			for(int u=0; u<readData.length;u++)
 	 			{	
 	 				sb.append("<Term>");
 	 				sb.append("<Termid>" + readData[u][0]+ "</Termid>"); 
 	 				sb.append("<Termname>" + readData[u][1]+ "</Termname>");
 	 				sb.append("<Description>" + readData[u][2]+ "</Description>");
 	 				sb.append("</Term>");	       
 	 			}
 	 			response.setContentType("text/xml");
 	            response.setHeader("Cache-Control", "no-cache");
 		        response.getWriter().write("<Terms>" + sb.toString() + "</Terms>");
 			} 
 	 		else 
 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
 			
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }
    
    public static void LoadPayment(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try
    	 {
    		 
    		String startletter=""+request.getParameter("startletter");
 			if("0".equals(startletter))
 				startletter="";
 			String sql="";
 			sql = "SELECT INT_PAYMENTMODEID,CHR_PAYMENTNAME,CHR_DES FROM con_inv_m_paymentmode WHERE CHR_PAYMENTNAME LIKE  '"+startletter+"%'    ORDER BY CHR_PAYMENTNAME ";
 			StringBuffer sb = new StringBuffer();
 			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 			if (readData.length > 0)
 	 		{	
 	 			for(int u=0; u<readData.length;u++)
 	 			{	
 	 				sb.append("<Payment>");
 	 				sb.append("<Paymentid>" + readData[u][0]+ "</Paymentid>"); 
 	 				sb.append("<Paymentname>" + readData[u][1]+ "</Paymentname>");
 	 				sb.append("<Description>" + readData[u][2]+ "</Description>");
 	 				sb.append("</Payment>");	       
 	 			}
 	 			response.setContentType("text/xml");
 	            response.setHeader("Cache-Control", "no-cache");
 		        response.getWriter().write("<Payments>" + sb.toString() + "</Payments>");
 			} 
 	 		else 
 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
 			
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }
    
    
    
    public static void LoadTax(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try
    	 {
    		 
    		String startletter=""+request.getParameter("startletter");
 			if("0".equals(startletter))
 				startletter="";
 			String sql="";
 			sql = "SELECT INT_TAXID,CHR_TAXNAME,DOU_VALUE,CHR_DES FROM con_inv_m_tax WHERE CHR_TAXNAME LIKE '"+startletter+"%'    ORDER BY CHR_TAXNAME ";
 			StringBuffer sb = new StringBuffer();
 			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 			if (readData.length > 0)
 	 		{	
 	 			for(int u=0; u<readData.length;u++)
 	 			{	
 	 				sb.append("<Tax>");
 	 				sb.append("<Taxid>" + readData[u][0]+ "</Taxid>"); 
 	 				sb.append("<Taxname>" + readData[u][1]+ "</Taxname>");
 	 				sb.append("<Taxvalue>" + readData[u][2]+ "</Taxvalue>");
 	 				sb.append("<Description>" + readData[u][3]+ "</Description>");
 	 				sb.append("</Tax>");	
 	 				
 	 			}
 	 			response.setContentType("text/xml");
 	            response.setHeader("Cache-Control", "no-cache");
 		        response.getWriter().write("<Taxs>" + sb.toString() + "</Taxs>");
 			} 
 	 		else 
 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
 			
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }
    
    public static void LoadBank(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try
    	 {
    		 
    		String startletter=""+request.getParameter("startletter");
 			if("0".equals(startletter))
 				startletter="";
 			String sql="";
 			sql = "SELECT INT_BANKID,CHR_BANKNAME,CHR_SHORTNAME FROM con_inv_m_bankname WHERE  CHR_BANKNAME LIKE '"+startletter+"%'    ORDER BY CHR_BANKNAME ";
 			StringBuffer sb = new StringBuffer();
 			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 			if (readData.length > 0)
 	 		{	
 	 			for(int u=0; u<readData.length;u++)
 	 			{	
 	 				sb.append("<Bank>");
 	 				sb.append("<Bankid>" + readData[u][0]+ "</Bankid>"); 
 	 				sb.append("<Bankname>" + readData[u][1]+ "</Bankname>");
 	 				sb.append("<Shortname>" + readData[u][1]+ "</Shortname>");
 	 				sb.append("</Bank>");	
 	 				
 	 			}
 	 			response.setContentType("text/xml");
 	            response.setHeader("Cache-Control", "no-cache");
 		        response.getWriter().write("<Banks>" + sb.toString() + "</Banks>");
 			} 
 	 		else 
 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
 			
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }
    
    public static void LoadBankBranch(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try
    	 {
    		 
    		
 			String startletter=""+request.getParameter("startletter");
 			String bankgroup=""+request.getParameter("bankgroup");
 			
 			if("0".equals(startletter))
 				startletter="";
 			String ssql="";
 			if(!"0".equals(bankgroup))
 				ssql=" AND a.INT_BANKID = "+bankgroup;
 			
 			String sql="";
 			sql = "SELECT a.INT_BANKBRANCHID,b.CHR_SHORTNAME,a.CHR_BRANCH,a.CHR_BRANCHCODE,a.CHR_PHONENO, a.CHR_EMAIL,a.CHR_SWIFTCODE FROM  con_inv_m_bankbranchname a,con_inv_m_bankname b WHERE a.INT_BANKID=b.INT_BANKID AND a.CHR_BRANCH LIKE '"+startletter+"%' "+ssql+" ORDER BY a.CHR_BRANCH ";
 			StringBuffer sb = new StringBuffer();
 			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 			if (readData.length > 0)
 	 		{	
 	 			for(int u=0; u<readData.length;u++)
 	 			{	
 	 				sb.append("<Branch>");
 	 				sb.append("<Branchid>" + readData[u][0]+ "</Branchid>"); 
 	 				sb.append("<Shortname>" + readData[u][1]+ "</Shortname>");
 	 				sb.append("<Branchname>" + readData[u][2]+ "</Branchname>");
 	 				sb.append("<Branchcode>" + readData[u][3]+ "</Branchcode>");
 	 				sb.append("<Phone>" + readData[u][4]+ "</Phone>");
                    sb.append("<Email>" + readData[u][5]+ "</Email>");
                    sb.append("<Swift>" + readData[u][6]+ "</Swift>");
                    sb.append("</Branch>");	
                    
 	 			}
 	 			response.setContentType("text/xml");
 	            response.setHeader("Cache-Control", "no-cache");
 		        response.getWriter().write("<Branchs>" + sb.toString() + "</Branchs>");
 			} 
 	 		else 
 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }
    
    
    public static void LoadDivision(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try
    	 {
    		 
    		String startletter=""+request.getParameter("startletter");
 			if("0".equals(startletter))
 				startletter="";
 			String sql="";
 			sql = " SELECT INT_DIVIID,CHR_DIVISION,CHR_DIVISHORTNAME FROM con_inv_m_division   WHERE CHR_DIVISION LIKE '"+startletter+"%' ORDER BY CHR_DIVISION";
 			StringBuffer sb = new StringBuffer();
 			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 			if (readData.length > 0)
 	 		{	
 	 			for(int u=0; u<readData.length;u++)
 	 			{	
 	 				sb.append("<Divison>");
 	 				sb.append("<Divisonid>" + readData[u][0]+ "</Divisonid>"); 
 	 				sb.append("<DivisonName>" + readData[u][1]+ "</DivisonName>");
                    sb.append("<ShortName>" + readData[u][2]+ "</ShortName>");
                    sb.append("</Divison>");	             
 	 			}
 	 			response.setContentType("text/xml");
 	            response.setHeader("Cache-Control", "no-cache");
 		        response.getWriter().write("<Divisons>" + sb.toString() + "</Divisons>");
 			} 
 	 		else 
 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }	
	
    public static void LoadTargetAssign(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    		 
    		String year= request.getParameter("year");
    		String office= request.getParameter("office");
    		String dept= request.getParameter("dept");
    		String startletter= request.getParameter("startletter");
    		
    		String ssql="";
    		if(!"0".equals(startletter))
    			  ssql=" AND a.CHR_STAFFNAME like '"+startletter+"%'";
    			  
    		String sql="";
       			
    		sql= "SELECT a.CHR_EMPID,a.CHR_STAFFNAME, b.INT_APR, b.INT_MAY, b.INT_JUN, b.INT_JUL, b.INT_AUG, b.INT_SEP, b.INT_OCT, b.INT_NOV, b.INT_DEC, b.INT_JAN, b.INT_FEB, b.INT_MAR,b.INT_TARGETID FROM com_m_staff a , con_ inv_t_targetassign  b ";
    		sql = sql+" WHERE a.CHR_EMPID =b.CHR_EMPID ";
    		sql = sql+ssql;
    		sql = sql+" AND a.INT_OFFICEID="+office+" AND a.INT_DEPARTID="+dept+" AND b.INT_FINANCIALYEARID = "+year+"  ORDER BY a.CHR_STAFFNAME ";
    		String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
   		 	StringBuffer sb = new StringBuffer();
 			if (Data.length > 0)
 	 		{	
 	 			for(int u=0; u<Data.length;u++)
 	 			{	
			 		sb.append("<TargetAssign>");
	   		 		sb.append("<Staffid>" + Data[u][0]+ "</Staffid>");
	   		 		sb.append("<Staffname>" + Data[u][1]+ "</Staffname>");
	   		 		sb.append("<APR>" + Data[u][2]+ "</APR>");
	   		 		sb.append("<MAY>" + Data[u][3]+ "</MAY>");
	   		 		sb.append("<JUN>" + Data[u][4]+ "</JUN>");
	   		 		sb.append("<JUL>" + Data[u][5]+ "</JUL>");
	   		 		sb.append("<AUG>" + Data[u][6]+ "</AUG>");
	   		 		sb.append("<SEP>" + Data[u][7]+ "</SEP>");
	   		 		sb.append("<OCT>" + Data[u][8]+ "</OCT>");
	   		 		sb.append("<NOV>" + Data[u][9]+ "</NOV>");
	   		 		sb.append("<DEC>" + Data[u][10]+ "</DEC>");
	   		 		sb.append("<JAN>" + Data[u][11]+ "</JAN>");
	   		 		sb.append("<FEB>" + Data[u][12]+ "</FEB>");
	   		 		sb.append("<MAR>" + Data[u][13]+ "</MAR>");
	   		 		sb.append("<ROW>" + Data[u][14]+ "</ROW>");
	   		 		sb.append("</TargetAssign>");
	   		 	
	   		 	}
 	 			response.setContentType("text/xml");
 	            response.setHeader("Cache-Control", "no-cache");
 		        response.getWriter().write("<TargetAssigns>" + sb.toString() + "</TargetAssigns>");
 			} 
 	 		else 
 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }	
	
    
    public static void LoadTCustomerGroup(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try
    	 {
    		 
    		
 			String startletter=""+request.getParameter("startletter");
 			if("0".equals(startletter))
 				startletter="";
 			String sql="";
 			sql = " SELECT INT_CUSTOMERGROUPID,CHR_NAME FROM con_inv_m_customergroup  WHERE CHR_NAME LIKE '"+startletter+"%' ORDER BY CHR_NAME ";
 			StringBuffer sb = new StringBuffer();
 			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 			if (readData.length > 0)
 	 		{	
 	 			for(int u=0; u<readData.length;u++)
 	 			{	
 	 				sb.append("<CustomerGroup>");
 	 				sb.append("<CustomerGroupid>" + readData[u][0]+ "</CustomerGroupid>"); 
 	 				sb.append("<CustomerGroupName>" + readData[u][1]+ "</CustomerGroupName>");
                    sb.append("</CustomerGroup>");	             
 	 			}
 	 			response.setContentType("text/xml");
 	            response.setHeader("Cache-Control", "no-cache");
 		        response.getWriter().write("<CustomerGroups>" + sb.toString() + "</CustomerGroups>");
 			} 
 	 		else 
 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }	
    
    
    public static void LoadVendorGroup(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try
    	 {
    		 
    		
 			String startletter=""+request.getParameter("startletter");
 			if("0".equals(startletter))
 				startletter="";
 			String sql="";
 			sql = " SELECT INT_VENDORGROUPID,CHR_NAME  FROM con_inv_m_vendorsgroup  WHERE CHR_NAME LIKE  '"+startletter+"%' ORDER BY CHR_NAME ";
 			StringBuffer sb = new StringBuffer();
 			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 			if (readData.length > 0)
 	 		{	
 	 			for(int u=0; u<readData.length;u++)
 	 			{	
 	 				sb.append("<VendorGroup>");
 	 				sb.append("<VendorGroupid>" + readData[u][0]+ "</VendorGroupid>"); 
 	 				sb.append("<VendorGroupName>" + readData[u][1]+ "</VendorGroupName>");
                    sb.append("</VendorGroup>");	             
 	 			}
 	 			response.setContentType("text/xml");
 	            response.setHeader("Cache-Control", "no-cache");
 		        response.getWriter().write("<VendorGroups>" + sb.toString() + "</VendorGroups>");
 			} 
 	 		else 
 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }	
    
    public static void LoadCustomer(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try
    	 {
    		HttpSession session = request.getSession();
    		 
    		String stkbranch=""+session.getAttribute("STKBRANCH");
			
 			String startletter=""+request.getParameter("startletter");
 			if("0".equals(startletter))
 				startletter="";
 			String customergroup=""+request.getParameter("customergroup");
 			String csql="";
 			if(!"0".equals(customergroup))
 				csql=" AND INT_CUSTOMERGROUPID="+customergroup;
 			String sql="";
 			sql = " SELECT INT_CUSTOMERID,CHR_CUSTOMERNAME,CHR_MOBILE,CHR_EMAIL,INT_ACTIVE,CHR_CONTACTMOBILE,CHR_CONTACTPERSON,CHR_TIN FROM con_inv_m_customerinfo WHERE INT_BRANCHID="+stkbranch+csql+ " AND CHR_CUSTOMERNAME LIKE  '"+startletter+"%' ORDER BY CHR_CUSTOMERNAME ";
 			StringBuffer sb = new StringBuffer();
 			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 			if (readData.length > 0)
 	 		{	
 	 			for(int u=0; u<readData.length;u++)
 	 			{	
 	 				sb.append("<Customer>");
 	 				sb.append("<Id>" + readData[u][0]+ "</Id>"); 
 	 				sb.append("<Name>" + readData[u][1]+ "</Name>");
 	 				sb.append("<Mobile>" + readData[u][2]+ "</Mobile>");
 	 				sb.append("<Mail>" + readData[u][3]+ "</Mail>");
 	 				if("1".equals(readData[u][4]))
 	 					sb.append("<Active>Active</Active>");
 	 				else
 	 					sb.append("<Active>InActive</Active>");
 	 				sb.append("<Tin>" + readData[u][5]+ "</Tin>");
 	 				sb.append("<Cmobile>" + readData[u][6]+ "</Cmobile>");
 	 				sb.append("<Cperson>" + readData[u][7]+ "</Cperson>");
 	 			    sb.append("</Customer>");
 	 			  
 	 			}
 	 			response.setContentType("text/xml");
 	            response.setHeader("Cache-Control", "no-cache");
 		        response.getWriter().write("<Customers>" + sb.toString() + "</Customers>");
 			} 
 	 		else 
 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }	
    
    
    public static void LoadVendor(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try
    	 {
    		HttpSession session = request.getSession();
    		 
    		String stkbranch=""+session.getAttribute("STKBRANCH");
    		String startletter=""+request.getParameter("startletter");
 			if("0".equals(startletter))
 				startletter="";
 			String vendorgroup=""+request.getParameter("vendorgroup");
 			String csql="";
 			if(!"0".equals(vendorgroup))
 				csql=" AND INT_VENDORGROUPID="+vendorgroup;
 			String sql="";
 			sql = " SELECT INT_VENDORID,CHR_VENDORNAME,CHR_MOBILE,CHR_EMAIL,INT_ACTIVE,CHR_CONTACTMOBILE,CHR_CONTACTPERSON,CHR_TIN FROM con_inv_m_vendorsinfo WHERE INT_BRANCHID="+stkbranch+csql+ " AND CHR_VENDORNAME LIKE  '"+startletter+"%' ORDER BY CHR_VENDORNAME ";
 			StringBuffer sb = new StringBuffer();
 			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 			if (readData.length > 0)
 	 		{	
 	 			for(int u=0; u<readData.length;u++)
 	 			{	
 	 				sb.append("<Customer>");
 	 				sb.append("<Id>" + readData[u][0]+ "</Id>"); 
 	 				sb.append("<Name>" + readData[u][1]+ "</Name>");
 	 				sb.append("<Mobile>" + readData[u][2]+ "</Mobile>");
 	 				sb.append("<Mail>" + readData[u][3]+ "</Mail>");
 	 				if("1".equals(readData[u][4]))
 	 					sb.append("<Active>Active</Active>");
 	 				else
 	 					sb.append("<Active>InActive</Active>");
 	 				sb.append("<Tin>" + readData[u][5]+ "</Tin>");
 	 				sb.append("<Cmobile>" + readData[u][6]+ "</Cmobile>");
 	 				sb.append("<Cperson>" + readData[u][7]+ "</Cperson>");
 	 			    sb.append("</Customer>");
 	 			  
 	 			}
 	 			response.setContentType("text/xml");
 	            response.setHeader("Cache-Control", "no-cache");
 		        response.getWriter().write("<Customers>" + sb.toString() + "</Customers>");
 			} 
 	 		else 
 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }	
    

    public static void ItemProductAssign(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try
    	 {
    		String group=""+request.getParameter("group");
		 	String listid=""+request.getParameter("listid");
		 	HttpSession session = request.getSession();
     		String branch = ""+session.getAttribute("STKBRANCH");
 
 			String sql="";
 			sql = " SELECT INT_ITEMID,CHR_ITEMNAME,CHR_DESC,DOU_PPRICE,DOU_SPRICE FROM con_inv_m_itemlist ";
 			sql = sql +" WHERE INT_ITEMID= "+listid;
 			if(!"0".equals(group))
 				sql = sql +" AND INT_GROUPID= "+group;
 			StringBuffer sb = new StringBuffer();
 			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 			if (readData.length > 0)
 	 		{	
 	 			for(int u=0; u<readData.length;u++)
 	 			{	
 	 				
 	 				sb.append("<Item>");
 	 				sb.append("<ItemId>" + readData[u][0]+ "</ItemId>"); 
 	 				sb.append("<ItemName>" + readData[u][1]+ "</ItemName>");
 	 				sb.append("<ItemDesc>" + readData[u][2]+ "</ItemDesc>");
 	 				sb.append("<ItemPprice>" + readData[u][3]+ "</ItemPprice>");
 	 				sb.append("<ItemSprice>" + readData[u][4]+ "</ItemSprice>");
 	 				sql = "SELECT INT_STOCKINHAND FROM con_inv_t_stock  WHERE INT_BRANCHID="+branch+" AND CHR_ITEMID ="+readData[u][0];
 	 				String stkData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 	 				if(stkData.length>=1)
 	 					sb.append("<ItemStock>" + stkData[0][0]+ "</ItemStock>");
 	 				else
 	 					sb.append("<ItemStock>0</ItemStock>");
 	 				
 	 				
 	 				sql ="SELECT  b.CHR_SHORTNAME  FROM con_inv_m_itemgroup a  ,con_inv_m_unites b WHERE a.INT_UNITID =b.INT_UNITID "; 
 	 				sql = sql + " AND a.INT_GROUPID="+group;
 	 				sb.append("<Itemunit>"+com.my.org.erp.common.CommonFunctions.QueryExecute(sql)[0][0]+"</Itemunit>");
 	 				sb.append("</Item>");
 	 			  
 	 			}
 	 			//ItemId,ItemName,ItemDesc,ItemPprice,ItemSprice
 	 			 
 	 			
 	 			response.setContentType("text/xml");
 	            response.setHeader("Cache-Control", "no-cache");
 		        response.getWriter().write("<Items>" + sb.toString() + "</Items>");
 			} 
 	 		else 
 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }	

    
    
    
    public static void  ItemProductAssignQuotation(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try
    	 {
    		String group=""+request.getParameter("group");
		 	String listid=""+request.getParameter("listid");
		 	
     		
 
 			String sql="";
 			sql = " SELECT INT_ITEMID,CHR_ITEMNAME,CHR_DESC,DOU_PPRICE,DOU_SPRICE FROM con_inv_m_itemlist ";
 			sql = sql +" WHERE INT_ITEMID= "+listid;
 			if(!"0".equals(group))
 				sql = sql +" AND INT_GROUPID= "+group;
 			StringBuffer sb = new StringBuffer();
 			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 			if (readData.length > 0)
 	 		{	
 	 			for(int u=0; u<readData.length;u++)
 	 			{	
 	 				
 	 				sb.append("<Item>");
 	 				sb.append("<ItemId>" + readData[u][0]+ "</ItemId>"); 
 	 				sb.append("<ItemName>" + readData[u][1]+ "</ItemName>");
 	 				sb.append("<ItemDesc>" + readData[u][2]+ "</ItemDesc>");
 	 				sb.append("<ItemPprice>" + readData[u][3]+ "</ItemPprice>");
 	 				sb.append("<ItemSprice>" + readData[u][4]+ "</ItemSprice>");
 	 				sql ="SELECT  b.CHR_SHORTNAME  FROM con_inv_m_itemgroup a  ,con_inv_m_unites b WHERE a.INT_UNITID =b.INT_UNITID "; 
 	 				sql = sql + " AND a.INT_GROUPID="+group;
 	 				sb.append("<Itemunit>"+com.my.org.erp.common.CommonFunctions.QueryExecute(sql)[0][0]+"</Itemunit>");
 	 				sb.append("</Item>");
 	 			  
 	 			}
 	 			
 	 			 
 	 			
 	 			response.setContentType("text/xml");
 	            response.setHeader("Cache-Control", "no-cache");
 		        response.getWriter().write("<Items>" + sb.toString() + "</Items>");
 			} 
 	 		else 
 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }	

    public static void LoadDirectPurchase(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try
    	 {
    		HttpSession session = request.getSession();
     		String branch = ""+session.getAttribute("STKBRANCH");	
    		String division=""+request.getParameter("division");
		 	String vendor=""+request.getParameter("vendor");
		 	String month=""+request.getParameter("month");
		 	String year=""+request.getParameter("year");
		 	String startletter=""+request.getParameter("startletter");
		 	String sql="";
 			sql = " SELECT a.INT_PURCHASEID,a.CHR_PURCHASEREFNUMBER,b.CHR_VENDORNAME,DATE_FORMAT(a.DAT_PURCHSEDATE,'%d-%m-%Y' ),a.DOU_TOTALAMOUNT,a.CHR_PAYMENTSTATUS ";
 			sql = sql +" FROM  con_inv_t_purchase a , con_inv_m_vendorsinfo b";
 			sql = sql +" WHERE a.INT_VENDORID=b.INT_VENDORID ";
 			sql = sql +" AND month(a.DAT_PURCHSEDATE)="+month;
 			sql = sql +" AND YEAR(a.DAT_PURCHSEDATE)="+year;
 			if(!"0".equals(vendor))
 				sql = sql +" AND a.INT_VENDORID="+vendor;

 			if(!"0".equals(division))
 				sql = sql +" AND a.INT_DIVIID="+division;
 			
 			if(!"0".equals(startletter))
 				sql = sql +" AND b.CHR_VENDORNAME LIKE '"+startletter+"%'";
 			sql = sql +" AND a.INT_BRANCHID="+branch;
 			
 			StringBuffer sb = new StringBuffer();
 			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 			if (readData.length > 0)
 	 		{	
 	 			for(int u=0; u<readData.length;u++)
 	 			{	
 	 				sb.append("<Purchase>");
 	 				sb.append("<Purchaseid>" + readData[u][0]+ "</Purchaseid>");
 	 				sb.append("<PurchaseNumber>" + readData[u][1]+ "</PurchaseNumber>"); 
 	 				sb.append("<Vendorname>" + readData[u][2]+ "</Vendorname>");
 	 				sb.append("<Date>" + readData[u][3]+ "</Date>");
 	 				sb.append("<Amount>" + readData[u][4]+ "</Amount>");
 	 				sb.append("<PaymentStatus>" + readData[u][5]+ "</PaymentStatus>");
 	 				sb.append("</Purchase>");
 	 				
 	 			  
 	 			}
 	 			//ItemId,ItemName,ItemDesc,ItemPprice,ItemSprice
 	 			response.setContentType("text/xml");
 	            response.setHeader("Cache-Control", "no-cache");
 		        response.getWriter().write("<Purchases>" + sb.toString() + "</Purchases>");
 			} 
 	 		else 
 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }	
    
    
    public static void LoadStock(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try
    	 {
    		String branch = ""+request.getParameter("branch");	
    		String item=""+request.getParameter("item");
    		String sta=""+request.getParameter("sta");
    		
		 	String sql="SELECT B.CHR_ITEMNAME,A.INT_STOCKINHAND,A.INT_STOCKID,D.CHR_SHORTNAME FROM con_inv_t_stock  A, con_inv_m_itemlist B, con_inv_m_itemgroup C, con_inv_m_unites D where A.CHR_ITEMID= B.INT_ITEMID AND B.INT_GROUPID=C.INT_GROUPID AND C.INT_UNITID=D.INT_UNITID ";
		 	if(!branch.equals("0"))
		 		sql=sql+" AND A.INT_BRANCHID="+branch;

		 	if(!item.equals("0"))
		 		sql=sql+" AND A.CHR_ITEMID="+item;
		 	
		 	if(!sta.equals("0"))
		 		sql=sql+" AND B.CHR_ITEMNAME LIKE %'"+sta+"'";
		 	
		 	sql=sql+" ORDER BY B.CHR_ITEMNAME";
		 	
		 	// System.out.println(""+sql);
		 	StringBuffer sb = new StringBuffer();
 			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 			if (readData.length > 0)
 	 		{	
 	 			for(int u=0; u<readData.length;u++)
 	 			{	
 	 				sb.append("<Stock>");
 	 				sb.append("<itemname>" + readData[u][0]+ "</itemname>");
 	 				sb.append("<stockin>" + readData[u][1]+ "</stockin>"); 
 	 				sb.append("<stockid>" + readData[u][2]+" ("+readData[u][3]+") </stockid>"); 
 	 				sb.append("</Stock>");
 	 				
 	 			  
 	 			}
 	 			//ItemId,ItemName,ItemDesc,ItemPprice,ItemSprice
 	 			response.setContentType("text/xml");
 	            response.setHeader("Cache-Control", "no-cache");
 		        response.getWriter().write("<Stocks>" + sb.toString() + "</Stocks>");
 			} 
 	 		else 
 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }


    public static  void loadCustomer(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException 
    {
		try
		{			
			String txtSer=""+request.getParameter("txtSer");			
			HttpSession session=request.getSession();			
 			String branch=""+session.getAttribute("STKBRANCH");
			String sql="";
			if(txtSer.equals("null") || "".equals(txtSer) )
				sql= "SELECT INT_CUSTOMERID,CHR_CUSTOMERNAME,CHR_LEGALNAME FROM con_inv_m_customerinfo WHERE INT_BRANCHID="+branch+" ORDER BY CHR_CUSTOMERNAME";
			else
				sql= "SELECT INT_CUSTOMERID,CHR_CUSTOMERNAME,CHR_LEGALNAME FROM con_inv_m_customerinfo WHERE INT_BRANCHID="+branch+"  AND CHR_CUSTOMERNAME LIKE '"+txtSer+"%' ORDER BY CHR_CUSTOMERNAME";
			StringBuffer sb = new StringBuffer();
			String readData[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
			if (readData.length > 0)
	 		{	
	 			for(int u=0; u<readData.length;u++)
	 			{	
	 				sb.append("<customer>");
	                sb.append("<id>" + readData[u][0]+ "</id>");
	                sb.append("<customerName>" +  readData[u][1]+ "</customerName>");  
	                sb.append("<leagalName>" + readData[u][2]+ "</leagalName>");	                
	                sb.append("</customer>");	      
	            }
	 			response.setContentType("text/xml");
	            response.setHeader("Cache-Control", "no-cache");
		        response.getWriter().write("<customers>" + sb.toString() + "</customers>");
			} 
	 		else 
	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		}
		catch(Exception e){
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 System.out.println(e.getMessage());
		}
			
	}	
    
    public  static void loadCustomerAddress(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try 
    	 {
    		 
    		 
    		 String tablename = request.getParameter("table"); 
    		 String fieldname= request.getParameter("field"); 
    		 String condition= request.getParameter("condition");
    		 String type= request.getParameter("type");
    		 String added[]= (request.getParameter("added")).split(",");
    		 String addedstring[]= (request.getParameter("addedstring")).split(",");
    		 String id = request.getParameter("id");
    		 String sql ="";
    		 if("0".equals(type))
    			 sql ="SELECT "+fieldname+" FROM "+tablename +" WHERE "+condition +" = '"+id+"'";
    		 else
    			 sql ="SELECT "+fieldname+" FROM "+tablename +" WHERE "+condition +" = "+id;
    		 String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    	     int columcount = com.my.org.erp.common.CommonInfo.intGetColumnCount(sql);
    	     StringBuffer sb = new StringBuffer();
		 	 if(readData.length >0)
		 	 {
		 		 for(int u=0; u<readData.length;u++)
		 		 {
		 			 	sb.append("<Address>");
		 			 	String s="";
		 			 	int g=0;
	     				for(int x=0;x<columcount;x++)
	     				{
	     					if(addedstring[g].equals(""+x))
	     					{	
	     						s= s+added[g]+" : "+readData[u][x]+",";
	     						g= g+1;
	     						 
	     					}
	     					else
	     						s=s+readData[u][x]+",";
	     				}
	     				s=s.replace("?", ",");
	     				sb.append("<A>" + s +"</A>");
	     				sb.append("</Address>");
		    	}	
		 		
		 		response.setContentType("text/xml");
 	     		response.setHeader("Cache-Control", "no-cache");
 	     		response.getWriter().write("<Addresss>" + sb.toString() + "</Addresss>");
 	     	} 
 	     	else 
 	     	{
 	     		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
 	     	}             
		} catch (Exception e) {
			 
			 System.out.println(e.getMessage());
		} 
    }
    
    
    
    public  static void loadDirectSale(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try 
    	 {
    		HttpSession session = request.getSession();
      		String branch = ""+session.getAttribute("STKBRANCH");	
     		String division=""+request.getParameter("division");
 		 	String customer=""+request.getParameter("customer");
 		 	String month=""+request.getParameter("month");
 		 	String year=""+request.getParameter("year");
 		 	String startletter=""+request.getParameter("startletter");
 		 	String sql="";
  			sql = " SELECT a.INT_SALESID,a.CHR_SALESNUMBER,b.CHR_CUSTOMERNAME,DATE_FORMAT(a.DAT_SALEDATE,'%d-%m-%Y' ),a.DOU_TOTALAMOUNT,a.CHR_PAYMENTSTATUS  FROM  con_inv_t_sales a , con_inv_m_customerinfo b WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID  ";
  			sql = sql +" AND month(a.DAT_SALEDATE)="+month;
  			sql = sql +" AND YEAR(a.DAT_SALEDATE)="+year;
  			if(!"0".equals(customer))
  				sql = sql +" AND a.INT_CUSTOMERID="+customer;

  			if(!"0".equals(division))
  				sql = sql +" AND a.INT_DIVIID="+division;
  			
  			if(!"0".equals(startletter))
  				sql = sql +" AND b.CHR_CUSTOMERNAME LIKE '"+startletter+"%'";
  			sql = sql +" AND a.INT_BRANCHID="+branch;
  			
  			StringBuffer sb = new StringBuffer();
  			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
  			if (readData.length > 0)
  	 		{	
  	 			for(int u=0; u<readData.length;u++)
  	 			{	
  	 				sb.append("<Sales>");
  	 				sb.append("<Salesid>" + readData[u][0]+ "</Salesid>");
  	 				sb.append("<SalesNumber>" + readData[u][1]+ "</SalesNumber>"); 
  	 				sb.append("<Cutomername>" + readData[u][2]+ "</Cutomername>");
  	 				sb.append("<Date>" + readData[u][3]+ "</Date>");
  	 				sb.append("<Amount>" + readData[u][4]+ "</Amount>");
  	 				sb.append("<PaymentStatus>" + readData[u][5]+ "</PaymentStatus>");
  	 				sb.append("</Sales>");
  	 				//Saless,Salesid,SalesNumber,Cutomername,Date,Amount,PaymentStatus
  	 			  
  	 			}
  	 			//ItemId,ItemName,ItemDesc,ItemPprice,ItemSprice
  	 			response.setContentType("text/xml");
  	            response.setHeader("Cache-Control", "no-cache");
  		        response.getWriter().write("<Saless>" + sb.toString() + "</Saless>");
  			} 
  	 		else 
  	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);             
		} catch (Exception e) {
			 
			 System.out.println(e.getMessage());
		} 
    }
    
    
    
    
    public  static void LoadQuotation(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try 
    	 {
    		HttpSession session = request.getSession();
      		String branch = ""+session.getAttribute("STKBRANCH");	
     		String division=""+request.getParameter("division");
 		 	String customer=""+request.getParameter("customer");
 		 	String month=""+request.getParameter("month");
 		 	String year=""+request.getParameter("year");
 		 	String startletter=""+request.getParameter("startletter");
 		 	String sql="";
  			sql = " SELECT a.INT_QUOTATIONID,a.CHR_QUOTATIONNUMBER,b.CHR_CUSTOMERNAME,DATE_FORMAT(a.DAT_DATE,'%d-%m-%Y' ),a.DOU_TOTALAMOUNT,a.CHR_STATUS  FROM  con_inv_t_quotation a , con_inv_m_customerinfo b WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID  ";
  			sql = sql +" AND month(a.DAT_DATE)="+month;
  			sql = sql +" AND YEAR(a.DAT_DATE)="+year;
  			if(!"0".equals(customer))
  				sql = sql +" AND a.INT_CUSTOMERID="+customer;

  			if(!"0".equals(division))
  				sql = sql +" AND a.INT_DIVIID="+division;
  			
  			if(!"0".equals(startletter))
  				sql = sql +" AND b.CHR_CUSTOMERNAME LIKE '"+startletter+"%'";
  			sql = sql +" AND a.INT_BRANCHID="+branch;
  			 System.out.println(sql);
  			StringBuffer sb = new StringBuffer();
  			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
  			if (readData.length > 0)
  	 		{	
  	 			for(int u=0; u<readData.length;u++)
  	 			{	
  	 				sb.append("<Quotation>");
  	 				sb.append("<ID>" + readData[u][0]+ "</ID>");
  	 				sb.append("<Number>" + readData[u][1]+ "</Number>"); 
  	 				sb.append("<Cutomername>" + readData[u][2]+ "</Cutomername>");
  	 				sb.append("<Date>" + readData[u][3]+ "</Date>");
  	 				sb.append("<Amount>" + readData[u][4]+ "</Amount>");
  	 				sb.append("<Status>" + readData[u][5]+ "</Status>");
  	 				sb.append("</Quotation>");
  	 				//Saless,Salesid,SalesNumber,Cutomername,Date,Amount,PaymentStatus
  	 			  
  	 			}
  	 			//ItemId,ItemName,ItemDesc,ItemPprice,ItemSprice
  	 			response.setContentType("text/xml");
  	            response.setHeader("Cache-Control", "no-cache");
  		        response.getWriter().write("<Quotations>" + sb.toString() + "</Quotations>");
  			} 
  	 		else 
  	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);             
		} catch (Exception e) {
			 
			 System.out.println(e.getMessage());
		} 
    }
    
    
}
