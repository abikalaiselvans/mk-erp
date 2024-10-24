<%@ page contentType="text/html; charset=utf-8"%>

<%@ page
	import="com.crystaldecisions.report.web.viewer.CrystalImageCleaner"%>
<%@ page
	import="com.crystaldecisions.report.web.viewer.CrystalReportViewer"%>
<%@ page
	import="com.crystaldecisions.report.web.viewer.CrystalReportPartsViewer"%>





<%
  // This page displays the chosen report in the chosen viewer.
%>

<%  /*
    * This page opens the report viewer on the server chosen in the previous pages.
    * When an item on the report is clicked, this same page is loaded again
    * to display the new report view.  Information about the report state is saved
    * as post data.
    */
%>

<%! 

public void jspInit(){
    CrystalImageCleaner.start(getServletContext(), 60000, 12000);
}


public void jspDestroy(){

    CrystalImageCleaner.stop(getServletContext());

}
%>

<% 
	
	String viewerToLaunch = (String) session.getAttribute("viewerToLaunch");
    Object reportSource = session.getAttribute("reportSource");

    if(viewerToLaunch.equals("pageViewer")){
        CrystalReportViewer viewer = new CrystalReportViewer();
        viewer.setReportSource(reportSource);
        viewer.setDisplayPage(true);
        viewer.setDisplayGroupTree(true);
        viewer.setDisplayToolbar(true);
        viewer.setOwnPage(true);
		viewer.setEnableDrillDown(true);        
        viewer.setEnableLogonPrompt(true);
        viewer.setEnableParameterPrompt(true);
        viewer.processHttpRequest(request, response, getServletContext(), null);
    }
    else if(viewerToLaunch.equals("partViewer")){
        CrystalReportPartsViewer viewer = new CrystalReportPartsViewer();
        // Set the viewer options.
        viewer.setReportSource(reportSource);
        viewer.setEnableDrillDown(false);
        viewer.setPreserveLayout(true);
        viewer.setOwnPage(true);

        // Show the report.
        viewer.processHttpRequest(request, response, getServletContext(), null);
    }
    else if(viewerToLaunch.equals("drillViewer")){
	
        
        CrystalReportPartsViewer viewer = new CrystalReportPartsViewer();

        viewer.setReportSource(reportSource);
        viewer.setOwnPage(true);
        viewer.setHasBorder(true);
        viewer.setPreserveLayout(true);

        viewer.processHttpRequest(request, response, getServletContext(), null);
    }    
%>

<html>
<head>
<!-- #include file=../Utilities.jsp -->
</head>
<body  onpaste='return false;'>
</body>
</html>
