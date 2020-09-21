package com.nidhi.utility;

import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class ManagementUtility {
	private static String host = "localhost";
	private static final String MAIL_SERVER = "smtp.gmail.com";
	private static String uname = "jaiswal.nidhi0512@gmail.com";
	private static String pwd = "nidhi2210";

	public static int getRandom() {
		return new Random().nextInt(99999);
	}

	public static boolean sendMail(String otp, String toEmail) {
		boolean flag = false;
		try {
			Properties properties = System.getProperties();
			properties.put("mail.smtps.host", MAIL_SERVER);
			properties.put("mail.smtps.auth", "true");
			Session session = Session.getInstance(properties);
			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(host));
			// msg.addRecipients(Message.RecipientType.TO, new InternetAddress(toSend));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
			msg.setSubject("your OTP");
			msg.setText(otp);
			Transport tr = session.getTransport("smtps");
			tr.connect(MAIL_SERVER, uname, pwd);
			tr.sendMessage(msg, msg.getAllRecipients());
			tr.close();
			flag = true;
		} catch (Exception e) {
			System.out.println(e);
		}
		return flag;
	}

	public static boolean sendNotification(String toEmail, String sub, String percent) {
		boolean flag = false;
		try {
			
			Properties properties = System.getProperties();
			properties.put("mail.smtps.host", MAIL_SERVER);
			properties.put("mail.smtps.auth", "true");
			Session session = Session.getInstance(properties);
			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(host));
			// msg.addRecipients(Message.RecipientType.TO, new InternetAddress(toSend));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
			msg.setSubject("Attendance");
			if (sub.equalsIgnoreCase("all")) {
				msg.setText("Your overall Attendance is " + percent + "%, Please maintain your attendance above 75%.");
			} else {
				msg.setText("Your Attendance in " + sub + " is " + percent
						+ "%, Please maintain your attendance above 75%.");
			}
			Transport tr = session.getTransport("smtps");
			
			tr.connect(MAIL_SERVER, uname, pwd);
			System.out.println("Hello");
			tr.sendMessage(msg, msg.getAllRecipients());
			tr.close();
			flag = true;
		} catch (Exception e) {
			System.out.println(e);
		}
		return flag;
	}
}
