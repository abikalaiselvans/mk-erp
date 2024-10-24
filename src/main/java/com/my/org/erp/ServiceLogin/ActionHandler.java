 
package com.my.org.erp.ServiceLogin;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
/**
* @author Mythra Kalaiselvan 
* @SmartERP version 1.2
*/

public interface ActionHandler
{
    public abstract void handle(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse) throws ServletException, IOException;
    public abstract void setApplication(ServletContext servletcontext);
    public abstract void setDatabaseConnection(Connection connection);
    public abstract void setPath(String path);
    public abstract void setPreparedStatement(PreparedStatement pstm);
    public abstract void setCallableStatementt(CallableStatement cs);
    public abstract void setResultSet(ResultSet arst);
    public abstract void setStatement(Statement ast);
    public abstract void setSql(String sql);
    public abstract void setEncodeKey(String sql);
    public abstract void setAction(String action);
    public abstract void setSession(HttpSession session);
    public abstract void setUserid(String auserid);
    public abstract void setRdispatcher(RequestDispatcher rdispatcher);
  
    
}