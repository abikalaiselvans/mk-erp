<%@ page
	import="java.sql.*,java.util.Date,java.util.Properties,java.io.*,java.text.*"%>
<%@ page import="java.util.Random"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!
	Connection con ;
	PreparedStatement pstm,ps;
	ResultSet rst,rs;	
	String sql;
	int pinno;
	String holderId;
	private boolean checkPinNo(int pin)
	{
		try{
			pstm=con.prepareStatement("SELECT * FROM M_PIN WHERE INT_PIN="+pin);
			rst=pstm.executeQuery();
			if(rst.next()){
				rst.close();
				return false;
			}
			else
			{			
				rst.close();
				return true;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
	private void generatePinNo(String act,String empid,String userName)
	{
		String sql=null;
		try{					
			Random	rm=new Random();
			SimpleDateFormat datetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");			
			java.util.Date date=new java.util.Date();			
			while(true){
				pinno=rm.nextInt(10000);
				if(pinno>999)
				{
					if(checkPinNo(pinno))
					{						
						if(act.equalsIgnoreCase("INSERT")){
							sql="INSERT INTO M_PIN VALUES('"+empid+"',"+pinno+",'"+userName+"','"+datetime.format(date)+"','Y')";
							//System.out.println("TRUE : INSERT");
						}
						else{
							sql="UPDATE M_PIN SET INT_PIN="+pinno+" WHERE CHR_HOLDERID='"+empid+"'";	
						}					
						pstm=con.prepareStatement(sql);
						pstm.execute();
						break;
					}
				}
			}			
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
%>
<%
	holderId=request.getParameter("holderId");
	try{		
		con = conbean.getConnection();
		generatePinNo("INSERT",holderId,"ADMIN");		
	}
	catch(Exception e){
		e.printStackTrace();
	}
	response.sendRedirect("Staff Registration.jsp?message=Staff Registration completed Successfully");
%>
