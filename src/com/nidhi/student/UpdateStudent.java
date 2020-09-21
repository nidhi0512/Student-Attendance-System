package com.nidhi.student;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.Session;

@WebServlet("/UpdateStudent")
public class UpdateStudent extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String student = req.getParameter("student");
		String arr[] = student.split("_");
		String course = arr[0];
		String year = arr[1];
		String branch = arr[2];
		String sec = arr[3];

		String sid = req.getParameter("sid");
		String sic = req.getParameter("sic");
		String sname = req.getParameter("sname");
		String email = req.getParameter("email");

		StudentDto dto = new StudentDto();
		dto.setSid(Integer.parseInt(sid));
		dto.setSic(Integer.parseInt(sic));
		dto.setSname(sname);
		dto.setEmail(email);

		if (new StudentDao().updateStudent(student, dto)) {
			try {
				resp.setContentType("text/html");
				HttpSession session = req.getSession();
				session.setAttribute("student", student);
				resp.sendRedirect("manageStudent.jsp");
			} catch (Exception e) {
				System.out.println(e);
			}
		} else {
			System.out.print("failed");
			resp.sendRedirect("manageStudent.jsp");
		}
	}
}
