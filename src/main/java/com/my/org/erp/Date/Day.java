/*
 * 
 */

package com.my.org.erp.Date;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.TimeZone;
import java.io.Serializable;


    
@SuppressWarnings("serial")
public class Day   implements Comparable, Cloneable, Serializable
{
	protected Calendar  calendar_;
	String[] stringDays = new String[]{ "Sunday","Monday","Tuesday","Wednesday","Thusday", "Friday", "Saturday" };
	private static Calendar cal = Calendar.getInstance();
	private static SimpleDateFormat dateformat=null;
	  
  private void initialize (int year, int month, int dayOfMonth)
  {
    calendar_ = Calendar.getInstance();
    calendar_.setLenient (true);
    calendar_.setFirstDayOfWeek (Calendar.MONDAY);
    calendar_.setTimeZone (TimeZone.getTimeZone ("GMT"));
    set (year, month, dayOfMonth);
  }

    
  public static String displayDate() 
  {
	   Calendar cal = new GregorianCalendar();
	   int month = cal.get(Calendar.MONTH);
	   int year = cal.get(Calendar.YEAR);
	   int day = cal.get(Calendar.DAY_OF_MONTH);
	   String[] strDays = new String[]{"Sunday","Monday", "Tuesday","Wednesday","Thusday","Friday","Saturday"};
	   return strDays[cal.get(Calendar.DAY_OF_WEEK) - 1]+" , "+day + "-" + com.my.org.erp.ServiceLogin.DateUtil.getMonth(month + 1) + "-" + year+"&nbsp;&nbsp;";
  }
  
  public Day (int year, int month, int dayOfMonth)
  {
    initialize (year, month, dayOfMonth);
  }


 
  public Day (int year, int dayOfYear)
  {
    initialize (year, Calendar.JANUARY, 1);
    calendar_.set (Calendar.DAY_OF_YEAR, dayOfYear);
  }
    
   
  public Day()
  {
    // Now (in the currenct locale of the client machine)
    Calendar calendar = Calendar.getInstance();

    // Prune time part
    initialize (calendar.get (Calendar.YEAR),
                calendar.get (Calendar.MONTH),
                calendar.get (Calendar.DAY_OF_MONTH));
  }
    

 
  public Day (Calendar calendar)
  {
    this (calendar.get (Calendar.YEAR),
          calendar.get (Calendar.MONTH),
          calendar.get (Calendar.DAY_OF_MONTH));
  }
    
 
  public Day (Date date)
  {
    // Create a calendar based on given date
    Calendar calendar = Calendar.getInstance();
    calendar.setTime (date);

    // Extract date values and use these only
    initialize (calendar.get (Calendar.YEAR),
                calendar.get (Calendar.MONTH),
                calendar.get (Calendar.DAY_OF_MONTH));
  }



 
  public Day (long time)
  {
    this (new Date (time));
  }
    

 
  public Day (Day day)
  {
    this (day.getYear(), day.getMonth(), day.getDayOfMonth());
  }


  
  public Object clone()
  {
    return new Day (this);
  }


 
  public static Day today()
  {
    return new Day();
  }
        
  public static int todayDate()
  {
	  Calendar calendar = Calendar.getInstance(TimeZone.getDefault());
      return calendar.get(Calendar.DATE); 
  }
        
  
  public static int todayMonth()
  {
	  Calendar calendar = Calendar.getInstance(TimeZone.getDefault());
      return calendar.get(Calendar.MONTH) + 1;
  }

  public static int todayYear()
  {
	  Calendar calendar = Calendar.getInstance(TimeZone.getDefault());
      return calendar.get(Calendar.YEAR);
  }
  
  
  
  public Calendar getCalendar()
  {
    return (Calendar) calendar_.clone();
  }


  
  public Date getDate()
  {
    return getCalendar().getTime();
  }
    
    

 
  public int compareTo (Object object)
  {
    Day day = (Day) object;
    return calendar_.getTime().compareTo (day.calendar_.getTime());
  }

    
 
  public boolean isAfter (Day day)
  {
    return calendar_.after (day.calendar_);
  }

    
 
  public boolean isBefore (Day day)
  {
    return calendar_.before (day.calendar_);
  }



   
  public boolean equals (Day day)
  {
    return calendar_.equals (day.calendar_);
  }


 
  public int hashCode()
  {
    return calendar_.hashCode();
  }
  
  
 
