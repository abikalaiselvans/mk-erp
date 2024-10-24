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

public class CommonFunction   
{	
	
	/*
	 * 
	 * 
	 * 	PreparedStatement ps=con.prepareStatement("INSERT INTO PRODUCT( productid,productname,productprice) values(?,?,?)");
		ps.setInt(1,Integer.parseInt(""+request.getParameter("productid")));
		ps.setString(3,""+request.getParameter("productprice"));
		ps.executeUpdate();
		
		PreparedStatement ps=con.prepareStatement("Update Product set productname='" +request.getParameter("productname")+"' , 	productprice='"+request.getParameter("productprice")+"'  where productid="+(Integer.parseInt(request.getParameter("productid"))) ); 
		ps.executeUpdate();
	 * 
	 * 	PreparedStatement ps=con.prepareStatement("Delete from Product where (productid=?)");
		ps.setInt(1,Integer.parseInt(request.getParameter("productid")));
		ps.executeUpdate();
		
		CallableStatement cs = con.prepareCall("{call  COM_PRO_DEPARTMENT (?,?,?,?,?)}");
		for (int i = 0; i < DepartId.length; i++) 
		{
			cs.setString(1, "DELETE");
			cs.setString(2, DepartId[i]);
			cs.setString(3, "");
			cs.setString(4, "");
			cs.setString(5, "");
			cs.addBatch();
		}
		cs.executeBatch();
		
		DROP PROCEDURE IF EXISTS ` COM_PRO_DEPARTMENT `;
		CREATE PROCEDURE ` COM_PRO_DEPARTMENT `(action varchar(10),depId INT,depName varchar(25),depDes varchar(50), userName varchar(25))
			BEGIN     
     			DECLARE dId INT DEFAULT 1;
     			DECLARE datTime VARCHAR(20);
     			DECLARE curDept CURSOR FOR SELECT MAX(INT_DEPARTID) AS MAXID FROM   com_m_depart  ;     
     			SET datTime=CURRENT_TIMESTAMP();
     			IF action="DELETE" THEN
         				DELETE FROM   com_m_depart   WHERE INT_DEPARTID=depId;        
     			ELSEIF action="INSERT" THEN
        			OPEN curDept;
        			FETCH curDept INTO dId;
        		IF ISNULL(dId) THEN
           				SET dId=0;
        		END IF;
        			SET dId=dId+1;
        			INSERT INTO   com_m_depart   VALUES(dId,depName,depDes,userName,datTime,'Y');
        			CLOSE curDept;
     			ELSEIF action="UPDATE" THEN
        			UPDATE   com_m_depart   SET CHR_DEPARTNAME=depName,CHR_DEPARTDES=depDes,CHR_USRNAME=userName,DT_UPDATEDATE=datTime WHERE INT_DEPARTID=depId;
     			END IF;     
			END;

	 * 
	 */
	String file ="Tomcat 5.0/webapps/SmartCampusWeb/error/error.txt";
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
		co.close();
		  
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


public static void SQLUpdates() 
{
	try {
			Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql = "SELECT CHR_EMPID,CHR_USRNAME,CHR_USRDES FROM m_user WHERE CHR_USRNAME not in('ADMIN')";
			Statement st = co.createStatement();
			 
			ResultSet rs = st.executeQuery(sql);
			while(rs.next())
			{
				String id = ""+rs.getString(1);
				String empid = ""+rs.getString(2);
				int length = id.length();
				String s =id.substring(0,length-4 )+"00"+id.substring(length-4);
			 
				sql = "UPDATE m_user SET CHR_EMPID='"+s+"'  WHERE CHR_USRNAME='"+empid+"'";
				//System.out.println(sql);
				//st1.execute(sql);
				 
				
			}
	
		} catch (Exception e) 
		{
			 System.out.println(e.getMessage());
		}
	
	}

public static boolean ArrayEquals(String a[] , String b[]) 
{
		boolean flag = false;
		try 
		{
			String s="";
			if(a.length == b.length)
			{	
				for(int u=0;u<a.length;u++)
				{
					if(a[u].equals(b[u]))
						s = s+"true"+",";
					else
						s = s+"false"+",";
				}
				if(s.indexOf("false") <0)
					flag =true;
				else
					flag = false;
			}
			else
				//System.out.println("Invalid Array Size...");
			return flag;
		} 
		catch (Exception e)
		{
			 System.out.println(e.getMessage());
		}
		 
		return flag;
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
	 		String stringValue[][] ;
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
	 			stringValue = svalue;
	 			return stringValue;
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
	 

public static double[][] doubleRecordSetArrays(String sql) 
{
		double stringValue[][] ;
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
	 		double svalue[][] = new double[rowcount][colcount];
	 		rs = st.executeQuery(sql);
	 		int i=0;
	 		while(rs.next())
	 		{	
	 			for(int u=0; u<rsmd.getColumnCount();u++)
	 					svalue[i][u] = Double.parseDouble(""+rs.getString((u+1)));
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




public static String[][] doubleRecordSetArraywithCon(Connection co, String sql) 
	 {
	 		String stringValue[][] ;
		 	try 
		 	{
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

public static String[][] intRecordSetArray(String sql) 
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
	 					if(svalue[i][u].equals("null") || svalue[i][u].equals(""))svalue[i][u]="0";
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
// Parameter With Connection
public static int intRecordCount(Connection con,String sql) {
	int rcount = 0;
	try 
	{
			Statement st = con.createStatement();
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
//Parameter With Out Connection
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
public static int intMaxCount(String sql) {
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
			String readData[][] = RecordSetArray(sql);
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



public static void ErrorWrite(String string) 
{
	try 
	{
		String fileName ="../webapps/SmartCampus/error/error.txt";
		/*java.io.FileReader fr = new java.io.FileReader(fileName);
		java.io.BufferedReader br = new java.io.BufferedReader(fr);
		String strfline ="";
		String sline="";	
		while((strfline=br.readLine())!= null )	
		{
			sline=sline +strfline+"\n\n";
		}
		br.close();
		fr.close();
		sline = sline+"\n\n"+string;*/
		FileWriter fw = new FileWriter(fileName);
		BufferedWriter bw = new BufferedWriter(fw);
		bw.write(string);
		bw.close();
		fw.close();
	} 
	catch (Exception e) 
	{
		 System.out.println(e.getMessage());
	}
	
}


public static void ErrorWrite(String path,String string) 
{
	try 
	{
		String fileName =path+"error.txt";
		FileWriter fw = new FileWriter(fileName);
		BufferedWriter bw = new BufferedWriter(fw);
		bw.write(string);
		bw.close();
		fw.close();
	} 
	catch (Exception e) 
	{
		System.out.println(e.getMessage() );
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



	
	

