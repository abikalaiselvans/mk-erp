 
package com.my.org.erp.Date;  
public class Time
{
   private int hour;   
   private int minute; 
   private int second; 
   public Time() throws Exception
   {
      this( 0, 0, 0 ); 
   } 

   
   public Time( int h ) throws Exception
   { 
      this( h, 0, 0 ); 
   } 

   
   public Time( int h, int m ) throws Exception
   { 
      this( h, m, 0 );
   }  

   
   public Time( int h, int m, int s ) throws Exception
   { 
      setTime( h, m, s );
   }  

    
   public Time( Time time ) throws Exception
   {
      this( time.getHour(), time.getMinute(), time.getSecond() );
   } 

   
   public void setTime( int h, int m, int s ) throws Exception
   {
      setHour( h );  
      setMinute( m );
      setSecond( s );
   }

   
   public void setHour( int h ) throws Exception
   { 
      if ( h >= 0 && h < 24 ) 
         hour = h;
      else 
         throw( new Exception() );
   } 

   
   public void setMinute( int m ) throws Exception
   {
      if ( m >= 0 && m < 60 ) 
         minute = m;
      else 
         throw( new Exception() );
   } 

   
   public void setSecond( int s ) throws Exception
   { 
      if ( s >= 0 && s < 60 ) 
         second = s;
      else 
         throw( new Exception() );
   } 

   
   public int getHour() 
   { 
      return hour; 
   } 

    
   public int getMinute() 
   { 
      return minute; 
   }

   
   public int getSecond() 
   { 
      return second; 
   } 

      
   public String toUniversalString()
   {
      return String.format( 
         "%02d:%02d:%02d", getHour(), getMinute(), getSecond() );
   }  

     
   public String toStandardString()
   {
      return String.format( "%d:%02d:%02d %s", 
         ( ( getHour() == 0 || getHour() == 12 ) ? 12 : getHour() % 12 ),
         getMinute(), getSecond(), ( getHour() < 12 ? "AM" : "PM" ) );
   }  
}  

 