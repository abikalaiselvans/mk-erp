 <%@ page import="com.my.org.erp.common.*"%>

  <%
try
{ 
	String salesno = request.getParameter("salno");
	boolean f = CommonFunction.RecordExist("SELECT count(*) FROM inv_t_directsales WHERE CHR_SALESNO='"+salesno+"'");
	String perdata[][]= CommonInfo.RecordSetArray("SELECT * FROM inv_t_directsales WHERE CHR_SALESNO='"+salesno+"'");
	String sql="";
	if(f)
	{
%> 
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
   <tr>
     <td><div align="center"><strong>I N V O I C E</strong> </div></td>
   </tr>
   <tr>
     <td>&nbsp;</td>
   </tr>
   <tr>
     <td><table width="673" border="0" align="center" cellpadding="0"
								cellspacing="0">
       <tr>
         <td width="119" valign="top" class="boldEleven"><div align="left">Sale .No</div></td>
         <td width="143" valign="top" class="boldEleven"><div align="left"><%=perdata[0][3]%></div></td>
         <td width="168" valign="top" class="boldEleven"><div align="right">Sale Date</div></td>
         <td width="178" valign="top" class="boldEleven"><div align="left"><%=perdata[0][4]%></div></td>
       </tr>
       <tr>
         <td valign="top" class="boldEleven"><div align="left">CustomerName &amp; Address</div></td>
         <td valign="top" class="boldEleven"><div align="left">
             <%
			 
			   
sql="SELECT a.INT_CUSTOMERID,f.CHR_NAME,a.CHR_CONTACTPERSON, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE),CONCAT('Phone :',a.CHR_PHONE),CONCAT('E-Mail :',a.CHR_EMAIL) FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND   a.INT_CUSTOMERID="+perdata[0][6];
String vendor[][]=CommonFunctions.QueryExecute(sql);
						 
						
						
						if(!"-".equals(vendor[0][1]))
							out.println(vendor[0][1]+",<br>");
						if(!"-".equals(vendor[0][2]))	
							out.println(vendor[0][2]+",<br>");
						if(!"-".equals(vendor[0][3]))
							out.println(vendor[0][3]+".");
						
 
						
						%>
         </div></td>
         <td valign="top" class="boldEleven"><div align="left">
             <%

		String links="SalesShippingAddressupdate.jsp?salesno="+salesno;
		out.print("<a href="+links+" ><font class=boldEleven>Change <b>Shipping Address<b></font></a></td>");
	

%>
         </div></td>
         <td valign="top" class="boldEleven"><div align="left"></div></td>
       </tr>
     </table></td>
   </tr>
   <tr>
     <td>&nbsp;</td>
   </tr>
   <tr>
     <td><%
					sql = "SELECT CHR_SALESNO,CHR_ITEMID,CHR_TYPE ,INT_QUANTITY,DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,DOU_TOTAL  FROM inv_t_swapsalesitem WHERE CHR_SALESNO ='"+salesno+"'";
					String iname="";
					String itemname="";
					String datas[][] =  CommonFunctions.QueryExecute(sql);
					out.println("<table border=1 width=100% cellpadding=2 cellspacing=2>");
					out.println("<tr><th class='boldEleven'><strong>Type</strong></th>");
                    out.println("<th class='boldEleven'><strong >Item / Product Code</strong></th>");
					out.println("<th class='boldEleven'><strong >Quantity/Units</strong></th>");
					out.println("<th class='boldEleven'><strong >Unit Price</strong></th>");
					out.println("<th class='boldEleven'><strong >Discount(%)</strong></th>");
					out.println("<th class='boldEleven'><strong >Unit Discount</strong></th>");
					out.println("<th class='boldEleven'><strong >Total</strong></th>");
					     
					for(int v=0;v<datas.length; v++)
					{	
						out.print("<tr>");
						if(datas[v][2].equals("I"))
						{
							iname="Item";
							sql = "SELECT CHR_ITEMNAME ,CHR_WARRANTY FROM inv_m_item WHERE CHR_ITEMID='"+datas[v][1]+"'";
							itemname =  CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
						}	
						if(datas[v][2].equals("P"))
						{
						  iname="Product";
						  sql= "SELECT CHR_PRODUCTCODE,CHR_WARRANTY FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+datas[v][1]+"'";
						  itemname= CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
						}	
						out.println("<tr><td   class='boldEleven' >"+iname+"</td>");
						out.println("<td  class='boldEleven' >"+itemname);
						out.println("<td  class='boldEleven'  align='right' >"+datas[v][3] );
						out.println("<td  class='boldEleven'  align='right'>"+datas[v][4] );
						out.println("<td  class='boldEleven'  align='right'>"+datas[v][5] );
						out.println("<td  class='boldEleven'  align='right'>"+datas[v][6] );
						out.println("<td  class='boldEleven'  align='right' >"+datas[v][7] );
					}	
					out.println("</table>");	
					  %></td>
   </tr>
   <tr>
     <td>&nbsp;</td>
   </tr>
   <tr>
     <td><%
	
	sql = "SELECT INT_ID,CHR_SALESNO,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY,CHR_TYPE,CHR_SWAPDESC FROM inv_t_swapsalesserialno WHERE CHR_SALESNO ='"+salesno+"' ORDER By INT_ID";
	//out.println(sql);
	
	String usertype=""+session.getAttribute("USRTYPE");
	
	
	
	String recdData[][]=  CommonFunctions.QueryExecute(sql);
	int row=1;
	iname="";
	itemname="";
	String masterwarranty="";
	String h="";
	String h1="";
	String typedesc="";
	if(recdData.length>0)
	{
		out.print(" <table width='100%' border='1' cellpadding='0' cellspacing='0' >");
		out.print("<th   class='boldEleven'><b>Type</b></th>");
		out.print("<th   class='boldEleven'><b>Item / Product Code</b></th>");
		out.print("<th   class='boldEleven'><b>Description</b></th>");
		out.print("<th   class='boldEleven'><b>Serial No</b></th> ");
		out.print("<th   class='boldEleven'><b>&nbsp;</b></th> ");
		out.print("<th   class='boldEleven'><b>Warranty</b></th>");
		
		for(int v=0;v<recdData.length; v++)
		{	
			out.print("<tr>");
			if(recdData[v][5].equals("I"))
			{
				iname="Item";
				sql = "SELECT CHR_ITEMNAME ,CHR_WARRANTY,CHR_DES FROM inv_m_item WHERE CHR_ITEMID='"+recdData[v][2]+"'";
				itemname =  CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
				masterwarranty= CommonInfo.stringGetAnySelectField(sql, "CHR_WARRANTY");
				typedesc=CommonInfo.stringGetAnySelectField(sql, "CHR_DES");
			}	
			if(recdData[v][5].equals("P"))
			{
			  iname="Product";
			  sql="SELECT CHR_PRODUCTCODE,CHR_WARRANTY ,CHR_PRODUCTDESC FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+recdData[v][2]+"'";
			  itemname=CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
			  masterwarranty=CommonInfo.stringGetAnySelectField(sql, "CHR_WARRANTY");
			  typedesc=CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTDESC");
			}	
			out.println("<tr><td valign='top'  class='boldEleven' >"+iname+"</td>");
			out.println("<td  valign='top' class='boldEleven' >"+itemname);
			
			if(recdData.length>=1)
				h=" onBlur=\"getValues('serial','"+recdData.length+"' ,'error' , 'Submit')\" ";
	
	h1=" onKeyUp=\"upperMe(this),LoadUniqueCheckSales('serial"+(v+1)+"','Valid"+(v+1)+"' , 'inv_t_vendorgoodsreceived','CHR_SERIALNO','Submit','"+recdData[v][5]+"','"+recdData[v][2]+"')\" ";
	
		
			out.print("<td  valign='top' class='boldEleven'>"+typedesc+" <br> "+recdData[v][6]+"</td>");
			if("-".equals(recdData[v][3]))		
				recdData[v][3]="";
			
			out.print("<td  valign='top' class='boldEleven'>"+recdData[v][3]+"</td>");

			
			if("F".equals(usertype))
			{
				String link="SalesSerialnoupdate.jsp?itype="+recdData[v][5].trim()+"&item="+recdData[v][2].trim()+"&serial="+recdData[v][3].trim()+"&salesno="+salesno;
				
				 
				out.print("<td  valign='top' class='boldEleven' class='boldEleven'>&nbsp; </td>");
			}
			else
			{
				out.print("<td  valign='top' class='boldEleven'>&nbsp;</td>");
			}
			
			out.print("<td  valign='top' class='boldEleven'>&nbsp;"+recdData[v][4]+" -Years</td>");
			
			
			out.print("</tr>");
			row= row+1;
		}
		out.print("</table> ");
	}		
	out.println("<input type='hidden' name='length' id='length' value='"+row+"'>");
	out.println("<input type='hidden' name='salesno' id='salesno' value='"+salesno+"'>");  
%>
       <input name="seriallength" type="hidden" id="seriallength"
								value="<%=row %>" /></td>
   </tr>
   <tr>
     <td>&nbsp;</td>
   </tr>
   <tr>
     <td><table cellspacing="0" cellpadding="0" width="673" align="center"
								border="0">
       <tbody>
         <tr>
           <td valign="top" width="114" rowspan="4">Memo</td>
           <td valign="top" width="197" rowspan="4">&nbsp;</td>
           <td width="107" valign="top" class="boldEleven"><div align="left">Total</div></td>
           <td width="169" valign="top" class="boldEleven" id="totals1"><div align="right"><%=perdata[0][9]%></div></td>
         </tr>
         <tr>
           <td valign="top" class="boldEleven"><div align="left">Total Discount</div></td>
           <td width="169" valign="top" class="boldEleven"
											id="totaldiscount1"><div align="right"><%=perdata[0][10]%>(%)</div></td>
         </tr>
         <tr>
           <td valign="top" class="boldEleven"><div align="left">Tax Name</div></td>
           <td width="169" valign="top" class="boldEleven" id="tax1"><div align="right">
               <%
							sql = "SELECT CHR_TAXNAME,DOU_VALUE FROM inv_m_tax WHERE INT_TAXID ="+perdata[0][11];
							String taxdata[][] = CommonInfo.RecordSetArray(sql);
							out.println(taxdata[0][0] );
							%>
           </div></td>
         </tr>
         <tr>
           <td valign="top" class="boldEleven"><div align="left">Sales Tax</div></td>
           <td width="169" valign="top" class="boldEleven" id="salestax1"><div align="right"><%=taxdata[0][1] %>(%)</div></td>
         </tr>
         <tr>
           <td valign="top">Sale Reference</td>
           <td>&nbsp;</td>
           <td class="boldEleven"><div align="left">Sales Tax Amount</div></td>
           <td width="169" class="boldEleven" id="salestaxamount1"><div align="right"><%=perdata[0][12]%></div></td>
         </tr>
         <tr>
           <td><div align="left"></div></td>
           <td><div align="left"></div></td>
           <td class="boldEleven"><div align="left">Net Total</div></td>
           <td width="169" class="boldEleven" id="nettotal1"><div align="right"><%=perdata[0][13]%></div></td>
         </tr>
       </tbody>
     </table></td>
   </tr>
   <tr>
     <td><script language="javascript">
					  	numberWord("<%=perdata[0][13]%>","Rupees") 
					  </script></td>
   </tr>
   <tr>
     <td>&nbsp;</td>
   </tr>
 </table>
 <p>&nbsp;</p>
 <%
  }
  else
  {
  	out.println("<font class='boldred'><center>Data not found</center></font>");
  }
}
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
  
%>
  
<%@ page import="com.my.org.erp.common.CommonInfo"%>
 
