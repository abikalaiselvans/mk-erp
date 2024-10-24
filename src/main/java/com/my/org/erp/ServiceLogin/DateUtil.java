// Decompiled by DJ v3.9.9.91 Copyright 2005 Atanas Neshkov  Date: 10/5/2007 9:50:47 AM
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   DateUtil.java

package com.my.org.erp.ServiceLogin;
 
import java.sql.Date;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import com.my.org.erp.common.CommonInfo;
/**
* @author Mythra Kalaiselvan 
* @SmartERP version 1.2
*/


public class DateUtil
{

    public DateUtil()
    {
    	
    }

    
    public static int dateDiff(Date date1, Date date2)
    {
        calendar.setTimeInMillis(date1.getTime());
        int dFirst = calendar.get(5);
        int mFirst = calendar.get(2);
        int yFirst = calendar.get(1);
        calendar.setTimeInMillis(date2.getTime());
        int dSecond = calendar.get(5);
        int mSecond = calendar.get(2);
        int ySecond = calendar.get(1);
        int noOfDays = (ySecond - yFirst) * 365 + (mSecond - mFirst) * 30 + (dSecond - dFirst);
        return noOfDays;
    }

    
    public static int dateDiff(java.util.Date date1, java.util.Date date2)
    {
        calendar.setTimeInMillis(date1.getTime());
        int dFirst = calendar.get(5);
        int mFirst = calendar.get(2);
        int yFirst = calendar.get(1);
        calendar.setTimeInMillis(date2.getTime());
        int dSecond = calendar.get(5);
        int mSecond = calendar.get(2);
        int ySecond = calendar.get(1);
        int noOfDays = (ySecond - yFirst) * 365 + (mSecond - mFirst) * 30 + (dSecond - dFirst);
        return noOfDays;
    }

    
    public static int dateDiff(String date1, String date2)
    {
        String data1[] = date1.split("-");
        String data2[] = date2.split("-");
        int dFirst = Integer.parseInt(data1[0]);
        int mFirst = Integer.parseInt(data1[1]);
        int yFirst = Integer.parseInt(data1[2]);
        int dSecond = Integer.parseInt(data2[0]);
        int mSecond = Integer.parseInt(data2[1]);
        int ySecond = Integer.parseInt(data2[2]);
        int noOfDays = 0;
        int month = mFirst + 1;
        for(int year = yFirst; month <= mSecond || year < ySecond; month++)
        {
            noOfDays += totalDays(month, yFirst);
            if(year < ySecond && month + 1 > 12)
            {
                year++;
                month = 0;
            }
        }

        if(dSecond == dFirst)
            noOfDays += dSecond;
        else
            noOfDays += dSecond - dFirst;
        return noOfDays;
    }

    
    public static Date getDate(String dateStr)
    {
        int year = getYear(dateStr);
        int month = getMonth(dateStr);
        int dateInt = getDateInt(dateStr);
        calendar.set(year, month, dateInt);
        Date date = new Date(calendar.getTimeInMillis());
        return date;
    }

    
    private static int getYear(String dateStr)
    {
        int index = dateStr.lastIndexOf("-");
        String yearStr = dateStr.substring(index + 1);
        return Integer.parseInt(yearStr);
    }

    
    private static int getDateInt(String dateStr)
    {
        int index = dateStr.indexOf("-");
        String date = dateStr.substring(0, index);
        return Integer.parseInt(date);
    }

    private static int getMonth(String dateStr)
    {
        int firstIndex = dateStr.indexOf("-");
        int secondIndex = dateStr.lastIndexOf("-");
        String monthStr = dateStr.substring(firstIndex + 1, secondIndex);
        return Integer.parseInt(monthStr);
    }

    public static int totalDays(int mon, int year)
    {
        int listTotalDays[] = {
            0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 
            31, 30, 31
        };
        if(year % 4 == 0)
            listTotalDays[2] = 29;
        return listTotalDays[mon];
    }

