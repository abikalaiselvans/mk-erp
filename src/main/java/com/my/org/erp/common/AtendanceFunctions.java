package com.my.org.erp.common;
 

 

public class AtendanceFunctions 
{
	
	public static  synchronized void  attendanceMarking(String userid) 
	{
		
		try 
		{
			 
			String bData[][] = CommonFunctions.QueryExecute(" SELECT INT_ATTENDANCEMARK,CHR_ATT_SKIP_CATEGORY FROM  att_m_basicsettings WHERE INT_ID=1 ");
			int day = Integer.parseInt(bData[0][0]);
			String category = bData[0][1];
			String sql = " SELECT DATE_FORMAT(now(),'%Y-%m-%d'),DAY(NOW()),DAYNAME(now()),MONTHNAME(NOW()),YEAR(NOW()),CHR_ATTENDANCEMARK  FROM  m_institution WHERE INT_ID =1 ";
			String Data[][] = CommonFunctions.QueryExecute(sql);
			if("Y".equals(Data[0][5]))
				if(!"Sunday".equals(Data[0][2]))
					if(!CommonFunction.RecordExist("SELECT COUNT(*)  FROM att_t_commonholiday WHERE  DT_HOLIDATE='"+Data[0][0]+"'"))
						if(!CommonFunction.RecordExist("SELECT COUNT(*)  FROM att_t_attendancemarking WHERE  DT_DATE='"+Data[0][0]+"'"))
						{
							sql = " UPDATE att_t_register a,com_m_staff b "; 
							sql = sql+ " SET a.CHR_MORNING"+Data[0][1]+" = 'PRE' ,a.CHR_EVENING"+Data[0][1]+" ='PRE'  ";   
							sql = sql+ " WHERE a.CHR_EMPID = b.CHR_EMPID "; 
							sql = sql+ " AND b.CHR_TYPE!='T' "; 
							sql = sql+ " AND b.CHR_HOLD!='Y' "; 
							sql = sql+ " AND a.CHR_MONTH ='"+Data[0][3]+"'  "; 
							sql = sql+ " AND a.INT_YEAR="+Data[0][4]; 
							if(day >=25)
								sql = sql+ " AND b.CHR_CATEGORY NOT IN( "+category+",0)" ; 
							CommonFunctions.Execute(sql); 
							sql=" INSERT INTO att_t_attendancemarking (DT_DATE,CHR_MONTH,INT_YEAR,CHR_STATUS,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) ";
							sql = sql+ " VALUES ('"+Data[0][0]+"' , '"+Data[0][3]+"',"+Data[0][4]+",'Y','"+userid+"',DATE(NOW()),'Y') ";
							CommonFunctions.Execute(sql);  
						}
				
			
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
			
		}
		
	}
	
	
}
