<%@ page import="java.sql.*,java.util.*,java.io.*,java.lang.String"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>
<%!
	Connection con ;
	PreparedStatement pstm,pstm1,pstm2,pstm3;
	ResultSet rst1,rst2,rst3,rst;
	String userid;
	String name3,name1,name2,stempname,stempid,stfname,stdob,stoffid1,stdesid1,stdepid1,stgender,stbg,sttype,stdoj,stnote,ststtype,stpf,stgray1,stmartial,stwedding,ststate,stmarry;
	String Sql,grade;
	int stdepid,stdesid,stoffid,desid,depid,offid,stgray,stsalary,stdist,stst1;
   	String sql_Insert_Query ="INSERT INTO  com_m_staff (CHR_EMPID,CHR_STAFFNAME,CHR_STAFFFNAME,INT_DEPARTID,INT_DESIGID,INT_OfficeID,CHR_GENDER,DT_DOB,CHR_BG,DT_DOJCOLLEGE,CHR_GRADE,CHR_CARD,INT_BALANCE,CHR_TYPE,INT_SALARY,CHR_PFESI,INT_GRATUITY,CHR_MartialSTATUS,DT_WEDDATE,CHR_ACCNO,INT_DISTRICTID,INT_STATEID,chr_USRNAME,dt_UPDATEDATE,chr_UPDATESTATUS)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

	public void insertUserInformation() 
	{
		try{
			String sql_select1="SELECT * from  com_m_desig  where CHR_DESIGNAME=?";
			pstm=con.prepareStatement(sql_select1);
			pstm.setString(1,name1);
			rst=pstm.executeQuery();
			
			if(rst.next())
			{
				desid=rst.getInt("int_DESIGID");
				//System.out.println(desid);
			}

			String sql_select2="SELECT * from   com_m_depart   where CHR_DEPARTNAME=?";
			pstm=con.prepareStatement(sql_select2);
			pstm.setString(1,name2);
			rst=pstm.executeQuery();
			
			if(rst.next())
			{
				depid=rst.getInt("INT_DEPARTID");
				//System.out.println(depid);
			}
			
			String sql_select="SELECT * from  com_m_office  where CHR_Officename=?";
			pstm=con.prepareStatement(sql_select);
			pstm.setString(1,name3);
			rst=pstm.executeQuery();
			
			if(rst.next())
			{
				offid=rst.getInt("INT_OfficeID");
				//System.out.println(offid);
			}	
			pstm = con.prepareStatement(sql_Insert_Query);
			pstm.setString(1,stempid);
			pstm.setString(2,stempname);
			pstm.setString(3,stfname);
			pstm.setInt(4,depid);
			pstm.setInt(5,desid);
			pstm.setInt(6,offid);
			pstm.setString(7,stgender);
			pstm.setString(8,stdob);
			pstm.setString(9,stbg);
			pstm.setString(10,stdoj);
			pstm.setString(11,grade);
			pstm.setString(12,"Not Issued");
			pstm.setString(13,"0");
			pstm.setString(14,sttype);
			pstm.setInt(15,stsalary);
			pstm.setString(16,stpf);
			pstm.setInt(17,stgray);
			pstm.setString(18,stmarry);
			pstm.setString(19,stwedding);
			pstm.setString(20,stnote);
			pstm.setInt(21,stdist);
			pstm.setInt(22,stst1);
			pstm.setString(23,"ADMIN");
			pstm.setString(24,"2003-06-20 00:00:00");
			pstm.setString(25,"Y");
			pstm.execute();
		}catch(NullPointerException ex)
		{
		                     //System.out.println(ex);
		}catch(SQLException ex)
		{
			//System.out.println(ex);
		}
	}
	
	public void releaseJDBCResource() 
	{
		try
		{
			rst.close();
			pstm.close();
			 

		}catch(NullPointerException ex)
		{
			//System.out.println(ex);
		}catch(SQLException ex)
		{
			//System.out.println(ex);
		}
	}
		
