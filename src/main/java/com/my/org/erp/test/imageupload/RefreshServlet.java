package com.my.org.erp.test.imageupload;
///How do I automatically refresh a servlet?
/*
 * 
 * 
 * 
 How do I hit a servlet without a web.xml servlet mapping?
<servlet-mapping>
<servlet-name>invoker</servlet-name>
<url-pattern>/servlet/*</url-pattern>
</servlet-mapping>

How do I prevent people from shutting down my Tomcat?
server.xml   <Server port="8008" shutdown="PLEASESHUTDOWN">
<Server port="8005" shutdown="SHUTDOWN">
<Server port="8008" shutdown="PLEASESHUTDOWN">



*/
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class RefreshServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		performTask(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
			IOException {
		performTask(request, response);
	}

	private void performTask(HttpServletRequest request, HttpServletResponse response) throws ServletException,
			IOException {
		response.setContentType("text/html");
		response.addHeader("Refresh", "5");
		PrintWriter out = response.getWriter();
		out.println("TestServlet says hi at " + new Date());
	}

}