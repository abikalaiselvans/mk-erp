<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.crystaldecisions.report.web.viewer.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.data.*"%>
<%@ page import="com.crystaldecisions.reports.sdk.ReportClientDocument"%>
<%

    Object reportSource = session.getAttribute("reportSource");
    if (reportSource == null)
    {
       String report = "/viewreport/datasource/Rep.rpt";
       ReportClientDocument reportClientDoc = new ReportClientDocument();
       reportClientDoc.open(report, 0);
       reportSource = reportClientDoc.getReportSource();
       session.setAttribute("reportSource", reportSource);

    }
	
    ConnectionInfos connInfos = new ConnectionInfos();
    IConnectionInfo connInfo1 = new ConnectionInfo();
    connInfo1.setUserName("root");
    connInfo1.setPassword("mythra");
    connInfos.add(connInfo1);
    CrystalReportViewer viewer = new CrystalReportViewer();
    viewer.setReportSource(reportSource);
    viewer.setEnableLogonPrompt(false);  
    viewer.setDatabaseLogonInfos(connInfos);
    if (session.getAttribute("refreshed") == null)
    {
	    viewer.refresh();
	    session.setAttribute("refreshed", "true");
    }
    viewer.setOwnPage(true);
    viewer.processHttpRequest(request, response, getServletConfig().getServletContext(), null);

%>