%>

<%

	String sql_Select_Query = "SELECT CHR_USRNAME FROM m_user";
	name1=request.getParameter("desig");
	name2=request.getParameter("depart");
	name3=request.getParameter("off");

	//Form Information
	
    stempid = request.getParameter("id");
    //System.out.println(stempid);
	stempname = request.getParameter("name");
	stfname =""+request.getParameter("fname");
	if(stfname.equals("null"))
		stfname="";
	stgender = request.getParameter("gender");
	depid=Integer.parseInt(request.getParameter("depart"));
	desid=Integer.parseInt(request.getParameter("desig"));
	offid=Integer.parseInt(request.getParameter("off"));
    stdob =""+request.getParameter("dob");  
    if(stdob.equals("null") || stdob.equals(""))
    {
    	stdob=null;
    }
    else
	{
	   String dtdob[]=stdob.split("-");
	   stdob=dtdob[2]+"-"+dtdob[1]+"-"+dtdob[0];
	}
	stbg =""+request.getParameter("bg");
	
	if(stbg.equals("Select")|| stbg.equals(""))
		stbg="";
	ststtype=""+request.getParameter("stype");
	 if(ststtype.equals("null")|| ststtype.equals(""))
		 ststtype="";
	 stdoj= ""+request.getParameter("doj");
	 if(stdoj.equals("null")|| stdoj.equals(""))
	 {	 
		 stdoj=null;
	 }	 
	 else
	{
		   String dtdoj[]=stdoj.split("-");
		   stdoj=dtdoj[2]+"-"+dtdoj[1]+"-"+dtdoj[0];
	}
	sttype=""+request.getParameter("type");
	if(sttype.equals("Select")|| sttype.equals(""))
		sttype="";
	stsalary=Integer.parseInt(request.getParameter("basic"));
	if(stsalary==0)
	   stsalary=0;
	stpf=request.getParameter("pf");
	stmarry=request.getParameter("marry");
	stwedding=""+request.getParameter("wedding");
	//System.out.println("Wedding Date"+stwedding);
	if(stwedding.equals("null") || stwedding.equals(""))
	{	
		stwedding=null;
	}	
	else
	{
	   String dt[]=stwedding.split("-");
	   stwedding=dt[2]+"-"+dt[1]+"-"+dt[0];	
	}
	stst1=Integer.parseInt(request.getParameter("st1"));
	//System.out.println(stst1);
	if(stst1==0)
	{
		stst1=0;
	//System.out.println("State is "+stst1);
	}
	stdist=Integer.parseInt(request.getParameter("dist"));
	if(stdist==0)
	stdist=0;
	//System.out.println("District is "+stdist);
	//stgray1=request.getParameter("gray");
	stgray=Integer.parseInt(request.getParameter("gray"));
	if(stgray==0)
		stgray=0;
	stnote=""+request.getParameter("number");
    if(stnote.equals("null")|| stnote.equals(""))
    	stnote="";
    
	//Loading JDBC Connection Information
	try
	{
		//Database Connectivity
		con = conbean.getConnection();
		pstm = con.prepareStatement(sql_Select_Query);
		rst = pstm.executeQuery();
		boolean exist = false;
		while(rst.next())
		{
		if(rst.getString("chr_USRNAME").equalsIgnoreCase(userid))
			{
				exist = true;
				releaseJDBCResource();
				break;				
			}
		}
		if(exist == true)
		{
			session.putValue("Username",userid);
			releaseJDBCResource();
			response.sendRedirect("ExsistUtility.htm");
		}
		else
		{
			insertUserInformation();
			releaseJDBCResource();
			response.sendRedirect("StaffAddressAdd.jsp?staffid="+stempid);
		}

	}catch(FileNotFoundException ex)
	{
		//System.out.println(ex);
	}
	catch(SQLException ex)
	{
		//System.out.println(ex);
	}
		releaseJDBCResource();	
%>
