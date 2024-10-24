<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<title> :: PAYROLL ::</title>


 
 
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
.style4 {color: #FF0000}
-->
</style>
</head>
<body  onpaste='return false;'>
<p><br>
<table width="739" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="739"><table width="693" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <th width="150" class="boldElevenPrint" scope="col"><div align="left">
          <%    
      String type=request.getParameter("type");
      String company=request.getParameter("company");
	  String branch = request.getParameter("branch");
	  String Office = request.getParameter("Office");
      
      int start=0,end=0;
      int year=Integer.parseInt(request.getParameter("Year"));
      String comname="",comst="",comcity="",compin="",from="",to="";
      String sql="",bra="",off="";
      sql="select * from com_m_company where INT_COMPANYID="+company;
      String datacom[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
      if(datacom.length>0)
      {
      comname=datacom[0][1];
      comst=datacom[0][3];
      comcity=datacom[0][4];
      compin=datacom[0][6];
      }
      String mon="",mon1="";
      if(type.equals("O"))
      {
    	 mon="'October','November','December'";
    	 mon1="'January','February','March'";
          from="OCT-"+(year-1);
    	  to="MAR-"+year;
    	  start=year-1;
    	  end=year;
      }
      else
      {
    	  mon="'April','May','June'";
    	  mon1="'July','August','September'";
    	  from="APRIL-"+year;
    	  to="SEP-"+year;
    	  start=year;
    	  end=year;
      }
	  if(!"-1".equals(branch))
		bra = " AND b.INT_BRANCHID=  "+branch;
	if(!"0".equals(Office))
		off = " AND b.INT_OFFICEID=  "+Office;
 %>
          51-77579-90</div></th>
        <th width="350" class="boldElevenPrint" scope="col"><%= comname %> </th>
        <th width="200" class="boldElevenPrint" scope="col">&nbsp;<%= from%>&nbsp;TO&nbsp;<%=to %></th>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="31"><table width="200" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <th class="boldElevenPrint" scope="col">FORM-6-2</th>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td align="center" >
	
	<table width='800'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' align="center" >
      <tr  bgcolor='#ffffff'>
        <th width="34" class="boldElevenPrint" scope="col">Sl. No.</th>
        <th width="75" class="boldElevenPrint" scope="col">Insurance Number </th>
        <th width="141" class="boldElevenPrint" scope="col">Name</th>
        <th width="48" class="boldElevenPrint" scope="col">No. Of days for which wages paid </th>
        <th width="82" class="boldElevenPrint" scope="col">Total amount of wages paid </th>
        <th width="63" class="boldElevenPrint" scope="col">Employee contri -bution deducted </th>
        <th width="68" class="boldElevenPrint" scope="col">Daily wages </th>
        <th width="65" class="boldElevenPrint" scope="col">still continues working and drwing wages within the </th>
        <th width="82" class="boldElevenPrint" scope="col"> DISPENSARY </th>
        <th width="62" class="boldElevenPrint" scope="col">Remarks</th>
      </tr>
      <%

    
	sql="select a.CHR_EMPNAME,sum(a.DOU_WORKDAYS),sum(a.DOU_BASIC),sum(a.DOU_ESI)"+
		",b.CHR_ESINO,b.CHR_TYPE,b.CHR_HOLD from pay_t_salary a,com_m_staff b  where ((a.CHR_MONTH in ("+mon+") and a.INT_YEAR=("+start+")) or (a.CHR_MONTH in ("+mon1+") and a.INT_YEAR=("+end+")))"+ 
	" and a.CHR_EMPID=b.CHR_EMPID and b.CHR_ESI<>'N' and b.INT_COMPANYID="+company+" ";
	sql = sql +bra;
	sql = sql +off+"  group by a.chr_empid order by a.CHR_EMPNAME";
	 
	String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	for(int i=0;i<data.length;i++){
	 out.println("<tr bgcolor='#ffffff'>");
      out.println("<th width='41' scope='col' class='boldElevenPrint' height='23'>"+(i+1)+"</th>");
      out.println("<th width='80' scope='col' class='boldElevenPrint'>&nbsp;"+data[i][4]+"</th>");
      if(data[i][5].equals("T"))
			out.println("<td class='boldElevenPrint'>"+data[i][0]+" <font color='red'>*</font>");
			else if(data[i][6].equals("Y"))
			out.println("<td class='boldElevenPrint'>"+data[i][0]+" <font color='red'>**</font>");
			else
		out.println("<td class='boldElevenPrint'>"+data[i][0]);
		out.println("<th width='52' scope='col' class='boldElevenPrint' align='right'>"+data[i][1]+"</th>");
      out.println("<th width='71' scope='col' class='boldElevenPrint' align='right'>"+data[i][2]+"</th>");
      out.println("<th width='83' scope='col' class='boldElevenPrint' align='right'>"+data[i][3]+"</th>");
      out.println("<th width='71' scope='col' class='boldElevenPrint' align='right'>"+com.my.org.erp.common.CommonFunctions.Round(Double.parseDouble(data[i][2])/Double.parseDouble(data[i][1]))+"</th>");
	  if(data[i][5].equals("T"))
      out.println("<th width='68' scope='col' class='boldElevenPrint' align='center'>&nbsp;No</th>");
	  else
	  out.println("<th width='68' scope='col' class='boldElevenPrint' align='center'>&nbsp;Yes</th>");
      out.println("<th width='108' scope='col' class='boldElevenPrint' align='left'>&nbsp;</th>");
      out.println("<th width='62' scope='col' class='boldElevenPrint' align='left'>&nbsp;</th>");
   out.println("</tr>");}
	%>
    </table></td>
  </tr>
  <tr>
    <td class="boldElevenPrint">Note : <span class="style4">*</span> - Resigned <span class="style4">**</span> - Hold </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table width="739" height="29" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <th width="144" class="bolddeepblue" scope="col"><div align="center">UDC</div></th>
        <th width="227" scope="col"><div align="left" class="bolddeepblue">
            <div align="center">HEAD CLERK </div>
        </div></th>
        <th width="406" scope="col"><div align="left" class="bolddeepblue">
            <div align="center">BRANCH MANAGER </div>
        </div></th>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
<p><BR />
</p>
<p>&nbsp;</p>
<table border="0" align="center" cellpadding="0" cellspacing="3">
  <tr>
    <td width="56"><input class="buttonbold14" type="button" name="Submit"  value="Close"   accesskey="c"  onclick="redirect('Payrollmain.jsp')" /></td>
  </tr>
</table>
<p>&nbsp;</p>
</body>
</html>