  public void set (int year, int month, int dayOfMonth)
  {
    setYear (year);
    setMonth (month);
    setDayOfMonth (dayOfMonth);
  }
    
    
    
  
  public int getYear()
  {
    return calendar_.get (Calendar.YEAR);
  }



  
  public void setYear (int year)
  {
    calendar_.set (Calendar.YEAR, year);
  }



  
  public int getMonth()
  {
    return calendar_.get (Calendar.MONTH);
  }


  
  
  public int getMonthinNumber()
  {
    // It is tempting to return getMonth() + 1 but this is conceptually
    // wrong, as Calendar month is an enumeration and the values are tags
    // only and can be anything.
    switch (getMonth()) {
      case Calendar.JANUARY   : return 1;
      case Calendar.FEBRUARY  : return 2;
      case Calendar.MARCH     : return 3;                
      case Calendar.APRIL     : return 4;
      case Calendar.MAY       : return 5;                
      case Calendar.JUNE      : return 6;
      case Calendar.JULY      : return 7;                
      case Calendar.AUGUST    : return 8;
      case Calendar.SEPTEMBER : return 9;                
      case Calendar.OCTOBER   : return 10;
      case Calendar.NOVEMBER  : return 11;                
      case Calendar.DECEMBER  : return 12;
    }

    // This will never happen
    return 0;
  }
  
    

  
  public void setMonth (int month)
  {
    calendar_.set (Calendar.MONTH, month);
  }


 
  public int getDayOfMonth()
  {
    return calendar_.get (Calendar.DAY_OF_MONTH);
  }


 
  public void setDayOfMonth (int dayOfMonth)
  {
    calendar_.set (Calendar.DAY_OF_MONTH, dayOfMonth);
  }

 
  public int getDayOfYear()
  {
    return calendar_.get (Calendar.DAY_OF_YEAR);
  }


 
  public int getDayOfWeek()
  {
    return calendar_.get (Calendar.DAY_OF_WEEK);
  }
    

 
  public int getDayNumberOfWeek()
  {
    return getDayOfWeek() == Calendar.SUNDAY ?
                           7 : getDayOfWeek() - Calendar.SUNDAY;
  }
    

    
 
  public int getWeekOfYear()
  {
    return calendar_.get (Calendar.WEEK_OF_YEAR);
  }
    
  
  public void addDays (int nDays)
  {
    calendar_.add (Calendar.DAY_OF_MONTH, nDays);
  }

  

 
  public void subtractDays (int nDays)
  {
    addDays (-nDays);
  }
  

    
  
  public void addMonths (int nMonths)
  {
    calendar_.add (Calendar.MONTH, nMonths);
  }
    

    
  
  public void subtractMonths (int nMonths)
  {
    addMonths (-nMonths);
  }
  

    
  public void addYears (int nYears)
  {
    calendar_.add (Calendar.YEAR, nYears);
  }

    
  public void subtractYears (int nYears)
  {
    addYears (-nYears);
  }
  

    
  public int getDaysInYear()
  {
    return calendar_.getActualMaximum (Calendar.DAY_OF_YEAR);
  }



  public boolean isLeapYear()
  {
    return getDaysInYear() == calendar_.getMaximum (Calendar.DAY_OF_YEAR);
  }


  public static boolean isLeapYear (int year)
  {
    return (new Day (year, Calendar.JANUARY, 1)).isLeapYear();
  }
  

  
  public int getDaysInMonth()
  {
    return calendar_.getActualMaximum (Calendar.DAY_OF_MONTH);
  }

  public static int getDaysInMonth(int month,int year)
  {
    
	  Calendar calendar = Calendar.getInstance();
	  int date = 1;
	  calendar.set(year, month, date);
	  int days = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
	  return days;
    
  }

  
  public static String displayDayname(int date,int month,int year,String option)
  {

	  Calendar calendar = Calendar.getInstance();
	  calendar.set(year, month, date);
	  String[] strDays = new String[]{"Sunday","Monday", "Tuesday","Wednesday","Thusday","Friday","Saturday"};
	  String[] strsDays = new String[]{"SUN","MON", "TUS","WED","THU","FRI","SAT"};
	  if(option =="1")
		  return strDays[calendar.get(Calendar.DAY_OF_WEEK) - 1];
	  else
		  return strsDays[calendar.get(Calendar.DAY_OF_WEEK) - 1];
  }
  
  

