package com.my.org.erp.General;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.Locale;
import java.util.Properties;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.DateFormatSymbols;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;



import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import com.my.org.erp.setting.CommonData;

import DBConnection.DBCon;
public class General   
{	
	//jar xf jar-file [archived-file(s)]

	String filedirectory ="../webapps/SmartCampus/ ";
	public static final int MIN_LENGTH = 10;
	protected static java.util.Random r = new java.util.Random();
	protected static char[] goodChar = { 'a', 'b', 'c', 'd', 'e', 'f', 'g',
	      'h', 'j', 'k', 'm', 'n', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
	      'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K',
	      'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
	      '2', '3', '4', '5', '6', '7', '8', '9', '+', '-', '@', };
	
	static final int BUFFER = 2048;
	
	
	public static void unzipFile(String filename)
    {
    	try
    	{
    		 
    		filename="../webapps/SmartCampus/Zip/src.zip";
    		BufferedOutputStream dest = null;
            FileInputStream fis = new 
   	   FileInputStream(filename);
            ZipInputStream zis = new 
   	   ZipInputStream(new BufferedInputStream(fis));
            ZipEntry entry;
            while((entry = zis.getNextEntry()) != null) {
               //System.out.println("Extracting: " +entry);
               int count;
               byte data[] = new byte[BUFFER];
               // write the files to the disk
               FileOutputStream fos = new 
   	      FileOutputStream(entry.getName());
               dest = new 
                 BufferedOutputStream(fos, BUFFER);
               while ((count = zis.read(data, 0, BUFFER)) 
                 != -1) {
                  dest.write(data, 0, count);
               }
               dest.flush();
               dest.close();
            }
            zis.close();
	      
    	} 
    	catch(Exception e)
    	{
    	}
    }
	public static void  zipFile(String filename)
    {
    	try
    	{
	     //java.util.zip.ZipFile f = new java.util.zip.ZipFile(filename);
	      
    	}
    	catch(Exception e)
    	{
    	}
    }
	
	public static void SimpleMail(String from , String to, String subject,String content)
    {
    	try
    	{
	        
    		
	        String host = "192.168.0.5";
	        Properties props = new Properties();
	        props.put("mail.smtp.host", host);
	        props.put("mail.debug", "true");
	        Session sessio  = Session.getInstance(props);
	        Message msg = new MimeMessage(sessio );
	        msg.setFrom(new InternetAddress(from));
	        InternetAddress[] address = {new InternetAddress(to)};
	        msg.setRecipients(Message.RecipientType.TO, address);
	        msg.setSubject(subject);
	        msg.setSentDate(new Date());
	   	 	msg.setText(content);
	   	 	Transport.send(msg);
	   	 	
    	}
    	catch(Exception e)
    	{
    	}
    }
   
    
    public static void SendMail(String title,String filename,String mesg)
   {
       //shari@careind.net
    	String to = CommonData.mailid;
    	
       String from = CommonData.mailid;
       String host = "192.168.0.5";
       Properties props = new Properties();
       props.put("mail.smtp.host", host);
       props.put("mail.debug", "true");
       //System.out.println("1");
       Session session = Session.getInstance(props);
       //select CHR_EMAILID FROM com_m_staff WHERE CHR_EMAILID <> ''
       try {
    	   Transport bus = session.getTransport("smtp");
           bus.connect();
           Message msg = new MimeMessage(session);
           msg.setFrom(new InternetAddress(from));
           InternetAddress[] address = {new InternetAddress(to)};
           msg.setRecipients(Message.RecipientType.TO, address);
           msg.setRecipients(Message.RecipientType.CC,
                               InternetAddress.parse(to, true));
           msg.setRecipients(Message.RecipientType.BCC,
                               InternetAddress.parse(to, false));

           msg.setSubject("Test E-Mail through Java");
           msg.setSentDate(new Date());

           // Set message content and send
           /*setTextContent(msg);
           msg.saveChanges();
           bus.sendMessage(msg, address);

           setMultipartContent(msg);
           msg.saveChanges();
           bus.sendMessage(msg, address);
*/
           setFileAsAttachment(msg, "C:/greetings.gif");
           msg.saveChanges();
           bus.sendMessage(msg, address);
           //System.out.println("file attached");
           setHTMLContent(msg);
           msg.saveChanges();
           bus.sendMessage(msg, address);

           bus.close();


       }
       catch (MessagingException mex) 
       {
          
       }
   }
	
