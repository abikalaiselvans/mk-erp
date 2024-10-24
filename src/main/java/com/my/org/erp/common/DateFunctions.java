package com.my.org.erp.common;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
public class DateFunctions 
{
	String[] stringDays = new String[]{ "Sunday","Monday","Tuesday","Wednesday","Thusday", "Friday", "Saturday" };
    private static Calendar cal = Calendar.getInstance();
    private static SimpleDateFormat dateformat=null;
    
    
	public static String  getDate(String fomat)//"dd-MM-yyyy"
	{
		String currentdate="";
		try
		{
			dateformat = new SimpleDateFormat(fomat);  
			Date newDate = new Date();
			String newdate = dateformat.format(newDate);
			currentdate=newdate;
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}
	
	public static String  addDayToCurrentDate(String format,int day)//"dd-MM-yyyy"
	{
		String currentdate="";
		try
		{
			dateformat = new SimpleDateFormat(format);  
			cal = Calendar.getInstance();
			cal.add(Calendar.DATE, day);	 
			String newdate = dateformat.format(cal.getTime());
			currentdate=newdate;
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}
	
	public static String  addDayToGivenDate(String datetime , String format,int day) //"dd-MM-yyyy"
	{
		String currentdate="";
		try
		{
			 
			dateformat = new SimpleDateFormat(format); 
			String date = datetime; 
        	cal = Calendar.getInstance(); 
            cal.setTime(dateformat.parse(date)); 
            cal.add(Calendar.DATE, day);
            String newdate = dateformat.format(cal.getTime()) ; 
            currentdate=newdate;
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}
	
	public static String  subtractDayToCurrentDate(String format,int day)//"dd-MM-yyyy"
	{
		String currentdate="";
		try
		{
			dateformat = new SimpleDateFormat(format);  
			cal = Calendar.getInstance();
			cal.add(Calendar.DATE, -day);	//Adding 1 day to current date
			String newdate = dateformat.format(cal.getTime());
			currentdate=newdate;
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}
	
	public static String  subtractDayToGivenDate(String datetime , String format,int day) //"dd-MM-yyyy"
	{
		String currentdate="";
		try
		{
			 
			dateformat = new SimpleDateFormat(format); 
			String date = datetime; 
        	cal = Calendar.getInstance(); 
            cal.setTime(dateformat.parse(date)); 
            cal.add(Calendar.DATE, -day);
            String newdate = dateformat.format(cal.getTime()) ; 
            currentdate=newdate;
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}
	
	public static String  addMonthToCurrentDate(String format,int month)//"dd-MM-yyyy"
	{
		String currentdate="";
		try
		{
			dateformat = new SimpleDateFormat(format);  
			cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, month);	 
			String newdate = dateformat.format(cal.getTime());
			currentdate=newdate;
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}

	public static String  addMonthToGivenDate(String datetime , String format,int month) //"dd-MM-yyyy"
	{
		String currentdate="";
		try
		{
			 
			dateformat = new SimpleDateFormat(format); 
			String date = datetime; 
        	cal = Calendar.getInstance(); 
            cal.setTime(dateformat.parse(date)); 
            cal.add(Calendar.MONTH, month);
            String newdate = dateformat.format(cal.getTime()) ; 
            currentdate=newdate;
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}
	
	public static String  subtractMonthToCurrentDate(String format,int month)//"dd-MM-yyyy"
	{
		String currentdate="";
		try
		{
			dateformat = new SimpleDateFormat(format);  
			cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -month);	//Adding 1 month to current date
			String newdate = dateformat.format(cal.getTime());
			currentdate=newdate;
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}
	
	public static String  subtractMonthToGivenDate(String datetime , String format,int month) //"dd-MM-yyyy"
	{
		String currentdate="";
		try
		{
			 
			dateformat = new SimpleDateFormat(format); 
			String date = datetime; 
        	cal = Calendar.getInstance(); 
            cal.setTime(dateformat.parse(date)); 
            cal.add(Calendar.MONTH, -month);
            String newdate = dateformat.format(cal.getTime()) ; 
            currentdate=newdate;
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}
	
	public static String  addYearToCurrentDate(String format,int year)//"dd-MM-yyyy"
	{
		String currentdate="";
		try
		{
			dateformat = new SimpleDateFormat(format);  
			cal = Calendar.getInstance();
			cal.add(Calendar.YEAR, year);	 
			String newdate = dateformat.format(cal.getTime());
			currentdate=newdate;
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}
	
	public static String   addYearToGivenDate(String datetime , String format,int year) //"dd-MM-yyyy"
	{
		String currentdate="";
		try
		{
			 
			dateformat = new SimpleDateFormat(format); 
			String date = datetime; 
        	cal = Calendar.getInstance(); 
            cal.setTime(dateformat.parse(date)); 
            cal.add(Calendar.YEAR, year);
            String newdate = dateformat.format(cal.getTime()) ; 
            currentdate=newdate;
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}
	
	public static String  subtractYearToCurrentDate(String format,int year)//"dd-MM-yyyy"
	{
		String currentdate="";
		try
		{
			dateformat = new SimpleDateFormat(format);  
			cal = Calendar.getInstance();
			cal.add(Calendar.YEAR, -year);	 
			String newdate = dateformat.format(cal.getTime());
			currentdate=newdate;
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}
	public static String  subtractYearToGivenDate(String datetime , String format,int year) 
	{
		String currentdate="";
		try
		{
			 
			dateformat = new SimpleDateFormat(format); 
			String date = datetime; 
        	cal = Calendar.getInstance(); 
            cal.setTime(dateformat.parse(date)); 
            cal.add(Calendar.YEAR, -year);
            String newdate = dateformat.format(cal.getTime()) ; 
            currentdate=newdate;
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}
	
	
	public static String getCurrentDateTime(String format)//"yyyy-MM-dd HH:mm:ss"
	{
		 dateformat = new SimpleDateFormat(format);
	     java.util.Date date = new java.util.Date();
	     String curDate = dateformat.format(date);
	     return curDate;
	}

	
	public static String  addHoursToCurrentDateandTime(String format,int hour)// dd/MM/yyyy hh:mm:ss
	{
		String currentdate="";
		try
		{
			dateformat = new SimpleDateFormat(format);  
			cal = Calendar.getInstance();
			cal.add(Calendar.HOUR, hour);	 
			String newdate = dateformat.format(cal.getTime());
			currentdate=newdate;
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}
	
	public static String  addHoursToGivenDateandTime(String datetime , String format,int hour) //"yyyy-MM-dd HH:mm:ss"
	{
		String currentdate="";
		try
		{
			 
			dateformat = new SimpleDateFormat(format); 
			String date = datetime; 
        	cal = Calendar.getInstance(); 
            cal.setTime(dateformat.parse(date)); 
            cal.add(Calendar.HOUR, hour);
            String newdate = dateformat.format(cal.getTime()) ; 
            currentdate=newdate;
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}
	
	public static String  subtractHoursToCurrentDateandTime(String format,int hour)// dd/MM/yyyy hh:mm:ss
	{
		String currentdate="";
		try
		{
			dateformat = new SimpleDateFormat(format);  
			cal = Calendar.getInstance();
			cal.add(Calendar.HOUR, -hour);	 
			String newdate = dateformat.format(cal.getTime());
			currentdate=newdate;
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}
	
	public static String  subtractHoursToGivenDateandTime(String datetime , String format,int hour) //"yyyy-MM-dd HH:mm:ss"
	{
		String currentdate="";
		try
		{
			 
			dateformat = new SimpleDateFormat(format); 
			String date = datetime; 
        	cal = Calendar.getInstance(); 
            cal.setTime(dateformat.parse(date)); 
            cal.add(Calendar.HOUR, -hour);
            String newdate = dateformat.format(cal.getTime()) ; 
            currentdate=newdate;
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}
	
	public static String  addMinutesToCurrentDateandTime(String format,int minute)// dd/MM/yyyy hh:mm:ss
	{
		String currentdate="";
		try
		{
			dateformat = new SimpleDateFormat(format);  
			cal = Calendar.getInstance();
			cal.add(Calendar.MINUTE, minute); 
			String newdate = dateformat.format(cal.getTime());
			currentdate=newdate;
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}
	
	public static String  addMinutesToGivenDateandTime(String datetime , String format,int minute) //"yyyy-MM-dd HH:mm:ss"
	{
		String currentdate="";
		try
		{
			 
			dateformat = new SimpleDateFormat(format); 
			String date = datetime; 
        	cal = Calendar.getInstance(); 
            cal.setTime(dateformat.parse(date)); 
            cal.add(Calendar.MINUTE, minute); 
            String newdate = dateformat.format(cal.getTime()) ; 
            currentdate=newdate;
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}
	
	public static String  subtractMinutesToCurrentDateandTime(String format,int minute)// dd/MM/yyyy hh:mm:ss
	{
		String currentdate="";
		try
		{
			dateformat = new SimpleDateFormat(format);  
			cal = Calendar.getInstance();
			cal.add(Calendar.MINUTE, -minute);	 
			String newdate = dateformat.format(cal.getTime());
			currentdate=newdate;
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}
	public static String subtractMinutesToGivenDateandTime(String datetime , String format,int minute) //"yyyy-MM-dd HH:mm:ss"
	{
		String currentdate="";
		try
		{
			 
			dateformat = new SimpleDateFormat(format); 
			String date = datetime; 
        	cal = Calendar.getInstance(); 
            cal.setTime(dateformat.parse(date)); 
            cal.add(Calendar.MINUTE, -minute);
            String newdate = dateformat.format(cal.getTime()) ; 
            currentdate=newdate;
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}
	
	public static String  addSecondsToCurrentDateandTime(String format,int second)// dd/MM/yyyy hh:mm:ss
	{
		String currentdate="";
		try
		{
			dateformat = new SimpleDateFormat(format);  
			cal = Calendar.getInstance();
			cal.add(Calendar.SECOND, second);	 
			String newdate = dateformat.format(cal.getTime());
			currentdate=newdate;
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}
	
	public static String  addSecondsToGivenDateandTime(String datetime , String format,int second) //"yyyy-MM-dd HH:mm:ss"
	{
		String currentdate="";
		try
		{
			 
			dateformat = new SimpleDateFormat(format); 
			String date = datetime; 
        	cal = Calendar.getInstance(); 
            cal.setTime(dateformat.parse(date)); 
            cal.add(Calendar.SECOND, second); 
            String newdate = dateformat.format(cal.getTime()) ; 
            currentdate=newdate;
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}
	
	
	public static String  subtractSecondsToCurrentDateandTime(String format,int second)// dd/MM/yyyy hh:mm:ss
	{
		String currentdate="";
		try
		{
			dateformat = new SimpleDateFormat(format);  
			cal = Calendar.getInstance();
			cal.add(Calendar.SECOND, -second);	 
			String newdate = dateformat.format(cal.getTime());
			currentdate=newdate;
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}
	
	public static String subtractSecondsToGivenDateandTime(String datetime , String format,int second) //"yyyy-MM-dd HH:mm:ss"
	{
		String currentdate="";
		try
		{
			 
			dateformat = new SimpleDateFormat(format); 
			String date = datetime; 
        	cal = Calendar.getInstance(); 
            cal.setTime(dateformat.parse(date)); 
            cal.add(Calendar.SECOND, -second); 
            String newdate = dateformat.format(cal.getTime()) ; 
            currentdate=newdate;
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}
	
	public static String  addMinutesToGivenDateandTimethroughSQL(String datetime , String format,int minute) //"yyyy-MM-dd HH:mm:ss"
	{
		String currentdate="";
		try
		{
			String sql = "SELECT TIMESTAMPADD(MINUTE,"+minute+" ,'"+datetime+"');";
			currentdate=com.my.org.erp.common.CommonFunctions.QueryExecute(sql)[0][0];
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}
	
	public static String  subtractMinutesToGivenDateandTimethroughSQL(String datetime , String format,int minute) //"yyyy-MM-dd HH:mm:ss"
	{
		String currentdate="";
		try
		{
			String sql = "SELECT TIMESTAMPADD(MINUTE,-"+minute+" ,'"+datetime+"');";
			currentdate=com.my.org.erp.common.CommonFunctions.QueryExecute(sql)[0][0];
			return currentdate;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return currentdate;
	}
	
	public static String FormateDateSQL(String indate)
    {
        String date = indate.substring(0, 2);
        String month = indate.substring(3, 5);
        String year = indate.substring(6);
        return (new StringBuilder()).append(year).append("-").append(month).append("-").append(date).toString();
    }
	
	public static String FormateDateSys(String indate)
    {
        String data[] = indate.split("-");
        String date = data[2];
        String month = data[1];
        String year = data[0];
        return (new StringBuilder()).append(date).append("-").append(month).append("-").append(year).toString();
    }

	public static String FormateDateSQLTime(String indate)
	{
		 String fdate=indate.substring(0,10);
		 String ftime=indate.substring(10);
		 String date = fdate.substring(0, 2);
		 String month = fdate.substring(3, 5);
		 String year = fdate.substring(6);
		 return (new StringBuilder()).append(year).append("-").append(month).append("-").append(date).append("").append(ftime).toString();
	}
	
	public static String FormateDateSysTime(String indate)
    {
        String fdate=indate.substring(0,10);
        String ftime=indate.substring(10);
        String data[] = fdate.split("-");
        String date = data[2];
        String month = data[1];
        String year = data[0];
        return (new StringBuilder()).append(date).append("-").append(month).append("-").append(year).append("").append(ftime).toString();
    }

	public static int totalDays(int mon, int year)
    {
        int listTotalDays[] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30,31, 30, 31};
        if(year % 4 == 0)
            listTotalDays[2] = 29;
        return listTotalDays[mon];
    }
	 
	
	public static int getMonthNumber(String month1)
    {
        int mon = 0;
        if(month1.equalsIgnoreCase("January"))
            mon = 1;
        else
        if(month1.equalsIgnoreCase("February"))
            mon = 2;
        else
        if(month1.equalsIgnoreCase("March"))
            mon = 3;
        else
        if(month1.equalsIgnoreCase("April"))
            mon = 4;
        else
        if(month1.equalsIgnoreCase("May"))
            mon = 5;
        else
        if(month1.equalsIgnoreCase("June"))
            mon = 6;
        else
        if(month1.equalsIgnoreCase("July"))
            mon = 7;
        else
        if(month1.equalsIgnoreCase("August"))
            mon = 8;
        else
        if(month1.equalsIgnoreCase("September"))
            mon = 9;
        else
        if(month1.equalsIgnoreCase("October"))
            mon = 10;
        else
        if(month1.equalsIgnoreCase("November"))
            mon = 11;
        else
        if(month1.equalsIgnoreCase("December"))
            mon = 12;
        return mon;
    }

    public static String getMonth(int mon)
    {
        String month = "";
        switch(mon)
        {
        case 1: // '\001'
            month = "January";
            break;

        case 2: // '\002'
            month = "February";
            break;

        case 3: // '\003'
            month = "March";
            break;

        case 4: // '\004'
            month = "April";
            break;

        case 5: // '\005'
            month = "May";
            break;

        case 6: // '\006'
            month = "June";
            break;

        case 7: // '\007'
            month = "July";
            break;

        case 8: // '\b'
            month = "August";
            break;

        case 9: // '\t'
            month = "September";
            break;

        case 10: // '\n'
            month = "October";
            break;

        case 11: // '\013'
            month = "November";
            break;

        case 12: // '\f'
            month = "December";
            break;
        }
        return month;
    }

}
