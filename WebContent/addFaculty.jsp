<%@page import="com.nidhi.faculty.FacultyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Faculty</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function DoOnSubmit() {
		if ((document.getElementById("dept").value == "null")) {
			document.getElementById("SubmitButton").disabled = true;
			alert("Please select a department...");
		} else {
			document.getElementById("SubmitButton").disabled = false;
		}

	}

	function DoOnResubmit() {
		document.getElementById("SubmitButton").disabled = false;
	}
</script>
<jsp:useBean id="dto" class="com.nidhi.faculty.FacultyDto"></jsp:useBean>
<jsp:setProperty property="*" name="dto" />

</head>
<body>
	<%
		if (request.getMethod().equalsIgnoreCase("post")) {
			if (new FacultyDao().addFaculty(dto)) {
				response.sendRedirect("manageFaculty.jsp");
			} else {
				out.print("Failed");
			}
		}
	%>
	<%@include file="main_header.jsp"%>
	<%@include file="admin_menu.jsp"%>
	<div style="width: 40%; margin-left: 30%; margin-top: 5%">
	<h1 style="text-align: center;">Add Faculty</h1>
		<form action="addFaculty.jsp" method="post">
			<input type="fname" name="fname" placeholder="Enter Faculty name"
				autofocus="" class="field" required required pattern="[A-z|\s]*"
				onchange="this.setCustomValidity(validity.patternMismatch ? 'Please Enter Only Alphabets for Student Name' : '');" />
			<input type="number" name="eid" placeholder="Enter Employee Id"
				class="field" required /> <input type="email" name="email"
				placeholder="Enter Email" class="field" required /> <select
				id="dept" name="dept" class="field" onchange="DoOnResubmit()">
				<option value="null">-- Select Department --</option>
				<option value="cse">CSE</option>

			</select> <input type="submit" id="SubmitButton" onclick="DoOnSubmit()"
				value="Register" />
		</form>
	</div>
</body>
</html>