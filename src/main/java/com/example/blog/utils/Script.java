package com.example.blog.utils;

public class Script {

	public static String back(String msg) {
		StringBuffer sb = new StringBuffer();
		sb.append("<script>");
		sb.append("alert('" + msg + "');");
		sb.append("history.back();");
		sb.append("</script>");

		return sb.toString();
	}
	
	public static String location(String location) {
		StringBuffer sb = new StringBuffer();
		sb.append("<script>");
		sb.append("location.href = '" + location + "'");
		sb.append("</script>");

		return sb.toString();
	}
	
	public static String locationWithMsg(String msg, String location) {
		StringBuffer sb = new StringBuffer();
		sb.append("<script>");
		sb.append("alert('" + msg + "');");
		sb.append("location.href = '" + location + "'");
		sb.append("</script>");

		return sb.toString();
	}
	
}
