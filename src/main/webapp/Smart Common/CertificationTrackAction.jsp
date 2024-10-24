<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
	String action=request.getParameter("action1");
	String id="",Name="",actionS="",value="";
	String sql="";
	String cid="";
	String link="  onLoad=\"init()\"";
	if("Add".equals(action))
	{
		id="";Name=""; cid="";
		actionS="GENCertificationTrackAdd";
		value="Add";
	}
	else
	{
		id="";Name=""; cid="";
		id=request.getParameter("id");
		sql = " SELECT INT_CERTIFICATIONTRACKID,CHR_EMPID,CHR_CERTIFICATIONID FROM  com_t_certification   WHERE INT_CERTIFICATIONTRACKID= "+id;
		String data[][] = CommonFunctions.QueryExecute(sql);
		id=data[0][0];Name=data[0][1];  cid=data[0][2];
		actionS="GENCertificationEdit";
		value="Update";
		link="";
	}
	
%>			
				
<html>
<head>

<title> :: COMMON ::</title>

 
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

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript">

function Validate()
  {
	
 
	if(  checkNull("ename","Select Staff")  && anyCheck( )  )
		return true;
	else
		return false;				
		
	
 } 	
 
 function  chkCertification()
 {
 	if(document.getElementById("checkbox").checked == true)
		return true;
	else
	{
		alert("Atleast One certification Tick..");
		return false;
	}
 }
 
 
 
function anyCheck( ) 
{
		var count;
		count=0;
		coffee1=document.forms[0].checkbox
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
				count=count+1;
			}
		}
		 
		 if(count>=1)
		 {			
				return true;			
		 }
		 else
		{
		    alert("Select Atleast One Value");
		    return false;
		}		
}


</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" <%=link%> >
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
	 <form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">
	<table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
			align="center" border="0">
      <tbody>
        <tr>
          <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
          <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
          <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
        </tr>
        <tr>
          <td height="6"><spacer height="1" width="1" type="block" /></td>
        </tr>
        <tr>
          <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
          <td width="6"><spacer height="1" width="1" type="block" /></td>
          <td width="412" valign="top">
		 
		    <table width="86%" border="0" align="center" cellpadding="3" cellspacing="3">
              <tr>
                <td colspan="2" class="bold1"><div align="center"> Certification Track
				
				   
				</div></td>
                </tr>
              <tr>
                <td colspan="2" class="boldEleven">
				
				  <div align="center"><strong>
				    <%
				if(!"Add".equals(action))
				{
				
				
				%>
				        <input name="ename" id="ename" type="hidden" value="<%=Name%>">
				        <%=Name%> / <%= CommonFunctions.QueryExecute("SELECT  CHR_STAFFNAME FROM com_m_staff WHERE CHR_EMPID='"+Name+"'")[0][0]%>
				    
				        <%
				}
				else
				{
				%>
				        <%@ include file="../JavaScript/ajax.jsp"%>
				        <%
				}
				
				%>
				      </strong></div></td>
                </tr>
               
              <tr>
                <td width="31%" class="boldEleven">Certification Name   <span class="boldElevenlink">* </span></td>
                <td width="69%" class="boldEleven">
				
				
				  <%
		String s="";		  
		if(!"Add".equals(action))
		{
			  
			 String cycle[][] =  CommonFunctions.QueryExecute(" SELECT  INT_CERTIFICATIONID,CHR_CERTIFICATIONNAME FROM com_m_certification ORDER BY CHR_CERTIFICATIONNAME ");
			 String cycleid[] =cid.split(",");
			 
			 out.println("<center><table width='100%' cellspacing=2 cellpadding=1 border=0>");
			 out.println("<tr>");
			 for(int x=0;x<cycle.length;x++)
			 {
				s="";
				if(x%3 == 0)
				{
					out.println("<tr>");
					for(int g=0;g<cycleid.length;g++)
						if(cycleid[g].equals(cycle[x][0]))
							s=" checked = checked";
					out.println("<td class='boldEleven'><input "+s+" type='checkbox' name='checkbox' id='checkbox' value='"+cycle[x][0]+"' >"+cycle[x][1]);	
				}	
				else
				{
					for(int g=0;g<cycleid.length;g++)
						if(cycleid[g].equals(cycle[x][0]))
							s=" checked = checked";
					out.println("<td class='boldEleven'><input "+s+" type='checkbox' name='checkbox' id='checkbox' value='"+cycle[x][0]+"' >"+cycle[x][1]);				}	
			 }
			 out.println("</table></center>");
			 
		}
		else
		{				  
			String cdata[][] =  CommonFunctions.QueryExecute(" SELECT  INT_CERTIFICATIONID,CHR_CERTIFICATIONNAME FROM com_m_certification ORDER BY CHR_CERTIFICATIONNAME ");
			out.println("<center><table width='100%' cellspacing=2 cellpadding=1 border=0>");
			out.println("<tr>");
			
				for(int u=0;u<cdata.length;u++)
				{
					if(u%3 == 0)
					{
							out.println("<tr>");
							out.println("<td class='boldEleven'><input type='checkbox' name='checkbox' id='checkbox' value='"+cdata[u][0]+"'>"+cdata[u][1]+"</td>");	
					}	
					else
						out.println("<td class='boldEleven'><input type='checkbox' name='checkbox' id='checkbox' value='"+cdata[u][0]+"'>"+cdata[u][1]+"</td>");	
				}	
					
					
			out.println("</table></center>");		
		}	
				  %>
				  
				
				 
				  <div id='divunitname'></div>				</td>
              </tr>
              
              <tr>
                <td colspan="2" class="boldEleven"><%
					String msg = ""+request.getParameter("msg");
					if(msg.length() >5)
						out.println("<center><font class='bolddeepred'>"+msg+"</font></center>");
				%></td>
                </tr>
              <tr>
                <td class="boldEleven"></td>
                <td class="boldEleven">
				<input type="hidden" name="filename" value="CertificationTrack" />
				<input type="hidden" name="actionS"  value="<%=actionS%>" />
				<input name="id" type="HIDDEN" id="id" value="<%=id%>">				</td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" type="submit" 	class="buttonbold13" value="Submit"   accesskey="s"   ></td>
                    <td><input name="Close" type="button"   class="buttonbold13" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('CertificationTrack.jsp')"></td>
                  </tr>
                </table></td>
                </tr>
            </table>
		 </td>
          <td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
          <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
        </tr>
        <tr>
          <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
          <td height="6"><spacer height="1" width="1" type="block" /></td>
          <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
        </tr>
        <tr>
          <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
        </tr>
      </tbody>
    </table> </form></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
 <%@ include file="../footer.jsp"%>

 <%
}
catch(Exception e)
{
}
%>
</body>
</html>
