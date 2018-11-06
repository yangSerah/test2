package com.zaeps.www.util;

public class RegisterRequest {
	private String id;
	private String pw;
	private String confirmPw;
	private String name;
	private String post;
	private String address;
	private String addressDetail;
	private String tel1;
	private String tel2;
	private String tel3;
	private String email;
	private String zooName;

	public String getZooName() {
		return zooName;
	}

	public void setZooName(String zooName) {
		this.zooName = zooName;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getConfirmPw() {
		return confirmPw;
	}

	public void setConfirmPw(String confirmPw) {
		this.confirmPw = confirmPw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPost() {
		return post;
	}

	public void setPost(String post) {
		this.post = post;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAddressDetail() {
		return addressDetail;
	}

	public void setAddressDetail(String addressDetail) {
		this.addressDetail = addressDetail;
	}

	public String getTel1() {
		return tel1;
	}

	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}

	public String getTel2() {
		return tel2;
	}

	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}

	public String getTel3() {
		return tel3;
	}

	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "RegisterRequest [id=" + id + ", pw=" + pw + ", confirmPw=" + confirmPw + ", name=" + name + ", post="
				+ post + ", address=" + address + ", addressDetail=" + addressDetail + ", tel1=" + tel1 + ", tel2="
				+ tel2 + ", tel3=" + tel3 + ", email=" + email + ", zooName=" + zooName + "]";
	}

}