package com.zaeps.www.util;

public class AuthInfo {
	private int zooNo;
	private String id;
	private String name;
	private int grade;
	
	public AuthInfo(int zooNo, String id, String name, int grade) {
		this.zooNo = zooNo;
		this.id = id;
		this.name = name;
		this.grade = grade;
	}
	
	public int getZooNo() {
		return zooNo;
	}
	public void setZooNo(int zooNo) {
		this.zooNo = zooNo;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	@Override
	public String toString() {
		return "AuthInfo [zooNo=" + zooNo + ", id=" + id + ", name=" + name + ", grade=" + grade + "]";
	}
}
