package com.zaeps.www.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.zaeps.www.dto.AniType;
import com.zaeps.www.dto.UserReq;
import com.zaeps.www.dto.Zoo;

@Repository
public class ZaepsDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	// �븘�씠�뵒 媛믪쑝濡� �룞臾쇱썝 媛앹껜 select
	public Zoo selectById(String id) {
		return sqlSession.selectOne("ZaepsDao.selectById", id);
	}
	
	// �쉶�썝 �슂泥��궗�빆 ���옣
	public int insertMember(Member member) {
		return sqlSession.insert("ZaepsDao.insertMember", member);
	}
	
}
