<%@page import="com.nidhi.student.StudentDao"%>
<%@page import="com.nidhi.faculty.FacultyDao"%>
<%@page import="com.nidhi.faculty.FacultyDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forget Password</title>
<link href="css/style.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
	function showField() {
		if (document.getElementById('student').checked) {
			course.style.display = '';
			branch.style.display = '';
			year.style.display = '';
			sec.style.display = '';
		} else {
			course.style.display = 'none';
			branch.style.display = 'none';
			year.style.display = 'none';
			sec.style.display = 'none';
		}
	}
</script>

</head>
<body>
	<%@ include file="main_header.jsp"%>
	<%@ include file="main_menu.jsp"%>

	<%
		if (request.getMethod().equalsIgnoreCase("post")) {
			String email = request.getParameter("email");
			String course = request.getParameter("course");
			String branch = request.getParameter("branch");
			String year = request.getParameter("year");
			String sec = request.getParameter("sec");
			String user = request.getParameter("user");
			String student = null;
			if (!user.equalsIgnoreCase("faculty"))
				student = course + "_" + year + "_" + branch + "_" + sec;
			if (user != null && "faculty".equalsIgnoreCase(user)) {
				FacultyDao dao = new FacultyDao();
				if (email != null) {
					int otp = dao.sendOtp(email);
					if (otp == 0) {
						out.print("<script> alert('There are some Server problems...')</script>");
					} else if (otp == 1) {
						out.print("<script> alert('Please give a valid email address')</script>");
					} else {
						session.setAttribute("user", user);
						session.setAttribute("otp", otp);
						session.setAttribute("email", email);
						response.sendRedirect("otpMatch.jsp");
					}
				}
			} else if (user != null && "student".equalsIgnoreCase(user)) {
				StudentDao dao = new StudentDao();
				if (email != null) {
					int otp = dao.sendOtp(student, email);
					if (otp == 0) {
						out.print("<script> alert('There are some Server problems...')</script>");
					} else if (otp == 1) {
						out.print("<script> alert('Please give a valid email address')</script>");
					} else {
						session.setAttribute("user", student);
						session.setAttribute("otp", otp);
						session.setAttribute("email", email);
						response.sendRedirect("otpMatch.jsp");
					}
				}
			}
		}
	%>

	<div style="width: 40%; margin-left: 30%; margin-top: 5%;"
		class="container">
		<div style="text-align: center; font-weight: bold; font-size: 20px;">Forgot
			Password</div>
		<form action="forgetPassword.jsp" method="post">
			<div style="width: 50%; margin-left: 30%;">
				<input type="radio" id="faculty" name="user" value="faculty"
					checked="checked" onchange="showField()">Faculty <input
					type="radio" id="student" name="user" value="student"
					onchange="showField()">Student

			</div>
			<div style="margin-left: 10%;">
				<table>
					<tr>
						<td><select id="course" name="course" class="field"
							style='display: none'>
								<option value="null">Course</option>
								<option value="btech">Btech</option>
						</select></td>
						<td><select id="year" name="year" class="field"
							style='display: none'>
								<option value="null">Year</option>
								<option value="1">1st</option>
						</select></td>
						<td><select id="branch" name="branch" class="field"
							style='display: none'>
								<option value="null">Branch</option>
								<option value="cse">CSE</option>
						</select></td>
						<td><select id="sec" name="sec" class="field"
							style='display: none'>
								<option value="null">Section</option>
								<option value="a">A</option>
								<option value="b">B</option>
						</select></td>
					</tr>
				</table>
			</div>
			<input type="email" name="email" class="field"
				placeholder="Enter email id" autofocus required="required">

			<center>
				<input type="submit" class="field" value="Submit">
			</center>

		</form>
	</div>


</body>
</html>