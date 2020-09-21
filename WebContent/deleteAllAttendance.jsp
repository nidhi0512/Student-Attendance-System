<%@page import="com.nidhi.attendance.AttendanceDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete All Attendance</title>
<link href="css/style.css" rel="stylesheet" type="text/css">

</head>
<body>
	<%@ include file="main_header.jsp"%>
	<%@ include file="admin_menu.jsp"%>
	<%
		if (request.getMethod().equalsIgnoreCase("post")) {
			if (new AttendanceDao().deleteAllAttendance())
				response.sendRedirect("admin.jsp");
		}
	%>
	<div style="width: 40%; margin-left: 30%; margin-top: 5%">
		<form action="deleteAllAttendance.jsp" method="post">
			<input type="submit" value="Delete All Attendance">
		</form>
	</div>
</body>
</html>