    public static void setTextContent(Message msg) throws MessagingException {
        String mytxt = "This is a test of sending a " +
                        "plain text e-mail through Java.\n" +
                        "Here is line 2.";
        msg.setText(mytxt);
        msg.setContent(mytxt, "text/plain");

}


    public static void setMultipartContent(Message msg) throws MessagingException 
    {
        MimeBodyPart p1 = new MimeBodyPart();
        p1.setText("This is part one of a test multipart e-mail.");
        MimeBodyPart p2 = new MimeBodyPart();
        p2.setText("This is the second part", "us-ascii");
        Multipart mp = new MimeMultipart();
        mp.addBodyPart(p1);
        mp.addBodyPart(p2);
        msg.setContent(mp);
    }

    public static void setFileAsAttachment(Message msg, String filename) throws MessagingException 
    {
    	//System.out.println(filename);
    	MimeBodyPart p1 = new MimeBodyPart();
		p1.setText("This is file as an attachment");
		MimeBodyPart p2 = new MimeBodyPart();
		FileDataSource fds = new FileDataSource(filename);
		p2.setDataHandler(new DataHandler(fds));
		p2.setFileName(fds.getName());
		Multipart mp = new MimeMultipart();
		mp.addBodyPart(p1);
		mp.addBodyPart(p2);
		msg.setContent(mp);
	}

    public static void setHTMLContent(Message msg) throws MessagingException 
    {

        String html = "<html><head><title>" +
                        msg.getSubject() +
                        "</title></head><body  onpaste='return false;'><h1>" +
                        msg.getSubject() +
                        "</h1><p>This is a test of sending an HTML e-mail" +
                        " through Java.</body></html>";

        msg.setDataHandler(new DataHandler(new HTMLDataSource(html)));
    }

    static class HTMLDataSource implements DataSource 
    {
        private String html;
        public HTMLDataSource(String htmlString) 
        {
            html = htmlString;
        }

        public InputStream getInputStream() throws IOException {
            if (html == null) throw new IOException("Null HTML");
            return new ByteArrayInputStream(html.getBytes());
        }

        public OutputStream getOutputStream() throws IOException {
            throw new IOException("This DataHandler cannot write HTML");
        }

        public String getContentType() {
            return "text/html";
        }

