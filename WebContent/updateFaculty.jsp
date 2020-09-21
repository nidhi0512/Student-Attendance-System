<%@page import="com.nidhi.faculty.FacultyDao"%>
<%@page import="com.nidhi.faculty.FacultyDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Faculty</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%@include file="main_header.jsp"%>
	<%@include file="admin_menu.jsp"%>
	<%
		if (request.getMethod().equalsIgnoreCase("post")) {
			String id1 = request.getParameter("fid");
			if (id1 != null) {
				int fid = Integer.parseInt(id1);
				FacultyDto dto = new FacultyDao().getFaculty(fid);
				if (dto != null) {
	%>
	<div style="width: 40%; margin-left: 30%; margin-top: 5%">
		<form action="UpdateFaculty" method="post">
			<input type="hidden" name="fid" value="<%=fid%>"> <input
				type="fname" name="fname" value="<%=dto.getFname()%>" autofocus=""
				class="field" required required pattern="[A-z|\s]*"
				onchange="this.setCustomValidity(validity.patternMismatch ? 'Please Enter Only Alphabets for Student Name' : '');" />
			<input type="number" name="eid" value="<%=dto.getEid()%>"
				class="field" required /> <input type="email" name="email"
				value="<%=dto.getEmail()%>" class="field" required /> <select
				id="dept" name="dept" class="field" value="<%=dto.getDept()%>">
				<option value="cse">CSE</option>
				
			</select> <input type="submit" value="Update" />
		</form>
	</div>
	<%
		}
			}
		}
	%>
</body>
</html>