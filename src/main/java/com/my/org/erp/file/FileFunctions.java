package com.my.org.erp.file;

import java.io.File;
import java.util.Calendar;
public class FileFunctions 
{
	
	 public static void listDrives() 
	 {
		    File[] drives = File.listRoots();
		    for (int i = 0; i < drives.length; i++) 
		    {
		      System.out.println(drives[i]);
		    }
	}
	 
	 
	
	public static boolean deleteFile(String filename) 
	{
		    File file = new File(filename);
		    return file.delete();
	}
	
	
	public static boolean fileIsThere(String filename) 
	{
		    File file = new File(filename);
		    return file.exists();
	}
	
	public static void renameLowertoHigherinFolderFilenames(String folderpath) 
	{
		try
		{
			File folder = new File(folderpath);
			File[] listOfFiles = folder.listFiles();
			for (int i = 0; i < listOfFiles.length; i++) 
			{
				if (listOfFiles[i].isFile()) 
				{
					File f = new File(folderpath); 
					f.renameTo(new File(folderpath));
				}
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	
	public static  void createDirectory(String dir) 
	 {
		    File directory = new File(dir);
		    if (directory.mkdir()) 
		    {
		      System.out.println("Success using alternative 1");
		    }
		    else 
		    {
		      System.out.println("Failed using alternative 1, trying alternative 2");
		      if (directory.mkdirs()) 
		      {
		        System.out.println("Success using alternative 2");
		      }
		      else 
		      {
		        System.out.println("Failed using both alternative 1 and alternative 2");
		      }
		    }
	}
	
	
	public static boolean removeDirectory(File directory) 
	{

		  if (directory == null)
		    return false;
		  if (!directory.exists())
		    return true;
		  if (!directory.isDirectory())
		    return false;

		  String[] list = directory.list();

		  if (list != null) {
		    for (int i = 0; i < list.length; i++) {
		      File entry = new File(directory, list[i]);

		      if (entry.isDirectory())
		      {
		        if (!removeDirectory(entry))
		          return false;
		      }
		      else
		      {
		        if (!entry.delete())
		          return false;
		      }
		    }
		  }

		  return directory.delete();
		}


	public static boolean deleteDir(File dir) 
	{
	      if (dir.isDirectory()) 
	      {
	         String[] children = dir.list();
	         for (int i = 0; i < children.length; i++) 
	         {
	            boolean success = deleteDir(new File(dir, children[i]));
	            if (!success) 
	            {
	               return false;
	            }
	         }
	      }
	      return dir.delete();
	  }
	 
	public static boolean ModifyDir(File dir) 
	{
	      if (dir.isDirectory()) 
	      {
	         String[] children = dir.list();
	         for (int i = 0; i < children.length; i++) 
	         {
	            boolean success = ModifyDir(new File(dir, children[i]));
	            if (!success) 
	            {
	               return false;
	            }
	         }
	      }
	      return dir.delete();
	  }
	 


	public static void createAutoDirectory(File dir) 
	{
		Calendar now = Calendar.getInstance();
		int year = now.get(Calendar.YEAR);
		int month = now.get(Calendar.MONTH);
		int date = now.get(Calendar.DATE);
		
	     
	 
	}
	
}
