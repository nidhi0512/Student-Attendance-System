package com.nidhi.feedback;

import java.io.Serializable;

public class FeedbackDto implements Serializable {
	private int fid;
	private String feed;

	public FeedbackDto() {
	}

	public int getFid() {
		return fid;
	}

	public void setFid(int fid) {
		this.fid = fid;
	}

	public String getFeed() {
		return feed;
	}

	public void setFeed(String feed) {
		this.feed = feed;
	}

}
