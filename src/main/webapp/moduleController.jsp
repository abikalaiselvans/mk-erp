<%@ page import="com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
 //pmcom, pmhrm, pmatt, pmpay, pminv, pmcon, pmhel, pmmkt, ppmmgt, pmamc, pmsms, pmtra, pmssr, pmdeb, pmupd, pmtrs, pmuti
	String msql1 = " SELECT CHR_SHORTNAME from m_projectmodule where CHR_VISIBLE='Y' AND CHR_SHORTNAME='COM' ";
	String pmcom=CommonFunctions.QueryExecute(msql1)[0][0];
	
	String msql2 = " SELECT CHR_SHORTNAME from m_projectmodule where CHR_VISIBLE='Y' AND CHR_SHORTNAME='HRM' ";
	String pmhrm =CommonFunctions.QueryExecute(msql2)[0][0];
	
	String msql3 = " SELECT CHR_SHORTNAME from m_projectmodule where CHR_VISIBLE='Y' AND CHR_SHORTNAME='ATT' ";
	String pmatt =CommonFunctions.QueryExecute(msql3)[0][0];
	
	String msql4 = " SELECT CHR_SHORTNAME from m_projectmodule where CHR_VISIBLE='Y' AND CHR_SHORTNAME='PAY' ";
	String pmpay =CommonFunctions.QueryExecute(msql4)[0][0];
	
	String msql5 = " SELECT CHR_SHORTNAME from m_projectmodule where CHR_VISIBLE='Y' AND CHR_SHORTNAME='INV' ";
	String pminv =CommonFunctions.QueryExecute(msql5)[0][0];
	
	String msql6 = " SELECT CHR_SHORTNAME from m_projectmodule where CHR_VISIBLE='Y' AND CHR_SHORTNAME='CON' ";
	String pmcon =CommonFunctions.QueryExecute(msql6)[0][0];
	
	String msql7 = " SELECT CHR_SHORTNAME from m_projectmodule where CHR_VISIBLE='Y' AND CHR_SHORTNAME='HEL' ";
	String pmhel =CommonFunctions.QueryExecute(msql7)[0][0];
	
	String msql8 = " SELECT CHR_SHORTNAME from m_projectmodule where CHR_VISIBLE='Y' AND CHR_SHORTNAME='MKT' ";
	String pmmkt =CommonFunctions.QueryExecute(msql8)[0][0];
	
	String msql9 = " SELECT CHR_SHORTNAME from m_projectmodule where CHR_VISIBLE='Y' AND CHR_SHORTNAME='MGT' ";
	String ppmmgt=CommonFunctions.QueryExecute(msql9)[0][0];
	
	String msql10 = " SELECT CHR_SHORTNAME from m_projectmodule where CHR_VISIBLE='Y' AND CHR_SHORTNAME='AMC' ";
	String pmamc=CommonFunctions.QueryExecute(msql10)[0][0];
	
	String msql11 = " SELECT CHR_SHORTNAME from m_projectmodule where CHR_VISIBLE='Y' AND CHR_SHORTNAME='SMS' ";
	String pmsms=CommonFunctions.QueryExecute(msql11)[0][0];
	
	String msql12 = " SELECT CHR_SHORTNAME from m_projectmodule where CHR_VISIBLE='Y' AND CHR_SHORTNAME='TRA' ";
	String pmtra=CommonFunctions.QueryExecute(msql12)[0][0];
	
	String msql13 = " SELECT CHR_SHORTNAME from m_projectmodule where CHR_VISIBLE='Y' AND CHR_SHORTNAME='SSR' ";
	String pmssr=CommonFunctions.QueryExecute(msql13)[0][0];
	
	String msql14 = " SELECT CHR_SHORTNAME from m_projectmodule where CHR_VISIBLE='Y' AND CHR_SHORTNAME='DEB' ";
	String pmdeb=CommonFunctions.QueryExecute(msql14)[0][0];
	
	String msql15 = " SELECT CHR_SHORTNAME from m_projectmodule where CHR_VISIBLE='Y' AND CHR_SHORTNAME='UPD' ";
	String pmupd=CommonFunctions.QueryExecute(msql15)[0][0];
	
	String msql16 = " SELECT CHR_SHORTNAME from m_projectmodule where CHR_VISIBLE='Y' AND CHR_SHORTNAME='TRS' ";
	String pmtrs=CommonFunctions.QueryExecute(msql16)[0][0];
	
	String msql17 = " SELECT CHR_SHORTNAME from m_projectmodule where CHR_VISIBLE='Y' AND CHR_SHORTNAME='UTI' ";
	String pmuti=CommonFunctions.QueryExecute(msql17)[0][0];
 %>