package com.zaeps.www.service;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zaeps.www.dao.ZaepsDao;
import com.zaeps.www.dto.UserReq;
import com.zaeps.www.dto.Zoo;
import com.zaeps.www.exception.IdPasswordNotMatchingException;
import com.zaeps.www.util.AuthInfo;
import com.zaeps.www.util.RegisterRequest;

@Service
public class ZaepsService {
	
	@Autowired
	private ZaepsDao zaepsDao;
	
	public int insertUserData(HttpServletRequest request) {
		//request 데이터 파싱
		
		Member member = new Member();
		member.setNum(regReq.getNum());
		member.setName(regReq.getName());
		member.setLocation(regReq.getLocation());
		member.setLatitude(regReq.getLatitude());
		member.setLongtitude(regReq.getLongtitude());
		member.setsDate(regReq.getsetDate());
		
		return zaepsDao.insertMember(member);
	}
	
}
