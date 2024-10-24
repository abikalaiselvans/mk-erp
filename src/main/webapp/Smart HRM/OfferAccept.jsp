<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"  %>
<%@ page import="com.my.org.erp.common.CommonFunctions" %>

<%
try
{
%>
<html>
<head>

<title>:: HRM ::</title>


<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<style type="text/css">
<!--
a:visited {
	color: #663366;
}
a:hover {
	color: #FF0000;
}
a:active {
	color: #0000FF;	
}
-->
</style>
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="../JavaScript/HRM/Offer.js"></script>
<script language="javascript">

 	
	
	 
	
</script>		
 
<style type="text/css">
<!--
.style3 {color: #000000}
-->
</style>
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
.style4 {font-weight: bold}
-->
</style>
</head>

<script language="javascript">
	function textArea(ctr,size)//it also accept '-'minus charactor
	{
		var txtval=document.getElementById(ctr).value;
		var len=size;
		 if(txtval.length>len)	
		{
			
			msg="Max char reached";		
			alert(msg);
			//show_popup(msg);
			document.getElementById(ctr).value=txtval.substring(0,size);
			document.getElementById(ctr).focus();
		}
	}
	
	
function checkNull(ctr,msg)
{
	var val=document.getElementById(ctr).value;
	if(val=="")
	{
	   alert(msg);	
	   document.getElementById(ctr).focus();
	   return false;
	}
	else
	   return true;
}



 
function checkDate(ctr1,ctr2)
  {
   try
   {
  	var date1=document.getElementById(ctr1).value;
  	var d1=date1.substr(0,2);
	var m1=date1.substr(3,2);
	var y1=date1.substr(6,4);
  	var date2=document.getElementById(ctr2).value;
	var d2=date2.substr(0,2);
	var m2=date2.substr(3,2);
	var y2=date2.substr(6,4);
	if(!isNaN(d1) && !isNaN(m1) && !isNaN(y1))
	{
	  if(!isNaN(d2) && !isNaN(m2) && !isNaN(y2))
	  { 
		 if((d1<=d2 && m1==m2 && y1==y2) ||(d1<=d2 && m1<=m2 && y1<=y2) ||
		 (m1<m2 && y1==y2) || (y1<y2) )
		  {
		    return true;
		  }
		  else
		  {
		 	alert(" To Date Should Be Greater Than From Date");
		 	document.getElementById(ctr2).value="";
		    document.getElementById(ctr2).focus();
		   	return false;
		  }
	  }
	  else
	  {
		  alert("Enter Correct Date");
		  document.getElementById(ctr2).value="";
		  document.getElementById(ctr2).focus();
		  return false;
	  }	  
	}
	else
	{
	  alert("Enter Correct Date");
	  document.getElementById(ctr1).value="";
	  document.getElementById(ctr1).focus();
	  return false;
	}
   }
   catch(err)
   {
      alert(err);
   }
  }
  
  
  

function Validate()
{
	
	 
	if( checkNull('comments','Enter the Description....')  )
		return true;
	else
		return false;
}

</script>		


<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >


<table width="100%" height="106" border="0" cellpadding="0" cellspacing="0"  id="header"> 
  <tr bgcolor="002B5B">
    <td height="62"><div align="right"><img src="../images/top_banner.png"  height="62" /></div></td>
  </tr>
  <tr>
    <td bgcolor="#F4BAAA"><table width="100%" height="20" border="0" cellpadding="0" cellspacing="0" class="headerBackground" >
           
    </table></td>
  </tr>
  <tr class="headerBackground"  >
    <td width="50"  id="menutd">&nbsp; </td>
  </tr>
</table>


 <table width="100%" height="263" align="center"  >
  <tr>
    <td height="21" align="center">&nbsp;</td>
  </tr>
  <tr>
    <td height="21" align="center">&nbsp;</td>
  </tr>
  <tr>
    <td height="151" align="center"><TABLE width=787 border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#dce4f9" class=BackGround>
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
                <td height="19" colspan="2">&nbsp; </td>
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
                <td height="19" colspan="2"><form name="form1" method="post" action="../SmartLoginAuth" onSubmit="return Validate()">
                  
				  <%
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
										rows="5" class="formText135" id="comments" tabindex="9" onKeyUp="textArea('fcomments','2000')"></textarea>
                      </td>
                    </tr>
                    <tr>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven"><input name="filename" type="hidden" id="result" value="OfferLetter">
                        <input name="actionS" type="hidden" id="actionS" value="HRMOfferLetterAccept">
                        <input name="Username" type="hidden" id="Username" value="MKS" />
                        <input name="noticeperiod" type="hidden" id="noticeperiod" value="<%=request.getParameter("noticeperiod")%>">
                        <input name="random" type="hidden" id="random" value="<%=request.getParameter("random")%>">
                        <input name="applicantid" type="hidden" id="random2" value="<%=request.getParameter("applicantid")%>">
                       <input name="ndate" type="hidden" id="ndate" value="<%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DATE_FORMAT(DATE_ADD(now(), INTERVAL "+request.getParameter("noticeperiod")+" DAY),'%d-%m-%Y')")[0][0]%>">
                       <input name="cdate" type="hidden" id="cdate" value="<%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DATE_FORMAT(now(),'%d-%m-%Y')")[0][0]%>"></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven">&nbsp; 
                        </td>
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
					  %>
					  
					  </td>
                    </tr>
                  </table>
                                </form>
                </td>
              </tr>
              <tr>
                <td height="19" colspan="2">&nbsp; </td>
              </tr>
              <tr>
                <td height="19" colspan="2">&nbsp;</td>
              </tr>
               
              <tr>
                <td height="19" colspan="2">&nbsp; </td>
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
    </TABLE>    </td>
  </tr>        
  <tr>
    <td height="17">&nbsp;</td>
  </tr>
  <tr>
      <td height="17" align="center"><center>
   <tr><td height="20" ><%@ include file="../footer.jsp"%></td></tr>
</table>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>

