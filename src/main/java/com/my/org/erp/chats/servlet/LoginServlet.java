package com.my.org.erp.chats.servlet;

 
 
import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import com.my.org.erp.chats.*;

public class LoginServlet extends HttpServlet
{

    /**
	 * 
	 */
	private static final long serialVersionUID = 3750248499343136334L;
	@SuppressWarnings("unused")
	private String contextPath;

    public void doGet(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws ServletException, IOException
    {
        contextPath = httpservletrequest.getContextPath();
        httpservletresponse.sendRedirect( "chat/login.jsp");
    }

    public void doPost(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)  throws ServletException, IOException
    {
        contextPath = httpservletrequest.getContextPath();
        String s = httpservletrequest.getParameter("nickname");
        s = s.trim().toLowerCase();
        String s1 = httpservletrequest.getParameter("sex");
        if(s1.length() > 0)
        {
            s1 = s1.trim().toLowerCase();
        }
        
        if(s != null && s.length() > 3 && s.indexOf(" ") == -1 && s1 != null && (s1.equals("m") || s1.equals("f")))
        {
            try
            {
            	ChatRoomList chatroomlist = (ChatRoomList)getServletContext().getAttribute("chatroomlist");
                boolean flag = chatroomlist.chatterExists(s);
                if(flag)
                {
                    httpservletresponse.sendRedirect( "chat/login.jsp?d=t&n=" + s);
                } 
                else
                {
                    HttpSession httpsession = httpservletrequest.getSession(true);
                    int i = 1800;
                    String s2 = getServletContext().getInitParameter("sessionTimeout");
                     if(s2 != null)
                    {
                        try
                        {
                            i = Integer.parseInt(s2);
                            i *= 60;
                        }
                        catch(NumberFormatException numberformatexception) { }
                    }
                    httpsession.setMaxInactiveInterval(i);
                    httpsession.setAttribute("nickname", s);
                    ChatRoom chatroom = chatroomlist.getRoom("StartUp");
                    s = s.toLowerCase();
                    Chatter chatter = null;
                    if("m".equals(s1))
                        s1 = "Male";
                     else
                        s1 = "Female";
                    
                    chatter = new Chatter(s, s1, (new Date()).getTime());
                    chatroom.addChatter(chatter);
                    httpservletresponse.sendRedirect("chat/listrooms.jsp");
                }
            }
            catch(Exception exception)
            {
            	httpservletresponse.sendRedirect( "chat/error.jsp?Mess="+exception.getMessage());
            }
        } else
        {
            httpservletresponse.sendRedirect( "chat/login.jsp?ic=t");
        }
    }

    private final void _mththis()
    {
        contextPath = "";
    }

    public LoginServlet()
    {
        _mththis();
    }
}
