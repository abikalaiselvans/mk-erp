<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%
try
{

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<title> :: ATTENDANCE ::</title>


 
<style type="text/css">
<!--
.style6 {font-weight: bold}
.bodys {
	 
	border:dashed;
}
.style3 {color: #FF0000}

-->
</style>
</head>
<script language="JavaScript">
 



	function Edit()
 	{		
 	    var count=0;
 	    sel=document.forms[0].staffid;
 	    for(i=0;i<sel.length;i++)
 	         if(sel[i].checked)
 	         	count=count+1;  
 	     
 	    if(count==0)
 	       if(document.forms[0].staffid.checked)
		    	count=1;
		    else
			{	    
		   	   alert("Select Record to Edit");
		   	   return false;
		   	 }
 	    
		if(count>1)
 	    {
 	       alert("Select One Record to Edit");
 	       return false
 	    }
 	    if(count==1)
 	    {
			document.frm.action="OnlinepermissionleaveEdit.jsp";
			document.frm.submit();
			return true;
		}
 	}
	
	
function Delete()
 	{		
		var count;
		count=0;
		c1=document.forms[0].staffid
		txt=""
		for (i=0;i<c1.length;++ i)
		{
			if (c1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].staffid.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
				document.frm.submit();
				return true;			
			}
			else
				return false;
		}
		else
		{
		    alert("Select Atleast One Value");
		    return false;
		}		
 	}
	 
	 	
//-->

</script>
<body  onpaste='return false;'>
<%@ include file="index.jsp"%>

<form  AUTOCOMPLETE = "off"   id="frm" name="frm" method="post" action="../SmartLoginAuth">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>

	<tr>
	  <td>&nbsp;</td>
	</tr>
	<tr>
	  <td>&nbsp; </td>
	</tr>
	<tr>
		<td><table width="810" border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
          <tbody>
            <tr>
              <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
              <td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
              <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
            </tr>
            <tr>
              <td height="6"><spacer height="1" width="1" type="block" />
                  <%
	 
	String Rowid =request.getParameter("Rowid");
	String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT a.CHR_EMPID, date_format(a.DT_PDATE,'%d-%b-%Y') ,a.CHR_TYPE,b.CHR_STAFFNAME,a.CHR_LDESC,a.CHR_REASON FROM att_m_onlineapplyleave a, com_m_staff b   WHERE a.CHR_EMPID=b.CHR_EMPID  AND  a.INT_ONLINELEAVEAPPLYID="+Rowid);
 
  
	 
	 

	String staff  =Data[0][0];
	String Date  =Data[0][1];
	String type = Data[0][2];
	String staffname= Data[0][3];
			

	String sql = " SELECT * FROM ATT_M_ONLINEAPPLYLEAVE WHERE CHR_EMPID ='"+staff+"'";
	sql = sql +" AND DT_PDATE ='"+Date+"' AND CHR_TYPE = '"+type+"'";
	String de = Data[0][4];
	String desc[] = de.split("~");
	String desp = desc[0];
	 String reason = Data[0][5];
	String val="";
	String lname="";
	
	String gh="";
	boolean flag=false;
	 
%></td>
            </tr>
            <tr>
              <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
              <td width="6"><spacer height="1" width="1" type="block" /></td>
              <td valign="top"><table width="801" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="100%"><div align="center" class="boldEleven"><span class="bold1">Permission
                      / Leave</span>
                            <input name="staffids" type="hidden" value="<%=Rowid%>" />
                            <input name="filename" type="hidden" id="filename" value="StaffPermission" />
                            <input name="actionS" type="hidden"  id="actionS" value="ATTStaffPermissionLeaveAcess" />
                    </div></td>
                  </tr>
                  <tr>
                    <td><div align="right"><span class="article style3">* </span><span
								class="changePos">Mandatory</span></div></td>
                  </tr>
                  <tr>
                    <td height="39">
					<%
					if(type.equals("PERMISSION"))
					{
						out.println("<table width='318' border='0' align='center' cellpadding='1' cellspacing='1'>");
						out.println("<tr><td valign='middle' bordercolor='#94C1E4' class='boldEleven'>Staff</td>  <td class='boldEleven'>"+staff+"</td></tr>");
						out.println("<tr><td valign='middle' bordercolor='#94C1E4' class='boldEleven'>Name</td>  <td class='boldEleven'>"+staffname+"</td></tr>");
						out.println("<tr><td valign='middle' bordercolor='#94C1E4' class='boldEleven'>Type</td>  <td class='boldEleven'>"+type+"</td></tr>");
						out.println("<tr><td valign='middle' bordercolor='#94C1E4' class='boldEleven'>Date</td>  <td class='boldEleven'>"+Date+"</td></tr>");
						val ="";
						if("PFD".equals(desp))
							val="Full Day ";
						
						if("PFN".equals(desp))
							val="Fore Noon";
						if("PAN".equals(desp) )
							val="After Noon ";
						   
	
	 
						out.println("<tr><td valign='middle' bordercolor='#94C1E4' class='boldEleven'>Day</td>  <td class='boldEleven'>"+val+"</td></tr>");
						out.println("<tr><td valign='middle' bordercolor='#94C1E4' class='boldEleven'>From Time</td>  <td class='boldEleven'>"+desc[1]+"</td></tr>");
						out.println("<tr><td valign='middle' bordercolor='#94C1E4' class='boldEleven'>To Time</td>  <td class='boldEleven'>"+desc[2]+"</td></tr>");
						out.println("<tr><td valign='middle' bordercolor='#94C1E4' class='boldEleven'>Reason</td>  <td class='boldEleven'>"+Data[0][5]+"</td></tr>");
						 
						out.println("</table>");
						out.println("");
						out.println("");
						out.println("");
						out.println("");
						out.println("");
						out.println("");
						
						
  
  
  				
					}
					%>
						
					</td>
                  </tr>
                  <tr>
                    <td height="39"><table border="0" align="center" cellpadding="5" cellspacing="5">
                        <tr>
                          <td width="56"><input class="buttonbold" type="submit" name="submit1" id="GSubmit" value="Grant" /></td>
                          <td width="56"><input class="buttonbold" type="submit" name="submit1" value="Deny" /></td>
                          <td width="56"><input class="buttonbold" type="button"  name="Button3" id="Button3"  value="Close"   accesskey="c" 	onclick="javascript:history.back()" /></td>
                        </tr>
                    </table></td>
                  </tr>
                  <script language="JavaScript" type="text/javascript">
				if (<%=flag%>)
					sett();		
			</script>
              </table></td>
              <td nowrap="nowrap" width="6"><spacer height="1" width="1"
						type="block" /></td>
              <td width="1" class="BorderLine"><spacer height="1" width="1"
						type="block" /></td>
            </tr>
            <tr>
              <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
              <td height="6"><spacer height="1" width="1" type="block" /></td>
              <td colspan="2" rowspan="2" valign="bottom"><div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div></td>
            </tr>
            <tr>
              <td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
            </tr>
          </tbody>
        </table></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>


<script language="JavaScript">
function sett()
{
	document.getElementById('GSubmit').disabled=true;
}
</script>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
