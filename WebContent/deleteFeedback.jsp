<%@page import="com.nidhi.feedback.FeedbackDao"%>
<%
	String id = request.getParameter("fid");
	if (id != null) {
		int fid = Integer.parseInt(id);
		new FeedbackDao().deleteFeedback(fid);
		response.sendRedirect("viewFeedback.jsp");
	} else {
		response.sendRedirect("viewFeedback.jsp");
	}
%>