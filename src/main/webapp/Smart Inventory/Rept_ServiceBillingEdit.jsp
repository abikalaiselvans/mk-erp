 <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<body    >
<table cellspacing="0" cellpadding="0" width="424"
			align="center" border="0">
  <tbody>
    <tr>
      <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
      <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
      <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
    </tr>
    <tr>
      <td height="6"><spacer height="1" width="1" type="block" /></td>
    </tr>
    <tr>
      <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
      <td width="6"><spacer height="1" width="1" type="block" /></td>
      <td width="412"><table width="700" border="0" align="center" cellpadding="1"
					cellspacing="1">
        <tr>
          <td width="650"></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td><div align="center" class="style3">
              <%
try
{
	String servicebill= ""+request.getParameter("salno");
	String sql="";
	
	sql = " SELECT INT_DIVIID,CHR_SALESNO,DATE_FORMAT(DAT_SALESDATE,'%d-%b-%Y'),INT_CUSTOMERID,CHR_REF,CHR_DES,DOU_AMOUNT,";
	sql = sql+" CHR_PAYMENTSTATUS,CHR_SHIPPING,CHR_SHIPPINGADDRESS,CHR_OTHERREF,	CHR_DELIVERYNOTE,";
	sql = sql+" CHR_DESPATCHTHRU,CHR_DESTINATION,CHR_TERMSOFDELIVERY,CHR_CONTACTDETAILS,CHR_CONTACTNO,";
	sql = sql+"	CHR_TAXID,CHR_TAXVALUE,CHR_TAXAMOUNT,DOU_NETAMOUNT   FROM inv_t_servicebilling WHERE CHR_SALESNO='"+servicebill+"'";
	String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	
	String ssql = " SELECT b.CHR_COMPANYNAME,a.CHR_BRANCHNAME,a.CHR_STREET,e.CHR_CITYNAME,d.CHR_STATENAME,a.INT_PINCODE,a.CHR_PHONE,  ";
	ssql = ssql +" a.CHR_FAX,a.CHR_EMAIL, a.CHR_TNGSTNO,a.CHR_CSTNO,a.CHR_REGNO,a.CHR_TINNO,a.CHR_LOCALTAXNO,a.CHR_PANNO, "; 
	ssql = ssql +" b.CHR_SERVICETAX FROM com_m_branch a , com_m_company b ,com_m_country c, com_m_state d, com_m_city e ";
	ssql = ssql +" WHERE  a.INT_CITYID = e.INT_CITYID ";
	ssql = ssql +" AND a.INT_COUNTRYID = c.INT_COUNTRYID ";
	ssql = ssql +" AND a.INT_STATEID =d.INT_STATEID ";
	ssql = ssql +" AND a.INT_COMPANYID = b.INT_COMPANYID  ";
	ssql = ssql +" AND a.INT_BRANCHID="+ session.getAttribute("BRANCHID");


	
	String cpydata[][]=com.my.org.erp.common.CommonInfo.RecordSetArray(ssql);

	 
%>
            SERVICE INVOICE</div></td>
        </tr>
        <tr>
          <td><table width="100%" border="0" align="center" cellpadding="2"
							cellspacing="2">
              <tr>
                <td colspan="3" valign="top" class="boldEleven"><%
					   
					   
					   String sql1 ="SELECT CHR_NAME,CHR_ADD1,CHR_ADD2,CHR_CITY,INT_PINCODE,INT_PHONE FROM m_institution";
					   
					   out.println("<b>"+cpydata[0][0]+"</b>,<br>");
						if(!"-".equals(cpydata[0][2]))
							out.println(cpydata[0][2]+",<br>");
						if(!"-".equals(cpydata[0][3]))	
							out.println(cpydata[0][3]+",<br>");
						if(!"-".equals(cpydata[0][4]))
							out.println(cpydata[0][4]+",<br>");
						if(!"-".equals(cpydata[0][5]))
							out.println("PIN  : " +cpydata[0][5]+".");	
						if(!"-".equals(cpydata[0][6]))
							out.println("Phone : " +cpydata[0][6]+".");	
					   
					  %></td>
              </tr>
              <tr>
                <td width="308" valign="top" class="boldEleven"><table width="100%" border="0" cellspacing="2" cellpadding="0">
                    <tr>
                      <td width="36%" valign="top" class="boldEleven"><strong> Invoice .No </strong></td>
                      <td width="64%" valign="top" class="boldEleven"><%=servicebill%></td>
                    </tr>
                    <tr>
                      <td valign="top" class="boldEleven"><strong>Billing
                        Address </strong></td>
                      <td valign="top" class="boldEleven"><%
						sql="SELECT a.INT_CUSTOMERID,f.CHR_NAME,a.CHR_ADDRESS1,a.CHR_ADDRESS2, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),CONCAT('Phone :',a.CHR_AREACODE,'-',a.CHR_PHONE),CONCAT('MOBILE :',a.CHR_MOBILE),CONCAT('E-Mail :',a.CHR_EMAIL),a.CHR_TIN,CHR_CST FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND a.INT_CUSTOMERID="+data[0][3]; 
							 
							
			String vendor[][] =  CommonFunctions.QueryExecute(sql);
			
			
					 
						 
						if(!"-".equals(vendor[0][1]))
							out.println(vendor[0][1]+",<br>");
						if(!"-".equals(vendor[0][2]))	
							out.println(vendor[0][2]+",<br>");
						if(!"-".equals(vendor[0][3]))
							out.println(vendor[0][3]);
						if(!"-".equals(vendor[0][4]))	
							out.println(vendor[0][4]+",<br>");	
						if(!"-".equals(vendor[0][5]))	
							out.println(vendor[0][5]+",<br>");	
							if(!"-".equals(vendor[0][6]))	
							out.println(vendor[0][6]+",<br>");
						if(!"-".equals(vendor[0][7]))	
							out.println(vendor[0][7]+",<br>");	
						if(!"-".equals(vendor[0][8]))	
							out.println(vendor[0][9]+",<br>");	
						
						%>                      </td>
                    </tr>
                    <tr>
                      <td valign="top" class="boldEleven"><strong>Shipping
                        Address </strong></td>
                      <td valign="top" class="boldEleven"><%
						  	if("S".equals(data[0][8]))
							{
								 
						if(!"-".equals(vendor[0][1]))
							out.println(vendor[0][1]+",<br>");
						if(!"-".equals(vendor[0][2]))	
							out.println(vendor[0][2]+",<br>");
						if(!"-".equals(vendor[0][3]))
							out.println(vendor[0][3]);
						if(!"-".equals(vendor[0][4]))	
							out.println(vendor[0][4]+",<br>");	
						if(!"-".equals(vendor[0][5]))	
							out.println(vendor[0][5]+",<br>");	
							if(!"-".equals(vendor[0][6]))	
							out.println(vendor[0][6]+",<br>");
						if(!"-".equals(vendor[0][7]))	
							out.println(vendor[0][7]+",<br>");	
						if(!"-".equals(vendor[0][8]))	
							out.println(vendor[0][9]+",<br>");	
							}
							else
							{
								out.println(data[0][9]);
							}
							
							
						  %>                      </td>
                    </tr>
                    <tr>
                      <td valign="top" class="boldEleven"><strong>TIN
                        Number </strong></td>
                      <td valign="top" class="boldEleven"><%=vendor[0][4]%></td>
                    </tr>
                </table></td>
                <td width="278" valign="top" class="boldEleven"><table width="100%" height="185" border="0" cellpadding="0"
									cellspacing="2">
                    <tr>
                      <td width="40%" valign="top" class="boldEleven"><strong>Sale
                        Date </strong></td>
                      <td width="60%" valign="top" class="boldEleven"><%=data[0][2].toUpperCase()%></td>
                    </tr>
                    <tr>
                      <td valign="top" class="boldEleven"><strong>Order
                        Reference </strong></td>
                      <td valign="top" class="boldEleven"><%=data[0][10].toUpperCase()%></td>
                    </tr>
                    <tr>
                      <td valign="top" class="boldEleven"><strong>Delivery
                        Note </strong></td>
                      <td valign="top" class="boldEleven"><%=data[0][11].toUpperCase()%></td>
                    </tr>
                    <tr>
                      <td valign="top" class="boldEleven"><strong>Despatch
                        Through </strong></td>
                      <td valign="top" class="boldEleven"><%=data[0][12].toUpperCase()%></td>
                    </tr>
                    <tr>
                      <td valign="top" class="boldEleven"><strong>Destinaion</strong></td>
                      <td valign="top" class="boldEleven"><%=data[0][13].toUpperCase()%></td>
                    </tr>
                    <tr>
                      <td valign="top" class="boldEleven"><strong>Terms
                        of Delivery </strong></td>
                      <td valign="top" class="boldEleven"><%=data[0][14].toUpperCase()%></td>
                    </tr>
                    <tr>
                      <td valign="top" class="boldEleven"><strong>Contact
                        Person </strong></td>
                      <td valign="top" class="boldEleven"><%=data[0][15].toUpperCase()%></td>
                    </tr>
                    <tr>
                      <td valign="top" class="boldEleven"><strong>Contact
                        No </strong></td>
                      <td valign="top" class="boldEleven"><%=data[0][16].toUpperCase()%></td>
                    </tr>
                </table></td>
              </tr>
          </table></td>
        </tr>
        <tr>
          <td height="9"><%
		out.println("<center>");
		out.println("<table cellspacing=0 cellpadding=0 border=1 width='90%' bordercolor='#D9D9D9'>");
		out.println("<tr><td class='boldEleven' align='center'><b>S.No<td class='boldEleven' align='center'><b>Description <td  class='boldEleven' align='center'><b> Amount(Rs.)");
		out.println("<tr><td class='boldEleven'>1.<td class='boldEleven'>"+data[0][5].toUpperCase());
		out.println("<td  class='boldEleven' align='right'>"+data[0][6]);
		out.println("<tr><td colspan=3>&nbsp;");
		out.println("<tr><td colspan=3 class='boldEleven'><b>Tax Description ");
		out.println("<tr><td colspan=3>&nbsp;");
		String taxid[]=data[0][17].split(",");
		String taxvalue[]=data[0][18].split(",");
		String taxamount[]=data[0][19].split(",");
		for(int u=0; u<taxid.length;u++)
		{
		String tdata[][]=com.my.org.erp.common.CommonInfo.RecordSetArray("SELECT CHR_TAXNAME FROM inv_m_tax WHERE INT_TAXID="+taxid[u]);
		out.println("<tr><td class='boldEleven'>"+(u+1)+"."+tdata[0][0]+"<td class='boldEleven' align='right'>"+taxvalue[u]+" %");
		out.println("<td  class='boldEleven' align='right'>"+taxamount[u]);
		}	
		out.println("<tr><td colspan=2  class='boldEleven' align='right'><b>Net Total<td  class='boldEleven' align='right'>"+data[0][20]);
		out.println("</table></center>");
		
		
		
						%>          </td>
        </tr>
        <tr>
          <td valign="top">&nbsp;</td>
        </tr>

        <tr>
          <td><%
}
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
  
%></td>
        </tr>
        <tr>
          <td></td>
        </tr>
        <tr>
          <td height="38" valign="top" class="boldEleven">&nbsp;</td>
        </tr>
      </table></td>
      <td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
      <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
    </tr>
    <tr>
      <td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
      <td height="6"><spacer height="1" width="1" type="block" /></td>
      <td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
    </tr>
    <tr>
      <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
    </tr>
  </tbody>
</table>
<p>&nbsp;</p>