  public String getDayName()
  {
    switch (getDayOfWeek()) {
      case Calendar.MONDAY    : return "Monday";
      case Calendar.TUESDAY   : return "Tuesday";        
      case Calendar.WEDNESDAY : return "Wednesday";
      case Calendar.THURSDAY  : return "Thursday";        
      case Calendar.FRIDAY    : return "Friday";
      case Calendar.SATURDAY  : return "Saturday";        
      case Calendar.SUNDAY    : return "Sunday";
    }

    // This will never happen
    return null;
  }
  
  
    
  public int daysBetween (Day day)
  {
    long millisBetween = Math.abs (calendar_.getTime().getTime() -
                                   day.calendar_.getTime().getTime());
    return (int) Math.round (millisBetween / (1000 * 60 * 60 * 24));
  }



  public static Day getNthOfMonth (int n, int dayOfWeek, int month, int year)
    throws ArrayIndexOutOfBoundsException
  {
    // Validate the dayOfWeek argument
    if (dayOfWeek < 0 || dayOfWeek > 6)
      throw new ArrayIndexOutOfBoundsException (dayOfWeek);
    
    Day first = new Day (year, month, 1);
    
    int offset = dayOfWeek - first.getDayOfWeek();
    if (offset < 0) offset = 7 + offset;
    
    int dayNo = (n - 1) * 7 + offset + 1;
    
    return dayNo > first.getDaysInMonth() ? null : new Day (year, month, dayNo);
  }


  
  public static Day getFirstOfMonth (int dayOfWeek, int month, int year)
  {
    return Day.getNthOfMonth (1, dayOfWeek, month, year);
  }
  

  
  public static Day getLastOfMonth (int dayOfWeek, int month, int year)
  {
    Day day = Day.getNthOfMonth (5, dayOfWeek, month, year);
    return day != null ? day : Day.getNthOfMonth (4, dayOfWeek, month, year);
  }

  

  public String toString()
  {
    StringBuffer string = new StringBuffer();        

    if (getDayOfMonth() < 10) string.append ('0');
    string.append (getDayOfMonth());
    string.append ('/');
    if (getMonth() < 9) string.append ('0');
    string.append (getMonth()+1);
    string.append ('-');
    string.append (getYear());
    string.append (" ");
    string.append (getDayName());        

    return string.toString();
  }


  
  
  /*java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("yyyy-MM-dd");
	java.util.Date date = new java.util.Date();
	String updatedate = "" + datetime.format(date);
	String month = DateUtil.getMonth(date.getMonth() + 1);
	int year = 1900 + date.getYear();*/

  
  
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
  
  

	public int getSundays(int month,int year)
  {
		int count=0;
		Calendar calendar=Calendar.getInstance();
		calendar.set(year, month,1);
		int days = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);

		for(int i=1;i<=days;i++)
		{
          calendar.set(year, month, i);
          if(calendar.get(Calendar.DAY_OF_WEEK)==Calendar.SUNDAY )
          	count++        ;
   	} 
		
		return count;
  }
  
  
  
  public static String  getMonthandYearBetweenTwoDateInSQLFormat(String fromdate, String todate) 
  {
  	 
  	try 
  	{
  		 
  		@SuppressWarnings("unused")
		String sql="";
  		String svalue="";
  		int i=0;
  		do
  		{
  			sql = " select  MONTHNAME(DATE_FORMAT(DATE_ADD('"+fromdate+"', INTERVAL "+i+" MONTH),'%Y-%m-%d')), YEAR(DATE_FORMAT(DATE_ADD('"+fromdate+"', INTERVAL "+i+" MONTH),'%Y-%m-%d')) ,MONTHNAME('"+todate+"'),year('"+todate+"')";
  			String data1[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
  			svalue=svalue+data1[0][0]+","+data1[0][1]+",~";
  			if((data1[0][0].equals(data1[0][2])) && (data1[0][1].equals(data1[0][3])))
  	  			break;
  			else
  				i=i+1;
  			
  		}
  		while(true);

  		
  		 
  		return svalue;
  	}
  	catch (Exception e) 
  	{
  		  System.out.println(e.getMessage());
  	}
  	return null;
  }

  
  
  
  
  
  
  


  
}

