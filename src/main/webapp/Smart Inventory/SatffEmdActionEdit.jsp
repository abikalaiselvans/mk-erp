<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>


<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>


$(function() {
		var dates = $( "#TenderDate, #timeline" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			numberOfMonths: 1,
			changeMonth: true,
			changeYear: true,
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true,
			minDate: -15, maxDate: "+10D",
			onSelect: function( selectedDate ) {
				var option = this.id == "TenderDate" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(
						instance.settings.dateFormat ||
						$.datepicker._defaults.dateFormat,
						selectedDate, instance.settings );
				dates.not( this ).datepicker( "option", option, date );
			}
		});
	});
	
 
</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">



<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
function validate()
{
	if(
		checkNullSelect('EmdType','Select Emd Type','0') 
		&& checkNullSelect('division','Select division','0') 
		&& checkNull('TenderNo','Enter Tender No') 
		&& checkNull('TenderDate','Enter Tender Date') 
		&& checkNull('timeline','Enter Tender timeline') 
		&& checkNullSelect('CustomerName','Enter Customer Name','0') 
		&& checkNull('EmdAmt','Enter EMD Amount') 
		&& checkNull('EmdFavourOf','Enter In Favour Of') 
		&& checkNull('Payableat','Enter Payable at') 
		&& checkNull('OrderValue','Enter Order Value') 
		&& checkNullSelect('Bank','Select Bank','0')
		&& checkNull('ddnumber','Enter Reference Number') 
		&& checkNull('Descrip','Enter Description') 
	)
		return true;
	else
		return false;
		

}
</script>

<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit=" return validate()">

  <p>&nbsp;</p>
  <table class="BackGround" cellspacing="0" cellpadding="0" width="400"
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
      <td width="412"><table width="400" height="163" border="0" align="center"
						cellpadding="1" cellspacing="1"  >
        <tr class="BackGround">
          <td width="393" height="31" class="BackGround"><div align="center"><strong>EMD<span class="boldThirteen">
            <%
							 
							 
							
						%>
            <%
String Rowid = request.getParameter("Rowid");
String sql="SELECT INT_EMD_TYPE,DAT_CREATION,CHR_TENDERNO,DATE_FORMAT(DAT_TENDER_LASTDATE,'%d-%m-%Y'),CHR_TENDER_DESC,INT_CUSTOMERID,DOU_EMD_AMOUNT,CHR_EMD_INFAVOUROF,CHR_PAYABLE_AT,DOU_ORDERVALUE,INT_BANKGROUPID,CHR_REF,INT_DIVIID,DATE_FORMAT(DAT_TENDER_TIMELINE,'%d-%m-%Y'),CHR_DD_NUMBER  ";
sql = sql+" FROM inv_t_emd_informations  WHERE  INT_EMDID="+Rowid+"";
String data[][] = CommonFunctions.QueryExecute(sql);
 
