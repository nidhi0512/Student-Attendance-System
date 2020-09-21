<%@page import="com.nidhi.attendance.AttendanceDto"%>
<%@page import="com.nidhi.attendance.AttendanceDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Sub Attendance</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function DoOnSubmit() {
		if (document.getElementById("course").value == "null") {
			document.getElementById("SubmitButton").disabled = true;
			alert("Please select an option...");
		} else {
			document.getElementById("SubmitButton").disabled = false;
		}

	}

	function DoOnResubmit() {
		document.getElementById("SubmitButton").disabled = false;
	}
</script>
</head>
<body>
	<%@ include file="main_header.jsp"%>
	<%@ include file="stud_menu.jsp"%>
	<div style="width: 40%; margin-left: 30%; margin-top: 5%">
		<h1 style="text-align: center;">Select Subject for Attendance</h1>
		<form action="studentSubAttendance.jsp" method="post">
			<div style="width: 50%; margin-left: 20%">
				<select id="sub" name="sub" class="field" onchange="DoOnResubmit()">
					<option value="null">Subject</option>
					<option value="dsa">DSA</option>
					<option value="automata">Automata</option>
					<option value="os">OS</option>
					<option value="dbms">DBMS</option>
				</select>
			</div>
			<input type="submit" value="Submit" id="SubmitButton"
				onclick="DoOnSubmit()">
		</form>
		<%
			if (request.getMethod().equalsIgnoreCase("post")) {
				String sub = request.getParameter("sub");
				String details = (String) session.getAttribute("student");
				int sic = (int) session.getAttribute("id");
				AttendanceDto dto = new AttendanceDto();
				dto.setDetails(details);
				dto.setSic(sic);
				dto.setSub(sub);
				double arr[] = new AttendanceDao().subjectAttendance(dto);
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
			}
		%>
	</div>
</body>
</html>