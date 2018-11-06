package com.zaeps.www.dto;

import java.util.List;

public class UserReq {
	private int reqNo;
	private int zooNo;
	private String reqLat;
	private String reqLong;
	private int aniTypeNo;
	private int aniCount;
	private List<UserReq> list;
	
	public int getAniCount() {
		return aniCount;
	}
	public void setAniCount(int aniCount) {
		this.aniCount = aniCount;
	}
	public int getReqNo() {
		return reqNo;
	}
	public void setReqNo(int reqNo) {
		this.reqNo = reqNo;
	}
	public int getZooNo() {
		return zooNo;
	}
	public void setZooNo(int zooNo) {
		this.zooNo = zooNo;
	}
	public String getReqLat() {
		return reqLat;
	}
	public void setReqLat(String reqLat) {
		this.reqLat = reqLat;
	}
	public String getReqLong() {
		return reqLong;
	}
	public void setReqLong(String reqLong) {
		this.reqLong = reqLong;
	}
	public int getAniTypeNo() {
		return aniTypeNo;
	}
	public void setAniTypeNo(int aniTypeNo) {
		this.aniTypeNo = aniTypeNo;
	}
	public List<UserReq> getList() {
		return list;
	}
	public void setList(List<UserReq> list) {
		this.list = list;
	}
	@Override
	public String toString() {
		return "UserReq [reqNo=" + reqNo + ", zooNo=" + zooNo + ", reqLat=" + reqLat + ", reqLong=" + reqLong
				+ ", aniTypeNo=" + aniTypeNo + ", aniCount=" + aniCount + ", list=" + list + "]";
	}
}
