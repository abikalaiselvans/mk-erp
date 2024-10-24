
<select name="grade"   id="grade"  class="formText135" style="width:100" onchange="CheckUnique(this,'divgrade','pay_m_salaryband','CHR_GRADE')">
	<option value="0">Select</option>
	 <%
	 	
		//AA,AB,AC,AD,AE,AF,AG,AH,AI,AJ,AK,AL,AM,AN,AO,AP,AQ,AR,AS,AT,AU,AV,AW,AX,AY,AZ,
		String salband = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,";
		String sdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT CHR_GRADE FROM pay_m_salaryband  ORDER BY CHR_GRADE");
		if(sdata.length>0)
			for(int y=0;y<sdata.length;y++)
				salband = salband.replaceAll( sdata[y][0]+"," ,"");
		String gradedata[] = salband.split(",");
		for (int i=0; i<gradedata.length; i++) 
			out.println("<option value='"+gradedata[i]+"'>"+gradedata[i]  +"</option>");	
	 %>

</select>
<div id="divgrade"></div>
 
