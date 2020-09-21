<%@page import="com.nidhi.utility.ManagementUtility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notify</title>
<link href="css/style.css" rel="stylesheet" type="text/css">

</head>
<body>
	<%@ include file="main_header.jsp"%>
	<%@ include file="faculty_menu.jsp"%>
	<%
		if (request.getMethod().equalsIgnoreCase("post")) {
			String email = request.getParameter("email");
			String sub = request.getParameter("sub");
			String details = request.getParameter("details");
			String percent = request.getParameter("percent");
			boolean flag = new ManagementUtility().sendNotification(email, sub, percent);
			session.setAttribute("details", details);
			session.setAttribute("sub", sub);
			if (flag == false) {
				out.print("<script> alert('There are some Server problems...')</script>");
			} else {
				if(sub.equalsIgnoreCase("all"))
					response.sendRedirect("facultyViewAttendance.jsp");
				else
					response.sendRedirect("facultySubAttendance.jsp");
			}
		}
	%>
</body>
</html>