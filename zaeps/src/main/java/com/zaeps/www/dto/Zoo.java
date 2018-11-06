package com.zaeps.www.dto;

public class Zoo {
	int num;
	String name;
	String location;
	String latitude;
	String longtitude;
	String sDate;
	String imgPath;
	String fileName;
	String content;
	
	public Zoo() {};
	
	public Zoo(int num, String name, String location, String latitude, String longtitude, String sDate, String imgPath, String fileName, String content){
	      this.num = num;
	      this.name = name;
	      this.location = location;
	      this.latitude = latitude;
	      this.longtitude = longtitude;
	      this.sDate = sDate;
	      this.imgPath = imgPath;
	      this.fileName = fileName;
	      this.content = content;
	}  
	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongtitude() {
		return longtitude;
	}

	public void setLongtitude(String longtitude) {
		this.longtitude = longtitude;
	}

	public int getNum() {
		return num;
	}



	public void setNum(int num) {
		this.num = num;
	}



	public String getContent() {
		return content;
	}



	public void setContent(String content) {
		this.content = content;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public String getLocation() {
		return location;
	}



	public void setLocation(String location) {
		this.location = location;
	}



	public String getsDate() {
		return sDate;
	}



	public void setsDate(String sDate) {
		this.sDate = sDate;
	}



	public String getImgPath() {
		return imgPath;
	}



	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}



	public String getFileName() {
		return fileName;
	}



	public void setFileName(String fileName) {
		this.fileName = fileName;
	}




}
