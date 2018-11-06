package com.zaeps.www.dto;

public class AniLatLong {
	private int aniNo;
	private int zooNo;
	private String aniLat;
	private String aniLong;
	private int aniTypeNo;
	private String regdate;
	private int pointNo;
	private int pointNo2;
	
	public int getPointNo2() {
		return pointNo2;
	}
	public void setPointNo2(int pointNo2) {
		this.pointNo2 = pointNo2;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getAniNo() {
		return aniNo;
	}
	public void setAniNo(int aniNo) {
		this.aniNo = aniNo;
	}
	public int getZooNo() {
		return zooNo;
	}
	public void setZooNo(int zooNo) {
		this.zooNo = zooNo;
	}
	public String getAniLat() {
		return aniLat;
	}
	public void setAniLat(String aniLat) {
		this.aniLat = aniLat;
	}
	public String getAniLong() {
		return aniLong;
	}
	public void setAniLong(String aniLong) {
		this.aniLong = aniLong;
	}
	public int getPointNo() {
		return pointNo;
	}
	public void setPointNo(int pointNo) {
		this.pointNo = pointNo;
	}
	public int getAniType() {
		return aniTypeNo;
	}
	public void setAniType(int aniTypeNo) {
		this.aniTypeNo = aniTypeNo;
	}
	@Override
	public String toString() {
		return "AniLatLong [aniNo=" + aniNo + ", zooNo=" + zooNo + ", aniLat=" + aniLat + ", aniLong=" + aniLong
				+ ", aniType=" + aniTypeNo + ", regdate=" + regdate + ", pointNo=" + pointNo + ", pointNo2=" + pointNo2
				+ "]";
	}
}
