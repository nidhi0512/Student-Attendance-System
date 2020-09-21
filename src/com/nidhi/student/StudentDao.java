package com.nidhi.student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.nidhi.db.ManagementDb;
import com.nidhi.utility.ManagementUtility;

public class StudentDao {
	private Connection conn = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;

	public boolean addStudent(String student, StudentDto dto) {
		boolean flag = false;
		try {
			if (conn == null) {
				conn = ManagementDb.getManagementDb();
			}
			String sql = "insert into " + student + " (sic, sname, email, pwd) values(?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, dto.getSic());
			ps.setString(2, dto.getSname());
			ps.setString(3, dto.getEmail());
			ps.setString(4, String.valueOf(dto.getSic()));
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("Exception at addStudent: " + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}

	}

	public boolean deleteAllStudent(String student) {
		boolean flag = false;
		if (conn == null) {
			conn = ManagementDb.getManagementDb();
		}
		try {
			String sql = "delete from " + student;
			ps = conn.prepareStatement(sql);
			if (ps.executeUpdate() > 0) {
				flag = false;
			}

		} catch (Exception e) {
			System.out.println("Exception at deleteAllStudent(): " + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}

	}

	public boolean updateStudent(String student, StudentDto dto) {

		boolean flag = false;
		try {
			if (conn == null) {
				conn = ManagementDb.getManagementDb();
			}
			String sql = "update " + student + " set sic=?,sname=?,email=? where sid=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, dto.getSic());
			ps.setString(2, dto.getSname());
			ps.setString(3, dto.getEmail());
			ps.setInt(4, dto.getSid());
			if (ps.executeUpdate() > 0) {
				flag = true;
			}

		} catch (Exception e) {
			System.out.println("Exception found at updateStudent(): " + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}

	public boolean deleteStudent(int sid, String student) {
		boolean flag = false;
		if (conn == null) {
			conn = ManagementDb.getManagementDb();
		}
		try {
			String sql = "delete from " + student + " where sid = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, sid);
			if (ps.executeUpdate() > 0) {
				flag = false;
			}

		} catch (Exception e) {
			System.out.println("Exception at deleteStudent(): " + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}

	}

	public ArrayList<StudentDto> getAllStudent(String student) {
		ArrayList<StudentDto> al = new ArrayList<>();
		if (conn == null) {
			conn = ManagementDb.getManagementDb();
		}
		try {
			String sql = "select * from " + student;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				StudentDto dto = new StudentDto();
				dto.setSid(rs.getInt("sid"));
				dto.setSic(rs.getInt("sic"));
				dto.setSname(rs.getString("sname"));
				dto.setEmail(rs.getString("email"));
				dto.setPwd(rs.getString("pwd"));
				al.add(dto);
			}
		} catch (Exception e) {
			System.out.println("Exception at getAllStudent :" + e);
		} finally {
			rs = null;
			ps = null;
			conn = null;
			return al;
		}
	}

	public StudentDto getStudent(int sid, String student) {
		StudentDto dto = null;
		if (conn == null) {
			conn = ManagementDb.getManagementDb();
		}
		try {
			String sql = "select * from " + student + " where sid =?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, sid);
			rs = ps.executeQuery();
			if (rs.next()) {
				dto = new StudentDto();
				dto.setSid(rs.getInt("sid"));
				dto.setSic(rs.getInt("sic"));
				dto.setSname(rs.getString("sname"));
				dto.setEmail(rs.getString("email"));
				dto.setPwd(rs.getString("pwd"));

			}
		} catch (Exception e) {
			System.out.println("Exception at getStudent :" + e);
		} finally {
			rs = null;
			ps = null;
			conn = null;
			return dto;
		}
	}

	public StudentDto studentLogin(int sic, String pwd, String student) {
		StudentDto dto = null;
		if (conn == null) {
			conn = ManagementDb.getManagementDb();
		}
		try {
			String sql = "select * from " + student + " where sic=? and pwd=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, sic);
			ps.setString(2, pwd);
			rs = ps.executeQuery();
			if (rs.next()) {
				dto = new StudentDto();
				dto.setSid(rs.getInt("sic"));
				dto.setSname(rs.getString("sname"));
				dto.setPwd(rs.getString("pwd"));
				dto.setEmail(rs.getString("email"));
			}
		} catch (Exception e) {
			System.out.println("Exception at studentLogin :" + e);
		} finally {
			rs = null;
			ps = null;
			conn = null;
			return dto;
		}
	}

	public int sendOtp(String student, String email) {
		int otp = 0;
		try {
			if (conn == null) {
				conn = ManagementDb.getManagementDb();
			}
			ps = conn.prepareStatement("Select * from " + student + " where email=?");
			ps.setString(1, email);
			rs = ps.executeQuery();
			if (rs.next()) {
				otp = ManagementUtility.getRandom();
				if (!new ManagementUtility().sendMail("" + otp, email)) {
					otp = 0;
				}
			} else {
				otp = 1;
			}
		} catch (Exception e) {
			System.out.println("Exception at sendOtp : " + e);
		} finally {
			rs = null;
			ps = null;
			conn = null;
			return otp;
		}
	}

	public boolean changePassword(String student, String email, String password) {
		boolean flag = true;
		try {
			if (conn == null) {
				conn = ManagementDb.getManagementDb();
			}
			String query = "update " + student + " set pwd=? where email=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, password);
			ps.setString(2, email);
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("Exception in changePassword : " + e.getMessage());
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}

}
