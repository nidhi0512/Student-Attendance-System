<%@page import="com.nidhi.student.StudentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete All Students</title>
	<link href="css/style.css" rel="stylesheet" type="text/css"> <script
		type="text/javascript">
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
</head>
<body>
	<%@ include file="main_header.jsp"%>
	<%@ include file="faculty_menu.jsp"%>

	<%
		if (request.getMethod().equalsIgnoreCase("post")) {
			String course = request.getParameter("course");
			String branch = request.getParameter("branch");
			String year = request.getParameter("year");
			String sec = request.getParameter("sec");
			String student = course + "_" + year + "_" + branch + "_" + sec;
			if (course != null && year != null && branch != null && sec != null) {
				if (new StudentDao().deleteAllStudent(student)) {
					response.sendRedirect("manageStudent.jsp");
				} else {
					response.sendRedirect("manageStudent.jsp");
				}
			}
		}
	%>

	<form action="deleteAllStudent.jsp" method="post" name="frm">
		<div style="width: 40%; margin-left: 30%; margin-top: 5%">
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
			<input class="field" type="submit" id="SubmitButton"
				onclick="DoOnSubmit()" value="Delete All Students">
	</form>
	</div>
</body>
</html>