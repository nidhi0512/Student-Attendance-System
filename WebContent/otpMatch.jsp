
<%
	Integer otpx = (Integer) session.getAttribute("otp");
	String email = (String) session.getAttribute("email");
	String user = (String) session.getAttribute("user");
	if (otpx == null || email == null || user == null) {
		response.sendRedirect("forgetPassword.jsp");
	}
%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Matching OTP</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%@include file="main_header.jsp"%>
	<%@include file="main_menu.jsp"%>
	<%
		if (request.getMethod().equalsIgnoreCase("post")) {
			int otp = Integer.parseInt(request.getParameter("otp"));
			int oldotp = (int) session.getAttribute("otp");
			if (otp == oldotp) {
				session.removeAttribute("otp");
				response.sendRedirect("resetPassword.jsp");
			} else {
	%>
	<h1>Please enter valid OTP</h1>
	<%
		}
		}
	%>
	<div style="width: 50%; margin-left: 25%; margin-top: 5%;"
		class="container">
		<div style="text-align: center; font-weight: bold; font-size: 20px;">Enter
			OTP</div>
		<form action="otpMatch.jsp" method="post">

			<label for="fname">Enter OTP</label> <input type="text" class="field"
				id="otp" name="otp" placeholder="Enter your OTP" autofocus
				required="required">

			<center>
				<input type="submit" class="field" value="Submit">
			</center>
			<br />

		</form>
	</div>

</body>
</html>