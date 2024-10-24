package com.my.org.erp.Jmail;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class FilterServlet extends HttpServlet
{

    /**
	 * 
	 */
	private static final long serialVersionUID = -1691257793933671400L;

	public FilterServlet()
    {
    }

    public void doGet(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws IOException, ServletException
    {
        HttpSession httpsession = httpservletrequest.getSession();
        MailUserBean mailuserbean = (MailUserBean)httpsession.getAttribute("mailuser");
        String s = httpservletrequest.getServletPath();
        s = s.concat(".jsp");
        if(mailuserbean.isLoggedIn())
        {
            getServletConfig().getServletContext().getRequestDispatcher("/" + s).forward(httpservletrequest, httpservletresponse);
        } else
        {
            getServletConfig().getServletContext().getRequestDispatcher("/index.html").forward(httpservletrequest, httpservletresponse);
        }
    }

    public void doPost(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws IOException, ServletException
    {
        String s = httpservletrequest.getServletPath();
        s = s.concat(".jsp");
        getServletConfig().getServletContext().getRequestDispatcher("/" + s).forward(httpservletrequest, httpservletresponse);
    }
}
