 

package com.my.org.erp.ServiceLogin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
/**
* @author Mythra Kalaiselvan 
* @SmartERP version 1.2
*/

public class Authenticator
{

    public Authenticator()
    {
    }

    public static boolean isAuthenticated(HttpServletRequest request)
    {
        HttpSession session = request.getSession();
        Object object = session.getAttribute("USRID");
        return object != null;
    }
}