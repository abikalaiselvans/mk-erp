package com.my.org.erp.SmartInventory;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public class CommonReport
{

	public static StringBuffer ReportWrite(String sql,int columncount)throws IOException 
	{
		@SuppressWarnings("unused")
		StringBuffer s;
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

}	