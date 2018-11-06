package com.zaeps.www.dto;

public class AniType {
	private int aniTypeNo;
	private String aniName;
	public int getAniTypeNo() {
		return aniTypeNo;
	}
	public void setAniTypeNo(int aniTypeNo) {
		this.aniTypeNo = aniTypeNo;
	}
	public String getAniName() {
		return aniName;
	}
	public void setAniName(String aniName) {
		this.aniName = aniName;
	}
	@Override
	public String toString() {
		return "AniType [aniTypeNo=" + aniTypeNo + ", aniName=" + aniName + "]";
	}
}
