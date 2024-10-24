package com.my.org.erp.ServiceLogin;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSessionBindingListener;
import javax.servlet.http.*;
public class User implements HttpSessionBindingListener 
{

    // All logins.
    private static Map<User, HttpSession> logins = new HashMap<User, HttpSession>();

    // Normal properties.
    private Long id;
    private String username;
    // Etc.. Of course with public getters+setters.

     
    public boolean equals(Object other) 
    {
        return (other instanceof User) && (id != null) ? id.equals(((User) other).id) : (other == this);
    }

     
    public int hashCode() 
    {
        return (id != null) ? (this.getClass().hashCode() + id.hashCode()) : super.hashCode();
    }

    public void valueBound(HttpSessionBindingEvent event) 
    {
        HttpSession session = logins.remove(this);
        if (session != null) 
        {
            session.invalidate();
        }
        logins.put(this, event.getSession());
    }

     
    public void valueUnbound(HttpSessionBindingEvent event) 
    {
        logins.remove(this);
    }

}