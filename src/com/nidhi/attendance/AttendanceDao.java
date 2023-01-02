package com.nidhi.attendance;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.nidhi.db.ManagementDb;

public class AttendanceDao {
	private Connection conn = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;

	public boolean addAttendance(AttendanceDto dto, int sic, String status) {
		boolean flag = false;
		try {
			if (conn == null) {
				conn = ManagementDb.getManagementDb();
			}
			String sql = "insert into attendance (sic, details, doa, sub, status) values (?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, sic);
			ps.setString(2, dto.getDetails());
			ps.setString(3, dto.getDoa());
			ps.setString(4, dto.getSub());
			ps.setString(5, status);
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("Exception at addAttendance : " + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}

	public AttendanceDto getAttendance(AttendanceDto dto1) {
		AttendanceDto dto = null;
		if (conn == null) {
			conn = ManagementDb.getManagementDb();
		}
		try {
			String sql = "select * from attendance where sic=? and details=? and doa=? and sub=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, dto1.getSic());
			ps.setString(2, dto1.getDetails());
			ps.setString(3, dto1.getDoa());
			ps.setString(4, dto1.getSub());
			rs = ps.executeQuery();
			if (rs.next()) {
				dto = new AttendanceDto();
				dto.setSic(rs.getInt("sic"));
				dto.setDetails(rs.getString("details"));
				dto.setDoa(rs.getString("doa"));
				dto.setSub(rs.getString("sub"));
				dto.setStatus(rs.getString("status"));
			}
		} catch (Exception e) {
			System.out.println("Exception at getAttendance :" + e);
		} finally {
			rs = null;
			ps = null;
			conn = null;
			return dto;
		}
	}

	public ArrayList<AttendanceDto> getDetailsAttendance(String details) {
		ArrayList<AttendanceDto> al = new ArrayList<>();
		AttendanceDto dto = null;
		if (conn == null) {
			conn = ManagementDb.getManagementDb();
		}
		try {
			String sql = "select * from attendance where details=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, details);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new AttendanceDto();
				dto.setSic(rs.getInt("sic"));
				dto.setDetails(rs.getString("details"));
				dto.setDoa(rs.getString("doa"));
				dto.setSub(rs.getString("sub"));
				dto.setStatus(rs.getString("status"));
				al.add(dto);
			}
		} catch (Exception e) {
			System.out.println("Exception at getDetailsAttendance :" + e);
		} finally {
			rs = null;
			ps = null;
			conn = null;
			return al;
		}
	}

	public ArrayList<AttendanceDto> getDetailsSubAttendance(String details, String sub) {
		ArrayList<AttendanceDto> al = new ArrayList<>();
		AttendanceDto dto = null;
		if (conn == null) {
			conn = ManagementDb.getManagementDb();
		}
		try {
			String sql = "select * from attendance where details=? and sub=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, details);
			ps.setString(2, sub);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new AttendanceDto();
				dto.setSic(rs.getInt("sic"));
				dto.setDetails(rs.getString("details"));
				dto.setDoa(rs.getString("doa"));
				dto.setSub(rs.getString("sub"));
				dto.setStatus(rs.getString("status"));
				al.add(dto);
			}
		} catch (Exception e) {
			System.out.println("Exception at getDetailsSubAttendance :" + e);
		} finally {
			rs = null;
			ps = null;
			conn = null;
			
			return al;
		}
	}

