<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="com.crystaldecisions.reports.sdk.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.reportsource.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.lib.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.data.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.exportoptions.*"%>
<%@ page import="com.crystaldecisions.report.web.viewer.*"%>
<%
String reportName = "CrystalReport1.rpt";
String userName = "root";
String password = "mythra";
ReportClientDocument oReportClientDocument = new ReportClientDocument();
try
{

    oReportClientDocument.open(reportName , 0);
    IReportSource oReportSource = (IReportSource)oReportClientDocument.getReportSource();
    ConnectionInfos oConnectionInfos = new ConnectionInfos();
    ConnectionInfo oConnectionInfo = new ConnectionInfo();
    oConnectionInfo.setUserName(userName);
    oConnectionInfo.setPassword(password);
    oConnectionInfos.add(oConnectionInfo);
    ExportOptions oExportOptions = new ExportOptions();
    
    oExportOptions.setExportFormatType(ReportExportFormat.PDF);   
    //oExportOptions.setExportFormatType(ReportExportFormat.RTF);    
    //oExportOptions.setExportFormatType(ReportExportFormat.crystalReports);    

    
    ReportExportControl oReportExportControl = new ReportExportControl();
    oReportExportControl.setReportSource(oReportSource);
    oReportExportControl.setExportOptions(oExportOptions);
    oReportExportControl.setExportAsAttachment(true);
    oReportExportControl.setDatabaseLogonInfos(oConnectionInfos);
    oReportExportControl.processHttpRequest(request, response, getServletConfig().getServletContext(), null);

}

catch(ReportSDKException e)

{

    out.print(e);

}    

%>