    public static int getLastday(String monthname, int year)
    {
        int mon = 0;
        if(monthname.equalsIgnoreCase("January"))
            mon = 1;
        else  if(monthname.equalsIgnoreCase("February"))
            mon = 2;
        else  if(monthname.equalsIgnoreCase("March"))
            mon = 3;
        else  if(monthname.equalsIgnoreCase("April"))
            mon = 4;
        else if(monthname.equalsIgnoreCase("May"))
            mon = 5;
        else if(monthname.equalsIgnoreCase("June"))
            mon = 6;
        else  if(monthname.equalsIgnoreCase("July"))
            mon = 7;
        else if(monthname.equalsIgnoreCase("August"))
            mon = 8;
        else  if(monthname.equalsIgnoreCase("September"))
            mon = 9;
        else  if(monthname.equalsIgnoreCase("October"))
            mon = 10;
        else  if(monthname.equalsIgnoreCase("November"))
            mon = 11;
        else  if(monthname.equalsIgnoreCase("December"))
            mon = 12;
         int listTotalDays[] = { 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31   };
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

    
   


    
    
    public static String getMonthNumbers(String shortmontname)
    {
        String mon = "0";
         
        if(shortmontname.equalsIgnoreCase("Jan"))
            mon = "01";
        else
        if(shortmontname.equalsIgnoreCase("Feb"))
            mon = "02";
        else
        if(shortmontname.equalsIgnoreCase("Mar"))
            mon = "03";
        else
        if(shortmontname.equalsIgnoreCase("Apr"))
            mon = "04";
        else
        if(shortmontname.equalsIgnoreCase("May"))
            mon = "05";
        else
        if(shortmontname.equalsIgnoreCase("Jun"))
            mon = "06";
        else
        if(shortmontname.equalsIgnoreCase("Jul"))
            mon = "07";
        else
        if(shortmontname.equalsIgnoreCase("Aug"))
            mon = "08";
        else
        if(shortmontname.equalsIgnoreCase("Sepr"))
            mon = "09";
        else
        if(shortmontname.equalsIgnoreCase("Oct"))
            mon = "10";
        else
        if(shortmontname.equalsIgnoreCase("Nov"))
            mon = "11";
        else
        if(shortmontname.equalsIgnoreCase("Dec"))
            mon = "12";
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

public static String parseDateFormat(String date, String srcFormat,String destFormat) 
{
		
	/*
	 * DateUtil.parseDateFormat("21/10/1977 05:20:00", "dd/MM/yyyy hh:mm", "yyyy-MM-dd hh:mm:ss"));
	 */
			
		SimpleDateFormat dateFormat1 = new SimpleDateFormat(srcFormat);
		SimpleDateFormat dateFormat2 = new SimpleDateFormat(destFormat);
		Date dt = null;
		try 
		{
			dt = (Date)dateFormat1.parse(date);
		} 
		catch (Exception e) 
		{
			return null;
		} 
		return dateFormat2.format(dt);
}
 
    public static String FormateDateSQL(String indate)
    {
    	indate=indate.trim();
    	String date = indate.substring(0, 2);
        String month = indate.substring(3, 5);
        String year = indate.substring(6);
        return (new StringBuilder()).append(year).append("-").append(month).append("-").append(date).toString();
    }
    
    public static String FormateDateSQLFromOne(String indate)
    {
    	indate=indate.trim();
    	String date = "01";
        String month = indate.substring(3, 5);
        String year = indate.substring(6);
        return (new StringBuilder()).append(year).append("-").append(month).append("-").append(date).toString();
    }

    public static String FormateDateandTimeSQL(String indate)
    {
    	indate=indate.trim();
    	String cdate[] = indate.split(" ");
        String cindate = cdate[0];
    	String date = cindate.substring(0, 2);
        String month = cindate.substring(3, 5);
        String year = cindate.substring(6);
        return (new StringBuilder()).append(year).append("-").append(month).append("-").append(date).append(" ").append(cdate[1]).toString();
    }

    public static String FormateDateSys(String indate)
    {
        String data[] = indate.split("-");
        String date = data[2];
        String month = data[1];
        String year = data[0];
        return (new StringBuilder()).append(date).append("-").append(month).append("-").append(year).toString();
    }

    public static String addDate(String dat, int nd)
    {
        String data[] = dat.split("-");
        int y1 = Integer.parseInt(data[0]);
        int m1 = Integer.parseInt(data[1]);
        int d1 = Integer.parseInt(data[2]);
        int tot = totalDays(m1, y1);
        d1 += nd;
        if(d1 > tot)
            if(m1 >= 12)
            {
                m1 = 1;
                y1++;
                d1 = 1;
            } else
            {
                m1++;
                d1 = 1;
            }
        if(d1 < 10 && m1 < 10)
            return (new StringBuilder()).append(y1).append("-0").append(m1).append("-0").append(d1).toString();
        if(d1 < 10)
            return (new StringBuilder()).append(y1).append("-").append(m1).append("-0").append(d1).toString();
        if(m1 < 10)
            return (new StringBuilder()).append(y1).append("-0").append(m1).append("-").append(d1).toString();
        else
            return (new StringBuilder()).append(y1).append("-").append(m1).append("-").append(d1).toString();
    }

    public static void main(String args[])
    {
        //String d1 = "01-11-2006";
        //String d2 = "31-11-2006";
        //System.out.println(d2);
        //System.out.println(d1);
        //System.out.println((new StringBuilder("Diff  ")).append(dateDiff(d1, d2)).toString());
    }

    public static String getCurrentDateTime()
    {
        SimpleDateFormat datetime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        java.util.Date date = new java.util.Date();
        String curDate = datetime.format(date);
        return curDate;
    }

    public static String getCurrentDate()
    {
        SimpleDateFormat datetime = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date date = new java.util.Date();
        String curDate = datetime.format(date);
        return curDate;
    }
    
    public static void setSysdatefromServerDate()
    {
    	Calendar date = Calendar.getInstance();
    	date.set(Calendar.YEAR,Calendar.MONTH,Calendar.DATE,Calendar.HOUR,Calendar.MINUTE,Calendar.SECOND);
    	
    }
     
    
    
    private Date stringToDate() 
    {
        try 
        {
          return (Date) new SimpleDateFormat("yyyy-mm-dd").parse("2008/05/16");
           
        } 
        catch (Exception e) 
        {
          e.printStackTrace();
        }
		return null;
     }
    
    
    public static String getCurrentDBDate()
    {
    	
       String curDate = CommonInfo.stringGetAnySelectField("select DATE_FORMAT(now(),'%Y-%m-%d') as CU_DATE", "CU_DATE");
       return curDate;
    }
    
    public static String getCurrentDBDateTime()
    {
    	
       String curDate =CommonInfo.stringGetAnySelectField("select now() as CU_DATE", "CU_DATE");
       return curDate;
    }

    
    String[] strDays = new String[]{
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thusday",
            "Friday",
            "Saturday"
          };
    private static Calendar calendar = Calendar.getInstance();

}