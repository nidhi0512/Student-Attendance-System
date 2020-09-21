
<%
	int id = (int) session.getAttribute("id");
	String sid = String.valueOf(id);
	String pwd = (String) session.getAttribute("pwd");
	if (sid.equalsIgnoreCase(pwd))
		response.sendRedirect("resetPassword.jsp");
	else
		response.sendRedirect("student.jsp");
%>