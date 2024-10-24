package com.my.org.erp.file;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
 
public class FileUtil1 
{


	public void renameDirectory(String fromDir, String toDir) 
	{
	    File from = new File(fromDir);
	    if (!from.exists() || !from.isDirectory()) 
	    {
	      System.out.println("Directory does not exist: " + fromDir);
	      return;
	    }
	    File to = new File(toDir);
	    //Rename
	    if (from.renameTo(to))
	    	System.out.println("Success!");
	    else
	    	System.out.println("Error");
    }
	
	 public void listDrives() 
	 {
		    File[] drives = File.listRoots();
		    for (int i = 0; i < drives.length; i++) 
		    {
		      System.out.println(drives[i]);
		    }
	}
	 
	 
	 public void createTemporaryFile(String filename) 
	 {
		    try 
		    {
		      //Create the temp file
		      File f = File.createTempFile("temp_", null);
		      //Check where the default temp dir is located
		      System.out.println(f.getAbsolutePath());
		      //Delete the file when the program exists
		      f.deleteOnExit();
		      //Place any processing of the file here
		      // ...
		    }
		    catch (IOException ex) 
		    {
		      ex.printStackTrace();
		    }
	}
	 
	 
	 
	 
	 public void changeFiletime(String filename) 
	 {
		    File fileToChange = new File(filename);
		    //Check time of the file/directory
		    Date filetime = new Date(fileToChange.lastModified());
		    System.out.println(filetime.toString());
		    //Change time to current
		    if (fileToChange.setLastModified(System.currentTimeMillis()))
		      System.out.println("Success!");
		    else
		      System.out.println("Failed!");
		    //Check time again
		    filetime = new Date(fileToChange.lastModified());
		    System.out.println(filetime.toString());
		      
	}
	 
	 
	 public void listFiles(String dir) 
	 {
		    File directory = new File(dir);
		    if (!directory.isDirectory()) 
		    {
		      System.out.println("No directory provided");
		      return;
		    }
		    
		    //create a FilenameFilter and override its accept-method
		    FilenameFilter filefilter = new FilenameFilter() 
		    {
		      public boolean accept(File dir, String name) 
		      {
		        //if the file extension is .txt return true, else false
		        return name.endsWith(".doc");
		      }
		    };

		    String[] filenames = directory.list(filefilter);
		    for (String name : filenames) 
		    {
		      System.out.println(name);
		    }
	}
	 
	 
	 
