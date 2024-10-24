<%@ page language="java" import="java.util.Vector,java.util.Enumeration,java.io.File"%>
<%
		String mode = request.getParameter("mode");
		String user="e://jrun/servers/default/default-app/fusionmail/attachment/test";

		out.println(mode);
		Vector files_add=(Vector)session.getValue("files_add");
		Vector vec_len=(Vector)session.getValue("vec_len");
		
		Long Len=(Long)session.getValue("len");
		long len=Len.longValue();
	
		String ind=""+mode.charAt(6);
		out.println(ind);
		int index=Integer.parseInt(ind);
		out.println(index);

		String filename=(String)files_add.elementAt(index);
		File f=new File(user+"/"+filename);
		f.delete();
		
		files_add.removeElementAt(index);

		long len_rem=((Long)vec_len.elementAt(index)).longValue();
		len=len-len_rem;
		
		vec_len.removeElementAt(index);

		out.println("Remove from the session");
		Enumeration enmue=files_add.elements();
		int j=0;	
		while(enmue.hasMoreElements())
		{
			j++;
			out.println(enmue.nextElement());

		}
		int i=3-j;
		
		session.putValue("files_add",files_add);
		session.putValue("vec_len",vec_len);
		Long leng=new Long(len);
		session.putValue("len",leng);
		response.sendRedirect("attach.jsp?i="+i);
		//response.sendRedirect("/mail_new/compose_mail.jsp");
	
%>

