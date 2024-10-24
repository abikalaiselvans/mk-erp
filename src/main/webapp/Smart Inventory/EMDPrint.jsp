<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css" />

<body onLoad="javascript:window.print()">
<br /><br /><br />
<table width="400" border="1" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="99%" height="380" border="0" align="center" cellpadding="0" cellspacing="5">
      <tr>
        <td height="24" colspan="2"><div align="center"><strong>DEPOSIT<span class="boldThirteen">
          <%
String Rowid = request.getParameter("Rowid");
String sql="SELECT INT_EMD_TYPE,DAT_CREATION,CHR_TENDERNO,DATE_FORMAT(DAT_TENDER_LASTDATE,'%d-%b-%Y') ,CHR_TENDER_DESC,FIND_A_CUSTOMER_ADDRESS(INT_CUSTOMERID),DOU_EMD_AMOUNT,CHR_EMD_INFAVOUROF,CHR_PAYABLE_AT,DOU_ORDERVALUE,INT_BANKGROUPID,CHR_REF,CHR_APPROVAL,CHR_STATUS,DATE_FORMAT(DAT_TENDER_TIMELINE,'%d-%b-%Y'),CHR_OTHERDEC,CHR_EMD_REFNUMBER  ";
sql = sql+" FROM inv_t_emd_informations  WHERE  INT_EMDID="+Rowid+"";
//out.println(sql);
String data[][]= CommonFunctions.QueryExecute(sql);
String ss=" checked= 'checked' ";
%>
        </span></strong></div></td>
        </tr>
      <tr>
        <td height="24" class="bold1">Deposit Reference Number </td>
        <td class="boldEleven"><%=data[0][16]%></td>
        </tr>
      <tr>
        <td width="217" height="24" class="bold1"><div align="left">Type<span class="bolddeepred"> </span></div></td>
        <td width="202" class="boldEleven"><div align="left">
            <%if(data[0][0].equals("E")){%>
          Earnest money deposit(E)
          <%}else if(data[0][0].equals("B")){%>
          Bank guarantee(B)
          <%}else if(data[0][0].equals("S")){%>
          Security deposit(S)
          <%}%>
        </div></td>
        </tr>
      <tr>
        <td width="217" class="bold1"><div align="left">Tender No<span class="bolddeepred"> </span></div></td>
        <td width="202" class="boldEleven" ><div align="left"><%=data[0][2]%></div></td>
        </tr>
      <tr>
        <td width="217" class="bold1"><div align="left">Tender Last Date<span class="bolddeepred"> </span></div></td>
        <td width="202" class="boldEleven"><div align="left"><%=data[0][3]%></div></td>
        </tr>
      <tr>
        <td class="bold1">Tender Timeline</td>
        <td class="boldEleven" ><%=data[0][14]%></td>
        </tr>
      <tr>
        <td width="217" class="bold1"><div align="left">Customer Name<span class="bolddeepred"> </span>&nbsp;</div></td>
        <td width="202" class="boldEleven" ><div align="left">
            <%=data[0][5]%></div></td>
        </tr>
      <tr>
        <td width="217" class="bold1"><div align="left">Deposit Amount </div></td>
        <td width="202" class="boldEleven" ><div align="left"><%=data[0][6]%></div></td>
        </tr>
      <tr>
        <td width="217" class="bold1"><div align="left">Deposit Favour Of<span class="bolddeepred"> </span></div></td>
        <td width="202" class="boldEleven" ><div align="left"><%=data[0][7]%></div></td>
        </tr>
      <tr>
        <td width="217" class="bold1"><div align="left">Payable at<span class="bolddeepred"> </span></div></td>
        <td width="202" class="boldEleven" ><div align="left"><%=data[0][8]%></div></td>
        </tr>
      <tr>
        <td width="217" class="bold1"><div align="left">Order Value<span class="bolddeepred"> </span></div></td>
        <td width="202" class="boldEleven" ><div align="left"><%=data[0][9]%></div></td>
        </tr>

    </table></td>
  </tr>
</table>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
