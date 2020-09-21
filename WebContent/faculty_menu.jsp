
<%
	Integer id = (Integer) session.getAttribute("id");
	if (id == null) {
		response.sendRedirect("login.jsp");
	}
%>


<ul>
	<li><a href="faculty.jsp">Home</a></li>
	<li><a href="addStudent.jsp">Add Student</a></li>
	<li><a href="manageStudent.jsp">Manage Student</a></li>
	<li><a href="attendance.jsp">Attendance</a></li>
	<li><a href="updateAttendance.jsp">Update Attendance</a></li>
	<li><a href="deleteAttendance.jsp">Delete Attendance</a></li>
	<li><a href="facultyViewAttendance.jsp">View Attendance</a></li>
	<li><a href="facultySubAttendance.jsp">Sub Attendance</a></li>
	<li><a href="facultyFeedback.jsp">Feedback</a></li>
	<li style="float: right"><a href="signOut.jsp">Logout</a></li>
</ul>