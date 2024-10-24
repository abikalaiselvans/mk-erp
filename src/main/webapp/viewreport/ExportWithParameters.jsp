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
ReportClientDocument oReportClientDocument = new ReportClientDocument();
try
{
    oReportClientDocument.open(reportName , 0);
    IReportSource oReportSource = (IReportSource)oReportClientDocument.getReportSource();

    Fields oFields = new Fields();
    ParameterField oParameterField = new ParameterField();

    oParameterField.setReportName("");
    Values oValues = new Values();

    ParameterFieldDiscreteValue oParameterFieldDiscreteValue = new ParameterFieldDiscreteValue();
    oParameterField.setName("pfield1");

    oParameterFieldDiscreteValue.setValue(new Double(5.00));

    oValues.add(oParameterFieldDiscreteValue);
    oParameterField.setCurrentValues(oValues);

    oFields.add(oParameterField);

    ExportOptions oExportOptions = new ExportOptions();
    //oExportOptions.setExportFormatType(ReportExportFormat.RTF);    
    //oExportOptions.setExportFormatType(ReportExportFormat.crystalReports);    
    oExportOptions.setExportFormatType(ReportExportFormat.PDF);        
    ReportExportControl oReportExportControl = new ReportExportControl();
    oReportExportControl.setReportSource(oReportSource);
    oReportExportControl.setExportOptions(oExportOptions);
    oReportExportControl.setExportAsAttachment(true);
    oReportExportControl.setParameterFields(oFields);
    oReportExportControl.processHttpRequest(request, response, getServletConfig().getServletContext(), null);

}

catch(ReportSDKException e)

{

    out.print(e);

}    

%>
