<%@ page language="java" contentType="text/html; 
    charset=US-ASCII" pageEncoding="US-ASCII"%>

<%@page import="java.util.*"%>

<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Session Elements</title>
</head>
<body  onpaste='return false;'>
<%
  String x = "testing";
  String[] a = { "xx", "yy", "zz" };

  Map<String, String> m = new LinkedHashMap<String, String>();
  m.put("aa", "1");
  m.put("bb", "2");
  m.put("cc", "3");

  List<String> l = new ArrayList<String>();
  l.add("nn");
  l.add("mm");
  l.add("oo");
  
  Set<String> s = new LinkedHashSet<String>();
  s.add("aa");
  s.add("bb");
  s.add("cc");
  
  session.setAttribute("x", x);
  session.setAttribute("a", a);
  session.setAttribute("m", m);
  session.setAttribute("l", l);
  session.setAttribute("s", s);
%>
<h2>print session elements</h2>
(String) x: ${x}<br />
(Array) a: ${fn:join(a,",")}<br />
(List) l: ${l}<br />
(Map) m: ${m}<br />
(Set) s: ${s}<br />

<h2>Array, List, Map access</h2>
a[1]: ${a[1]} <br />
l[2]: ${l[2]} <br />
m["bb"]: ${m["bb"]} <br />

</body>
</html>
