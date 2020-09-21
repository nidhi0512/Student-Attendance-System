<%@page import="com.nidhi.feedback.FeedbackDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Feedback</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<jsp:useBean id="dto" class="com.nidhi.feedback.FeedbackDto"></jsp:useBean>
<jsp:setProperty property="*" name="dto" />
</head>
<body>
	<%@ include file="main_header.jsp"%>
	<%@ include file="faculty_menu.jsp"%>
	<%
		if (request.getMethod().equalsIgnoreCase("post")) {
			if (new FeedbackDao().addFeedback(dto)) {
				response.sendRedirect("faculty.jsp");
			} else {
				out.print("Failed");
			}
		}
	%>
	<div style="width: 50%; margin-left: 25%; margin-top: 5%">
		<h1 align="center">Give Feedback</h1>
		<form action="facultyFeedback.jsp" method="post">
			<input type="text" name="feed" autofocus="autofocus"
				required="required" class="field" placeholder="Enter Feedback">
			<input type="submit" value="Register Feedback">
		</form>
	</div>
</body>
</html>