%>
          </span></strong></div></td>
        </tr>
        <tr>
          <td height="127" valign="top" class="footermenu"><table width="400" height="380" border="0" align="center">
            <tr>
              <td width="31" height="24" align="left">&nbsp;</td>
              <td width="170" align="left"><div align="left"><span class="boldEleven">Emd Type<span class="bolddeepred"> *</span></span></div></td>
              <td width="231" class="boldEleven" align="left"><div align="left">
                  <select name="EmdType" class="formText135" style="width: 100" id="EmdType" tabindex="1" onChange="loadEmd('0')">
                    <option value='0'>Select EMD type</option>
                    <option value="E">Earnest money deposit </option>
                    <option value="B">Bank guarantee </option>
                    <option value="S">Security deposit </option>
                  </select>
              </div></td>
              <script language="javascript">setOptionValue('EmdType','<%=data[0][0]%>')</script>
              <td width="15">&nbsp;</td>
            </tr>
            <tr>
              <td align="left">&nbsp;</td>
              <td align="left"><span class="boldEleven">Division<span class="bolddeepred"> *</span></span></td>
              <td align="left" class="boldEleven" ><select name="division"  style="width: 100"
							class="formText135" id="division"  
							 >
                  <option value="0">Select Division</option>
                  <%
								String division[][] =  CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                </select>
                  <script language="javascript">setOptionValue('division','<%=data[0][12]%>')</script>
                  </span></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td width="31" align="left">&nbsp;</td>
              <td width="170" align="left"><div align="left"><span class="boldEleven">Tender No <span class="bolddeepred">*</span></span>&nbsp;</div></td>
              <td width="231" class="boldEleven" align="left"><div align="left">
                  <input type="text" size ="20" class="formText135" name="TenderNo" id="TenderNo" value="<%=data[0][2]%>" maxlength="95" onKeyUp="upperMe(this)"/>
              </div></td>
              <td width="15">&nbsp;</td>
            </tr>
            <tr>
              <td width="31" align="left">&nbsp;</td>
              <td width="170" align="left"><div align="left"><span class="boldEleven">Tender Last Date<span class="bolddeepred">*</span></span>&nbsp;</div></td>
              <td width="231" class="boldEleven" align="left"><div align="left">
                  <input name="TenderDate"
									type="text" class="formText135" id="TenderDate"
								 value="<%=data[0][3]%>" size="21" readonly="readonly"/>
                &nbsp;</div></td>
              <td width="15">&nbsp;</td>
            </tr>
            <tr>
              <td align="left">&nbsp;</td>
              <td align="left" class="boldEleven">Tender Timeline <span class="bolddeepred">*</span></td>
              <td class="boldEleven" align="left"><input name="timeline"
									type="text" class="formText135" id="timeline" value="<%=data[0][13]%>"
									 size="20" maxlength="20" readonly="readonly"/></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td width="31" align="left">&nbsp;</td>
              <td width="170" align="left"><div align="left"><span class="boldEleven">Customer Name<span class="bolddeepred">*</span></span>&nbsp;</div></td>
              <td width="231" class="boldEleven" align="left"><div align="left">
                  <select name="CustomerName" class="formText135" style="width:100" id="CustomerName">
                    <option value='0' >Select CustomerName</option>
                    <jsp:include page="LoadCustomer.jsp" />          
                  </select>
                  <script language="javascript">setOptionValue('CustomerName','<%=data[0][5]%>')</script>
              </div></td>
              <td width="15">&nbsp;</td>
            </tr>
            <tr>
              <td width="31" align="left">&nbsp;</td>
              <td width="170" align="left"><div align="left"><span class="boldEleven">EMD Amount <span class="bolddeepred">*</span></span>&nbsp;</div></td>
              <td width="231" class="boldEleven" align="left"><div align="left">
                  <input type="text" size ="20" class="formText135" name="EmdAmt" id="EmdAmt" onKeyPress="return numeric_only(event,'EmdAmt','12')" maxlength="9" value="<%=data[0][6]%>"/>
              </div></td>
              <td width="15">&nbsp;</td>
            </tr>
            <tr>
              <td width="31" align="left">&nbsp;</td>
              <td width="170" align="left"><div align="left"><span class="boldEleven">Emd Favour Of<span class="bolddeepred"> *</span></span>&nbsp;</div></td>
              <td width="231" class="boldEleven" align="left"><div align="left">
                  <input type="text" size ="20" class="formText135" name="EmdFavourOf" id="EmdFavourOf" value="<%=data[0][7]%>" maxlength="95" onKeyUp="upperMe(this)"/>
              </div></td>
              <td width="15">&nbsp;</td>
            </tr>
            <tr>
              <td width="31" align="left">&nbsp;</td>
              <td width="170" align="left"><div align="left"><span class="boldEleven">Payable at<span class="bolddeepred"> *</span></span>&nbsp;</div></td>
              <td width="231" class="boldEleven" align="left"><div align="left">
                  <input type="text" size ="20" class="formText135" id = "Payableat" name="Payableat" value="<%=data[0][8]%>" maxlength="95" onKeyUp="upperMe(this)"/>
              </div></td>
              <td width="15">&nbsp;</td>
            </tr>
            <tr>
              <td width="31" align="left">&nbsp;</td>
              <td width="170" align="left"><div align="left"><span class="boldEleven">Order Value<span class="bolddeepred"> *</span></span>&nbsp;</div></td>
              <td width="231" class="boldEleven" align="left"><div align="left">
                  <input type="text" size ="20"  id="OrderValue" class="formText135" name="OrderValue" onKeyPress="return numeric_only(event,'OrderValue','12')"  maxlength="9" value="<%=data[0][9]%>"/>
              </div></td>
              <td width="15">&nbsp;</td>
            </tr>
            <tr>
              <td width="31" align="left">&nbsp;</td>
              <td width="170" align="left"><div align="left"><span class="boldEleven">Bank <span class="bolddeepred">*</span></span>&nbsp;</div></td>
              <td width="231" class="boldEleven" align="left"><div align="left">
                  <select name="Bank" style="width: 100" class="formText135" id="Bank">
                    <option value='0' >Select Bank</option>
                    <%
						String Bank[][] =  CommonFunctions.QueryExecute(" SELECT INT_BANKGROUPID,CHR_BANKGROUPNAME FROM com_m_bankgroup");
 						if(Bank.length>0)
 							for(int u=0;u<Bank.length;u++)
							out.println("<option value='"+Bank[u][0]+"'>"+Bank[u][1] + "</option>");
 				   %>
                  </select>
                  <script language="javascript">setOptionValue('Bank','<%=data[0][10]%>')</script>
              </div></td>
              <td width="15">&nbsp;</td>
            </tr>
            <tr>
              <td align="left">&nbsp;</td>
              <td class="boldEleven">DD/Cheque/Other Ref Number <span class="bolddeepred">*</span>&nbsp;</td>
              <td class="boldEleven" align="left"><input name="ddnumber" type="text" class="formText135"  id="ddnumber"   value="<%=data[0][14]%>" size ="20" maxlength="10" /></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td width="31" align="left">&nbsp;</td>
              <td width="170" align="left"><div align="left"><span class="boldEleven">Description<span class="bolddeepred">*</span></span>&nbsp;</div></td>
              <td width="231" class="boldEleven" align="left"><div align="left">
                  <textarea type="text" name="Descrip"   cols="24" id="Descrip" rows="5" class="formText135"><%=data[0][4]%></textarea>
              </div></td>
              <td width="15">&nbsp;</td>
            </tr>
            <tr>
              <td align="left" class="boldEleven">&nbsp;</td>
              <td align="left" ><div align="left"></div></td>
              <td align="left"><input type="hidden" name="actionS" value="STAEmdAssignEdit"/>
                  <input type="hidden" name="filename" value="Emd" />
                  <input name="Rowid" type="hidden" id="Rowid" value="<%=Rowid%>">
              </td>
              <td>&nbsp;</td>
            </tr>
            <tr align="left">
              <td colspan="4"><table border="0" align="center" cellpadding="2"
										cellspacing="2">
                  <tr>
                    <td width="56"><input type="submit" name="Submit"	id="submit_btn" class="buttonbold" value="Update" /></td>
                    <td width="56"><input type="button" name="submit" class="buttonbold"  value="Close"   accesskey="c" 	onClick="redirect('StaffEMD.jsp')" /></td>
                  </tr>
              </table></td>
            </tr>
          </table></td>
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
</form>
 