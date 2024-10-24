 <%@ page import="java.io.*,java.util.*,java.sql.*" %> 

    <%

    int id=0;

    if(request.getParameter("id")!=null && request.getParameter("id")!="")

    {

  id = Integer.parseInt(request.getParameter("id").toString());

    }

         String connectionURL = "jdbc:mysql://localhost:3306/smartcampus";

          String url=request.getParameter("WEB_URL");

          String Content=new String("");

          Statement stmt=null;

      Connection con=null;

    try

    {

        String filename="data"+id+".xls";

         Class.forName("com.mysql.jdbc.Driver").newInstance();

      con=DriverManager.getConnection(connectionURL,"root","mythra"); 

      stmt=con.createStatement();

          String qry = "select * from com_m_staff  where INT_OFFICEID="+id;
			out.println(qry);
          ResultSet rst= stmt.executeQuery(qry);

                       while(rst.next())

                        {

    

                                Content=Content+"\n"+rst.getString("CHR_EMPID")+"\t"+rst.getString("CHR_STAFFNAME")+"\t"+rst.getString("CHR_STAFFFNAME")+"\t"+rst.getString("DT_DOB");

                        }

                        

                byte requestBytes[] = Content.getBytes();

                ByteArrayInputStream bis = new ByteArrayInputStream(requestBytes);

                response.reset();

                response.setContentType("application/xls");

                response.setHeader("Content-disposition","attachment; filename=" +filename);

                byte[] buf = new byte[1024];

                  int len;

                  while ((len = bis.read(buf)) > 0){

                                  response.getOutputStream().write(buf, 0, len);

                                 }

                bis.close();

                response.getOutputStream().flush(); 

    }

    catch(Exception e){

        e.printStackTrace();

    }

    %>