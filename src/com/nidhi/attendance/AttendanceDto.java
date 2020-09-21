package com.nidhi.attendance;

import java.io.Serializable;

public class AttendanceDto implements Serializable {
	private int sic;
	private String details, doa, sub, status;

	public String getSub() {
		return sub;
	}

	public void setSub(String sub) {
		this.sub = sub;
	}

	public AttendanceDto() {
	}

	public int getSic() {
		return sic;
	}

	public void setSic(int sic) {
		this.sic = sic;
	}

	public String getDetails() {
		return details;
	}

	public void setDetails(String details) {
		this.details = details;
	}

	public String getDoa() {
		return doa;
	}

	public void setDoa(String doa) {
		this.doa = doa;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
