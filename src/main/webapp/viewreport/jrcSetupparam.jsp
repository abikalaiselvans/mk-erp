<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="com.crystaldecisions.reports.sdk.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.reportsource.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.lib.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.data.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.exportoptions.*"%>
<%@ page import="com.crystaldecisions.report.web.viewer.*"%>
<%
String reportName = "Report1.rpt";
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

    Fields oFields = new Fields();
    ParameterField oParameterField = new ParameterField();
    oParameterField.setReportName("");

    Values oValues = new Values();
    ParameterFieldDiscreteValue oParameterFieldDiscreteValue = new ParameterFieldDiscreteValue();
    oParameterField.setName("fname");

    oParameterFieldDiscreteValue.setValue("Maria");
    oValues.add(oParameterFieldDiscreteValue);

    oParameterField.setCurrentValues(oValues);
    oFields.add(oParameterField);

    ExportOptions oExportOptions = new ExportOptions();
    oExportOptions.setExportFormatType(ReportExportFormat.PDF);        
    ReportExportControl oReportExportControl = new ReportExportControl();
    oReportExportControl.setReportSource(oReportSource);
    oReportExportControl.setExportOptions(oExportOptions);
    oReportExportControl.setExportAsAttachment(true);
    oReportExportControl.setDatabaseLogonInfos(oConnectionInfos);
    oReportExportControl.setParameterFields(oFields);
    oReportExportControl.processHttpRequest(request, response, getServletConfig().getServletContext(), null);

}

catch(ReportSDKException e)

{

    out.print(e);

}    

%>
