<%@page import="com.nidhi.student.StudentDao"%>
<%@page import="com.nidhi.student.StudentDto"%>
<%@page import="com.nidhi.attendance.AttendanceDao"%>
<%@page import="com.nidhi.attendance.AttendanceDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View SUb Attendance</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function DoOnSubmit() {
		if ((document.getElementById("course").value == "null")
				|| (document.getElementById("year").value == "null")
				|| (document.getElementById("branch").value == "null")
				|| (document.getElementById("sec").value == "null")
				|| (document.getElementById("sub").value == "null")) {
			document.getElementById("SubmitButton").disabled = true;
			alert("Please select all options...");
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
	<%@ include file="faculty_menu.jsp"%>
	<%
		String sub = (String) session.getAttribute("sub");
		String details = (String) session.getAttribute("details");
		if (details != null) {
			session.removeAttribute("details");
			session.removeAttribute("sub");
		}
	%>
	<div style="width: 50%; margin-left: 25%; margin-top: 5%">
		<h1 style="text-align: center;">Enter Details for Attendance</h1>
		<form action="facultySubAttendance.jsp" method="post" name="frm">
			<div style="margin-left: 7%;">
				<table>
					<tr>
						<td><select id="course" name="course" class="field"
							onchange="DoOnResubmit()">
								<option value="null">Course</option>
								<option value="btech">Btech</option>
						</select></td>
						<td><select id="year" name="year" class="field"
							onchange="DoOnResubmit()">
								<option value="null">Year</option>
								<option value="1">1st</option>
						</select></td>
						<td><select id="branch" name="branch" class="field"
							onchange="DoOnResubmit()">
								<option value="null">Branch</option>
								<option value="cse">CSE</option>
						</select></td>
						<td><select id="sec" name="sec" class="field"
							onchange="DoOnResubmit()">
								<option value="null">Section</option>
								<option value="a">A</option>
								<option value="b">B</option>
						</select></td>
						<td><select id="sub" name="sub" class="field"
							onchange="DoOnResubmit()">
								<option value="null">Subject</option>
								<option value="dsa">DSA</option>
								<option value="automata">Automata</option>
								<option value="os">OS</option>
								<option value="dbms">DBMS</option>
						</select></td>
					</tr>
				</table>
			</div>
			<input class="field" type="submit" id="SubmitButton"
				onclick="DoOnSubmit()" value="View Attendance">
		</form>
		<%
			if (request.getMethod().equalsIgnoreCase("post") || details != null) {
				String course = request.getParameter("course");
				String branch = request.getParameter("branch");
				String year = request.getParameter("year");
				String sec = request.getParameter("sec");
				if (details == null) {
					details = course + "_" + year + "_" + branch + "_" + sec;
					sub = request.getParameter("sub");
				}
				if (details != null) {
					ArrayList<AttendanceDto> al = new AttendanceDao().getDetailsSubAttendance(details, sub);
					if (al.size() > 0) {
		%>
		<table id="tables" style="width: 100%">
			<tr>
				<th>S.No.</th>
				<th>Name</th>
				<th>SIC</th>
				<th>Present</th>
				<th>Absent</th>
				<th>percent</th>
				<th>Notify</th>
			</tr>
			<%
				ArrayList<StudentDto> al1 = new StudentDao().getAllStudent(details);
							if (al1 != null) {
								int s = 0;
								for (StudentDto dto1 : al1) {
									AttendanceDto dto = new AttendanceDto();
									dto.setDetails(details);
									dto.setSub(sub);
									dto.setSic(dto1.getSic());
									double arr[] = new AttendanceDao().subjectAttendance(dto);
									int present = (int) arr[0];
									int absent = (int) arr[1];
									double percent = Double.parseDouble(String.format("%.2f", arr[2]));
			%>
			<tr>
				<td><%=++s%></td>
				<td><%=dto1.getSname()%></td>
				<td><%=dto1.getSic()%></td>
				<td><%=present%></td>
				<td><%=absent%></td>
				<td><%=percent%></td>
				<td><form action="notify.jsp" method="post">
						<input type="hidden" name="details" value=<%=details%>> <input
							type="hidden" name="email" value=<%=dto1.getEmail()%>> <input
							type="hidden" name="percent" value=<%=percent%>> <input
							type="hidden" name="sub" value=<%=sub%>> <input
							type="submit" value="Notify">
					</form></td>

				<%
					}
								}
							} else {
				%>
				<h1 style="text-align: center; color: red">No Records Found.</h1>
				<%
					}
						}
					}
				%>

				</div>
</body>
</html>