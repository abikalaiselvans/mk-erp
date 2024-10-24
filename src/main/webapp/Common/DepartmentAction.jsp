<%@ page import="java.io.*,java.util.*"%>
<%!
	String departName,departDes,departId;
	String actionStu;
%>
<%@ page import="com.my.org.erp.bean.Department"%>
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
    	  ArrayList departmentList=(ArrayList) session.getAttribute("departmentList");
        int i=0;
%>  var departmentitems=[<%        
        while(i<departmentList.size())
        {
        	Department department= (Department)departmentList.get(i); 
        	if(i==0){
        		departId=""+department.getDepartId();
        		departName=(String)department.getDepartName();
	             %>["<%=departId%>","<%=departName%>"] <% }
             else{
            	 departId=""+department.getDepartId();
            	 departName=(String)department.getDepartName();
            	 %> ,["<%=departId%>","<%=departName%>"] <% }
              i++;       	
        }
%>];<%
       }
       catch(Exception e)
       {
    	   
    	   
       }
%>
act="<%=request.getParameter("action1")%>";
bid="<%=request.getParameter("OptDepartName")%>";

    function checkName()
  {	  	
	  	var aname=document.getElementById("depart").value;
	  	var message;
	  	var messageText;	  	
	  	if(true)
	  	{
          i=0;
          var userMessageElement = document.getElementById("dep");
          aname=aname.toLowerCase();
          aname=Trim(aname);
          while(i<departmentitems.length)
          {
            id=departmentitems[i][0];
            allowitem=departmentitems[i][1].toLowerCase();
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
  	if(checkNull('depart','Enter Department Name'))
  	{
  		document.frmDepart.action="../SmartLoginAuth";
  	}  	
  }
  function set()
  {
     document.frmDepart.TxtDepartName.focus();
  }
  function upperMe(field)
  {
  	field.value=field.value.toUpperCase();
  }  
  function mainPage()
  {
     //document.frmDepart.action="../RemoveSession";     
	 history.back(1);
  }
  </script>
</head>
<body onpaste="return false;" onLoad="set()">
<form AUTOCOMPLETE="off" method="get" name='frmDepart'><%@ include
	file="insert.jsp"%> <input name="path"
	type="hidden" value="<%=qp%>"> <%   
  	String action=request.getParameter("action1");
	//courseName=""+request.getParameter("courseName");
	//courseId=request.getParameter("TxtCourseId");
	ArrayList departmentList=(ArrayList) session.getAttribute("departmentList");
	if(action.equals("Edit")){
		 actionStu="COM_ATTdepartEdit";
		 departId=request.getParameter("OptDepartName");		 
		 for(int i=0;i<departmentList.size();i++)
		 {
			Department depart= (Department)departmentList.get(i);
			if(depart.getDepartId()==Integer.parseInt(departId)){
				departName=depart.getDepartName();
				departDes=depart.getDepartDes();
				break;
			}
		 }
	}else{
		actionStu="COM_ATTdepartAdd";
		departName="";
		departDes="";
	}
		
%> <br>
<br>
<br>
<table width="100%" border=0>
	<!--DWLayoutTable-->
	<tr>
		<td height="109" colspan="7"><br>

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

					<table width="425" border="0" align="center" cellpadding="2"
						cellspacing="2">
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="28" colspan="2" class="BackGround">Department</td>
						</tr>
						<tr>
							<td width="150" height="29" valign="middle" class="boldEleven">Department
							Name <font color="#ff0000">*</font></td>
							<td width="246" valign="middle" class="boldEleven"><input
								name="TxtDepartName" type="text" class="formText135" id="depart"
								onBlur="TxtTrim(this)" onChange="upperMe(this)"
								onKeyPress="charOnly('depart','50')" onKeyUp="checkName()"
								value="<%= departName %>" size="35" maxlength="30">
							<div id="dep"></div>
							</td>
						</tr>
						<tr>
							<td height="29" valign="top" class="boldEleven">Description</td>
							<td valign="middle" class="boldEleven"><textarea
								name="TxtDepartDes" cols="35" rows="5" class="formText135"
								onKeyPress="textArea('TxtDepartDes','500')"><%= departDes%></textarea></td>
						</tr>
						<tr>
							<td height="29" colspan="2" valign="top" class="bolddeepblue"><input
								type="HIDDEN" name="filename" value="Department"> <input
								type="HIDDEN" name="actionS" value="<%=actionStu %>"> <input
								type="HIDDEN" name="departId" value="<%=departId %>">
							<table width="129" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="51"><input type="SUBMIT" class="buttonbold"
										id="submit" name="Submit" disabled="disabled" value="Submit"
										accesskey="s" onClick="return validate()"></td>
									<td width="57"><input name="Button" type="button"
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
		<td colspan="7">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="7">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="7">&nbsp;</td>
	</tr>
</table>
<br>
<br>
<br>
<%@ include file="../footer.jsp"%>
</body>
</html>
