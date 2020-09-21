<%@page import="java.util.ArrayList"%>
<%@page import="com.nidhi.attendance.AttendanceDao"%>
<%@page import="com.nidhi.attendance.AttendanceDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Date</title>
<link href="css/style.css" rel="stylesheet" type="text/css">

</head>
<body>
	<%@ include file="main_header.jsp"%>
	<%@ include file="faculty_menu.jsp"%>
	<%
		String details = request.getParameter("details");
		String doa = request.getParameter("doa");
		String sub = request.getParameter("sub");
		String doa1 = request.getParameter("doa1");
		AttendanceDto dto = new AttendanceDto();
		dto.setDetails(details);
		dto.setDoa(doa1);
		dto.setSub(sub);
		ArrayList<AttendanceDto> al = new AttendanceDao().getAllAttendance(dto);
		if (al.size() > 0) {
	%>
	<h1 style="text-align: center; color: red">This date already
		exist.</h1>
	<%
		} else {
			AttendanceDto dto1 = new AttendanceDto();
			dto1.setDetails(details);
			dto1.setDoa(doa);
			dto1.setSub(sub);
			if (new AttendanceDao().updateDateAttendance(dto1, doa1)) {
				response.sendRedirect("updateAttendance.jsp");
			}
		}
	%>
</body>
</html>