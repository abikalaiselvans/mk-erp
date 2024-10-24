
<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="com.crystaldecisions.report.web.viewer.*"%>
<%@ page import="com.crystaldecisions.reports.sdk.*"%>

<%

//CrystalReportViewer viewer = new CrystalReportViewer();
//viewer.setOwnPage(true);
//viewer.setOwnForm(true);
//viewer.setPrintMode(CrPrintMode.ACTIVEX);

Object reportSource = session.getAttribute("reportSource");
//viewer.setReportSource(reportSource);

//Render the report.
//viewer.processHttpRequest(request, response, getServletConfig().getServletContext(), null); 
CrystalReportViewer viewer = new CrystalReportViewer();
viewer.setReportSource(reportSource);
viewer.setOwnPage(true);
viewer.processHttpRequest(request, response, getServletConfig().getServletContext(), null);



%>
