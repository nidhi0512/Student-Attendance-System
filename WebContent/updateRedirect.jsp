<%@page import="com.nidhi.attendance.AttendanceDao"%>
<%@page import="com.nidhi.attendance.AttendanceDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Attendance</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	
</script>
</head>
<body>
	<%@ include file="main_header.jsp"%>
	<%@ include file="faculty_menu.jsp"%>
	<%
		if (request.getMethod().equalsIgnoreCase("post")) {
			String details = request.getParameter("details");
			String doa = request.getParameter("doa");
			String sub = request.getParameter("sub");
			String status = request.getParameter("status");
			int sic = Integer.parseInt(request.getParameter("sic"));
			if (status.equalsIgnoreCase("a"))
				status = "p";
			else
				status = "a";
			AttendanceDto dto = new AttendanceDto();
			dto.setDetails(details);
			dto.setDoa(doa);
			dto.setSic(sic);
			dto.setSub(sub);
			dto.setStatus(status);
			if (new AttendanceDao().updateStudentAttendance(dto)) {
	%>
	<div style="width: 40%; margin-left: 30%; margin-top: 5%">
		<form name="myForm" id="myForm" action="updateAttendance.jsp"
			method="post">
			<input type="hidden" name="sic" value="<%=sic%>"> <input
				type="hidden" name="details" value="<%=details%>"> <input
				type="hidden" name="doa" value="<%=doa%>"> <input
				type="hidden" name="sub" value="<%=sub%>"> <input
				name="submit" type="submit" value="View Updates Status">
		</form>
	</div>
	<%
		}
		}
	%>
</body>
</html>