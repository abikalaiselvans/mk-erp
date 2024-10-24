package com.my.org.erp.menu;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import DBConnection.DBCon;


public class Menu 
{
	
	public  static Map<String, ArrayList<String>> viewpart=new HashMap<String, ArrayList<String>>();
    public  static Map<String,String> urlpart=new HashMap<String, String>();
    static  ResultSet rs;
     
	
	 
	public  static void views() throws Exception
    {
		Connection con = new DBCon().getConnection();     
		PreparedStatement preparedStatement=con.prepareStatement("SELECT CHR_MENUNAME,CHR_MENUDES,CHR_URL FROM m_menu_inventory ORDER BY INT_MENUID");
		rs=preparedStatement.executeQuery();
        String chrmenu="";
        while(rs.next())
        {
        	ArrayList<String> ob=new ArrayList<String>();
            urlpart.put(rs.getString("CHR_MENUNAME"), rs.getString("CHR_URL"));
            if(rs.getString("CHR_MENUDES").equals("Root"))
            {
            	chrmenu=rs.getString("CHR_MENUNAME");
                urlpart.put(rs.getString("CHR_MENUNAME"), rs.getString("CHR_URL"));
                while(rs.next())
                {
                	if(!rs.getString("CHR_MENUDES").equals("Root"))
                    {
                		urlpart.put(rs.getString("CHR_MENUNAME"), rs.getString("CHR_URL"));
                        ob.add(rs.getString("CHR_MENUNAME"));
                    }
                    else
                    {
                             break;
                    }
                 }
                 viewpart.put(chrmenu, ob);
                 rs.previous();
                      
               }
               else
               {
                      urlpart.put(rs.getString("CHR_MENUNAME"), rs.getString("CHR_URL"));
               }
               
            }
            System.out.println(""+viewpart+"\n"+urlpart);
    	}
}
