package com.nidhi.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class ManagementDb implements DbData {
	private static Connection conn = null;
	private ManagementDb() {}
		public static Connection getManagementDb() {
			return conn;
		}
	
	static {
		try {
			Class.forName(DRIVER);
			conn = DriverManager.getConnection(URL, USER, PWD);
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	public static void main(String[] args) {
		System.out.println(getManagementDb());
	}
}
