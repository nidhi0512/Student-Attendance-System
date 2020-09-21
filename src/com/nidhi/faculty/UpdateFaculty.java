package com.nidhi.faculty;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateFaculty")
public class UpdateFaculty extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String fid = req.getParameter("fid");
		String eid = req.getParameter("eid");
		String fname = req.getParameter("fname");
		String email = req.getParameter("email");
		String dept = req.getParameter("dept");

		FacultyDto dto = new FacultyDto();

		dto.setFid(Integer.parseInt(fid));
		dto.setEid(Integer.parseInt(eid));
		dto.setFname(fname);
		dto.setEmail(email);
		dto.setDept(dept);

		if (new FacultyDao().updateFaculty(dto)) {
			resp.sendRedirect("manageFaculty.jsp");
		} else {
			System.out.println("Failed");
			resp.sendRedirect("manageFaculty.jsp");
		}
	}
}
