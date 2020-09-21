<%@page import="com.nidhi.student.StudentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Student</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function DoOnSubmit() {
		if ((document.getElementById("course").value == "null")
				|| (document.getElementById("year").value == "null")
				|| (document.getElementById("branch").value == "null")
				|| (document.getElementById("sec").value == "null")) {
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
<jsp:useBean id="dto" class="com.nidhi.student.StudentDto"></jsp:useBean>
<jsp:setProperty property="*" name="dto" />

</head>
<body>
	<%
		if (request.getMethod().equalsIgnoreCase("post")) {
			String course = request.getParameter("course");
			String branch = request.getParameter("branch");
			String year = request.getParameter("year");
			String sec = request.getParameter("sec");
			String student = course + "_" + year + "_" + branch + "_" + sec;
			if (new StudentDao().addStudent(student, dto)) {
				response.sendRedirect("manageStudent.jsp");
			} else {
				out.print("Failed");
			}
		}
	%>
	<%@include file="main_header.jsp"%>
	<%@include file="faculty_menu.jsp"%>
	<div style="width: 40%; margin-left: 30%; margin-top: 5%">
	<h1 style="text-align: center;">Add Student</h1>
		<form action="addStudent.jsp" method="post">
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
					</tr>
				</table>
			</div>
			<input type="text" name="sname" placeholder="Enter student name"
				autofocus="" class="field" required required pattern="[A-z|\s]*"
				onchange="this.setCustomValidity(validity.patternMismatch ? 'Please Enter Only Alphabets for Student Name' : '');" />
			<input type="number" name="sic" placeholder="Enter sic" class="field"
				required /> <input type="email" name="email"
				placeholder="Enter Email" class="field" required /> <input
				type="submit" id="SubmitButton" onclick="DoOnSubmit()"
				value="Register" />
		</form>
	</div>
</body>
</html>