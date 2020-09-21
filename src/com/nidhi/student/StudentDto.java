package com.nidhi.student;

import java.io.Serializable;

public class StudentDto implements Serializable {
	private int sid, sic;
	private String sname, email, pwd;

	public StudentDto() {
	}

	public int getSid() {
		return sid;
	}

	public void setSid(int sid) {
		this.sid = sid;
	}

	public int getSic() {
		return sic;
	}

	public void setSic(int sic) {
		this.sic = sic;
	}

	public String getSname() {
		return sname;
	}

	public void setSname(String sname) {
		this.sname = sname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

}
