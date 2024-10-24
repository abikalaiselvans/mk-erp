package com.my.org.erp.JasperReport.FormQ;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import java.sql.ResultSetMetaData;

public class DAO {
	
	
	
public List<HashMap<String,String>> getRecords(String month,String year,int days){
	
	String query="SELECT b.CHR_EMPID,b.CHR_STAFFNAME,b.DT_DOB,c.CHR_DESIGNAME,";
	for(int i=1;i<=days;i++)
		query+="a.CHR_MORNING"+i+", a.CHR_EVENING"+i+",";
	query+="a.CHR_MONTH,a.INT_YEAR FROM att_t_register a, com_m_staff b,com_m_desig c WHERE a.CHR_MONTH=? AND a.INT_YEAR=? AND b.CHR_EMPID =a.CHR_EMPID"; 
    query+=" AND c.INT_DESIGID = b.INT_DESIGID ORDER BY b.CHR_STAFFNAME";
    
	
	ArrayList<HashMap<String,String>> list=new ArrayList<HashMap<String,String>>();
	try {
		PreparedStatement pstmt=com.my.org.erp.JasperReport.JdbcUtil.getJdbcConnection().prepareStatement(query);
	pstmt.setString(1, month);
	pstmt.setString(2, year);
	
	ResultSet rs=pstmt.executeQuery();
	ResultSetMetaData rdata=rs.getMetaData();
	int count=rdata.getColumnCount();
	
	while(rs.next()){
		HashMap<String,String> map=new HashMap<String,String>();
		String []data=new String[2*days];
	for(int i=1,j=0;i<count ;i++){
		
		//System.out.print(rdata.getColumnName(i)+"\t");
		//System.out.print(rdata.getColumnName(i).startsWith("CHR_MORNING")+" "+i+"\t");
		if(!(rdata.getColumnName(i).startsWith("CHR_MORNING") || rdata.getColumnName(i).startsWith("CHR_EVENING"))){
			map.put(rdata.getColumnName(i), rs.getString(i));
		}else{
			data[j++]=rs.getString(i);
		}
			
	}
	map=countHours(data,map);
	System.out.println(map);
	if(map.size()>0)
	list.add(map);
	}
	System.out.println("\n"+list.size()+" "+count);
	
	//System.out.println(rs.getFetchSize());
	}catch(Exception e){
		e.printStackTrace();
	}
    
	return list;
}
public HashMap<String,String> countHours(String[] data,HashMap<String,String> map){
	
	int d=0;
	for(int i=0;i<data.length;i=i+2){
		d=d+1;
		if(("SUN".equals(data[i])) && ("SUN".equals(data[i+1]) ))
			map.put("d"+d, "S");
		else if(("HOL".equals(data[i])) && ("HOL".equals(data[i+1]) ))
			map.put("d"+d, "H");
			
		else if(("LEA".equals(data[i])) && ("LEA".equals(data[i+1]) ))
			map.put("d"+d, "L");
			
		else if(("ABS".equals(data[i])) && ("ABS".equals(data[i+1]) ))
			map.put("d"+d, "A");
		else if(("PRE".equals(data[i])) && ("PRE".equals(data[i+1]) ))
			map.put("d"+d, "8");
		else if("PRE".equals(data[i]) || "PRE".equals(data[i+1]))
			map.put("d"+d, "4");
		else map.put("d"+d, "-");
	}
	//System.out.println("method:"+map);
	return map;
}


}
