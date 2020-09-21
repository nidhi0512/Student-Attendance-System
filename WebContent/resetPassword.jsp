
<%@page import="com.nidhi.faculty.FacultyDao"%>
<%@page import="com.nidhi.student.StudentDao"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reset Password</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%@include file="main_header.jsp"%>
	<%@include file="main_menu.jsp"%>
	<%
		String mail = (String) session.getAttribute("mail");
		String usr = (String) session.getAttribute("usr");
		String pwd = (String) session.getAttribute("pwd");
		if (request.getMethod().equalsIgnoreCase("post")) {
			if (usr != null) {
				String password = request.getParameter("password");
				if (!usr.equalsIgnoreCase("faculty")) {
					String student = (String) session.getAttribute("student");
					if (new StudentDao().changePassword(student, mail, password)) {
						session.invalidate();
						response.sendRedirect("login.jsp");
					}
				} else {
					if (new FacultyDao().changePassword(mail, password)) {
						session.invalidate();
						response.sendRedirect("login.jsp");
					}
				}
			} else {

				String password = request.getParameter("password");
				String email = (String) session.getAttribute("email");
				String user = (String) session.getAttribute("user");
				if (user != null) {
					if (!user.equalsIgnoreCase("faculty")) {
						if (new StudentDao().changePassword(user, email, password)) {
							session.removeAttribute("email");
							session.removeAttribute("user");
							response.sendRedirect("login.jsp");
						}
					} else {
						if (new FacultyDao().changePassword(email, password)) {
							session.removeAttribute("email");
							session.removeAttribute("user");
							response.sendRedirect("login.jsp");
						}
					}
				} else {
					response.sendRedirect("login.jsp");
				}
			}
		}
	%>
	<div style="width: 50%; margin-left: 25%; margin-top: 5%;"
		class="container">
		<div style="text-align: center; font-weight: bold; font-size: 20px;">Reset
			Password</div>
		<form action="resetPassword.jsp" method="post">

			<label for="fname">Enter new password</label> <input type="password"
				class="field" id="pass" name="password"
				placeholder="Enter new Password" autofocus required="required">

			<center>
				<input type="submit" class="field" value="Submit">
			</center>
			<br />

		</form>
	</div>

</body>
</html>