 
 

<%@ page session="true" import="com.my.org.erp.chats.ChatRoomList, com.my.org.erp.chats.ChatRoom" errorPage="error.jsp"%>
<%
	String nickname = (String)session.getAttribute("nickname");
	if (nickname != null && nickname.length() > 0)
	{
		ChatRoomList roomList = (ChatRoomList) application.getAttribute("chatroomlist");
		ChatRoom room = roomList.getRoomOfChatter(nickname);
		String roomname = room.getName();
%>
	
<HTML>
<HEAD>
<TITLE>   <%=nickname%> (<%=roomname%>) </TITLE>
<META name="Author" value="Sukhwinder Singh (ssruprai@hotmail.com)">
</HEAD>
<FRAMESET rows="75%,26%" cols="*">
<FRAME SRC="displayMessages.jsp#current" name="MessageWin">
<FRAME SRC="sendMessage.jsp" name="TypeWin">
</FRAMESET>
<NOFRAMES>
<H2>This chat rquires a browser with frames support</h2>
</NOFRAMES>
</HTML>
<%
}
else
{
	response.sendRedirect("login.jsp");
}
%>