	 /*public void passwordExample() 
	 {
	        
	        Console console = System.console();
	        
	        if (console == null) {
	            System.out.println("Couldn't get Console instance, maybe you're running this from within an IDE?");
	            System.exit(0);
	        }
	       console.printf("Testing password%n");
	        char passwordArray[] = console.readPassword("Enter your secret password: ");
	        console.printf("Password entered was: %s%n", new String(passwordArray));
	    
	    }
	 */
	 
	 
	 public boolean deleteFile(String filename) 
	 {
		    File file = new File(filename);
		    return file.delete();

	}
	
	 
	 
	 
	 public void createDirectory(String dir) 
	 {
		    File directory = new File(dir);
		    //Alternative 1: All ancestor directories must exist.
		    if (directory.mkdir()) 
		    {
		      
		      System.out.println("Success using alternative 1");
		    }
		    else 
		    {
		      System.out.println("Failed using alternative 1, trying alternative 2");
		      //Alternative 2: If ancestors doesn\'t exist, they will be created.
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
	 
	 
	 
	 
	 
	 public long getFileSize(String filename) {

		    File file = new File(filename);
		    
		    if (!file.exists() || !file.isFile()) {
		      System.out.println("File doesn\'t exist");
		      return -1;
		    }
		    
		    //Here we get the actual size
		    return file.length();
		  }
	
	 
	 
	 public void removeLineFromFile(String file, String lineToRemove) {

		    try {

		      File inFile = new File(file);
		      
		      if (!inFile.isFile()) {
		        System.out.println("Parameter is not an existing file");
		        return;
		      }
		       
		      //Construct the new file that will later be renamed to the original filename.
		      File tempFile = new File(inFile.getAbsolutePath() + ".tmp");
		      
		      BufferedReader br = new BufferedReader(new FileReader(file));
		      PrintWriter pw = new PrintWriter(new FileWriter(tempFile));
		      
		      String line = null;

		      //Read from the original file and write to the new
		      //unless content matches data to be removed.
		      while ((line = br.readLine()) != null) {
		        
		        if (!line.trim().equals(lineToRemove)) {

		          pw.println(line);
		          pw.flush();
		        }
		      }
		      pw.close();
		      br.close();
		      
		      //Delete the original file
		      if (!inFile.delete()) {
		        System.out.println("Could not delete file");
		        return;
		      }
		      
		      //Rename the new file to the filename the original file had.
		      if (!tempFile.renameTo(inFile))
		        System.out.println("Could not rename file");
		      
		    }
		    catch (FileNotFoundException ex) {
		      ex.printStackTrace();
		    }
		    catch (IOException ex) {
		      ex.printStackTrace();
		    }
		  }

	 
	 
	 
	 
	 
	 
	  int tabCounter = 0;
	  public void listFilesAndFolders(String folder,String filetype) throws Exception 
	  {
		  File file = new File(folder);
		  if (!file.exists() || !file.isDirectory()) 
		 	  System.exit(1);
		 
		  File[] fileArray = file.listFiles();
		  for (int i = 0; i < fileArray.length; i++) 
		  {
			  if (fileArray[i].isDirectory()) 
			  {
				  //System.out.println(getTabs() + "- " + fileArray[i].getName());
				  
				  if((folder+"\\"+fileArray[i].getName()).endsWith(filetype))
					  System.out.println(folder+"\\"+fileArray[i].getName()); 	
				  tabCounter++;
				  listFilesAndFolders(fileArray[i].getAbsolutePath(),filetype);
			  }
			  else 
			  {
				  //System.out.println(getTabs() + fileArray[i].getName());
				  if((folder+"\\"+fileArray[i].getName()).endsWith(filetype))
					  System.out.println(folder+"\\"+fileArray[i].getName()); 	
				
			  }
		  }
		  
		  
		  tabCounter--;
	  }

	  
	  
	  
	    
	    
	  private String getTabs() {

	    StringBuffer buffer = new StringBuffer();
	    for (int i = 0; i < tabCounter; i++)
	      buffer.append("\t");

	    return buffer.toString();
	  }

	  
	  
	  
	  
	  ArrayList<String> filesinarraylist = new ArrayList<String>();
	  public ArrayList listFilesinFoldersandSubfolders(String folder,String filetype) throws Exception 
	  {
		 File file = new File(folder);
		  if (!file.exists() || !file.isDirectory()) 
		 	  System.exit(1);
		 
		  File[] fileArray = file.listFiles();
		  for (int i = 0; i < fileArray.length; i++) 
		  {
			  if (fileArray[i].isDirectory()) 
			  {
				  if((folder+"\\"+fileArray[i].getName()).endsWith(filetype))
					  filesinarraylist.add(""+folder+"\\"+fileArray[i].getName());
				
				  listFilesinFoldersandSubfolders(fileArray[i].getAbsolutePath(),filetype);
			  }
			  else 
			  {
				  if((folder+"\\"+fileArray[i].getName()).endsWith(filetype))
					  filesinarraylist.add(""+folder+"\\"+fileArray[i].getName()); 	
				  
			  }
		  }
		  return filesinarraylist;
	  }
 
	  

	  
	  
	  int k=0;
	  ArrayList<String> kfiles = new ArrayList<String>();
	  public ArrayList listSearchFilesinFoldersandSubfolders(String folder,String filetype,String searchinput) throws Exception 
	  {
		 
		  File file = new File(folder);
		  if (!file.exists() || !file.isDirectory()) 
		 	  System.exit(1);
		 
		  File[] fileArray = file.listFiles();
		  for (int i = 0; i < fileArray.length; i++) 
		  {
			 
			  if (fileArray[i].isDirectory()) 
			  {
				  if((folder+"\\"+fileArray[i].getName()).toLowerCase().endsWith(filetype))
				    if(textSearch(""+folder+"\\"+fileArray[i].getName(),searchinput))
					 	  kfiles.add(""+folder+"\\"+fileArray[i].getName());
				  listSearchFilesinFoldersandSubfolders(fileArray[i].getAbsolutePath(),filetype,searchinput);
			  }
			  else 
			  {
				  if((folder+"\\"+fileArray[i].getName()).toLowerCase().endsWith(filetype))
				 	  if(textSearch(""+folder+"\\"+fileArray[i].getName(),searchinput))
						  kfiles.add(""+folder+"\\"+fileArray[i].getName());
				
			  }
		  }
		  return kfiles;
	  }

	  
	   
	  private boolean textSearch(String filename,String searchinput) 
	  {
		  boolean flag = false;
		  try 
		  	{
			  	BufferedReader bufferedReader = new BufferedReader(new FileReader(filename));
				String line = null;
				while ((line = bufferedReader.readLine()) != null) 
				{        
					if((line.toUpperCase()).contains(searchinput.toUpperCase()))
						flag =true;
					
				} 
				bufferedReader.close();
				return flag;
			} 
		  	catch (FileNotFoundException e) 
		  	{
				 System.out.println(e.getMessage());
			} 
		  	catch (IOException e) {
				 System.out.println(e.getMessage());
			}
		  	return flag;
	  }

	  
	  
	  
  public static void main(String[] args) 
  {
  
	  	try 
	  	{
			
	  		DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	  		Date date = new Date();
	  		String start = dateFormat.format(date);
	  		
	  		
	  		FileUtil1 fileutil = new FileUtil1();
			//fileutil.renameDirectory("c:/kalaipdf2", "c:/kalaipdf");
			//fileutil.listDrives();
			//fileutil.createTemporaryFile("myfile.txt");
			//fileutil.changeFiletime("C:\\\\temp\\\\myfile.txt");
			//fileutil.listFiles("C:/kalaipdf/Resume");
			//fileutil.createDirectory("C:\\\\temp\\\\temp1\\\\temp2\\\\temp3");
			//fileutil.listFilesAndFolders("C:\\kalaipdf" ,".doc");
			ArrayList<String> arrayList = fileutil.listFilesinFoldersandSubfolders("C:\\kalaipdf" ,".doc");
			int i=0;
			
			/*for (String str: arrayList)
			{
				Scanner fileScanner = new Scanner(new File(str));
				String input = "add";  
			    while(fileScanner.hasNextLine())
			    {  
			    		String line = fileScanner.nextLine(); 
			            if(Pattern.matches(line.toUpperCase(), input.toUpperCase()))
			            {  
			            	i++;
			        		System.out.println(i+"---"+arrayList.size()+"----"+str);
			            }  
			    }  
			}
			*/
			
			
			
			
			
			 
			/*i=0;
			for (String str: arrayList)
			{
				BufferedReader bufferedReader = new BufferedReader(new FileReader(str));
		        String line = null;
		        boolean flag = false;
		        while ((line = bufferedReader.readLine()) != null) 
		        {        
		        	if((line.toUpperCase()).contains("PHYSICS"))
		        		flag =true;
		        	
		        } 
		        bufferedReader.close();
		        if(flag)
		        {
		        	i++;
	        		System.out.println(i+"---"+arrayList.size()+"----"+str);
		        }
		        flag = false;
			}
			 
			*/
			
			
			System.out.println("=========================================");
			
			ArrayList<String> filename = fileutil.listSearchFilesinFoldersandSubfolders("C:\\kalaipdf" ,".doc","Athichidambaram");
			System.out.println(filename.size());
			for (String str: filename)
				System.out.println(str);
				
			date = new Date();
	  		String end = dateFormat.format(date);
	  		System.out.println("------------------------"+start+"/"+end);
	  		
			
			//long size = fileutil.getFileSize("/temp/myfile1.txt");
			//System.out.println("Filesize in bytes: " + size);
		} 
	  	catch (Exception e) 
	  	{
			 
			 System.out.println(e.getMessage());
		}
  }
  
  
}
