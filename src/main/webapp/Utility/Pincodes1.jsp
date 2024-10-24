<%
try
{
%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/common/SelectChangesCountry.js"></script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<p>&nbsp;</p>
<%@include file="Redirect.jsp" %>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table width="80%" border="0" align="center" cellpadding="3" cellspacing="4">
      <tr>
        <td><span class="boldEleven">Country</span></td>
        <td><select name="country" id="country" style="width:170" onchange="LoadSelectState()">
          <option value="0">All</option>
          <%
	 		String readData[][]= com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_COUNTRYID ,CHR_COUNTRYNAME FROM  com_m_country ORDER BY CHR_COUNTRYNAME");
			for(int i=0;i<readData.length;i++)
				out.println("<option value='"+readData[i][0]+"'>"+readData[i][1]+"</option>");
	 %>
        </select></td>
        <td><span class="boldEleven">State</span></td>
        <td><select name="state" id="state" style="width:170" onchange="LoadSelectDistrict()">
          <option value="0" selected="selected">All</option>
           
        </select></td>
        <td><span class="boldEleven">District</span></td>
        <td><span class="bolddeepblue">
          <select name="district" id="district" style="width:170" onchange=" LoadSelectCity()">
            <option value="0" selected="selected">All</option>
          </select>
        </span></td>
        <td><span class="boldEleven">City</span></td>
        <td><span class="bolddeepblue">
          <select name="city" id="city" style="width:170"  >
            <option value="0" selected="selected">All</option>
          </select>
        </span></td>
        <td>&nbsp;</td>
       <td><img src="../images/submit_btn.gif" width="91" height="27" onClick="javascript:callURLrewriting()"></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><div id="divscroll" style="OVERFLOW:auto;width:100%;height:auto" 	class="boldEleven">
		
		
		
  <%
  
  
  
  
String country=""+request.getParameter("country");
if("".equals(country) || "null".equals(country))
	country="0";
 	
String state=""+request.getParameter("state");
if("".equals(state) || "null".equals(state))
	state="0";
 
String district=""+request.getParameter("district");
 if("".equals(district) || "null".equals(district))
	district="0";
 String links="&country="+country+"&state="+state+"&district="+district;
 
String sql= "SELECT COUNT(*) FROM  com_m_city  WHERE INT_CITYID>=1";
//if(!"0".equals(country) )
	//sql = sql+" AND INT_COUNTRYID = "  +country;
	
if(!"0".equals(state))
	sql = sql+" AND INT_STATEID = "  +state;
	
if(!"0".equals(district))
	sql = sql+" AND INT_DISTRICTID = "  +district;

sql = sql+" ORDER BY CHR_CITYNAME ";
 

//sql=" SELECT CHR_CITYNAME FROM  com_m_city  ORDER BY CHR_CITYNAME ";

String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 
int perpagerecord =10;
int pagessplit=1;

if(data.length>0)
{

	int totalnoofrecord= Integer.parseInt(data[0][0]);
	int totalnoofpages = totalnoofrecord/perpagerecord;
	if((totalnoofrecord-(totalnoofpages*perpagerecord)) >0)
		totalnoofpages = totalnoofpages+1;
		
	int noofpagessplit=totalnoofpages/pagessplit;
	if((totalnoofpages-(noofpagessplit*pagessplit)) >0)
		noofpagessplit = noofpagessplit+1;
	
	
	
	
	int startingpage=1;
	int endingpage=10;//
	int h=0;	
	int startrecord =0;
	int endingrecord =perpagerecord;
	String stringrequestpage= ""+request.getParameter("page");
	if("".equals(stringrequestpage) || "null".equals(stringrequestpage))
	{
			startingpage = 1;
			if(noofpagessplit>10)//
				endingpage=10;//
			else
				endingpage=noofpagessplit;
				
			startrecord =startingpage;
			if(totalnoofrecord>perpagerecord)
				endingrecord =perpagerecord;
			else	
				endingrecord =totalnoofrecord;
	}	
	else
	{
			startingpage= Integer.parseInt(stringrequestpage);
			endingpage= startingpage+9;//
			if(endingpage>noofpagessplit)
			{
				endingpage = noofpagessplit-startingpage;
				endingpage = startingpage+endingpage;
				h=endingpage;
			}	
			
			if(startingpage<1)
			{
				startrecord =1;
				if(totalnoofrecord>perpagerecord)
					endingrecord =perpagerecord;
				else	
					endingrecord =totalnoofrecord;
			}
			else
			{
				startrecord =(startingpage*perpagerecord)-(perpagerecord-1);
				endingrecord = startingpage*perpagerecord;
				if(endingrecord>totalnoofrecord)
					endingrecord=totalnoofrecord;
			}	
			 
			
	}		
	
	
	
			// Start Displaying Records......
			 
			out.println("<br> ");
			sql= " SELECT b.CHR_COUNTRYNAME,c.CHR_STATENAME,d.CHR_DISTRICT,a.CHR_CITYNAME,DECODE(a.CHR_PINCODE,'9865043008')    FROM com_m_city a ,com_m_country b,com_m_state c,com_m_district d WHERE  a.INT_STATEID= c.INT_STATEID   AND a.INT_DISTRICTID = d.INT_DISTRICTID  ";
			//if(!"0".equals(country) )
				//sql = sql+" AND a.INT_COUNTRYID = "  +country;
				
			if(!"0".equals(state))
				sql = sql+" AND a.INT_STATEID = "  +state;
				
			if(!"0".equals(district))
				sql = sql+" AND a.INT_DISTRICTID = "  +district;
			
			sql = sql+" ORDER BY  a.CHR_CITYNAME,d.CHR_DISTRICT LIMIT "+(startrecord-1)+","+perpagerecord;
			
			String datas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			 
			out.println("<br><table width='100%' align='center' class='boldEleven' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC'>");
			out.println("<tr class='MRow1'><td class='boldEleven'><b>S.no</b></td><td class='boldEleven'><b>Country</b></td><td><b>State</td><td><b>District</td><td><b>City </td><td><b>Postal Code</td>  </tr>");   
			for(int d=0;d<datas.length;d++)
			{
				if(d%2==0)
					out.println("<tr class='MRow2'>");
				else
					out.println("<tr class='MRow3'>");	
				out.println("<td  class='boldEleven'>"+(d+1)+".");
				out.println("<td  class='boldEleven'>"+datas[d][0]);
				out.println("<td  class='boldEleven'>"+datas[d][1]);
				out.println("<td  class='boldEleven'>"+datas[d][2]);
				out.println("<td  class='boldEleven'>"+datas[d][3]);
				out.println("<td  class='boldEleven'>"+datas[d][4]);
				 
				out.println("</tr>");
			}
			
			
			
			
			
			out.println("</table><br> ");
			 
			// End Displaying Records......
			
			
			
			
	
	// Start Paging
	out.println("<center>");
	out.println("<table width='100%' class='boldEleven'  cellpadding=3 cellspacing=1 bgcolor='#9900CC'>");
	out.println("<tr class='MRow3'>");	
	if(startingpage>1)
	{
		boolean f =true;;
		if((startingpage<0))
		{
			startingpage = 1;
			if(noofpagessplit>10)//
				endingpage=10;//
			else
				endingpage=noofpagessplit;
			f = false;	
			 
		}	
		if(f)
			out.println("<td class='boldEleven' align='center'><a href='Pincodes.jsp?&page="+(startingpage-10)+"&country="+country+"&state="+state+"&district="+district+"'>Prev</a></td>");	
	}
	else
	{
		startingpage = 1;
		if(noofpagessplit>10)//
			endingpage=10;//
		else
			endingpage=noofpagessplit;
	}
	
	for(int u=startingpage;u<=endingpage;u++)
	{
		out.println("<td class='boldEleven' align='center'>");
		out.println("<a title='Go to "+u+"th Page' href='Pincodes.jsp?session="+session.getId()+"&page="+u+"&recordstart="+u+"&country="+country+"&state="+state+"&district="+district+"'>"+u+"</a>");
		out.println("</td>");
		h=h+1;
	}
	if(endingpage>=noofpagessplit)
	{
		
	}
	else
		out.println("<td class='boldEleven' align='center'><a href='Pincodes.jsp?&page="+(endingpage+1)+"&country="+country+"&state="+state+"&district="+district+"'>Next</a>");
		
		
		
	
	//Start Pages in Combo Box
	out.println("<td class='boldEleven' align='right'>Pages</td>");
	out.println("<td class='boldEleven'  align='left' valign='middle'>");
	out.println("<select name='pages' id='pages' class='formText135' onchange =\"MM_jumpMenu('parent',this,0)\" >");
	for(int t=1;t<=noofpagessplit;t++)
		out.println("<option value='"+t+"'>"+t+"</option>");
	out.println("</select>");
	
	%>
  	<script language="javascript">
	
			setOptionValue('pages','<%=stringrequestpage%>')
			function setOptionValue(ctr,value) 
			{
				
				var len,val,i,sel;
				len=document.getElementById(ctr).length;
				for(i=0;i<len;i++){
					val=document.getElementById(ctr).options[i].value;
					if(val==value) sel=i;
				}
				document.getElementById(ctr).selectedIndex=sel;
			}


			
			function MM_jumpMenu(targ,selObj,restore)
			{ //v3.0
  					eval(targ+".location='Pincodes.jsp?getId=<%=session.getId()+links%>&page="+selObj.options[selObj.selectedIndex].value+"&recordstart="+selObj.options[selObj.selectedIndex].value+"'");
  					if (restore) selObj.selectedIndex=0;
			}


			function callURLrewriting()
			{
				var country = document.getElementById('state').value;
				var state = document.getElementById('state').value;
 				var district = document.getElementById('district').value;
				
				if(	checkNullSelect('country','Select Country' ,'0')	
					&& checkNullSelect('state','Select State' ,'0')	
					&& checkNullSelect('district','Select District' ,'0')	
				)
					{
					 
					window.location="Pincodes.jsp?country="+country+"&state="+state+"&district="+district; 	
					}
			}

			</script>
  
  <%
	out.println("</td> "); 
	//End Pages in Combo Box
	
	out.println("</tr></table>");
	out.println("</center> ");
	//End Paging
	
	
	
}
%>
		
</div></td>
  </tr>
</table>
<p><br>
  <br>
  <br>
</p>

		
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>		