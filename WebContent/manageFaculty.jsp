<%@page import="com.nidhi.faculty.FacultyDao"%>
<%@page import="com.nidhi.faculty.FacultyDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Faculty</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%@ include file="main_header.jsp"%>
	<%@ include file="admin_menu.jsp"%>
	<%
		ArrayList<FacultyDto> al = new FacultyDao().getAllFaculty();
		if (al.size() > 0) {
	%>
	<div id="tables" style="width: 60%; margin-left: 20%; margin-top: 5%">
	<h1 style="text-align: center;">Manage Faculty</h1>
		<table style="width: 100%">
			<tr>
				<th>S.No.</th>
				<th>Name</th>
				<th>EID</th>
				<th>Email</th>
				<th>Department</th>
				<th>Update</th>
				<th>Delete</th>
			</tr>
			<%
				int s = 0;
					for (FacultyDto dto : al) {
			%>
			<tr>
				<td><%=++s%></td>
				<td><%=dto.getFname()%></td>
				<td><%=dto.getEid()%></td>
				<td><%=dto.getEmail()%></td>
				<td><%=dto.getDept()%></td>
				<td>


					<form action="updateFaculty.jsp" method="post">
						<input type="hidden" name="fid" value="<%=dto.getFid()%>">
						<input type="submit" value="Update">
					</form>
				</td>
				<td>
					<form action="deleteFaculty.jsp" method="post">
						<input type="hidden" name="fid" value="<%=dto.getFid()%>">
						<input type="submit" value="Delete">
					</form>
				</td>
			</tr>
			<%
				}
				} else {
			%>
			<h1 style="text-align: center; color: red">No Faculty to Show.</h1>
			<%
				}
			%>
		</table>
	</div>
</body>
</html>