
<%
	String str = (String) session.getAttribute("admin");
	if (str == null) {
		response.sendRedirect("login.jsp");
	}
%>

<ul>
	<li><a href="admin.jsp">Home</a></li>
	<li><a href="addFaculty.jsp">Add Faculty</a></li>
	<li><a href="manageFaculty.jsp">Manage Faculty</a></li>
	<li><a href="deleteAllAttendance.jsp">Delete All Attendance</a></li>
	<li><a href="viewFeedback.jsp">View Feedback</a></li>
	<li style="float: right"><a href="signOut.jsp">Logout</a></li>
</ul>