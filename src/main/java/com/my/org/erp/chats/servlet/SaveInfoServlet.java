package com.my.org.erp.chats.servlet;

import java.io.*;
 
import javax.servlet.ServletException;
import javax.servlet.http.*;
import com.my.org.erp.chats.*;

public class SaveInfoServlet extends HttpServlet
{

    /**
	 * 
	 */
	private static final long serialVersionUID = -6034008878803795219L;
	String nickname;
    int age;
    String email;
    String comment;
    HttpSession session;
    String contextPath;

    public void doGet(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws IOException, ServletException
    {
        nickname = httpservletrequest.getParameter("nickname");
        contextPath = httpservletrequest.getContextPath();
        try
        {
            Integer integer = Integer.valueOf(httpservletrequest.getParameter("age"));
            age = integer.intValue();
        }
        catch(NumberFormatException numberformatexception)
        {
            age = -1;
        }
        email = httpservletrequest.getParameter("email");
        comment = httpservletrequest.getParameter("comment");
        session = httpservletrequest.getSession(true);
        try
        {
            ChatRoomList chatroomlist = (ChatRoomList)getServletContext().getAttribute("chatroomlist");
            ChatRoom chatroom = chatroomlist.getRoomOfChatter(nickname);
            if(chatroom != null)
            {
                Chatter chatter = chatroom.getChatter(nickname);
                chatter.setAge(age);
                chatter.setEmail(email);
                chatter.setComment(comment);
                httpservletresponse.setContentType("text/html");
                PrintWriter printwriter = httpservletresponse.getWriter();
                printwriter.write("<html>\n<head>\n<title>Information Saved</title>\n</head>\n<body  onpaste='return false;'>\n");
                printwriter.write("<b>Information Saved</b>\n<div align=\"center\">\n<form name=\"closing\">\n");
                printwriter.write("<input type=\"button\" onClick=\"window.close()\" value=\"Close\">\n");
                printwriter.write("</form>\n</div>\n</body>\n</html>");
                printwriter.close();
            }
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
            System.out.println("Exception: " + exception.getMessage());
            httpservletresponse.sendRedirect(contextPath + "/chat/error.jsp");
        }
    }

    public void doPost(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws IOException, ServletException
    {
        doGet(httpservletrequest, httpservletresponse);
    }

    private final void _mththis()
    {
        nickname = null;
        age = -1;
        email = null;
        comment = null;
        session = null;
        contextPath = null;
    }

    public SaveInfoServlet()
    {
        _mththis();
    }
}
