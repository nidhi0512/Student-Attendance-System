<%@page import="com.nidhi.student.StudentDao"%>
<%@page import="com.nidhi.student.StudentDto"%>
<%@page import="com.nidhi.faculty.FacultyDao"%>
<%@page import="com.nidhi.faculty.FacultyDto"%>
<%@page import="java.lang.reflect.Method"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
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

	<%
		if (request.getMethod().equalsIgnoreCase("post")) {
			String uname = request.getParameter("uname");
			String pwd = request.getParameter("pwd");
			String user = request.getParameter("user");
			String course = request.getParameter("course");
			String branch = request.getParameter("branch");
			String year = request.getParameter("year");
			String sec = request.getParameter("sec");
			String student = course + "_" + year + "_" + branch + "_" + sec;

			if (user != null && "admin".equalsIgnoreCase(user)) {
				if (uname.equals("admin") && pwd.equals("admin")) {
					String s = "admin";
					session.setAttribute("admin", s);
					response.sendRedirect("admin.jsp");
				} else {
					out.print("<script type='text/javascript'>alert('Please Enter valid login details');</script>");
				}
			} else if (user != null && "faculty".equalsIgnoreCase(user)) {
				int eid = 0;
				try {
					eid = Integer.parseInt(uname);
				} catch (Exception e) {
					out.print("<script type='text/javascript'>alert('Please Enter valid login details');</script>");
				}
				FacultyDto dto = new FacultyDao().facultyLogin(eid, pwd);
				if (dto != null) {
					session.setAttribute("id", dto.getEid());
					session.setAttribute("usr", user);
					session.setAttribute("pwd", dto.getPwd());
					session.setAttribute("mail", dto.getEmail());
					response.sendRedirect("facultyPassCheck.jsp");
				} else {
					out.print("<script type='text/javascript'>alert('Please Enter valid login details');</script>");
				}
			} else if (user != null && "student".equalsIgnoreCase(user)) {
				int sic = 0;
				try {
					sic = Integer.parseInt(uname);
				} catch (Exception e) {
					out.print("<script type='text/javascript'>alert('Please Enter valid login details');</script>");
				}
				StudentDto dto = new StudentDao().studentLogin(sic, pwd, student);
				if (dto != null) {
					session.setAttribute("id", dto.getSid());
					session.setAttribute("usr", user);
					session.setAttribute("student", student);
					session.setAttribute("pwd", dto.getPwd());
					session.setAttribute("mail", dto.getEmail());
					response.sendRedirect("studentPassCheck.jsp");
				} else {
					out.print("<script type='text/javascript'>alert('Please Enter valid login details');</script>");
				}
			}
		}
	%>

	<%@ include file="main_header.jsp"%>
	<%@ include file="main_menu.jsp"%>
	<div style="width: 32%; margin-left: 29%; margin-top: 2%">
		<form action="login.jsp" method="post">
			<h2 style="font-size: 20px; color: red" align="center">Login</h2>
			<div>
				<input style="margin-left: 22%;" type="radio" id="admin" name="user"
					value="admin" checked="checked" onchange="showField()">Admin
				<input type="radio" id="faculty" name="user" value="faculty"
					onchange="showField()">Faculty <input type="radio"
					id="student" name="user" value="student" onchange="showField()">Student
			</div>



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



			<input class="field" type="text" name="uname"
				placeholder="Enter user name" autofocus="autofocus"
				required="required"> <input class="field" type="password"
				name="pwd" placeholder="Enter password" required="required">
			<input type="submit" value="Login">


		</form>
		<a href="forgetPassword.jsp"> Forget Password </a>
	</div>

</body>
</html>