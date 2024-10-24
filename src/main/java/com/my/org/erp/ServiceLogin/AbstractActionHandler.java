 
package com.my.org.erp.ServiceLogin;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
/**
* @author Mythra Kalaiselvan 
* @SmartERP version 1.2
*/


public abstract class AbstractActionHandler extends Transaction  implements ActionHandler
{

    protected ServletContext application;
    protected Connection con;
    protected String Path  ;
    protected PreparedStatement apstm  ;
    protected CallableStatement acs  ;
    protected String asql  ;
    protected String EncodeKey;
    protected String action;
    protected HttpSession asession;
    protected String  auserid;
    protected RequestDispatcher  rdispatcher;
    protected ResultSet  arst;
    protected Statement  ast;
    
    
    public AbstractActionHandler()
    {
    }
    
    public void setApplication(ServletContext application)
    {
        this.application = application;
    }

    public void setDatabaseConnection(Connection con)
    {
        this.con = con;
    }

    public void setPath(String Path)
    {
        this.Path = Path;
    }
    
    
    public void setPreparedStatement(PreparedStatement apstm) 
    {
        this.apstm = apstm;
    }
    
    
    public void setCallableStatementt(CallableStatement acs)
    {
        this.acs = acs;
    }
     
    public void setSql(String asql)
    {
        this.asql = asql;
    }
    
    public void setEncodeKey(String EncodeKey)
    {
        this.EncodeKey = EncodeKey;
    }
    
    public void setAction(String action)
    {
        this.action = action;
    }
    
    public void setSession(HttpSession session)
    {
        this.asession = session;
    }
    
    
    public void setUserid(String auserid)
    {
        this.auserid = auserid;
    }
    
    public void setRdispatcher(RequestDispatcher rdispatcher)
    {
        this.rdispatcher = rdispatcher;
    }

	
	public void setResultSet(ResultSet arst) {
		this.arst = arst;
	}

	public void setStatement(Statement ast) {
		this.ast = ast;
	}
    
    
}

