package com.my.org.erp.export;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;

public class FileFunctions
{
	 
	public static String[] FindDirectories()
	  {
		@SuppressWarnings("unused")
		String s[];
		String dr="";
	    try 
	    {
	      File pathName = new File("c:\\");
	      String[] fileNames = pathName.list();
	      for (int i = 0; i < fileNames.length; i++) 
	      {
	        File tf = new File(pathName.getPath(), fileNames[i]);
	        if (tf.isDirectory()) 
	        	dr = dr+tf.getCanonicalPath()+",";
	      }
	      String ss[] = dr.split(",");
	      return ss;
	    }
	    catch (IOException e) 
	    {
	      //System.out.println("Error: " + e);
	    }
	    return null;
	  }

	
	////System.out.println(com.my.org.erp.file.FileFunctions.copyDirectory(new File("c:/kalai"), new File("c:/kalais"));
	public static boolean copyDirectory(File srcPath, File dstPath) throws IOException
	{
		
		@SuppressWarnings("unused")
		boolean flag = false;
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
				return false;
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
		return true;
	}
	
	
	public static void copy(String fromFileName, String toFileName) throws IOException 
	{
		File fromFile = new File(fromFileName);
		File toFile = new File(toFileName);

		if (!fromFile.exists()) throw new IOException("FileCopy: " + "no such source file: " + fromFileName);
		if (!fromFile.isFile()) throw new IOException("FileCopy: " + "can't copy directory: "+ fromFileName);
		if (!fromFile.canRead())throw new IOException("FileCopy: " + "source file is unreadable: "+ fromFileName);
    
		if (toFile.isDirectory())
			toFile = new File(toFile, fromFile.getName());

		if (toFile.exists()) 
		{
			if (!toFile.canWrite()) throw new IOException("FileCopy: "+ "destination file is unwriteable: " + toFileName); 
			//System.out.print("Overwrite existing file " + toFile.getName() + "? (Y/N): ");
			System.out.flush();
			BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
			String response = in.readLine();
			if (!response.equals("Y") && !response.equals("y")) throw new IOException("FileCopy: " + "existing file was not overwritten.");
		} 
		else 
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
        try {
          to.close();
        } catch (IOException e) {
          ;
        }
    }
  }
	
 public static boolean createDirectory()
 {
	 boolean flag = false;
	 try
	 {
		    boolean success = (new File("directoryName")).mkdir();
		    if (!success) 
		    	return false;
		    else
		    	return true;
		    
		   
	 }
	 catch(Exception e)
	 {
	 }
	 return flag;
 }

 
 public static boolean DirectoryExist(File filename)
 {
	 boolean flag = false;
	 try
	 {
		 return filename.isDirectory();    
		   
	 }
	 catch(Exception e)
	 {
	 }
	 return flag;
 }
	
 public static String TomcatExist()
 {
	 String file="";
	 try
	 {
		 String drive[] ={"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};
		 String s="";
		 for(int u=0;u<drive.length;u++)
			 s =s+drive[u]+":/Program Files/Apache Software Foundation/Tomcat 5.0/webapps"+",";
		 String drives[]= s.split(",");
		 @SuppressWarnings("unused")
		boolean flag = false;
		 s="";
		 for(int u=0;u<drives.length;u++)
		 {	 
			 File f = new File(drives[u]); 
			 if(DirectoryExist(f))
				 s= drives[u];
		 }
		 return s;
	 }
	 catch(Exception e)
	 {
	 }
	 return file;
 }

 public static String MySQLExist()
 {
	 String file="";
	 try
	 {
		 String drive[] ={"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};
		 String s="";
		 //D:\Program Files\mmi\MySQL\MySQL Server 5.0  Program Files/MySQL Server 5.0
		 for(int u=0;u<drive.length;u++)
			 s =s+drive[u]+":/Program Files/MySQL/MySQL Server 5.0"+",";
		 String drives[]= s.split(",");
		 @SuppressWarnings("unused")
		boolean flag = false;
		 s="";
		 for(int u=0;u<drives.length;u++)
		 {	 
			 File f = new File(drives[u]); 
			 if(DirectoryExist(f))
				 s= drives[u];
		 }
		 return s;
	 }
	 catch(Exception e)
	 {
	 }
	 return file;
 }
 public static String MySQLFrontExist()
 {
	 String file="";
	 try
	 {
		 String drive[] ={"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};
		 String s="";
		 //D:\Program Files\mmi\MySQL\MySQL Server 5.0  Program Files/MySQL Server 5.0
		 for(int u=0;u<drive.length;u++)
			 s =s+drive[u]+":/Program Files/MySQL-Front"+",";
		 String drives[]= s.split(",");
		 @SuppressWarnings("unused")
		boolean flag = false;
		 s="";
		 for(int u=0;u<drives.length;u++)
		 {	 
			 File f = new File(drives[u]); 
			 if(DirectoryExist(f))
				 s= drives[u];
		 }
		 return s;
	 }
	 catch(Exception e)
	 {
	 }
	 return file;
 }
 
 
 
 public static void runExe( String name) 
 {
     try
     {
         //"software/jakarta-tomcat-5.0.28.exe"
         //File f = new File(name);
         Runtime.getRuntime().exec("rundll32 SHELL32.DLL,ShellExec_RunDLL "+name);
      }
     catch(Exception es)
     {
         //System.out.println(es.getMessage());
     }       
 }
 
 
}
          