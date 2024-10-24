 
<%@ page import="com.my.org.erp.bean.payroll.PayrollInfo"%>
<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css" />

 
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<div align="center">
					      <table class="BackGround" cellspacing="0" cellpadding="0" width="390"
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
                                <td width="412"><table width="600" border="0" align="center" cellpadding="3" cellspacing="3">
                                    <tr>
                                      <td class="bold1"></td>
                                    </tr>
                                    <tr>
                                      <td class="bold1"><div align="center">ERROR</div></td>
                                    </tr>
                                    <tr>
                                      <td class="boldEleven"><div align="center">
                                        <%
					  	
						 	out.println("<font class='bolddeepred'>"+request.getParameter("msg")+"</font>");
						 
						
						  
					  %>
                                      </div></td>
                                    </tr>
                                    <tr>
                                      <td class="boldEleven"><table width="56" border="0" align="center" cellpadding="1"
									cellspacing="1">
                                          <tr>
                                            <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onclick="javascript:window.close()" /></td>
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
  <p>&nbsp;</p>
					     
</div>