package com.nidhi.attendance;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nidhi.student.StudentDao;
import com.nidhi.student.StudentDto;

@WebServlet("/MarkAttendance")
public class MarkAttendance extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getMethod().equalsIgnoreCase("post")) {
			String details = req.getParameter("details");
			String doa = req.getParameter("doa");
			String sub = req.getParameter("sub");
			String status[] = req.getParameterValues("status");
			AttendanceDto dto = new AttendanceDto();
			dto.setDetails(details);
			dto.setDoa(doa);
			dto.setSub(sub);
			ArrayList<AttendanceDto> al1 = new AttendanceDao().getAllAttendance(dto);
			if (al1.size() > 0) {
				resp.sendRedirect("duplicateAttendance.jsp");
			} else {
				ArrayList<StudentDto> al = new StudentDao().getAllStudent(details);
				int i = 0;
				if (al.size() > 0) {
					for (StudentDto dto1 : al) {
						new AttendanceDao().addAttendance(dto, dto1.getSic(), status[i]);
						++i;
					}
					resp.sendRedirect("faculty.jsp");
				}
			}
		}
	}
}
