 <%@ page import="java.sql.*,java.io.*,java.util.*"   errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions" %>

 
<html>
<head>

<%
try
{
%>

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
   

function Validate()
{
	
	 
	if( checkNull('comments','Enter the Description....')  )
		return true;
	else
		return false;
}

</script>
 


<title>:: HRM ::</title>


 
 
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
.style4 {font-weight: bold}
-->
</style>
</head>


<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<form  AUTOCOMPLETE = "off" name="frm" method="post" action="../SmartLoginAuth" onSubmit="return Validate() ">
<table width="100%" border="0">
  <tr>
    <td>
	<%@ include file="indexhrm.jsp"%>	
	 
	</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td valign="top"> </td>
  </tr>
  <tr>
    <td><TABLE width=787 border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#dce4f9" class=BackGround>
      <TBODY>
        <TR>
          <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/TLCorner.gif" width=7></TD>
          <TD class=BorderLine height=1><SPACER height="1" 
                        width="1" type="block" /></TD>
          <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/TRCorner.gif" width=7></TD>
        </TR>
        <TR>
          <TD height=6><SPACER height="1" width="1" type="block"/></TD>
        </TR>
        <TR>
          <TD class=BorderLine width=1><SPACER height="1" 
                        width="1" type="block" /></TD>
          <TD width=6><SPACER height="1" width="1" type="block" 
                      /></TD>
          <TD width=772 valign="top"><table width="772" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td colspan="2"><div align="center"><span class="boldThirteen"> ACCEPT OUR OFFER </span></div></td>
              </tr>
              <tr>
                <td colspan="2"><div align="right"><span class="style4"><font color="red">*</font></span><span class="changePos">Mandatory</span></div></td>
              </tr>
              <tr>
                <td colspan="2"></td>
              </tr>
              <tr>
                <td height="19" colspan="2">&nbsp;</td>
              </tr>
              <tr>
                <td height="19" colspan="2"><p>
                    <%
				String applicantid= request.getParameter("applicantid");
				String sql="";
				 
				sql = "  SELECT g.INT_OFFERID,b.INT_APPID,b.CHR_APPCODE,b.CHR_APPNAME,b.CHR_APPFATHER,b.CHR_GENDER, 	 ";	  
				sql = sql +"  DATE_FORMAT(b.DT_DOB,'%d-%m-%Y'),b.CHR_EMAILID,b.CHR_MOBILE, b.CHR_PADD1,b.CHR_PADD2,f.CHR_CITYNAME,	 ";	  
				sql = sql +"  e.CHR_DISTRICT,d.CHR_STATENAME, c.CHR_COUNTRYNAME,b.INT_PPIN, a.CHR_JOBGRADE,a.CHR_JOBCODE,a.CHR_JOBTITLE ,	 ";	  
				sql = sql +"  g.DT_OFFERDATE, DATE_FORMAT(g.DT_OFFERDATE,'%d-%m-%Y'),CHR_PF,CHR_ESI ,	 ";	  
				sql = sql +"  h.CHR_CATEGORYNAME ,i.CHR_DESIGNAME,j.CHR_OFFICENAME,g.INT_NOTICEPERIOD,b.CHR_EMAILID	,g.CHR_RANDOMCHAR , (NOW() <=(SELECT DATE_FORMAT(DATE_ADD(now(), INTERVAL g.INT_NOTICEPERIOD DAY),'%Y-%m-%d')) )";	  
				sql = sql +"  FROM hrm_m_jobdesign a, hrm_m_application b , com_m_country c, com_m_state d,com_m_district e,	 ";	  
				sql = sql +"  com_m_city f ,hrm_t_offerletter g ,com_m_employeecategory h,com_m_desig i,com_m_office j	 ";	  
				sql = sql +"  WHERE a.INT_JOBID=b.INT_JOBID 	 ";	  
				sql = sql +"  AND b.INT_APPID= g.INT_APPID	 ";	  
				sql = sql +"  AND b.INT_PCOUNTRYID=c.INT_COUNTRYID 	 ";	  
				sql = sql +"  AND b.INT_PSTATE=d.INT_STATEID 	 ";	  
				sql = sql +"  AND b.INT_PDISTRICTID=e.INT_DISTRICTID	 ";	   
				sql = sql +"  AND b.INT_PCITY=f.INT_CITYID 	 ";	  
				sql = sql +"  AND g.INT_CATEGORY=h.INT_EMPLOYEECATEGORYID 	 ";	  
				sql = sql +"  AND g.INT_DESIGID=i.INT_DESIGID	 ";	  
				sql = sql +"  AND g.INT_OFFICEID=j.INT_OFFICEID	 ";	
				sql = sql +"  AND g.CHR_ACCEPT  = 'N' "; 
				sql = sql +"  AND b.INT_APPID="+applicantid;
				//out.println(sql);
				String rowdata[][]   =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	
				if(rowdata.length<1)
					response.sendRedirect(com.my.org.erp.common.CommonFunctions.getPath(request));
				%>
                </p></td>
              </tr>
              <tr>
                <td height="19" colspan="2"><div align="center" class="bolddeepred">
                    <div align="center">Hi, <%=rowdata[0][3]+"  " +rowdata[0][4] %>&nbsp; </div>
                </div></td>
              </tr>
              <tr>
                <td height="19" colspan="2"><%
				  if("1".equals(rowdata[0][29]))
				  {
				  %>
                    <table width="474" border="0" align="center" cellpadding="0" cellspacing="0">
                      <tr>
                        <td width="233" class="boldEleven">&nbsp;</td>
                        <td width="267" class="boldEleven">&nbsp;</td>
                      </tr>
                      <tr>
                        <td class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">&nbsp;</td>
                      </tr>
                      <tr>
                        <td class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">&nbsp;</td>
                      </tr>
                      <tr>
                        <td valign="top" class="boldEleven">Confirmation Description <font color="red">*</font></td>
                        <td class="boldEleven"><textarea name="comments" cols="50"
										rows="5" class="formText135" id="comments" tabindex="9" onKeyUp="textArea('comments','2000')"></textarea>                        </td>
                      </tr>
                      <tr>
                        <td class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">
<input name="filename" type="hidden" id="result" value="OfferLetter">
<input name="actionS" type="hidden" id="actionS" value="HRMOfferLetterAcceptAdmin">
<input name="noticeperiod" type="hidden" id="noticeperiod" value="<%=request.getParameter("noticeperiod")%>">
<input name="random" type="hidden" id="random" value="<%=request.getParameter("random")%>">
<input name="applicantid" type="hidden" id="random2" value="<%=request.getParameter("applicantid")%>">
<input name="ndate" type="hidden" id="ndate" value="<%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DATE_FORMAT(DATE_ADD(now(), INTERVAL "+request.getParameter("noticeperiod")+" DAY),'%d-%m-%Y')")[0][0]%>">
<input name="cdate" type="hidden" id="cdate" value="<%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DATE_FORMAT(now(),'%d-%m-%Y')")[0][0]%>"></td>
                      </tr>
                      <tr>
                        <td class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">&nbsp;</td>
                      </tr>
                      <tr>
                        <td colspan="2" class="boldEleven"><table  border="0" align="center" cellpadding="2" cellspacing="2">
                            <tr>
                              <td width="130"><input type="submit" name="Submit" id="submit_btn" class="tMLAscreenHead" value="Accept Offer"  /></td>
                            </tr>
                          </table>
                            <%
					  }
					  else
					  {
					  	out.println("<br><br><h1> <center> <font color='red'>Your notice period over due so we could'nt join our organisation....</font></center></h1><br><br>");
					  }
					  %>                        </td>
                      </tr>
                  </table></td>
              </tr>
              <tr>
                <td height="19" colspan="2">&nbsp;</td>
              </tr>
              <tr>
                <td height="19" colspan="2">&nbsp;</td>
              </tr>
              <tr>
                <td height="19" colspan="2">&nbsp;</td>
              </tr>
          </table></TD>
          <TD noWrap width=7><SPACER height="1" width="1" 
                        type="block" /></TD>
          <TD class=BorderLine width=1><SPACER height="1" width="1" type="block" /></TD>
        </TR>
        <TR>
          <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/BLCorner.gif" width=7></TD>
          <TD height=6><SPACER height="1" width="1" type="block"/></TD>
          <TD colSpan=2 rowSpan=2 valign="bottom"><div align="right"><IMG height=7 src="../Image/General/BRCorner.gif" width=7></div></TD>
        </TR>
        <TR>
          <TD class=BorderLine height=1><SPACER height="1" width="1" type="block" /></TD>
        </TR>
      </TBODY>
    </TABLE></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><%@ include file="../footer.jsp"%></td>
  </tr>
</table>
 
  
</form>

<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
</body>
</html>