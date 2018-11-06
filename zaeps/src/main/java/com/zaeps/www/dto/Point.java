package com.zaeps.www.dto;

public class Point {
	private int pointNo;
	private int zooNo;
	private String pointLat;
	private String pointLong;
	private String pointDist;
	private int aniTypeNo;
	
	public int getAniTypeNo() {
		return aniTypeNo;
	}
	public void setAniTypeNo(int aniTypeNo) {
		this.aniTypeNo = aniTypeNo;
	}
	public int getPointNo() {
		return pointNo;
	}
	public void setPointNo(int pointNo) {
		this.pointNo = pointNo;
	}
	public int getZooNo() {
		return zooNo;
	}
	public void setZooNo(int zooNo) {
		this.zooNo = zooNo;
	}
	public String getPointLat() {
		return pointLat;
	}
	public void setPointLat(String pointLat) {
		this.pointLat = pointLat;
	}
	public String getPointLong() {
		return pointLong;
	}
	public void setPointLong(String pointLong) {
		this.pointLong = pointLong;
	}
	public String getPointDist() {
		return pointDist;
	}
	public void setPointDist(String pointDist) {
		this.pointDist = pointDist;
	}
	@Override
	public String toString() {
		return "Point [pointNo=" + pointNo + ", zooNo=" + zooNo + ", pointLat=" + pointLat + ", pointLong=" + pointLong
				+ ", pointDist=" + pointDist + ", aniTypeNo=" + aniTypeNo + "]";
	}
}
