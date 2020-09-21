package com.nidhi.faculty;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.nidhi.db.ManagementDb;
import com.nidhi.utility.ManagementUtility;

public class FacultyDao {
	private Connection conn = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;

	public boolean addFaculty(FacultyDto dto) {
		boolean flag = false;
		try {
			if (conn == null) {
				conn = ManagementDb.getManagementDb();
			}
			String sql = "insert into faculty (eid, fname, email, pwd, dept) values (?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, dto.getEid());
			ps.setString(2, dto.getFname());
			ps.setString(3, dto.getEmail());
			ps.setString(4, String.valueOf(dto.getEid()));
			ps.setString(5, dto.getDept());
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("Exception at addFaculty : " + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}

	public boolean updateFaculty(FacultyDto dto) {
		boolean flag = false;
		try {
			if (conn == null) {
				conn = ManagementDb.getManagementDb();
			}
			String sql = "update faculty set eid=?,fname=?,email=?,dept=? where fid=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, dto.getEid());
			ps.setString(2, dto.getFname());
			ps.setString(3, dto.getEmail());
			ps.setString(4, dto.getDept());
			ps.setInt(5, dto.getFid());
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("Exception at updateFaculty :" + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}

	public boolean deleteFaculty(int fid) {
		boolean flag = false;
		if (conn == null) {
			conn = ManagementDb.getManagementDb();
		}
		try {
			String sql = "delete from faculty where fid=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, fid);
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("Exception at deleteFaculty :" + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}

	public ArrayList<FacultyDto> getAllFaculty() {
		ArrayList<FacultyDto> al = new ArrayList<>();
		if (conn == null) {
			conn = ManagementDb.getManagementDb();
		}
		try {
			String sql = "select * from faculty";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				FacultyDto dto = new FacultyDto();
				dto.setFid(rs.getInt("fid"));
				dto.setEid(rs.getInt("eid"));
				dto.setFname(rs.getString("fname"));
				dto.setEmail(rs.getString("email"));
				dto.setPwd(rs.getString("pwd"));
				dto.setDept(rs.getString("dept"));
				al.add(dto);
			}
		} catch (Exception e) {
			System.out.println("Exception at getAllFaculty :" + e);
		} finally {
			rs = null;
			ps = null;
			conn = null;
			return al;
		}
	}

	public FacultyDto getFaculty(int fid) {
		FacultyDto dto = null;
		if (conn == null) {
			conn = ManagementDb.getManagementDb();
		}
		try {
			String sql = "select * from faculty where fid =?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, fid);
			rs = ps.executeQuery();
			if (rs.next()) {
				dto = new FacultyDto();
				dto.setFid(rs.getInt("fid"));
				dto.setEid(rs.getInt("eid"));
				dto.setFname(rs.getString("fname"));
				dto.setEmail(rs.getString("email"));
				dto.setPwd(rs.getString("pwd"));
				dto.setDept(rs.getString("dept"));
			}
		} catch (Exception e) {
			System.out.println("Exception at getFaculty :" + e);
		} finally {
			rs = null;
			ps = null;
			conn = null;
			return dto;
		}
	}

	public FacultyDto facultyLogin(int eid, String pwd) {
		FacultyDto dto = null;
		if (conn == null) {
			conn = ManagementDb.getManagementDb();
		}
		try {
			String sql = "select * from faculty where eid=? and pwd=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, eid);
			ps.setString(2, pwd);
			rs = ps.executeQuery();
			if (rs.next()) {
				dto = new FacultyDto();
				dto.setEid(rs.getInt("eid"));
				dto.setFname(rs.getString("fname"));
				dto.setPwd(rs.getString("pwd"));
				dto.setEmail(rs.getString("email"));
				dto.setDept(rs.getString("dept"));
			}
		} catch (Exception e) {
			System.out.println("Exception at facultyLogin :" + e);
		} finally {
			rs = null;
			ps = null;
			conn = null;
			return dto;
		}
	}

	public int sendOtp(String email) {
		int otp = 0;
		try {
			if (conn == null) {
				conn = ManagementDb.getManagementDb();
			}
			ps = conn.prepareStatement("Select * from faculty where email=?");
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
	
	public boolean changePassword(String email, String password) {
		boolean flag = true;
		try {
			if (conn == null) {
				conn = ManagementDb.getManagementDb();
			}
			String query = "update faculty set pwd=? where email=?";
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