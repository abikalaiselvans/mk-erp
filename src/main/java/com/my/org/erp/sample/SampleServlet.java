package com.my.org.erp.sample;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/SampleServlet")
public class SampleServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException,  ServletException 
	  {
		  try 
		    {
			
			  String name,age,blood,department;
			  name = request.getParameter("");
			  age = request.getParameter("age");
			  blood = request.getParameter("blood");
			  department = request.getParameter("department");
			  String filename = request.getRealPath("/")+"persons.txt";
			  Sample person1 = new Sample( name,  age,  blood, department) ; 
			  List list = new ArrayList();
			  list.add(person1);
			  FileOutputStream fos = null;
			  ObjectOutputStream out = null;
			  try 
			  {
					fos = new FileOutputStream(filename);
					out = new ObjectOutputStream(fos);
					out.writeObject(list);
					out.close();
					System.out.println("Object Persisted");
			  } 
			  catch (IOException ex) 
			  {
					ex.printStackTrace();
			}
			  response.sendRedirect("Test/Sample/sample2.jsp");
		    } 
		  	catch (Exception e) 
		    {
		    	System.out.println(e.getMessage());
		    } 
		
	  }
}
