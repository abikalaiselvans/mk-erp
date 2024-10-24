<%@ page language="java" import="java.io.*,java.util.*,java.io.*,java.sql.*;" %>
//com.ayush.beans.MultipartRequest
<%
	/*
	String user = "test";
	String path1 = application.getRealPath("/");
	String path = path1 + "/mail_new/attachment/test";
	String mode = "next";
	int j = 0,k = 0;

	File location = new File(path);
	if(!location.isDirectory())
	{
		location.mkdir();
		out.println("Directory Created");
	}
	Vector files_add=new Vector();
	Vector vec_len=new Vector();
	long len=0;

	try
	{
	//MultipartRequest multi = null; // new MultipartRequest(request,path,1048576);
	
	//tring first=multi.getParameter("first");
	int i=Integer.parseInt(multi.getParameter("i"));
	out.println(i);
	
	if(first==null)
		{
		files_add=(Vector)session.getValue("files_add");
		vec_len=(Vector)session.getValue("vec_len");
		Long Len=(Long)session.getValue("len");
		len=Len.longValue();
		}
	else
		{
		for(int a=1;a<4;a++)
			{
			String save_at=user+a;
			String path_at=path+"/"+save_at;
			out.println("<br>PATH AT  "+path_at);
			File save=new File(path_at);
			if(!save.isDirectory())
				save.mkdir();
			}
		}

	Enumeration files=multi.getFileNames();
	String name="";
	String filename="";
	String type="";
	File f=null;

	while(files.hasMoreElements())
	{
		
		name=(String)files.nextElement();
		out.println(name+"name<br>");
		filename=multi.getFilesystemName(name);
		out.println(filename+"  :  filename <BR>");
		type=multi.getContentType(name);
		out.println(type+"    typs<BR>");
		f=multi.getFile(name);
		out.println(f+"    File <BR>");
		
		if(filename!=null)
		{
			long file_len=f.length();
			len=len+file_len;
			Long len_file=new Long(file_len);
			files_add.addElement(filename);
			vec_len.addElement(len_file);
			j++;
			i--;
		}
		else
		{	k++;	}
		out.println("Length of the uploaded "+len);
	}
	if(len>=1000000)
	{
		int excess=files_add.size();
		i++;
		int z=i;
		String fff=(String)files_add.elementAt(excess-1);
		out.println(fff);
		
		File ff=new File(user+"/"+fff);
		ff.delete();
		files_add.removeElementAt(excess-1);
		
		long len_rem=((Long)vec_len.elementAt(excess-1)).longValue();
		len=len-len_rem;
		vec_len.removeElementAt(excess-1);

		Long leng=new Long(len);
		session.putValue("files_add",files_add);
		session.putValue("len",leng);
		session.putValue("vec_len",vec_len);
	
		response.sendRedirect("attach.jsp?i="+z+"&error=error");
		
//		out.println("<BR>size"+excess+"<BR>Uploaded file(s) Size is more than 1 MB");
	}
	else
	{
		out.println("BAK 3  ");
	Long leng=new Long(len);
	session.putValue("files_add",files_add);
	session.putValue("len",leng);
	session.putValue("vec_len",vec_len);
	
	response.sendRedirect("attach.jsp?i="+k);
	}
   //response.sendRedirect("hel_mailform2.jsp");
}
catch(Exception ex)
{
	response.sendRedirect("attach.jsp?error=error");

}
	*/
%>
