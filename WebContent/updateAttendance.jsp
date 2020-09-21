<%@page import="com.nidhi.attendance.AttendanceDao"%>
<%@page import="com.nidhi.attendance.AttendanceDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Attendance</title>
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
		<table style="width: 100%;">
			<tr>
				<td>
					<form action="updateDate.jsp">
						<input type="submit" value="Update Date">
					</form>
				</td>
				<td>
					<form action="updateSub.jsp">
						<input type="submit" value="Update Subject">
					</form>
				</td>
		</table>
		<h1 style="text-align: center;">View Student to Update status</h1>
		<form action="updateAttendance.jsp" method="post">
			<table>
				<tr>
					<td><input name="sic" placeholder="Enter sic" type="number"
						class="field" required="required"></td>
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
				value="View Student" />
		</form>
		<%
			if (request.getMethod().equalsIgnoreCase("post")) {
				String details = request.getParameter("details");
				String course = request.getParameter("course");
				String branch = request.getParameter("branch");
				String year = request.getParameter("year");
				String sec = request.getParameter("sec");
				if (details == null)
					details = course + "_" + year + "_" + branch + "_" + sec;
				String doa = request.getParameter("doa");
				String sub = request.getParameter("sub");
				int sic = Integer.parseInt(request.getParameter("sic"));
				if (details != null) {
					AttendanceDto dto = new AttendanceDto();
					dto.setDetails(details);
					dto.setDoa(doa);
					dto.setSic(sic);
					dto.setSub(sub);
					AttendanceDto dto1 = new AttendanceDao().getAttendance(dto);
					if (dto1 != null) {
		%>
		<table style="width: 100%" id="tables">
			<tr>
				<th>SIC</th>
				<th>Date</th>
				<th>Subject</th>
				<th>Status</th>
				<th>Update</th>
			</tr>

			<tr>
				<td><%=dto1.getSic()%></td>
				<td><%=dto1.getDoa()%></td>
				<td><%=dto1.getSub()%></td>
				<td><%=dto1.getStatus()%></td>
				<td>

					<form action="updateRedirect.jsp" method="post">
						<input type="hidden" name="sic" value="<%=dto1.getSic()%>">
						<input type="hidden" name="details" value="<%=dto1.getDetails()%>">
						<input type="hidden" name="doa" value="<%=dto1.getDoa()%>">
						<input type="hidden" name="sub" value="<%=dto1.getSub()%>">
						<input type="hidden" name="status" value="<%=dto1.getStatus()%>">
						<input type="submit" value="Update Status">
					</form>
				</td>

			</tr>
			<%
				} else {
			%>
			<h1 style="text-align: center; color: red">No Students to Show.</h1>
			<%
				}
					}
				}
			%>
		</table>
	</div>
</body>
</html>