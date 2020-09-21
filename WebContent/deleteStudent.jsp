<%@page import="com.nidhi.student.StudentDao"%>
<%
	String id = request.getParameter("sid");
	String student = request.getParameter("student");
	if (id != null) {
		int sid = Integer.parseInt(id);
		new StudentDao().deleteStudent(sid, student);
		session.setAttribute("student", student);
		response.sendRedirect("manageStudent.jsp");
	} else {
		System.out.print("Failed");
		response.sendRedirect("manageStudent.jsp");
	}
%>