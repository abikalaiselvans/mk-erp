<%@ page
	import="java.sql.*,java.util.Date,java.util.Properties,java.io.*,java.text.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>
<%!
	Connection con ;
	PreparedStatement pstm,pstran;
	ResultSet rst;
	String userid;
	String empid,advid,staffid,status,day,dmonth,closeday,intype;
	int i,m1,d1,y1,m2,d2,y2,addamt,noinstal,dueamt,balamt,binstal;
	String Sql,sid[]=new String[20];
    String sql_Insert_Query ="INSERT INTO PAY_M_ADVANCE(CHR_EMPID,CHR_ADVID,DT_DATE,INT_YEAR,CHR_MONTH,INT_ADVAMT,Int_NOOFINS,INT_DUE,INT_BALAMT,INT_BALINS,CHR_DUE,CHR_DECTYPE,DT_CLOSEDATE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    String sql_tran_Insert="INSERT INTO PAY_T_ADVANCE(CHR_EMPID,CHR_ADVID,INT_YEAR,CHR_MONTH,INT_BALAMT,INT_DUEAMT,INT_BALANCE,CHR_STATUS)VALUES(?,?,?,?,?,?,?,?)";
    SimpleDateFormat dateformat=new SimpleDateFormat("yyyy-MM-dd");
    private void openDate(String dat)
    {
	  String data[]=dat.split("-");
	  d1=Integer.parseInt(data[0]);
	  m1=Integer.parseInt(data[1]);
	  y1=Integer.parseInt(data[2]);		  
    }
    private void closeDate(String dat)
    {
	  String data[]=dat.split("-");
	  d2=Integer.parseInt(data[0]);
	  m2=Integer.parseInt(data[1]);
	  y2=Integer.parseInt(data[2]);		
	}    
    private String getMonth(int mon)
	{
    	String month="";
		switch(mon)
		{
			case 01:month="January";
					break;
			case 02:month="February";
					break;
			case 03:month="March";
					break;
			case 04:month="April";
					break;
			case 05:month="May";
					break;
			case 06:month="June";
					break;
			case 07:month="July";
					break;
			case 8:month="August";
					break;
			case 9:month="September";
					break;
			case 10:month="October";
					break;
			case 11:month="November";
					break;
			case 12:month="December";
					break;
		}
		return(month);
	}
    private String openFormat(int d1,int m1,int y1)
    {
        return y1+"-"+m1+"-"+d1;    	
    }
    private String closeFormat(int d1,int m1,int y1)
    {
        return y1+"-"+m1+"-"+d1;    	
    }
%>
<%
    empid = request.getParameter("ename");
    advid=request.getParameter("advid");
    intype=request.getParameter("intype");
	openDate(request.getParameter("openday"));
	String mon=getMonth(m1);
	String odate=openFormat(d1,m1,y1);
	addamt=Integer.parseInt(request.getParameter("adamt"));	
	String instal=""+request.getParameter("noinstal");
	if(instal.equals("null"))
		noinstal=0;
	else
		noinstal=Integer.parseInt(instal);
	String amt=""+request.getParameter("dueamt");
	if(amt.equals("null"))
		dueamt=0;		
	else
		dueamt=Integer.parseInt(amt);
	status=request.getParameter("status");
	closeday=""+request.getParameter("closeday");
	String cdate=null;
	if(closeday.equals("null")||closeday.equals(""))
	{
		closeday=null;		
	}else{
		closeDate(closeday);
		cdate=closeFormat(d2,m2,y2);		
	}
	dmonth=request.getParameter("duemonth");
	if(dmonth.equals("n"))
	{
		m1=m1+1;
		mon=getMonth(m1);		
	}
	balamt=Integer.parseInt(request.getParameter("balamt"));
	String balIns=""+request.getParameter("binstal");
	if(balIns.equals("null"))
	{
		balIns="0";
	}
	binstal=Integer.parseInt(balIns);    
	try
	{
    	if(intype.equals("M"))
    	{	
    		con = conbean.getConnection();
			pstm = con.prepareStatement(sql_Insert_Query);
			pstm.setString(1,empid);
			pstm.setString(2,advid);
			pstm.setString(3,odate);
			pstm.setInt(4,y1);
			pstm.setString(5,mon);
			pstm.setInt(6,addamt);
			pstm.setInt(7,noinstal);
			pstm.setInt(8,dueamt);
			pstm.setInt(9,balamt);
			pstm.setInt(10,binstal);
			pstm.setString(11,status);
			pstm.setString(12,intype);
			pstm.setString(13,cdate);
			pstm.setString(14,"ADMIN");
			pstm.setString(15,"2003-06-20 00:00:00");
			pstm.setString(16,"Y");
			pstm.executeUpdate();
			pstm.close();
    	}
    	else if(intype.equals("A"))
    	{
    		con = conbean.getConnection();
			pstm = con.prepareStatement(sql_Insert_Query);
			pstm.setString(1,empid);
			pstm.setString(2,advid);
			pstm.setString(3,odate);
			pstm.setInt(4,y1);
			pstm.setString(5,mon);
			pstm.setInt(6,addamt);
			pstm.setInt(7,noinstal);
			pstm.setInt(8,dueamt);
			pstm.setInt(9,balamt);
			pstm.setInt(10,binstal);
			pstm.setString(11,status);
			pstm.setString(12,intype);
			pstm.setString(13,cdate);
			pstm.setString(14,"ADMIN");
			pstm.setString(15,"2003-06-20 00:00:00");
			pstm.setString(16,"Y");
			pstm.executeUpdate();
			pstm.close();
    		//System.out.println("Length :"+noinstal);
		    for(i=0;i<noinstal;i++)
		    {
				pstran = con.prepareStatement(sql_tran_Insert);
			    pstran.setString(1,empid);
			    pstran.setString(2,advid);
			    pstran.setInt(3,y1);
			    pstran.setString(4,mon);
			    pstran.setInt(5,balamt);
			    pstran.setInt(6,dueamt);
			    pstran.setInt(7,binstal);
			    pstran.setString(8,status);
			    pstran.executeUpdate();
			    m1=m1+1;
			    if(m1>12)
			    {
			     	m1=1;
			     	y1=y1+1;
			    }
			    balamt=balamt-dueamt;
			    binstal=binstal-1;
				mon=getMonth(m1);	
		    }
    	 }	
	 	} 
		catch(Exception e)
		{			
			//System.out.println(e);
		}
        response.sendRedirect("Advance.jsp");			 
%>
