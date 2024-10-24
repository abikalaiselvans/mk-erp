
<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>

<%//Crystal Java Reporting Component (JRC) imports. %>
<%@ page import="com.crystaldecisions.reports.sdk.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.lib.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.data.*"%>

<%//Java imports. %>
<%@ page import="java.util.*"%>

<%
//Report can be opened from the relative location specified in the CRConfig.xml, or the report location
//tag can be removed to open the reports as Java resources or using an absolute path (absolute path not recommended
//for Web applications).
final String REPORT_NAME = "jrc_view_report_parameters.rpt";
%>

<%
try {
	
	//Open report.
	ReportClientDocument reportClientDoc = new ReportClientDocument();
	reportClientDoc.open(REPORT_NAME, 0);

	//We will be using the ParameterFieldController quite a bit through-out the rest of this function.
	ParameterFieldController paramFieldController = reportClientDoc.getDataDefController().getParameterFieldController();
			
	//SINGLE VALUE DISCRETE PARAMETERS.
	paramFieldController.setCurrentValue("", "StringParam", new String("Hello"));
	paramFieldController.setCurrentValue("", "BooleanParam", new Boolean(true));
	paramFieldController.setCurrentValue("", "CurrencyParam", new Double(123.45));
	paramFieldController.setCurrentValue("", "NumberParam", new Integer(123));
						
	//Date value parameter.
	Calendar calendar = Calendar.getInstance();
	calendar.set(2004, 1, 17);
	Date dateValue = calendar.getTime();
	paramFieldController.setCurrentValue("", "DateParam", dateValue);
			
	//Date-time value parameter.
	Calendar calendar2 = Calendar.getInstance();
	calendar2.set(2002, 5, 12, 8, 23, 15);
	Date dateTimeValue = calendar2.getTime();
	paramFieldController.setCurrentValue("", "DateTimeParam", dateTimeValue);
		    
	//Time value parameter.
	Calendar calendar3 = Calendar.getInstance();
	calendar3.set(2002, 5, 12, 13, 44, 59);
	Date timeValue = calendar3.getTime();
	paramFieldController.setCurrentValue("", "TimeParam", timeValue);
		    
	//MULTI-VALUE DISCRETE PARAMETERS.
	Object [] multiVals = {"String1", "String2", "String3"};
	paramFieldController.setCurrentValues("", "StringMultiParam", multiVals);
					    
	//NOTE: For more complex parameter value types below (range and multi-value range parameters), use the sample utility methods below for creating ParameterFieldValue
	//objects that can be passed into the setCurrentValue(s) method.
		    
	//SINGLE VALUE RANGE PARAMETERS. 
	ParameterFieldValue rangeVal = createSingleRangeVal(new Integer(1), new Integer(5), RangeValueBoundType.inclusive, RangeValueBoundType.inclusive);						
	paramFieldController.setCurrentValue("", "NumberRangeParam", rangeVal);
			
	//MULTI-VALUE RANGE PARAMETERS.
	Object [] beginVals = {new Integer(12), new Integer(13), new Integer(14)};
	Object [] endVals = {new Integer(15), new Integer(16), new Integer(17)};
	RangeValueBoundType [] beginBoundTypes = {RangeValueBoundType.inclusive, RangeValueBoundType.exclusive, RangeValueBoundType.noBound};
	RangeValueBoundType [] endBoundTypes = {RangeValueBoundType.noBound, RangeValueBoundType.inclusive, RangeValueBoundType.exclusive};
	ParameterFieldValue [] multiRangeVal = createMultiValRangeParameter(beginVals, endVals, beginBoundTypes, endBoundTypes);
	paramFieldController.setCurrentValues("", "NumberMultiRangeParam", multiRangeVal);
			
	//Set subreport parameters using the main report's parameter field controller.  To get the names of the 
	//subreport dynamically, use the SubreportController's getSubreportNames() method.
	String subreportName = "sub";
	paramFieldController.setCurrentValue(subreportName, "StringParam", new String("Subreport string value."));
	
	//Store the report source in session, will be used by the CrystalReportViewer.
	session.setAttribute("reportSource", reportClientDoc.getReportSource());
		
	//Launch CrystalReportViewer page that contains the report viewer.
	response.sendRedirect("CrystalReportViewer.jsp");
		
}
catch(ReportSDKException ex) {	
	out.println(ex);
}
catch(Exception ex) {
	out.println(ex);			
}
%>

<%!
   /**
	* This sample utility method is used to create single-valued range parameters.
	*/
	private static ParameterFieldRangeValue createSingleRangeVal(Object beginValue, Object endValue, RangeValueBoundType beginBoundType, RangeValueBoundType endBoundType) {
	
		//Create parameter field value container.
		ParameterFieldRangeValue rangeValue = new ParameterFieldRangeValue();
		
		//Populate the parameter field value container with appropriate values.
		rangeValue.setBeginValue(beginValue);
		rangeValue.setEndValue(endValue);
		rangeValue.setLowerBoundType(beginBoundType);
		rangeValue.setUpperBoundType(endBoundType);
		
		return rangeValue;
	}
%>

<%!
   /**
	* This sample utility method is used for creating multi-value range parameters.
    */
	private static ParameterFieldRangeValue [] createMultiValRangeParameter(Object [] beginValues, Object [] endValues, RangeValueBoundType [] beginBoundTypes, RangeValueBoundType [] endBoundTypes) {
	
		//Create parameter field value container.
		ParameterFieldRangeValue [] multiRangeValues = new ParameterFieldRangeValue[beginValues.length];
				
		//Populate the parameter field value container with appropriate values.
		for (int i=0; i < beginValues.length; i++) {
			
			multiRangeValues[i] = new ParameterFieldRangeValue();
			multiRangeValues[i].setBeginValue(beginValues[i]);
			multiRangeValues[i].setEndValue(endValues[i]);
			multiRangeValues[i].setLowerBoundType(beginBoundTypes[i]);
			multiRangeValues[i].setUpperBoundType(endBoundTypes[i]);
					
		}
		
		return multiRangeValues;
		
	}
%>
