<%@page import="com.nidhi.attendance.AttendanceDao"%>
<%@page import="com.nidhi.attendance.AttendanceDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Attendance</title>
<link href="css/style.css" rel="stylesheet" type="text/css">

</head>
<body>
	<%@ include file="main_header.jsp"%>
	<%@ include file="stud_menu.jsp"%>
	<%
		String details = (String) session.getAttribute("student");
		int sic = (int) session.getAttribute("id");
		AttendanceDto dto = new AttendanceDto();
		dto.setDetails(details);
		dto.setSic(sic);
		double arr[] = new AttendanceDao().totalAttendance(dto);
		if (arr[0] == -1) {
	%>
	<h1 style="text-align: center; color: red">No Records Found.</h1>
	<%
		} else {
			int present = (int) arr[0];
			int absent = (int) arr[1];
			double percent = Double.parseDouble(String.format("%.2f", arr[2]));
	%>
	<h1 style="text-align: center; color: gray;">
		Total Present :
		<%=present%>
		days
	</h1>
	<h1 style="text-align: center; color: gray;">
		Total absent :
		<%=absent%>
		days
	</h1>
	<h1 style="text-align: center; color: red">
		Total Percentage :
		<%=percent%>%
	</h1>
	<%
		}
	%>
</body>
</html>