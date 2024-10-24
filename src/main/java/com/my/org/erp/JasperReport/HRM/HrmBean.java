package com.my.org.erp.JasperReport.HRM;

import java.util.*;
import java.sql.*;
 

import com.my.org.erp.JasperReport.JdbcUtil;

public class HrmBean {
	
	
	public HashMap getData(String query,String id)
	{
		HashMap map=new HashMap();
		try
		{
			System.out.println("Bean/id:"+id);
			PreparedStatement pstmt=JdbcUtil.getJdbcConnection().prepareStatement(query);
			pstmt.setString(1, id);
			ResultSet rs=pstmt.executeQuery();
			if(rs.next())
			{
				map.put("staffname",rs.getObject("CHR_STAFFNAME") );
				map.put("desig", rs.getObject("CHR_DESIGNAME"));
				map.put("office", rs.getObject("CHR_OFFICENAME"));
				map.put("dept", rs.getObject("CHR_DEPARTNAME"));
				map.put("doj", rs.getObject("DT_DOJCOLLEGE"));
				map.put("ad1", rs.getObject("CHR_SADD1"));
				map.put("ad2", rs.getObject("CHR_SADD2"));
			}
			
			
			String gallowance[][]=getAllowance("SELECT CHR_ACODE,CHR_ANAME  FROM pay_m_allowance WHERE CHR_FLAG='Y' ORDER BY INT_ALLOWANCEID");
			String otherallowance[][]=getAllowance("SELECT CHR_ACODE,CHR_ANAME  FROM pay_m_allowance WHERE CHR_FLAG='N' ORDER BY INT_ALLOWANCEID");
			
			String q="SELECT  app.INT_SALARY,al."+gallowance[0][0]+" c1,al."+gallowance[1][0]+" c2,al."+gallowance[2][0]+" c3,al."+gallowance[3][0]+" c4, (app.INT_SALARY+";
			
			q=getAlowanceQuery(gallowance, q)+" grossallowance,( ";
			q=getAlowanceQuery(otherallowance, q);
			q+=" otherallowance FROM pay_t_allowance al,com_m_staff app WHERE app.CHR_EMPID='"+id+"' AND app.CHR_EMPID=al.CHR_EMPID";
			
			pstmt=JdbcUtil.getJdbcConnection().prepareStatement(q);
			//pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			//System.out.println(q);
			int otheralw=0,gross=0;
			if(rs.next())
			{
				int basic=rs.getInt("INT_SALARY");
				map.put("basic",basic );
				map.put("hra", rs.getInt("c1"));
				map.put("salw", rs.getInt("c2"));
				map.put("galw", rs.getInt("c3"));
				map.put("talw",rs.getInt("c4"));
				gross=rs.getInt("grossallowance");
			}
			map.put("gross", gross);
			String nq="	SELECT FUN_GET_PFAMOUNT(CHR_PF,INT_SALARY) pf,FUN_GET_ESIAMOUNT('STAFF', CHR_ESI, "+map.get("gross")+") esi from com_m_staff WHERE CHR_EMPID =?";
			//System.out.println("nq:"+nq);
			pstmt=JdbcUtil.getJdbcConnection().prepareStatement(nq);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			int pf=0,esi=0;
			if(rs.next())
			{
				pf=rs.getInt("pf");
				esi=rs.getInt("esi");
				System.out.println("esi:"+rs.getInt("esi"));
			}
			map.put("pf", pf);
			map.put("esi", esi);
			int takehome=((Integer)map.get("gross")+otheralw)-((pf)-(esi));
			map.put("cpy", takehome);
			System.out.println("Map:"+map);
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return map;
	}
	
	
	
	public List getData(String query)
	{
		ArrayList data=new ArrayList();
		try
		{
			Statement stmt=JdbcUtil.getJdbcConnection().createStatement();
			ResultSet rs=stmt.executeQuery(query);
			while(rs.next())
			{
				data.add(rs.getString(1));
			}
			rs.close();
			stmt.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return data;
	}
	
	public String[][] getAllowance(String query)throws Exception
	{
		PreparedStatement pstmt=JdbcUtil.getJdbcConnection().prepareCall(query,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
		ResultSet rs=pstmt.executeQuery();
		rs.last();
		int rcount=rs.getRow();
		String str[][]=new String[rcount][2];
		rs.beforeFirst();
		int i=0,j=0;
		while(rs.next())
		{
			j=0;
			str[i][j++]=rs.getString("CHR_ACODE");
			str[i++][j]=rs.getString("CHR_ANAME");
			
		}
		return str;
	}
	
	public String getAlowanceQuery(String alow[][],String q)
	{
		
		for(int i=0;i<alow.length;i++)
			if(i<alow.length-1)
				q+="al."+alow[i][0]+"+";
			else
				q+="al."+alow[i][0]+")";
        return q;
	}
	
}
