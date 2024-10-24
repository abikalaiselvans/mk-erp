<%
/*
String l_str_http_base_path = new java.net.URL(new java.net.URL(HttpUtils.getRequestURL(request).toString()), "/").toString();
String l_str_con_path = request.getContextPath();
String l_str_complete_url = l_str_http_base_path + ((l_str_con_path != null && !(l_str_con_path.equals("")))? l_str_con_path.substring(1,l_str_con_path.length()) + "/" : "") + "default.jsp";*/
response.sendRedirect("http://www.ayushman.net:8100/default.jsp");
%>