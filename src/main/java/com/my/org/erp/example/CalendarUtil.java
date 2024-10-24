package com.my.org.erp.example;

import java.util.Calendar;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.Locale;
import java.text.ParseException;

public class CalendarUtil {

    public static void main(String[] args) throws Exception {
        String string = "January 2, 2010";

        CalendarUtil calendarUtil = new CalendarUtil();

        System.out.println(calendarUtil.getLastDateOfMonth(string));
        System.out.println(calendarUtil.getLastDateOfMonth());
    }

    public Date getLastDateOfMonth() {
        return getLastDateOfMonth(new Date());
    }

    public Date getLastDateOfMonth(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);

        return getLastDateOfMonth(calendar);
    }

    public Date getLastDateOfMonth(Calendar calendar) {
        setCalendarToLastDayOfMonth(calendar);

        return calendar.getTime();
    }

    public Date getLastDateOfMonth(String date) throws ParseException {

        return getLastDateOfMonth(date, "MMMM d, yyyy");
    }

    public Date getLastDateOfMonth(String date, String format) throws ParseException {
        return getLastDateOfMonth(date, format, Locale.US);
    }

    public Date getLastDateOfMonth(String stringDate, String format, Locale locale) throws ParseException {
         Date date = new SimpleDateFormat(format, locale).parse(stringDate);

         return getLastDateOfMonth(date);
    }    

    private static void setCalendarToLastDayOfMonth(Calendar calendar) {
        int lastDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
        calendar.set(Calendar.DAY_OF_MONTH, lastDay);
        calendar.set(Calendar.HOUR, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
    }
}