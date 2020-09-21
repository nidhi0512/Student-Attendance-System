<%
Integer id=(Integer)session.getAttribute("id");
if(id==null){
	response.sendRedirect("login.jsp");
}
%>


<ul>
<li><a href = "student.jsp">Home</a></li>
<li><a href = "studentViewAttendance.jsp">View Attendance</a></li>
<li><a href = "studentSubAttendance.jsp">View Subject Attendance</a></li>
<li><a href="studentFeedback.jsp">Feedback</a></li>
<li  style="float: right"><a href = "signOut.jsp">Logout</a></li>
</ul>