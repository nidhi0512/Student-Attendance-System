<%@page import="com.nidhi.student.StudentDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.nidhi.student.StudentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Student</title>
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
</head>
<body>
	<%@ include file="main_header.jsp"%>
	<%@ include file="faculty_menu.jsp"%>
	<div id="tables" style="width: 50%; margin-left: 25%; margin-top: 5%">
		<%
			String student;
			if (request.getMethod().equalsIgnoreCase("post")) {
				String course = request.getParameter("course");
				String branch = request.getParameter("branch");
				String year = request.getParameter("year");
				String sec = request.getParameter("sec");
				student = course + "_" + year + "_" + branch + "_" + sec;
			} else {
				student = (String) session.getAttribute("student");
				session.removeAttribute("student");
			}
		%>
		<h1 style="text-align: center;">Manage Students</h1>
		<table style="width: 100%">
			<tr>
				<td>
					<form action="addStudent.jsp">
						<input type="submit" value="Add Students">
					</form>
				</td>
				<td>
					<form action="deleteAllStudent.jsp" method="post">
						<input type="submit" value="Delete All Students">
					</form>
				</td>
			</tr>
		</table>
		<form action="manageStudent.jsp" method="post" name="frm">
			<div style="margin-left: 12%;">
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
				onclick="DoOnSubmit()" value="View Students">
		</form>
		<%
			if (student != null) {
				ArrayList<StudentDto> al = new StudentDao().getAllStudent(student);
				if (al.size() > 0) {
		%>
		<table style="width: 100%">


			<tr>
				<th>S.No.</th>
				<th>Name</th>
				<th>SIC</th>
				<th>Email</th>
				<th>Update</th>
				<th>Delete</th>
			</tr>
			<%
				int s = 0;
						for (StudentDto dto : al) {
			%>
			<tr>
				<td><%=++s%></td>
				<td><%=dto.getSname()%></td>
				<td><%=dto.getSic()%></td>
				<td><%=dto.getEmail()%></td>
				<td>


					<form action="updateStudent.jsp" method="post">
						<input type="hidden" name="sid" value="<%=dto.getSid()%>">
						<input type="hidden" name="student" value="<%=student%>">
						<input type="submit" value="Update">
					</form>
				</td>
				<td>
					<form action="deleteStudent.jsp" method="post">
						<input type="hidden" name="sid" value="<%=dto.getSid()%>">
						<input type="hidden" name="student" value="<%=student%>">
						<input type="submit" value="Delete">
					</form>
				</td>
			</tr>
			<%
				}
					} else {
						%>
						<h1 style="text-align: center; color: red">No Student to Show.</h1>
						<%
					}
				}
			%>
		</table>
	</div>
</body>
</html>