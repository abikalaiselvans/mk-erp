<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
</style>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<script language="javascript">

	var hh=0; 
	var mm=0; 
	var ss=0;
	var time="";
    var duration = "<%=CommonFunctions.QueryExecute("SELECT INT_TIME_FOR_LOGIN_TERMSANDCONDITION FROM  m_institution WHERE INT_ID=1")[0][0]%>"; 
	
	
	function startTime()
	{
		
		 
		ss=(ss+1);
		  
		 if(ss>=60)
		{
			ss=0;
			mm =   (mm+1);
		}
		if(mm>=60)
		{
			mm=0;
			hh =   (hh+1);
		} 
		 
		 
		t=setTimeout('startTime()',1000);
		 
		
	}
	
	function checkTime(i)
	{
		if (i<10)
		{
			i="0" + i;
		}
		return i;
	}
	
	function submitPage() 
	{
	   pf0.style.visibility="Visible"; 
	   info.style.visibility="hidden"; 
	}

	setTimeout("submitPage()",(duration*60*1000));


	startTime();
	
</script>

 <form action="../SmartLoginAuth" method="post" name="frm" id="frm">
   <table width="100%" border="0" cellspacing="0" cellpadding="0">
     <tr>
       <td colspan="2">
       <%@ include file="operating_policy.html" %>
       </td>
     </tr>
      
     <tr>
       <td colspan="2" align="center"><span class="boldEleven">
         <input type="hidden" name="filename" value="Rules" />
         <input type="hidden" name="actionS"  value="STARulesAccept" />
       </span>
         <table width="100" border="0" align="center" cellpadding="0" cellspacing="0">
         <tr>
           <td  id="pf0" align="center"><input name="Submit" type="submit" class="formTableOuterDesign" id="button" value="Submit"></td>
         </tr>
       </table></td>
     </tr>
     <tr>
       <td>&nbsp;</td>
       <td>&nbsp;</td>
     </tr>
   </table>
 </form>
 <script language="javascript">pf0.style.visibility="hidden"; info.style.visibility="Visible"; </script> 