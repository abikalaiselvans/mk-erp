<%@ page import="java.lang.*,java.util.*,java.io.*,java.sql.*"%>
<%@ page import="java.io.*,java.util.*"%>
 <%
try
{

%>
 
<% 
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='GEN' ")[0][0]%></title>
<script language="javascript" src="../JavaScript/common/CheckUniqueAjax.js"  ></script>
<script language="javascript"   src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
	 
	 

 
function Validate()
{
 		 
		if(
			checkNullSelect('itemgroup','Select Itemgroup..', '0')
			&& checkNull('itemname', 'Enter Itemname..')
			&& checkNull('description', 'Enter Description..')
			&& checkNull('pdescription', 'Enter Purchase Description..')
			&& checkNull('pprice', 'Enter Purchase Price..')
			&& checkNull('sdescription','Sales Description..' )
			&& checkNull('sprice','Sales Price..' )
			&& checkNullSelect('warranty', 'Select Warranty..','0')
			 
			
			//itemgroup,itemname,description,active,pdescription,pprice,sdescription, sprice,warranty,returnable
		)
		{

  			return true;			
		}
		else
		{

			return false;
		}	    
 }
 
</script>
 

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<body  onpaste="return false;" leftmargin="0" rightmargin="0" topmargin="0">
<form  AUTOCOMPLETE = "off"   name="casesheet" method="post" onSubmit="return Validate()" 	action="../SmartLoginAuth">
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	 
	<tr>
	  <td height="19">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="424"
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
				  <td width="412"><table cellspacing="2" cellpadding="2" width="500" align="center"
						border="0">
                    <!--DWLayoutTable-->
                    <tbody>
                      <tr>
                        <td height="19" colspan="3" align="right" valign="top" class="boldgre"><div align="center">ITEM
                            <%     
   // itemgroup,itemname,description,active,pdescription,pprice,sdescription, sprice,warranty,itemgroup,returnable
  	String action=request.getParameter("action1");  
	String itemgroup="",itemname="",description="",active="";
	String pdescription="",pprice="",sdescription="";
	String sprice="",warranty="",returnable="";
	String actionStu="";
	String buttonvalue="";
	String edlink="";
	String id="";
	String s1="",s2="";
	if(action.equals("Edit"))
	{
		 actionStu="ASSItemEdit";
		 buttonvalue="Update";
		 id=request.getParameter("id");
		 String qry="SELECT INT_ITEMID,INT_ITEMGROUPID,CHR_ITEMNAME,CHR_DES,INT_ACTIVE ,CHR_PURCHASEDES ,DOU_PURCHASEPRICE , CHR_SALESDES  ,DOU_SALESPRICE  ,CHR_WARRANTY  ,CHR_RETURNABLE FROM  asset_m_item  WHERE INT_ITEMID="+id;
		  		 
		 		String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(qry);
				for(int i=0;i<10;i++)
					if("-".equals(data[0][i]))
					
				itemgroup=data[0][1];
				itemname=data[0][2];
				description=data[0][3];
				active=data[0][4];
	 			pdescription=data[0][6];
				pprice=data[0][6];
				sdescription=data[0][7];
				sprice=data[0][8];
				warranty=data[0][9];
				returnable=data[0][10];
				edlink="";
		  
	}		 
	 else
	{
		actionStu="ASSItemAdd";
		buttonvalue="Add";
		itemgroup="0";itemname="";description="";active="1";
	 	pdescription="";pprice="";sdescription="";
		sprice="";warranty=""; returnable="Y";
		 edlink="  onBlur=\"upperMe(this), CheckUnique(this,'divunitname','asset_m_item','CHR_ITEMNAME')\"  onKeyUp=\"upperMe(this),CheckUnique(this,'divunitname','asset_m_item','CHR_ITEMNAME')\"  ";
				
		 
	} 
%>
                        </div></td>
                      </tr>
                      <tr>
                        <td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory </span></td>
                      </tr>
                      <tr>
                        <td height="17" class="boldEleven">Item group  <span
									class="bolddeepred">* </span></td>
                        <td width="371">
						
						<select name='itemgroup' id='itemgroup'>
                            <option value="0">Select Group</option>
						<%
				String	groupdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_ITEMGROUPID,CHR_GROUPNAME FROM asset_m_itemgroup ORDER BY CHR_GROUPNAME");
				for(int i=0;i<groupdata.length;i++)
					out.println("<option  value='"+groupdata[i][0]+"'>"+groupdata[i][1]+"</option>");		
									
					%>
                          </select>
						  <script language="javascript">setOptionValue('itemgroup','<%=itemgroup%>')</script>                        </td>
                      </tr>
                      <tr>
                        <td height="17" class="boldEleven">Item Name  <span
									class="bolddeepred">*</span></td>
                        <td colspan="2" align="left"><input type="type"
									name="itemname" id="itemname" class="formText135"
									value="<%=itemname%>"  <%=edlink%> maxlength="50"
									size="35" />
                            
                            <div id="divunitname"></div></td>
                      </tr>
                       
                      <tr>
                        <td width="115" height="17" valign="top" class="boldEleven">Description<span class="bolddeepred">*</span></td>
                        <td colspan="2" align="left" class="bolddeepblue"><textarea
									name="description"  id="description" cols="30" rows="5" class="formText135"><%=description%></textarea>                        </td>
                      </tr>
                      <tr>
                        <td class="boldEleven">Active <span
									class="bolddeepred">* </span>
									
									<%
										s1="";s2="";
										if("1".equals(active))
											s1 = "checked ='checked' ";
										else
											s2 = "checked ='checked' ";
									%>
						</td>
                        <td align="left"><table width="100" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td><input name="active"
									type="radio" class="formText135" id="radio" value="1" <%=s1%>
									  /></td>
                            <td><font class="boldEleven">True</font></td>
                            <td><input
									name="active" type="radio" class="formText135" value="0"
									id="active"  <%=s2%> /></td>
                            <td><font class="boldEleven"> False</font></td>
                          </tr>
                        </table></td>
                      </tr>
                      <tr>
                        <td class="boldEleven">Purchase
                        Description<span class="bolddeepred">*</span></td>
                        <td align="left"><textarea
									rows="3" cols="30" class="formText135" name="pdescription"
									id="pdescription"><%=pdescription%></textarea></td>
                      </tr>
                      <tr>
                        <td class="boldEleven">Purchase Price<span class="bolddeepred">*</span></td>
                        <td align="left"><input name="pprice"
									id="pprice" value="<%=pprice %>" size="30" type="text"
									class="formText135" maxlength="7" onKeyPress="return numeric_only(event,'pprice','10');"
									  /></td>
                      </tr>
                      <tr>
                        <td class="boldEleven">Sales
                        Description<span class="bolddeepred">*</span></td>
                        <td align="left"><textarea
									rows="3" cols="30" class="formText135" name="sdescription"
									id="sdescription"><%=sdescription %></textarea></td>
                      </tr>
                      <tr>
                        <td class="boldEleven">Sales Price<span class="bolddeepred">*</span></td>
                        <td align="left"><input name="sprice"
									id="sprice" value="<%=sprice %>" size="30" type="text"
									class="formText135" maxlength="7"
									onKeyPress="return numeric_only(event,'sprice','10');"/></td>
                      </tr>
                       
                      <tr>
                        <td valign="top" class="boldEleven">Warranty
                        Info<span class="bolddeepred">*</span></td>
                        <td align="left" valign="top"><select name="warranty" id="warranty" style="width: 200"
									class="formText135">
									<option value="0">Select Warranty</option>
                         <%
							 out.println("<option  value='0.3'>3 - Months </option>");
							 out.println("<option  value='0.6'>6 - Months </option>");
							for(int u=0;u<=10;u++)
							{
								if(u==0)
									out.println("<option  value='"+u+"'>No Warranty </option>");
								else if(u==1)
									out.println("<option selected='selected' value='"+u+"'>"+u+" - Year</option>");
								else
									out.println("<option  value='"+u+"'>"+u+" - Years</option>");	
							}
							%>                  
</select>
<script language="javascript">setOptionValue('warranty','<%=warranty%>')</script>
</td>
                      </tr>
                       
                      <tr>
                        <td valign="top" class="boldEleven">Returnable
                        <%
										s1="";s2="";
										if("Y".equals(returnable))
											s1 = "checked ='checked' ";
										else
											s2 = "checked ='checked' ";
									%></td>
                        <td align="left" valign="top"><!--              <textarea rows="3" cols="30"  class="formText135" name="warranty" id="warranty"><%=warranty %></textarea>				   -->
                          <table width="100" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td><input name="returnable"
									type="radio" class="formText135" id="radio2" value="Y" <%=s1%>
									 /></td>
                              <td><font class="boldEleven">Yes</font></td>
                              <td><input
									name="returnable" type="radio" class="formText135" value="N"
									id="radio3"   <%=s2%> /></td>
                              <td><font class="boldEleven"> No </font></td>
                            </tr>
                          </table>
                          <span class="boldEleven">
                          <input type="hidden" name="filename" value="Item" />
                          <input type="hidden" name="actionS" value="<%=actionStu %>" />
                          <input name="rowid" type="hidden" id="rowid" value="<%=id%>" />
                          </span></td>
                      </tr>
                       
                       
                      <tr>
                        <td height="30" colspan="2"  valign="top"><table border="0" align="center" cellpadding="1" cellspacing="1">
                            <tr>
                              <td width="56"><input name="Submit" type="submit" id="Submit" class="buttonbold" value="<%=buttonvalue%>" /></td>
                              <td width="56" colspan="2"><div align="center">
                                  <input name="button" type="button" id="button" class="buttonbold"  value="Close"   accesskey="c"  	onclick="redirect('ItemView.jsp')" />
                              </div></td>
                            </tr>
                        </table></td>
                      </tr>
                    </tbody>
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
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</form>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
