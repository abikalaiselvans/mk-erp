package com.my.org.erp.common;


 


public class SalaryFunctions 
{

	public static void salaryBand(String userid,String staffid,double gross ,String type)
	{
		 
		try
		{
			
			
			String AllowanceData[][] =CommonFunctions.QueryExecute("SELECT INT_ALLOWANCEID,CHR_ACODE,CHR_ANAME FROM  pay_m_allowance WHERE CHR_FLAG='Y' ORDER BY INT_ALLOWANCEID");
			String recoveryData[][] =CommonFunctions.QueryExecute("  SELECT CHR_RCODE FROM pay_m_recovery  ORDER BY  INT_RECOVERYID ");
			String sql ="";
			if("Y".equals(CommonFunctions.QueryExecute("SELECT  CHR_FLAG FROM com_m_stafftype WHERE CHR_TYPENAME='"+type+"'")[0][0]))
			{
				String salaryData[][] =CommonFunctions.QueryExecute(" SELECT INT_SALARYBANDID,INT_STARTINGSALARY,INT_ENDINGSALARY,CHR_SPLITUPIN FROM  pay_m_salaryband  ORDER BY INT_SALARYBANDID ");
				int rowid=0;
				boolean flag = false;
				 
				for(int u=0; u<salaryData.length;u++)
					if( ((int)gross >=Integer.parseInt(salaryData[u][1])) && ((int)gross <=Integer.parseInt(salaryData[u][2]) ) )
					{	 
						rowid = Integer.parseInt(salaryData[u][0]);
						flag = true;
						 
					}
			 
				if(!flag)
					System.out.println("Salary Band not available for the gross Rs."+gross);
				
				if(flag)
				{
										
				 	String salaryband="";
				 	salaryband=" SELECT ("+gross+" *(INT_BASIC/100)) , ";
				 	
					for(int u=0; u<AllowanceData.length;u++)
						salaryband = salaryband+"("+gross+" * ( "+AllowanceData[u][1]+"/100) ) , ";
					salaryband=salaryband.trim();
					salaryband = salaryband.substring(0,salaryband.length()-1);
					salaryband = salaryband+"  FROM  pay_m_salaryband  WHERE INT_SALARYBANDID= "+rowid;
				  
					  
					String Data[][] =CommonFunctions.QueryExecute(salaryband);
					
					
					 
					
					//Updation for Basic 
					sql =" UPDATE com_m_staff  SET INT_SALARY="+Data[0][0]+" WHERE CHR_EMPID='"+staffid+"'";
					CommonFunctions.Execute(sql);
					
					 
					
					//insert into Allowance data
					sql=" INSERT  INTO pay_t_allowance  ( CHR_EMPID , ";
					for(int u=0; u<AllowanceData.length;u++)
						sql = sql+AllowanceData[u][1]+", ";
					
					sql= sql +" DAT_EFFECT,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ) VALUES ( ";
					 
					sql = sql+" '"+staffid+"' , ";
					for(int u=0; u<AllowanceData.length;u++)
						sql = sql+Data[0][(u+1)]+", ";
					sql = sql+" now(),'"+userid+"',DATE(NOW()),'Y' ";
					sql = sql + " )";
					System.out.println(sql);
					CommonFunctions.Execute(sql);
					 
					
					
					 //Insert into recovery Values
					sql=" INSERT  INTO pay_t_recovery  ( CHR_EMPID , ";
					for(int u=0; u<recoveryData.length;u++)
						sql = sql+recoveryData[u][0]+", ";
					
					sql= sql +" DAT_EFFECT ,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES ( ";
					 
					sql = sql+" '"+staffid+"' , ";
					for(int u=0; u<recoveryData.length;u++)
						sql = sql+"0, ";
					sql = sql+" now() ,'"+userid+"',DATE(NOW()),'Y'";
					sql = sql + " )";
					System.out.println(sql);
					CommonFunctions.Execute(sql);
				}
			}
			else
			{
				//Updation for Basic 
				CommonFunctions.Execute(" UPDATE com_m_staff  SET INT_SALARY="+gross+" WHERE CHR_EMPID='"+staffid+"'");
			
				
				//insert into Allowance data
				sql=" INSERT  INTO pay_t_allowance  ( CHR_EMPID , ";
				for(int u=0; u<AllowanceData.length;u++)
					sql = sql+AllowanceData[u][1]+", ";
				
				sql= sql +" DAT_EFFECT ,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ) VALUES ( ";
				 
				sql = sql+" '"+staffid+"' , ";
				for(int u=0; u<AllowanceData.length;u++)
					sql = sql+" 0 , ";
				sql = sql+" now(),'"+userid+"',DATE(NOW()),'Y' ";
				sql = sql + " )";
				CommonFunctions.Execute(sql);
				
				 //Insert into recovery Values
				sql=" INSERT  INTO pay_t_recovery  ( CHR_EMPID , ";
				for(int u=0; u<recoveryData.length;u++)
					sql = sql+recoveryData[u][0]+", ";
				
				sql= sql +" DAT_EFFECT ,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ) VALUES ( ";
				 
				sql = sql+" '"+staffid+"' , ";
				for(int u=0; u<recoveryData.length;u++)
					sql = sql+"0, ";
				sql = sql+" now(),'"+userid+"',DATE(NOW()),'Y' ";
				sql = sql + " )";
				CommonFunctions.Execute(sql);
			}
			
			 
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		 
	}
	
	
	
	public static double salaryBandBasic(double gross)
	{
		double basic=0.0;
		try
		{
			int grosslimit = Integer.parseInt(CommonFunctions.QueryExecute("SELECT INT_GROSSLIMIT FROM m_institution  WHERE INT_ID=1")[0][0]);
			int minimumwageslimit = Integer.parseInt(CommonFunctions.QueryExecute("SELECT INT_PFLIMITMINIMUM FROM m_institution  WHERE INT_ID=1")[0][0]);
			String salaryData[][] =CommonFunctions.QueryExecute(" SELECT INT_SALARYBANDID,INT_STARTINGSALARY,INT_ENDINGSALARY,CHR_SPLITUPIN FROM  pay_m_salaryband  ORDER BY INT_SALARYBANDID ");
			int rowid=0;
			boolean flag = false;
		 
			for(int u=0; u<salaryData.length;u++)
			{
				if( ((int)gross >=Integer.parseInt(salaryData[u][1])) && ((int)gross <=Integer.parseInt(salaryData[u][2]) ) )
				{	 
					rowid = Integer.parseInt(salaryData[u][0]);
					flag = true;
				}
			}
			if(flag)
			{
				String salaryband="";
			 	if(gross <=grosslimit)
			 		salaryband=" SELECT ("+minimumwageslimit+" )  ,";
			 	else
			 		salaryband=" SELECT ("+gross+" *(INT_BASIC/100))  ,";
				salaryband=salaryband.trim();
				salaryband = salaryband.substring(0,salaryband.length()-1);
				salaryband = salaryband+"  FROM  pay_m_salaryband  WHERE INT_SALARYBANDID= "+rowid;
				// System.out.println(salaryband);
				String Data[][] =CommonFunctions.QueryExecute(salaryband);
				basic = Double.parseDouble(Data[0][0]);
				return basic; 
			}
		}
		catch(Exception e)
		{
		}
		return basic;
	}
	
	
	public static void salaryBandInVariableAllowance(String staffid,double gross,double newvariable)
	{
		 
		try
		{
			 
			String AllowanceData[][] =CommonFunctions.QueryExecute("SELECT INT_ALLOWANCEID,CHR_ACODE,CHR_ANAME FROM  pay_m_allowance WHERE CHR_FLAG='N'  ORDER BY INT_ALLOWANCEID");
			String sql ="";
			String salaryData[][] =CommonFunctions.QueryExecute(" SELECT INT_SALARYBANDID,INT_STARTINGSALARY,INT_ENDINGSALARY,CHR_SPLITUPIN FROM  pay_m_salaryband  ORDER BY INT_SALARYBANDID ");
			int rowid=0;
			boolean flag = false;
			 
			for(int u=0; u<salaryData.length;u++)
				if( ((int)gross >=Integer.parseInt(salaryData[u][1])) && ((int)gross <=Integer.parseInt(salaryData[u][2]) ) )
				{	 
					rowid = Integer.parseInt(salaryData[u][0]);
					flag = true;
				}
			 
				 
			if(flag)
			{
				String salaryband=" SELECT ";
			 	for(int u=0; u<AllowanceData.length;u++)
					salaryband = salaryband+"("+newvariable+" * ( "+AllowanceData[u][1]+"/100) ) , ";
				salaryband=salaryband.trim();
				salaryband = salaryband.substring(0,salaryband.length()-1);
				salaryband = salaryband+"  FROM  pay_m_salaryband  WHERE INT_SALARYBANDID= "+rowid;
			    String Data[][] =CommonFunctions.QueryExecute(salaryband);
				
				//UPDATE Allowance data
			    sql = " UPDATE pay_t_allowance SET ";
			    	for(int u=0; u<AllowanceData.length;u++)
						sql = sql+AllowanceData[u][1]+" = "+Data[0][u]+" , ";
			    sql = sql + " DAT_EFFECT =DATE(NOW()) WHERE  CHR_EMPID = '"+staffid+"'";
				// System.out.println(sql);
				CommonFunctions.Execute(sql);
				 
			}
			else
			{
				sql = " UPDATE pay_t_allowance SET ";
			    	for(int u=0; u<AllowanceData.length;u++)
						sql = sql+AllowanceData[u][1]+" = 0 , ";
			    sql = sql + " DAT_EFFECT =DATE(NOW()) WHERE  CHR_EMPID = '"+staffid+"'";
				// System.out.println(sql);
				CommonFunctions.Execute(sql);
				 
			}
			
			 
		}
		catch(Exception e)
		{
			 
		}
		 
	}
	
	

	
	
	
	
	
	
	
	
	
	
	public static void offerLetterBand(String applicantid,double gross  )
	{
		 
		try
		{
			
			
			
			
			String AllowanceData[][] =CommonFunctions.QueryExecute("SELECT INT_ALLOWANCEID,CHR_ACODE,CHR_ANAME FROM  pay_m_allowance  ORDER BY INT_ALLOWANCEID");
			String sql ="";
			
			String salaryData[][] =CommonFunctions.QueryExecute(" SELECT INT_SALARYBANDID,INT_STARTINGSALARY,INT_ENDINGSALARY,CHR_SPLITUPIN FROM  pay_m_salaryband  ORDER BY INT_SALARYBANDID ");
			int rowid=0;
			boolean flag = false;
				 
			for(int u=0; u<salaryData.length;u++)
				if( ((int)gross >=Integer.parseInt(salaryData[u][1])) && ((int)gross <=Integer.parseInt(salaryData[u][2]) ) )
				{	 
					rowid = Integer.parseInt(salaryData[u][0]);
					flag = true;
					 
				}
			 
				 
			if(flag)
			{
				String salaryband="";
			 	salaryband=" SELECT ("+gross+" *(INT_BASIC/100)) , ";
			 	
				for(int u=0; u<AllowanceData.length;u++)
					salaryband = salaryband+"("+gross+" * ( "+AllowanceData[u][1]+"/100) ) , ";
				salaryband=salaryband.trim();
				salaryband = salaryband.substring(0,salaryband.length()-1);
				salaryband = salaryband+"  FROM  pay_m_salaryband  WHERE INT_SALARYBANDID= "+rowid;
			  
				System.out.println(salaryband);
				String Data[][] =CommonFunctions.QueryExecute(salaryband);
				
				
				sql=" INSERT  INTO hrm_t_allowance  ( INT_APPID, INT_BASIC, ";
				for(int u=0; u<AllowanceData.length;u++)
					sql = sql+AllowanceData[u][1]+", ";
				
				sql= sql +" DAT_EFFECT ) VALUES ( ";
				 
				sql = sql+" '"+applicantid+"' , "+Data[0][0]+", ";
				for(int u=0; u<AllowanceData.length;u++)
					sql = sql+Data[0][(u+1)]+", ";
				sql = sql+" now() ";
				sql = sql + " )";
				System.out.println();
				System.out.println(sql);
				System.out.println();
				CommonFunctions.Execute(sql);
				 
				 
			}
		 
			
			
			
			 
			 
		}
		catch(Exception e)
		{
			 
		}
		 
	}
	
	
	
	
	
	
	public static void salaryBandManual(String staffid,String basic )
	{
		try
		{
			//CommonFunctions.Execute(" UPDATE com_m_staff  SET INT_SALARY="+basic+" WHERE CHR_EMPID='"+staffid+"'");
			
		}
		catch(Exception e)
		{
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
