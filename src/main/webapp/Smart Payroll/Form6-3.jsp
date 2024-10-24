<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<title> :: PAYROLL ::</title>


 
 
<style type="text/css">
<!--
.style4 {font-size: 10px}
.style5 {font-size: 14px}
-->
</style>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
body {
	margin-top: 25px;
}
-->
</style></head>
<body  onpaste='return false;'>
<p>

<table width="288" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <th width="226" scope="col"><div align="center"><%
      String type=request.getParameter("type");
      String company=request.getParameter("company");
	  String branch = request.getParameter("branch");
	  String Office = request.getParameter("Office");
      int start=0,end=0;
      int year=Integer.parseInt(request.getParameter("Year"));
      String comname="",comst="",comcity="",compin="",from="",to="";
      String sql="",bra="",off="";
	  if(!"-1".equals(branch))
		bra = " AND a.INT_BRANCHID=  "+branch;
	if(!"0".equals(Office))
		off = " AND a.INT_OFFICEID=  "+Office;
      sql="select * from com_m_company where INT_COMPANYID="+company;
      String datacom[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
      if(datacom.length>0)
      {
      comname=datacom[0][1];
      comst=datacom[0][3];
      comcity=datacom[0][4];
      compin=datacom[0][6];
      }
      String mon="";
      if(type.equals("O"))
      {
    	 mon="October,November,December,January,February,March";
          from="OCT,"+(year-1);
    	  to="MAR,"+year;
    	  start=year-1;
    	  end=year;
      }
      else
      {
    	  mon="April,May,June,July,August,September";
    	  from="APRIL,"+year;
    	  to="SEP,"+year;
    	  start=year;
    	  end=year;
      }
      String month[]=mon.split(","); %>
        <span class="boldElevenPrint">FORM-6<br />
          <strong>Register of Employees</strong> <br />
          Employees' State Insurance Corporation <br />
          (Regulation 32)</span></div></th>
    </tr>
</table><BR />
  <table width="1563" border="1" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <th width="20" rowspan="2" class="boldElevenPrint" scope="col">Sl. No.</th>
      <th width="68" rowspan="2" class="boldElevenPrint" scope="col"><div align="center">Insurance No</div></th>
      <th width="137" rowspan="2" class="boldElevenPrint" scope="col">Name of the Insured Person </th>
      <th width="97" rowspan="2" class="boldElevenPrint" scope="col">Name of the dispen sary to which attached </th>
      <th width="68" rowspan="2" class="boldElevenPrint" scope="col">Occupation </th>
      <th width="34" rowspan="2" class="boldElevenPrint" scope="col">Dept. Abd Shift, if any </th>
      <th width="70" rowspan="2" class="boldElevenPrint" scope="col">If appointed during the Contri bution period date of appoinment </th>
      <th colspan="3" class="boldElevenPrint" scope="col">Month :<%= month[0] %>-<%= start %></th>
      <th colspan="3" class="boldElevenPrint" scope="col">Month :<%= month[1] %>-<%= start %> </th>
      <th colspan="3" class="boldElevenPrint" scope="col">Month :<%= month[2] %>-<%= start %> </th>
      <th colspan="3" class="boldElevenPrint" scope="col">Month :<%= month[3] %>-<%= end %> </th>
      <th colspan="3" class="boldElevenPrint" scope="col">Month :<%= month[4] %>-<%= end %> </th>
      <th colspan="3" class="boldElevenPrint" scope="col">Month :<%= month[5] %>-<%= end %> </th>
      <th colspan="4" class="boldElevenPrint" scope="col">Total Contribution Months </th>
	  <th width="38" colspan="1" rowspan="2" class="boldElevenPrint" scope="col">Remarks</th>
    </tr>
    <tr>
      <th width="48" class="boldElevenPrint" scope="col">No of days for which wages paid / payable </th>
      <th width="47" class="boldElevenPrint" scope="col">Total amount of wages paid / payable</th>
      <th width="38" class="boldElevenPrint" scope="col">Emplo yee's share of contr ibution </th>
      <th width="48" class="boldElevenPrint" scope="col">No of days for which wages paid / payable </th>
      <th width="47" class="boldElevenPrint" scope="col">Total amount of wages paid / payable</th>
      <th width="38" class="boldElevenPrint" scope="col">Emplo yee's share of contr ibution </th>
      <th width="48" class="boldElevenPrint" scope="col">No of days for which wages paid / payable </th>
      <th width="47" class="boldElevenPrint" scope="col">Total amount of wages paid / payable</th>
      <th width="38" class="boldElevenPrint" scope="col">Emplo yee's share of contr ibution </th>
      <th width="48" class="boldElevenPrint" scope="col">No of days for which wages paid / payable </th>
      <th width="47" class="boldElevenPrint" scope="col">Total amount of wages paid / payable</th>
      <th width="38" class="boldElevenPrint" scope="col">Emplo yee's share of contr ibution </th>
      <th width="48" class="boldElevenPrint" scope="col">No of days for which wages paid / payable </th>
      <th width="47" class="boldElevenPrint" scope="col">Total amount of wages paid / payable</th>
      <th width="38" class="boldElevenPrint" scope="col">Emplo yee's share of contr ibution </th>
      <th width="48" class="boldElevenPrint" scope="col">No of days for which wages paid / payable </th>
      <th width="47" class="boldElevenPrint" scope="col">Total amount of wages paid / payable</th>
      <th width="38" class="boldElevenPrint" scope="col">Emplo yee's share of contr ibution </th>
      <th width="48" class="boldElevenPrint" scope="col">Total No of days for which wages paid / payable </th>
      <th width="47" class="boldElevenPrint" scope="col">Total amount of wages paid / payable</th>
      <th width="38" class="boldElevenPrint" scope="col">Total Emplo yee's share of contr ibution </th>
      <th width="38" class="boldElevenPrint" scope="col">Daily wages 27/26 </th>
    </tr>

    <tr>
      <th width="20" class="boldElevenPrint" scope="col">1</th>
      <th width="68" class="boldElevenPrint" scope="col"><div align="center">2</div></th>
      <th width="137" class="boldElevenPrint" scope="col">3</th>
      <th width="97" class="boldElevenPrint" scope="col">4</th>
      <th width="68" class="boldElevenPrint" scope="col">5</th>
      <th width="34" class="boldElevenPrint" scope="col">6</th>
      <th width="70" class="boldElevenPrint" scope="col">7</th>
      <th width="48" class="boldElevenPrint" scope="col">8</th>
      <th width="47" class="boldElevenPrint" scope="col">9</th>
      <th width="38" class="boldElevenPrint" scope="col">10</th>
      <th width="48" class="boldElevenPrint" scope="col">11</th>
      <th width="47" class="boldElevenPrint" scope="col">12</th>
      <th width="38" class="boldElevenPrint" scope="col">13</th>
      <th width="48" class="boldElevenPrint" scope="col">14</th>
      <th width="47" class="boldElevenPrint" scope="col">15</th>
      <th width="38" class="boldElevenPrint" scope="col">16</th>
      <th width="48" class="boldElevenPrint" scope="col">17</th>
      <th width="47" class="boldElevenPrint" scope="col">18</th>
      <th width="38" class="boldElevenPrint" scope="col">19</th>
      <th width="48" class="boldElevenPrint" scope="col">20</th>
      <th width="47" class="boldElevenPrint" scope="col">21</th>
      <th width="38" class="boldElevenPrint" scope="col">22</th>
      <th width="48" class="boldElevenPrint" scope="col">23</th>
      <th width="47" class="boldElevenPrint" scope="col">24</th>
      <th width="38" class="boldElevenPrint" scope="col">25</th>
      <th width="48" class="boldElevenPrint" scope="col">26</th>
      <th width="47" class="boldElevenPrint" scope="col">27</th>
      <th width="38" class="boldElevenPrint" scope="col">28</th>
      <th width="38" class="boldElevenPrint" scope="col">29</th>
	  <th width="38" class="boldElevenPrint" scope="col">30</th>
    </tr>
    <%
    
    String basic1="0",nod1="0",es1="0";
    String basic2="0",nod2="0",es2="0";
    String basic3="0",nod3="0",es3="0";
    String basic4="0",nod4="0",es4="0";
    String basic5="0",nod5="0",es5="0";
    String basic6="0",nod6="0",es6="0";
    double tbasic=0,tnod=0,tes=0;
    sql="select a.CHR_ESINO,a.CHR_STAFFNAME,a.DT_DOJCOLLEGE,b.CHR_DESIGNAME,c.CHR_BRANCHNAME,a.CHR_EMPID,d.CHR_DESPNAME from com_m_staff a,com_m_desig b,com_m_branch c,com_m_dispensary d where a.CHR_ESI<>'N' and b.INT_DESIGID=a.INT_DESIGID and c.INT_BRANCHID=a.INT_BRANCHID and a.INT_COMPANYID="+company+"";
	sql = sql +bra;
	sql = sql +off+"  group by a.chr_empid order by a.CHR_STAFFNAME";
	out.println(sql);
    String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    //System.out.println(sql);
    for(int i=0;i<data.length;i++){
    	basic1="0";nod1="0";es1="0";
        basic2="0";nod2="0";es2="0";
        basic3="0";nod3="0";es3="0";
        basic4="0";nod4="0";es4="0";
        basic5="0";nod5="0";es5="0";
        basic6="0";nod6="0";es6="0";
    	sql="select DOU_WORKDAYS,DOU_GROSSPAY,DOU_ESI from  pay_t_salary where CHR_EMPID='"+data[i][5]+"' and CHR_MONTH='"+month[0]+"' and INT_YEAR="+start+"";
		
    	String data1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    	if(data1.length>0)
    	{
    		if(!data1[0][0].equals(""))
    			nod1=data1[0][0];
    		if(!data1[0][1].equals(""))
    			basic1=data1[0][1];
    		if(!data1[0][2].equals(""))
    			es1=data1[0][2];
    	}
    	sql="select DOU_WORKDAYS,DOU_GROSSPAY,DOU_ESI from  pay_t_salary where CHR_EMPID='"+data[i][5]+"' and CHR_MONTH='"+month[1]+"' and INT_YEAR="+start+"";
    	String data2[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    	if(data2.length>0)
    	{
    		if(!data2[0][0].equals(""))
    			nod2=data2[0][0];
    		if(!data2[0][1].equals(""))
    			basic2=data2[0][1];
    		if(!data2[0][2].equals(""))
    			es2=data2[0][2];
    	}
    	sql="select DOU_WORKDAYS,DOU_GROSSPAY,DOU_ESI from  pay_t_salary where CHR_EMPID='"+data[i][5]+"' and CHR_MONTH='"+month[2]+"' and INT_YEAR="+start+"";
    	String data3[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    	if(data3.length>0)
    	{
    		if(!data3[0][0].equals(""))
    			nod3=data3[0][0];
    		if(!data3[0][1].equals(""))
    			basic3=data3[0][1];
    		if(!data3[0][2].equals(""))
    			es3=data3[0][2];
    	}
    	sql="select DOU_WORKDAYS,DOU_GROSSPAY,DOU_ESI from  pay_t_salary where CHR_EMPID='"+data[i][5]+"' and CHR_MONTH='"+month[3]+"' and INT_YEAR="+end+"";
    	String data4[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    	if(data4.length>0)
    	{
    		if(!data4[0][0].equals(""))
    			nod4=data4[0][0];
    		if(!data4[0][1].equals(""))
    			basic4=data4[0][1];
    		if(!data4[0][2].equals(""))
    			es4=data4[0][2];
    	}
    	sql="select DOU_WORKDAYS,DOU_GROSSPAY,DOU_ESI from  pay_t_salary where CHR_EMPID='"+data[i][5]+"' and CHR_MONTH='"+month[4]+"' and INT_YEAR="+end+"";
    	String data5[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    	if(data5.length>0)
    	{
    		if(!data5[0][0].equals(""))
    			nod5=data5[0][0];
    		if(!data5[0][1].equals(""))
    			basic5=data5[0][1];
    		if(!data5[0][2].equals(""))
    			es5=data5[0][2];
    	}
    	sql="select DOU_WORKDAYS,DOU_GROSSPAY,DOU_ESI from  pay_t_salary where CHR_EMPID='"+data[i][5]+"' and CHR_MONTH='"+month[5]+"' and INT_YEAR="+end+"";
    	String data6[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    	if(data6.length>0)
    	{
    		if(!data6[0][0].equals(""))
    			nod6=data6[0][0];
    		if(!data6[0][1].equals(""))
    			basic6=data6[0][1];
    		if(!data6[0][2].equals(""))
    			es6=data6[0][2];
    	}   
    	
    	tbasic=Double.parseDouble(basic1)+Double.parseDouble(basic2)+Double.parseDouble(basic3)+Double.parseDouble(basic4)+Double.parseDouble(basic5)+Double.parseDouble(basic6);
    	tnod=Double.parseDouble(nod1)+Double.parseDouble(nod2)+Double.parseDouble(nod3)+Double.parseDouble(nod4)+Double.parseDouble(nod5)+Double.parseDouble(nod6);
    	tes=Double.parseDouble(es1)+Double.parseDouble(es2)+Double.parseDouble(es3)+Double.parseDouble(es4)+Double.parseDouble(es5)+Double.parseDouble(es6);
    out.println("<tr>");
    out.println("<th width='20' class='boldElevenPrint' scope='col'>"+(i+1)+"</th>");
    out.println("<th width='68' class='boldElevenPrint' scope='col' align='left'>&nbsp;"+data[i][0]+"</th>");
    out.println("<th width='199' class='boldElevenPrint' scope='col' align='left'>&nbsp;"+data[i][1]+"</th>");
	out.println("<th width='52' class='boldElevenPrint' scope='col'>&nbsp;"+data[i][6]+"</th>");
    out.println("<th width='51' class='boldElevenPrint' scope='col' align='left'>&nbsp;</th>");//"+data[i][3]+"
    out.println("<th width='34' class='boldElevenPrint' scope='col' align='left'>&nbsp;"+data[i][4]+"</th>");
    out.println("<th width='70' class='boldElevenPrint' scope='col' align='left'>&nbsp;"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(data[i][2])+"</th>");
    out.println("<th width='48' class='boldElevenPrint' scope='col'>"+nod1+"</th>");
    out.println("<th width='47' class='boldElevenPrint' scope='col'>"+basic1+"</th>");
    out.println("<th width='38' class='boldElevenPrint' scope='col'>"+es1+"</th>");
    out.println("<th width='48' class='boldElevenPrint' scope='col'>"+nod2+"</th>");
    out.println("<th width='47' class='boldElevenPrint' scope='col'>"+basic2+"</th>");
    out.println("<th width='38' class='boldElevenPrint' scope='col'>"+es2+"</th>");
    out.println("<th width='48' class='boldElevenPrint' scope='col'>"+nod3+"</th>");
    out.println("<th width='47' class='boldElevenPrint' scope='col'>"+basic3+"</th>");
    out.println("<th width='38' class='boldElevenPrint' scope='col'>"+es3+"</th>");
    out.println("<th width='48' class='boldElevenPrint' scope='col'>"+nod4+"</th>");
    out.println("<th width='47' class='boldElevenPrint' scope='col'>"+basic4+"</th>");
    out.println("<th width='38' class='boldElevenPrint' scope='col'>"+es4+"</th>");
    out.println("<th width='48' class='boldElevenPrint' scope='col'>"+nod5+"</th>");
    out.println("<th width='47' class='boldElevenPrint' scope='col'>"+basic5+"</th>");
    out.println("<th width='38' class='boldElevenPrint' scope='col'>"+es5+"</th>");
    out.println("<th width='48' class='boldElevenPrint' scope='col'>"+nod6+"</th>");
    out.println("<th width='47' class='boldElevenPrint' scope='col'>"+basic6+"</th>");
    out.println("<th width='38' class='boldElevenPrint' scope='col'>"+es6+"</th>");
    out.println("<th width='48' class='boldElevenPrint' scope='col'>"+tnod+"</th>");
    out.println("<th width='47' class='boldElevenPrint' scope='col'>"+Math.round(tbasic)+"</th>");
    out.println("<th width='38' class='boldElevenPrint' scope='col'>"+Math.round(tes)+"</th>");
    out.println("<th width='38' class='boldElevenPrint' scope='col'>"+Math.round(tbasic/tnod)+"</th>");
	out.println("<th width='50' class='boldElevenPrint' scope='col'>&nbsp;</th>");
    out.println("</tr>");}
    %>
</table>
  </body>
</html>
