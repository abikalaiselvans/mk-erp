<%@ page import="java.io.*,java.util.*"%>
<%!
	String desigName,desigDes,desigId;
	String actionStu;
%>
<%@ page import="com.my.org.erp.bean.Designation"%>
<html>
<head>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='COM' ")[0][0]%></title>

<style type="text/css">
<!--
.style8 {
	font-family: Verdana;
	font-size: 12px;
}

.style9 {
	color: #FFFFFF
}

.style10 {
	font-family: Verdana;
	font-size: 12px;
	color: #FFFFFF;
}

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
<script language="javascript">
 <%
      try
       {
    	  ArrayList designationList=(ArrayList) session.getAttribute("designationList");
        int i=0;
%>  var designationitems=[<%        
        while(i<designationList.size())
        {
        	Designation designation= (Designation)designationList.get(i); 
        	if(i==0){
        		desigId=""+designation.getDesigId();
        		desigName=(String)designation.getDesigName();
	             %>["<%=desigId%>","<%=desigName%>"] <% }
             else{
            	 desigId=""+designation.getDesigId();
            	 desigName=(String)designation.getDesigName();
            	 %> ,["<%=desigId%>","<%=desigName%>"] <% }
              i++;       	
        }
%>];<%
       }
       catch(Exception e)
       {
    	   
       }
%>
act="<%=request.getParameter("action1")%>";
bid="<%=request.getParameter("OptDesigName")%>";

    function checkName()
  {	  	
	  	var aname=document.getElementById("desig").value;
	  	var message;
	  	var messageText;	  	
	  	if(true)
	  	{
          i=0;
          var userMessageElement = document.getElementById("des");
          aname=aname.toLowerCase();
          aname=Trim(aname);
          while(i<designationitems.length)
          {
            id=designationitems[i][0];
            allowitem=designationitems[i][1].toLowerCase();
            if(act=="Edit" && id==bid)
            {
            	window.status="Valid Name";
                message="true";
                break;
            }
            if(aname==allowitem)
            {
               window.status="Already Exists";
               message="false";
               break;
            }
            else{
	            window.status="Valid Name";
                message="true";
            }
            i++;
          }           
	     if (message == "false" || aname=="") {
	         userMessageElement.style.color = "red";
	         messageText = " Already Exists";
	         document.getElementById("submit").disabled=true;
	     } else {
	         userMessageElement.style.color = "green";
	         messageText = "Valid Name";
   	         document.getElementById("submit").disabled=false;
	     }
	     var messageBody = document.createTextNode(messageText);
	     if (userMessageElement.childNodes[0]) 
	     {
	         userMessageElement.replaceChild(messageBody, userMessageElement.childNodes[0]);
	     }
	     else 
	     {
	         userMessageElement.appendChild(messageBody);
	     }
	    
	    }
       
  }
  function validate()
  {
  	if(checkNull('desig','Enter Designation Name'))
	  	document.frmDesig.action="../SmartLoginAuth";
  	
  }
   function set()
  {
     document.frmDesig.TxtDesigName.focus();
  }
  function upperMe(field)
  {
  	field.value=field.value.toUpperCase();
  }
  function mainPage()
  {
    // document.frmDesig.action="../RemoveSession";     
	history.back(1);
  }  
  </script>
</head>
<body onpaste="return false;" onLoad="set()">
<%   
  	String action=request.getParameter("action1");
	//courseName=""+request.getParameter("courseName");
	//courseId=request.getParameter("TxtCourseId");
	ArrayList designationList=(ArrayList) session.getAttribute("designationList");
	if(action.equals("Edit")){
		 actionStu="COM_ATTdesigEdit";
		 desigId=request.getParameter("OptDesigName");		 
		 for(int i=0;i<designationList.size();i++)
		 {
			Designation desig= (Designation)designationList.get(i);
			if(desig.getDesigId()==Integer.parseInt(desigId)){
				desigName=desig.getDesigName();
				desigDes=desig.getDesigDes();
				break;
			}
		 }
	}else{
		actionStu="COM_ATTdesigAdd";
		desigName="";
		desigDes="";
	}
		
%>
<form AUTOCOMPLETE="off" method="post" name='frmDesig'>
<p><%@ include file="insert.jsp"%> <input
	name="path" type="hidden" value="<%=qp%>"></p>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
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
					<td width="412">
					<table width="425" border="0" cellspacing="2" cellpadding="2">
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="28" colspan="2" class="BackGround">Designation

							
						</tr>
						<tr>
							<td width="150" height="29" valign="middle" class="boldEleven">Designation
							Name <font color="#ff0000">*</font></td>
							<td width="246" valign="middle" class="boldEleven"><input
								name="TxtDesigName" type="text" class="formText135" id="desig"
								onBlur="TxtTrim(this)" onChange="upperMe(this)"
								onKeyPress="charOnly('TxtDesigName','45')" onKeyUp="checkName()"
								value="<%=desigName %>" size="35" maxlength="30">
							<div id="des"></div>
							</td>
						</tr>
						<tr>
							<td height="29" valign="top" class="boldEleven">Description</td>
							<td valign="middle" class="boldEleven"><textarea
								name="TxtDesigDes" cols="35" rows="5" class="formText135"
								onKeyPress="textArea('TxtDesigDes','500')"><%= desigDes  %></textarea></td>
						</tr>
						<tr>
							<td height="29" colspan="2" valign="top" class="bolddeepblue"><input
								type="HIDDEN" name="filename" value="Designation"> <input
								type="HIDDEN" name="actionS" value="<%=actionStu %>"> <input
								type="HIDDEN" name="desigId" value="<%= desigId %>">
							<table width="140" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="59"><input name="Submit" type="submit"
										disabled="disabled" class="buttonbold" id="submit"
										value="Submit" onClick="return validate()"></td>
									<td width="60"><input name="Button" type="button"
										class="buttonbold" value="Close" accesskey="c"
										onClick="redirect('<%=closefile%>')"></td>
								</tr>
							</table>
							</td>
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
</table>
<p>&nbsp;</p>

</td>
</tr>
</table>
</form>
<br>
<br>
<%@ include file="../footer.jsp"%>
</body>
</html>
