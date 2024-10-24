package com.my.org.erp.DAO.SmartCommon;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
public interface Country 
{
	public abstract void Add(HttpServletRequest request, HttpServletResponse response,Connection con, PreparedStatement apstm, CallableStatement acs) throws ServletException, IOException ;
    public abstract void Edit(HttpServletRequest request, HttpServletResponse response,Connection con, PreparedStatement apstm, CallableStatement acs) throws ServletException, IOException ;
    public abstract void Delete(HttpServletRequest request, HttpServletResponse response,Connection con, PreparedStatement apstm, CallableStatement acs) throws ServletException, IOException ;
    
}