	public ArrayList<AttendanceDto> getAllAttendance(AttendanceDto dto1) {
		ArrayList<AttendanceDto> al = new ArrayList<>();
		AttendanceDto dto = null;
		if (conn == null) {
			conn = ManagementDb.getManagementDb();
		}
		try {
			String sql = "select * from attendance where details=? and doa=? and sub=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto1.getDetails());
			ps.setString(2, dto1.getDoa());
			ps.setString(3, dto1.getSub());
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new AttendanceDto();
				dto.setSic(rs.getInt("sic"));
				dto.setDetails(rs.getString("details"));
				dto.setDoa(rs.getString("doa"));
				dto.setSub(rs.getString("sub"));
				dto.setStatus(rs.getString("status"));
				al.add(dto);
			}
		} catch (Exception e) {
			System.out.println("Exception at getAttendance :" + e);
		} finally {
			rs = null;
			ps = null;
			conn = null;
			return al;
		}
	}

	public boolean updateStudentAttendance(AttendanceDto dto) {
		boolean flag = false;
		try {
			if (conn == null) {
				conn = ManagementDb.getManagementDb();
			}
			String sql = "update attendance set status=? where sic=? and details=? and doa=? and sub=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getStatus());
			ps.setInt(2, dto.getSic());
			ps.setString(3, dto.getDetails());
			ps.setString(4, dto.getDoa());
			ps.setString(5, dto.getSub());
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("Exception at updateStudentAttendance :" + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}

	public boolean updateDateAttendance(AttendanceDto dto, String date) {
		boolean flag = false;
		try {
			if (conn == null) {
				conn = ManagementDb.getManagementDb();
			}
			String sql = "update attendance set doa=? where details=? and sub=? and doa=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, date);
			ps.setString(2, dto.getDetails());
			ps.setString(3, dto.getSub());
			ps.setString(4, dto.getDoa());
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("Exception at updateDateAttendance :" + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}

	public boolean updateSubjectAttendance(AttendanceDto dto, String subject) {
		boolean flag = false;
		try {
			if (conn == null) {
				conn = ManagementDb.getManagementDb();
			}
			String sql = "update attendance set sub=? where details=? and doa=? and sub=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, subject);
			ps.setString(2, dto.getDetails());
			ps.setString(3, dto.getDoa());
			ps.setString(4, dto.getSub());
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("Exception at updateSubjectAttendance :" + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}

	public boolean deleteAttendance(AttendanceDto dto) {
		boolean flag = false;
		if (conn == null) {
			conn = ManagementDb.getManagementDb();
		}
		try {
			String sql = "delete from attendance where doa=? and details=? and sub=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getDoa());
			ps.setString(2, dto.getDetails());
			ps.setString(3, dto.getSub());
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("Exception at deleteAttendance :" + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}

	public boolean deleteAllAttendance() {
		boolean flag = false;
		if (conn == null) {
			conn = ManagementDb.getManagementDb();
		}
		try {
			String sql = "delete from attendance";
			ps = conn.prepareStatement(sql);
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("Exception at deleteAllAttendance :" + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}

	public double[] totalAttendance(AttendanceDto dto1) {
		ArrayList<AttendanceDto> al = new ArrayList<>();
		AttendanceDto dto = null;
		double[] arr = new double[3];
		double present = -1, absent = -1, count = 0;
		double percent = -1;
		if (conn == null) {
			conn = ManagementDb.getManagementDb();
		}
		try {
			String sql = "select * from attendance where details=? and sic=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto1.getDetails());
			ps.setInt(2, dto1.getSic());
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new AttendanceDto();
				dto.setSic(rs.getInt("sic"));
				dto.setDetails(rs.getString("details"));
				dto.setDoa(rs.getString("doa"));
				dto.setSub(rs.getString("sub"));
				dto.setStatus(rs.getString("status"));
				al.add(dto);
				if ((rs.getString("status")).equalsIgnoreCase("p"))
					count++;
			}
			if (al.size() > 0) {
				present = count;
				absent = al.size() - present;
				percent = (present * 100) / ((double) al.size());
			}
			arr[0] = present;
			arr[1] = absent;
			arr[2] = percent;
		} catch (Exception e) {
			System.out.println("Exception at totalAttendance :" + e);
		} finally {
			rs = null;
			ps = null;
			conn = null;
			return arr;
		}
	}

	public double[] subjectAttendance(AttendanceDto dto1) {
		ArrayList<AttendanceDto> al = new ArrayList<>();
		AttendanceDto dto = null;
		double[] arr = new double[3];
		int present = -1, absent = -1, count = 0;
		double percent = -1;
		if (conn == null) {
			conn = ManagementDb.getManagementDb();
		}
		try {
			String sql = "select * from attendance where details=? and sic=? and sub=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto1.getDetails());
			ps.setInt(2, dto1.getSic());
			ps.setString(3, dto1.getSub());
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new AttendanceDto();
				dto.setSic(rs.getInt("sic"));
				dto.setDetails(rs.getString("details"));
				dto.setDoa(rs.getString("doa"));
				dto.setSub(rs.getString("sub"));
				dto.setStatus(rs.getString("status"));
				al.add(dto);
				if ((rs.getString("status")).equalsIgnoreCase("p"))
					count++;
			}
			if (al.size() > 0) {
				present = count;
				absent = al.size() - present;
				percent = (present * 100) / (al.size());
			}
			arr[0] = present;
			arr[1] = absent;
			arr[2] = percent;
		} catch (Exception e) {
			System.out.println("Exception at subjectAttendance :" + e);
		} finally {
			rs = null;
			ps = null;
			conn = null;
			return arr;
		}
	}

}
