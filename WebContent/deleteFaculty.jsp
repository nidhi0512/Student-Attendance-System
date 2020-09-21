<%@page import="com.nidhi.faculty.FacultyDao"%>
<%
	String id = request.getParameter("fid");
	if (id != null) {
		int fid = Integer.parseInt(id);
		new FacultyDao().deleteFaculty(fid);
		response.sendRedirect("manageFaculty.jsp");
	} else {
		System.out.print("Failed");
		response.sendRedirect("manageFaculty.jsp");
	}
%>