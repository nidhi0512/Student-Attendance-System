<%@page import="com.nidhi.student.StudentDto"%>
<%@page import="com.nidhi.student.StudentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Student</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%@ include file="main_header.jsp"%>
	<%@ include file="faculty_menu.jsp"%>

	<%
		if (request.getMethod().equalsIgnoreCase("post")) {
			String id1 = request.getParameter("sid");
			String student = request.getParameter("student");
			if (id1 != null) {
				int sid = Integer.parseInt(id1);
				StudentDto dto = new StudentDao().getStudent(sid, student);
				if (dto != null) {
	%>
	<div style="width: 40%; margin-left: 30%; margin-top: 5%">
		<form action="UpdateStudent" method="post">
			<input type="hidden" name="student" value="<%=student%>"> <input
				type="hidden" name="sid" value="<%=sid%>"><input type="text"
				name="sname" placeholder="Enter student name"
				value="<%=dto.getSname()%>" autofocus="" class="field" required
				required pattern="[A-z|\s]*"
				onchange="this.setCustomValidity(validity.patternMismatch ? 'Please Enter Only Alphabets for Student Name' : '');" />
			<input type="number" name="sic" placeholder="Enter sic" class="field"
				value="<%=dto.getSic()%>" required /> <input type="email"
				name="email" value="<%=dto.getEmail()%>" placeholder="Enter Email"
				class="field" required /> <input type="submit" id="SubmitButton"
				onclick="DoOnSubmit()" value="Update" />
		</form>
	</div>
	<%
		}
			}
		}
	%>
</body>
</html>