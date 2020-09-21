<%@page import="com.nidhi.attendance.AttendanceDao"%>
<%@page import="com.nidhi.attendance.AttendanceDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Date</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function DoOnSubmit() {
		if ((document.getElementById("course").value == "null")
				|| (document.getElementById("year").value == "null")
				|| (document.getElementById("branch").value == "null")
				|| (document.getElementById("sec").value == "null")
				|| (document.getElementById("sub").value == "null")) {
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
	<div style="width: 40%; margin-left: 30%; margin-top: 5%">
		<h1 style="text-align: center;">Enter Details to Update Date</h1>
		<form action="updateDate.jsp" method="post">
			<table style="margin-left: 17%">
				<tr>

					<td><input type="date" class="field" name="doa"
						required="required"></td>
					<td><select id="sub" name="sub" class="field"
						onchange="DoOnResubmit()">
							<option value="null">Subject</option>
							<option value="dsa">DSA</option>
							<option value="automata">Automata</option>
							<option value="os">OS</option>
								<option value="dbms">DBMS</option>
					</select></td>
				</tr>
			</table>
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
			<input type="submit" id="SubmitButton" onclick="DoOnSubmit()"
				value="Submit" />
		</form>
		<%
			if (request.getMethod().equalsIgnoreCase("post")) {
				String course = request.getParameter("course");
				String branch = request.getParameter("branch");
				String year = request.getParameter("year");
				String sec = request.getParameter("sec");
				String details = course + "_" + year + "_" + branch + "_" + sec;
				String doa = request.getParameter("doa");
				String sub = request.getParameter("sub");
				if (details != null) {
					AttendanceDto dto = new AttendanceDto();
					dto.setDetails(details);
					dto.setDoa(doa);
					dto.setSub(sub);
					ArrayList<AttendanceDto> al = new AttendanceDao().getAllAttendance(dto);
					if (al.size() > 0) {
		%>

		<h2 style="text-align: center;">Enter updated Date</h2>
		<form action="dateRedirect.jsp" method="post">
			<div style="width: 50%; margin-left: 20%">
				<input type="date" class="field" name="doa1" required="required">
			</div>
			<input type="hidden" name="details" value="<%=details%>"> <input
				type="hidden" name="doa" value="<%=doa%>"> <input
				type="hidden" name="sub" value="<%=sub%>"> <input
				type="submit" value="Update Date">
		</form>

		<%
			} else {
		%>
		<h1 style="text-align: center; color: red">No Records Found.</h1>
		<%
			}
				}
			}
		%>
	</div>
</body>
</html>