        public String getName() {
            return "JAF text/html dataSource to send e-mail only";
        }
    }

    
	public static boolean packageExpired() 
	{
		boolean stringValue = false;
		try 
		{
			String sql = "SELECT DATEDIFF( '2007-10-31',(select date(now())))";
			String d[][]= com.my.org.erp.common.CommonFunction.intRecordSetArray(sql);	
			if((Integer.parseInt(d[0][0])>1) && (Integer.parseInt(d[0][0])<60))
				stringValue = true;
			else
				stringValue = false;
			return stringValue;
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());
		}
			return stringValue;
		}

	
	//Deleting file 
	public static void fileDelete(String fileName) 
	{
		try 
		{
			File f = new File(fileName);
		    if (!f.exists())
		      throw new IllegalArgumentException(
		          "Delete: no such file or directory: " + fileName);
		    if (!f.canWrite())
		      throw new IllegalArgumentException("Delete: write protected: "
		          + fileName);
		    if (f.isDirectory()) 
		    {
		      String[] files = f.list();
		      if (files.length > 0)
		        throw new IllegalArgumentException(
		            "Delete: directory not empty: " + fileName);
		    }
		    boolean success = f.delete();
		    if (!success)
		      throw new IllegalArgumentException("Delete: deletion failed");
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());
		}
			
	}
	
	//copyDirectory
	public static void copyDirectory(File srcPath, File dstPath) throws IOException
	{
		if (srcPath.isDirectory())
		{
			if (!dstPath.exists())
			{
				dstPath.mkdir();
			}

			String files[] = srcPath.list();
			for(int i = 0; i < files.length; i++)
			{
				copyDirectory(new File(srcPath, files[i]), new File(dstPath, files[i]));
			}
		}
		else
		{
			if(!srcPath.exists())
			{
				//System.out.println("File or directory does not exist.");
				System.exit(0);
			}
			else
			{
				InputStream in = new FileInputStream(srcPath);
		        OutputStream out = new FileOutputStream(dstPath);
    
				// Transfer bytes from in to out
		        byte[] buf = new byte[1024];
				int len;
		        while ((len = in.read(buf)) > 0) {
					out.write(buf, 0, len);
				}
				in.close();
		        out.close();
			}
		}
		//System.out.println("Directory copied.");
	}
	
	
	public static boolean deleteDir(File dir) 
	{
        boolean flag = false;
		try 
		{
			if (dir.isDirectory()) 
			{
			    String[] children = dir.list();
			    for (int i=0; i<children.length; i++) 
			    {
			        boolean success = deleteDir(new File(dir, children[i]));
			        if (!success) 
			        {
			            return false;
			        }
			    }
			}
		} 
		catch (RuntimeException e) 
		{
			 System.out.println(e.getMessage());
		}
		return flag;
    }

	public static String[][] birthDay()
	{
		
		try 
		{
			String sql= "SELECT b.CHR_COMPANYNAME,c.CHR_BRANCHNAME,a.CHR_STAFFNAME,a.CHR_EMPID,CHR_MOBILE ,CHR_EMAILID ";
			sql = sql +" FROM  com_m_staff a ,com_m_company b, com_m_branch c WHERE a.INT_BRANCHID = c.INT_BRANCHID ";
			sql = sql +" AND a.INT_COMPANYID = b.INT_COMPANYID AND day(DT_DOB)  = (select day(now())) ";
			sql = sql +" AND MONTH(DT_DOB) =(select month(now())) ";
			String birthdata[][] =com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
			return birthdata;
		} 
		
		catch (RuntimeException e) 
		{
			 System.out.println(e.getMessage());
		}
		return null;	
	}
	
	 public static void copy(String fromFileName, String toFileName)  throws IOException 
	 {
		 File fromFile = new File(fromFileName);
		 File toFile = new File(toFileName);
		 
		 if (!fromFile.exists()) throw new IOException("FileCopy: " + "no such source file: "+ fromFileName);
		 
		 if (!fromFile.isFile()) throw new IOException("FileCopy: " + "can't copy directory: " + fromFileName);
		 
		 if (!fromFile.canRead())throw new IOException("FileCopy: " + "source file is unreadable: " + fromFileName);

		 if (toFile.isDirectory())
			 toFile = new File(toFile, fromFile.getName());

		 /*if (toFile.exists()) 
		 {
			 if (!toFile.canWrite())  throw new IOException("FileCopy: "  + "destination file is unwriteable: " + toFileName); //System.out.print("Overwrite existing file " + toFile.getName() + "? (Y/N): ");
			 System.out.flush();
			 BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
			 String response = in.readLine();
			 if (!response.equals("Y") && !response.equals("y")) throw new IOException("FileCopy: "  + "existing file was not overwritten.");
		} 
		else*/ 
		{
			String parent = toFile.getParent();
			if (parent == null)
				parent = System.getProperty("user.dir");
			File dir = new File(parent);
			if (!dir.exists()) throw new IOException("FileCopy: " + "destination directory doesn't exist: " + parent);
			if (dir.isFile())  throw new IOException("FileCopy: " + "destination is not a directory: " + parent);
			if (!dir.canWrite())throw new IOException("FileCopy: "+ "destination directory is unwriteable: " + parent);
		}

		 FileInputStream from = null;
		 FileOutputStream to = null;
		 try 
		 {
			 from = new FileInputStream(fromFile);
			 to = new FileOutputStream(toFile);
			 byte[] buffer = new byte[4096];
			 int bytesRead;

			 while ((bytesRead = from.read(buffer)) != -1)
				 to.write(buffer, 0, bytesRead); // write
		 } 
		 finally 
		 {
			 if (from != null)
			 try 
			 {
					 from.close();
			 } 
			 catch (IOException e) 
			 {
				 ;
			 }
			 if (to != null)
			 try 
			 {
				 to.close();
			 } 
			 catch (IOException e) 
			 {
				 ;
			 }
		 }
	 }
	 
	 public static String  passwodGenerate()   
	 {
		String s;
		try 
		{
			s=getNextPassword();
			return s;
		} 
		catch (RuntimeException e) 
		{
			 System.out.println(e.getMessage());
		}
		return null;
	 }
	 
	 public static String getNextPassword() 
	 {
	    StringBuffer sb = new StringBuffer();
	    for (int i = 0; i < MIN_LENGTH; i++) 
	    {
		      sb.append(goodChar[r.nextInt(goodChar.length)]);
		}
		 return sb.toString();
	 }
	
	 public static boolean  LockCheck(String lock)   
	 {
		boolean s= false;
		try 
		{
			lock = (("I"+lock).replaceAll("-", "")).toUpperCase();
			char n[] =lock.toCharArray();
			String lockkey[]={"9865043008","9443779749","9486165608","9443350318","9786969318","9786969325","9786969326","9940185529","9894624798","9894510420"};
			String no="";
			for(int u=0; u<n.length;u++)
			{	
				if("A".equalsIgnoreCase((""+n[u])))
					no = no+"1";
				else if("B".equalsIgnoreCase((""+n[u])))
					no = no+"2";
				else if("C".equalsIgnoreCase((""+n[u])))
					no = no+"3";
				else if("D".equalsIgnoreCase((""+n[u])))
					no = no+"4";
				else if("E".equalsIgnoreCase((""+n[u])))
					no = no+"5";
				else if("F".equalsIgnoreCase((""+n[u])))
					no = no+"6";
				else if("G".equalsIgnoreCase((""+n[u])))
					no = no+"7";
				else if("H".equalsIgnoreCase((""+n[u])))
					no = no+"8";
				else if("I".equalsIgnoreCase((""+n[u])))
					no = no+"9";
				else if("J".equalsIgnoreCase((""+n[u])))
					no = no+"0";
			}
			no = no.trim();
			s = false;
			 
			for(int g=0;g<lockkey.length;g++)
				if(lockkey[g].equalsIgnoreCase(no))
					s = true;
			return s;
		} 
		catch (RuntimeException e) 
		{
			 System.out.println(e.getMessage());
		}
		return false;
	 }
	 
	 
	 
	 public static void InsertImage(String fielName)throws IOException
		{
			
			try
			{
			String file  = (String)"../webapps/SmartCampus/Image/billing.jpg";
			//String file =fielName;
		    File f = new File(file);
		    InputStream is = new FileInputStream(f);
	        long length = f.length();
	        byte[] bytes = new byte[(int)length];
	        int offset = 0;
	        int numRead = 0;
	        while (offset < bytes.length && (numRead=is.read(bytes, offset,
	 bytes.length-offset)) >= 0) 
	        {
	            offset += numRead;
	        }
	        is.close();
	        Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
	        PreparedStatement pstm ;
			String sql="INSERT INTO  att_m_staffimages (IMAGE,CHR_EMPID) VALUES(?,?)";	
			pstm = co.prepareStatement(sql);
			pstm.setObject(1,bytes);			
			pstm.setString(2,"123456s");
			pstm.execute();
 
			}
			catch(Exception e)
			{
				
			}
		}
			
		
		public static void getImage(String sql) throws IOException
		{
		
			try {
					DBCon co  = new DBCon();
					Connection con= co.getConnection();
					Statement st = con.createStatement();
					ResultSet rs = st.executeQuery(sql);
					int i=0;
					while(rs.next())
					{
						
						byte dbbytes[] = rs.getBytes("IMAGE");
						String ofile  = (String)
	 "../webapps/SmartCampusWeb/kimage/"+i+".jpg";
						File of = new File(ofile);
						OutputStream os = new FileOutputStream(of);
						os.write(dbbytes,0,dbbytes.length);
						os.close();
						i=i+1;
					}
					 
				} 
				catch (SQLException e) 
				{
					 System.out.println(e.getMessage());
				} 
				catch (Exception e) 
				{
					 System.out.println(e.getMessage());
				}
		}
		
		
		//fix 2 decimal
		public static double FixDigitFormat(double number) throws MessagingException 
	    {
			double value=0.00;
			try
			{
				NumberFormat formatter = new DecimalFormat("#0.00");
		        return Double.parseDouble(formatter.format(number));
			}
			catch(Exception e)
			{
				
			}
	    	 return value;
		}
		
		
		
		//Display Country Name
		public static Locale[] CountryNames()
		{
			
			try 
			{ 
				Locale[] locales = Locale.getAvailableLocales();
				/*for (int i = 0; i < locales.length; i++) 
				{
					String iso = locales[i].getCountry();
					String name = locales[i].getDisplayCountry();
				}*/	
				return locales;
			} 
			catch (RuntimeException e) 
			{
				 System.out.println(e.getMessage());
			}
			return null;
		}
		
		
		//display month name JAN,FEB,..
		public static String[]  MonthName()   
		 {
			String s[];
			try 
			{ 
				String[] months = new DateFormatSymbols().getMonths();
				s = months;
				return s;
			} 
			catch (RuntimeException e) 
			{
				 System.out.println(e.getMessage());
			}
			return null;
		 }
		
		//display sortmonth JAN,FEB,..
		public static String[]  sortMonthName()   
		 {
			String s[];
			try 
			{ 
				String[] shortMonths = new DateFormatSymbols().getShortMonths();
				 s = shortMonths;
				return s;
			} 
			catch (RuntimeException e) 
			{
				 System.out.println(e.getMessage());
			}
			return null;
		 }
		
		public static String[]  WeekDayName()   
		 {
			String s[];
			try 
			{ 
				String[] weekdays = new DateFormatSymbols().getWeekdays();
				s = weekdays;
				return s;
			} 
			catch (RuntimeException e) 
			{
				 System.out.println(e.getMessage());
			}
			return null;
		 }
		 
		public static String[]  shortWeekdayName()   
		 {
			String s[];
			try 
			{ 
				String[] shortWeekdays = new DateFormatSymbols().getShortWeekdays();
				s = shortWeekdays;
				return s;
			} 
			catch (RuntimeException e) 
			{
				 System.out.println(e.getMessage());
			}
			return null;
		 }
		
		
		public static String  getDate()   
		 {
			
			try 
			{ 
				DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
		        Date today = Calendar.getInstance().getTime();        
		        String reportDate = df.format(today);
				return reportDate;
			} 
			catch (RuntimeException e) 
			{
				 System.out.println(e.getMessage());
			}
			return null;
		 }
		
		public static String  getDateFormat(int f)   
		 {
			String s="";
			try 
			{ 
				Date date = Calendar.getInstance().getTime();
				DateFormat formatter;
				String today ;
				if(f == 1)
				{	
					//02/12/2007
					formatter = new SimpleDateFormat("dd/MM/yyyy");
					today = formatter.format(date);
					return today;
				}	
				else if(f==2)
				{
					//Sun, 02/12/2007
					formatter = new SimpleDateFormat("EEE, dd/MM/yyyy");
					today = formatter.format(date);
					return today;
				}
				else if(f==3)
				{
					//Sun, 02 Dec 2007
					formatter = new SimpleDateFormat("EEE, dd MMM yyyy");
					today = formatter.format(date);	
					return today;
				}
				else if(f==4)
				{
					//Sunday, 02 December 2007, 08:03:17.828 AM
					formatter = new SimpleDateFormat("EEEE, dd MMMM yyyy, hh:mm:ss.SSS a");
					today = formatter.format(date);		
					return today;
				}
				 
				return s;
			} 
			catch (RuntimeException e) 
			{
				 System.out.println(e.getMessage());
			}
			return null;
		 }
	 	 
	       
 }



	
	

