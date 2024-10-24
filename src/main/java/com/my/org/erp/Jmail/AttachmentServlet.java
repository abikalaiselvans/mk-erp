package com.my.org.erp.Jmail;
import java.io.*;
import javax.mail.*;
import javax.mail.internet.ContentType;
import javax.servlet.*;
import javax.servlet.http.*;

@SuppressWarnings("serial")
public class AttachmentServlet extends HttpServlet
{

    public AttachmentServlet()
    {
    }

    public void doGet(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws IOException, ServletException
    {
        HttpSession httpsession = httpservletrequest.getSession();
        ServletOutputStream servletoutputstream = httpservletresponse.getOutputStream();
        int i = Integer.parseInt(httpservletrequest.getParameter("message"));
        int j = Integer.parseInt(httpservletrequest.getParameter("part"));
        MailUserBean mailuserbean = (MailUserBean)httpsession.getAttribute("mailuser");
        if(mailuserbean.isLoggedIn())
        {
            try
            {
                Message message = mailuserbean.getFolder().getMessage(i);
                Multipart multipart = (Multipart)message.getContent();
                javax.mail.BodyPart bodypart = multipart.getBodyPart(j);
                String s = bodypart.getContentType();
                if(s == null)
                {
                    servletoutputstream.println("invalid part");
                    return;
                }
                ContentType contenttype = new ContentType(s);
                httpservletresponse.setContentType(contenttype.getBaseType());
                InputStream inputstream = bodypart.getInputStream();
                int k;
                while((k = inputstream.read()) != -1) 
                {
                    servletoutputstream.write(k);
                }
                servletoutputstream.flush();
                servletoutputstream.close();
            }
            catch(MessagingException messagingexception)
            {
                throw new ServletException(messagingexception.getMessage());
            }
        } else
        {
            getServletConfig().getServletContext().getRequestDispatcher("/index.html").forward(httpservletrequest, httpservletresponse);
        }
    }
}
