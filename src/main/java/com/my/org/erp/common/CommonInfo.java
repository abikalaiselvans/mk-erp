package com.my.org.erp.common;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DBConnection.DBCon;
public class CommonInfo   
{	
	
	//Parameter With Connection	
	public static boolean RecordExist(Connection con, String sql)
	{
		//Query in the form of Select count(*) from tablename
		boolean flag=false;
		try
		{		
			Statement st=con.createStatement();
			ResultSet rs;
			rs = st.executeQuery(sql);
			int rcount=0;
			if(rs.next())
				rcount = rs.getInt(1);
			if(rcount > 0)
				flag = true;
			else
				flag =false;		
			return flag;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return flag;
	}
	
	public static String[] EmpidArray() 
	{
	 		 
	 		try {
	 			
	 			Connection co=null;	
	 			DBCon con = new DBCon();
	 			co = con.getConnection();
	 			String sql = "SELECT CHR_EMPID FROM com_m_staff";
	 			String data[][] = com.my.org.erp.common.CommonFunctions.RecordSetArray(co, sql);
	 			String s="";
	 			for(int u=0;u<data.length;u++)
	 			{
	 				sql= "SELECT count(*) from m_user WHERE CHR_EMPID='"+data[u][0]+"'";
	 				if(!com.my.org.erp.common.CommonFunctions.RecordExist(co, sql))
	 				{	
	 					s= s+data[u][0]+",";
	 					//System.out.println(data[u][0]);
	 				}	
	 			}
	 			////System.out.println(s);
	 			String value[] = s.split(",");
	 			return value;
	 			
	 		} 
	 		catch (Exception e) 
	 		{
	 			 
	 			 
	 		}
	 		return null;
	 	}

	
	
	
	
	//Parameter  With out Connection
	public static boolean RecordExist(String sql)
	{
		//Query in the form of Select count(*) from tablename
		boolean flag=false;
		try
		{
		Connection co=null;	
		DBCon con = new DBCon();
		co = con.getConnection();
		Statement st=co.createStatement();
		ResultSet rs;
		rs = st.executeQuery(sql);
		int rcount=0;
		if(rs.next())
			rcount = rs.getInt(1);
		if(rcount > 0)
			flag = true;
		else
			flag =false;
		st.close();
 
		return flag;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return flag;
}
	
public static String stringGetAnySelectField(String sql, String selectfield) 
{
	String stringValue = "";
		try {
				Connection co = null;
				DBCon con = new DBCon();
				co = con.getConnection();
				Statement st = co.createStatement();
				ResultSet rs;
				stringValue = "";
				rs = st.executeQuery(sql);
				
				if (rs.next())
					stringValue = "" + rs.getString(selectfield).trim();
				if(stringValue.equals("") || stringValue.equals("null"))
					stringValue="-";
				return stringValue;
			} catch (Exception e) {
				 System.out.println(e.getMessage());
			}
			return stringValue;
}

public static void SQLUpdate(String sql) 
	{
		try {
				Connection co = null;
				DBCon con = new DBCon();
				co = con.getConnection();
				Statement st = co.createStatement();
				st.executeUpdate(sql);
		
			} catch (Exception e) 
			{
				 System.out.println(e.getMessage());
			}
		
		}
	
public static int intGetAnySelectField(String sql, String selectfield) {
			int stringValue = 0;
			try {

				Connection co = null;
				DBCon con = new DBCon();
				co = con.getConnection();
				Statement st = co.createStatement();
				ResultSet rs;
				rs = st.executeQuery(sql);
				if (rs.next())
					stringValue = Integer.parseInt(rs.getString(selectfield).trim());
				return stringValue;
			} catch (Exception e) {
				 System.out.println(e.getMessage());
				 
			}
			return stringValue;
		}
	 
public static int intGetColumnCount(String sql) {
			int stringValue = 0;
			try {

				Connection co = null;
				DBCon con = new DBCon();
				co = con.getConnection();
				Statement st = co.createStatement();
				ResultSet rs;
				rs = st.executeQuery(sql);
				ResultSetMetaData rsmd = rs.getMetaData();
				if (rs.next())
					stringValue=rsmd.getColumnCount();


				return stringValue;
			} catch (Exception e) {
				 System.out.println(e.getMessage());
				 
			}
			return stringValue;
		}

public static String[][] getTableAllValuesArray(String sql) 
	 {
	 		 
	 		try {

	 			Connection co = null;
	 			DBCon con = new DBCon();
	 			co = con.getConnection();
	 			Statement st = co.createStatement();
	 			ResultSet rs;
	 			rs = st.executeQuery(sql);
	 			ResultSetMetaData rsmd = rs.getMetaData();
	 			int colcount = rsmd.getColumnCount();
	 			int rowcount =0;
	 			while(rs.next())
	 				rowcount = rowcount +1;
	 			String svalue[][] = new String[rowcount][colcount];
	 			rs = st.executeQuery(sql);
	 			int i=0;
	 			while(rs.next())
	 			{	
	 				for(int u=0; u<rsmd.getColumnCount();u++)
	 				{
	 					svalue[i][u] = ""+rs.getString((u+1));
	 					if(svalue[i][u].equals("null")) svalue[i][u]="";
	 				}
	 				i= i+1;
	 				
	 			}		
	 			 
	 			return svalue;
	 		} catch (Exception e) {
	 			 System.out.println(e.getMessage());
	 			 
	 		}
	 		return null;
	 	}

public static String[][] RecordSetArray(String sql) 
	 {
	 		String stringValue[][] ;
		 	try 
		 	{

		 		Connection co = null;
		 		DBCon con = new DBCon();
		 		co = con.getConnection();
		 		Statement st = co.createStatement();
		 		ResultSet rs;
		 		rs = st.executeQuery(sql);
		 		ResultSetMetaData rsmd = rs.getMetaData();
		 		int colcount = rsmd.getColumnCount();
		 		int rowcount =0;
		 		while(rs.next())
		 			rowcount = rowcount +1;
		 		String svalue[][] = new String[rowcount][colcount];
		 		rs = st.executeQuery(sql);
		 		int i=0;
		 		while(rs.next())
		 		{	
		 			for(int u=0; u<rsmd.getColumnCount();u++)
		 			{
		 					svalue[i][u] = ""+rs.getString((u+1));
		 					if(svalue[i][u].equals("null") || svalue[i][u].equals(""))svalue[i][u]="-";
		 			}
		 			i=i+1;
		 				
		 		}		
		 		stringValue = svalue;
		 		return stringValue;
		 		}
		 	catch (Exception e) 
		 	{
		 			 System.out.println(e.getMessage());
		 			 
		 	}
		 	return null;
		 }
	 
public static String[][] KRecordSetArray(String sql) 
	 {
	 		String stringValue[][] ;
		 	try 
		 	{

		 		Connection co = null;
		 		DBCon con = new DBCon();
		 		co = con.getConnection();
		 		Statement st = co.createStatement();
		 		ResultSet rs;
		 		rs = st.executeQuery(sql);
		 		ResultSetMetaData rsmd = rs.getMetaData();
		 		int colcount = rsmd.getColumnCount();
		 		int rowcount =0;
		 		while(rs.next())
		 			rowcount = rowcount +1;
		 		String svalue[][] = new String[rowcount][colcount];
		 		rs = st.executeQuery(sql);
		 		int i=0;
		 		while(rs.next())
		 		{	
		 			for(int u=0; u<rsmd.getColumnCount();u++)
		 			{
		 					svalue[i][u] = ""+rs.getString((u+1));
		 					if(svalue[i][u].equals("null") || svalue[i][u].equals(""))svalue[i][u]="-";
		 			}
		 			
		 			i=i+1;
		 				
		 		}		
		 		stringValue = svalue;
		 		return stringValue;
		 		}
		 	catch (Exception e) 
		 	{
		 			 System.out.println(e.getMessage());
		 			 
		 	}
		 	return null;
		 }
	 
public static String[][] doubleRecordSetArray(String sql) 
	 {
	 		String stringValue[][] ;
		 	try 
		 	{

		 		Connection co = null;
		 		DBCon con = new DBCon();
		 		co = con.getConnection();
		 		Statement st = co.createStatement();
		 		ResultSet rs;
		 		rs = st.executeQuery(sql);
		 		ResultSetMetaData rsmd = rs.getMetaData();
		 		int colcount = rsmd.getColumnCount();
		 		int rowcount =0;
		 		while(rs.next())
		 			rowcount = rowcount +1;
		 		String svalue[][] = new String[rowcount][colcount];
		 		rs = st.executeQuery(sql);
		 		int i=0;
		 		while(rs.next())
		 		{	
		 			for(int u=0; u<rsmd.getColumnCount();u++)
		 			{
		 					svalue[i][u] = ""+rs.getString((u+1));
		 					if(svalue[i][u].equals("null") || svalue[i][u].equals(""))svalue[i][u]="0.0";
		 			}
		 			i= i+1;		 				
		 		} 				 		
		 		stringValue = svalue;
		 		return stringValue;
		 		}
		 	catch (Exception e) 
		 	{
		 		 System.out.println(e.getMessage());		 			 
		 	}
		 	return null;
		 }
	 
public static int intRecordCount(String sql) {
		int rcount = 0;
		try 
		{
				Connection co = null;
				DBCon con = new DBCon();
				co = con.getConnection();
				Statement st = co.createStatement();
				ResultSet rs;
				rs = st.executeQuery(sql);
				rcount =0;
				if(rs.next())
					rcount = rs.getInt(1);
				return rcount;
		} 
		catch (Exception e) {
			 System.out.println(e.getMessage());
		}
			return rcount;
		}
 
public static String[] sortArray(String getArray[],int arraylength) 
 {
 		String stringValue[] ;
 		try 
 		{
 			String svalue[] = new String[arraylength];
 			int alength =svalue.length;
 			svalue = getArray;
 			String temp="";
			for(int i=0; i<alength-1;i++)
			{
				for(int j=i+1; j<alength; j++)
				{
					if(svalue[i].compareToIgnoreCase(svalue[j])>1)
					{	
					  temp = svalue[i];
					  svalue[i]=svalue[j];
					  svalue[j]=temp;
					} 
				}
			}
 			stringValue = svalue;
 			return stringValue;
 			
 		} 
 		catch (Exception e) 
 		{
 			 System.out.println(e.getMessage());
 		}
 		return null;
 	}

public static String stringSortArray(String getArray[],int arraylength) 
 {
 		String stringValue ;
 		try 
 		{
 			String svalue[] = new String[arraylength];
 			int alength =svalue.length;
 			svalue = getArray;
 			String temp="";
			for(int i=0; i<alength-1;i++)
			{
				for(int j=i+1; j<alength; j++)
				{
					if(svalue[i].compareToIgnoreCase(svalue[j])>1)
					{	
					  temp = svalue[i];
					  svalue[i]=svalue[j];
					  svalue[j]=temp;
					} 
				}
			}
			temp="";
			for(int u=0; u<alength; u++)
				temp=temp+svalue[u]+","; 
 			
			stringValue = temp;
 			return stringValue;
 		} 
 		catch (Exception e) 
 		{
 			 System.out.println(e.getMessage());
 		}
 		return null;
 	}

@SuppressWarnings("rawtypes")
public static String callDynamicName(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		String values="";
		try
		{	
			String itm="";
			String desc="";
			String qty="";
			String uprice="";
			String discount="";
			String unitdiscount="";
			String total="";
			Enumeration enums = request.getParameterNames();
			for (; enums.hasMoreElements(); ) 
			{
	            String name = (String)enums.nextElement();
	             
	            if(name.startsWith("item"))
	            {
	            	itm = itm+name+",";
	            	values =values+name+",";
	            }	
	            if(name.startsWith("desc"))
	            {
	            	desc = desc+name+",";
	            	values =values+name+",";
	            }
	            
	            if(name.startsWith("qty"))
	            {	
	            	qty = qty+name+",";
	            	values =values+name+",";
	            }	
	            
	            if(name.startsWith("uprice"))
	            {	
	            	uprice = uprice+name+",";
	            	values =values+name+",";
	            }
	            
	            if(name.startsWith("discount"))
	            {	
	            	discount = discount+name+",";
	            	values =values+name+",";
	            }	
	            if(name.startsWith("unitdiscount"))
	            {	
	            	unitdiscount = unitdiscount+name+",";
	            	values =values+name+",";
	            }	
	            
	            if(name.startsWith("total"))
	            	total = total+name+",";
	            
	        }
			
			String tot[] = total.split(",");
			for (int i=0; i<tot.length; i++) 
				if((tot[i].equals("totals"))||(tot[i].equals("totaldiscount")))
					tot[i]="";
			total="";
			
			for (int i=0; i<tot.length; i++) 
				if(! tot[i].equals(""))
				{	
					total = total +tot[i]+",";
					values =values+tot[i]+",";
				}	
		  
			
			String collect[] = values.split(",");
			int alength =collect.length;
			values = stringSortArray(collect,alength);
		   return values;
		}
		catch(Exception e)
		{
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 System.out.println(e.getMessage());
		}	
		return null;
	}
	
public static StringBuffer ReportWrite(String sql,int columncount)throws IOException 
	{
		 
		try 
		{
			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0)
	 		{	
				sb.append("<Fields>");
				for(int u=0; u<readData.length;u++)
	 			{
	 				sb.append("<Field>");
	 				for(int x=1; x<columncount; x++)
	 					sb.append("<Field"+x+">" +readData[u][x] +"</Field"+x+">");
	 				sb.append("</Field>");	
	 	 		}	
				sb.append("</Fields>");
				
	 		} 
			return sb;		
		}
		catch(Exception e)
		{
			
		}
		return null;
	}
	
public static void ReportWrite(String string, StringBuffer sb) 
	{
		try 
		{
			FileWriter fw = new FileWriter(string);
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write(sb.toString());
			bw.close();
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
		}
		
	}

public static String packageName(String path) 
	{
 		String stringValue = "";
		try {
			if("ATT".equals(path))
			{
				stringValue ="Smart Attendance/";
			}
			if("PAY".equals(path))
			{
				stringValue ="Smart Payroll/";
			}
			if("INV".equals(path))
			{
				stringValue ="Smart Inventory/";
			}
			if("STU".equals(path))
			{
				stringValue ="SmartStudent/";
			}
			if("HRM".equals(path))
			{
				stringValue ="Smart HRM/";
			}
			if("MKT".equals(path))
			{
				stringValue ="Smart Marketing/";
			}
			return stringValue;
			} catch (Exception e) {
				 System.out.println(e.getMessage());
			}
			return stringValue;
		}
 	
}

	
	

