package com.zaeps.www.controller;

import java.security.PrivateKey;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.crypto.Cipher;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.zaeps.www.exception.IdPasswordNotMatchingException;
import com.zaeps.www.service.ZaepsService;
import com.zaeps.www.util.AuthInfo;

@RestController
public class ZaepsRestController {
	@Autowired
	private ZaepsService zaepsService;
	
	// 濡쒓렇�씤 �떆 RSA �븫�샇�솕 �맂 pw 蹂듯샇�솕 �썑 濡쒓렇�씤 泥섎━
	@RequestMapping("/vision")
	public Map<String, String> androidTestWithRequestAndResponse(HttpServletRequest request){
		ArrayList<Member> member = new ArrayList<Member>();
		Map<String, String> result = new HashMap<String, String>(); 
		
		String nowTime = getCurrentTime("YYYY,M,d");
		String num = "",day = "",content = "";
		VDao dao = sqlSession.getMapper(VDAO.class);
		dao.writeDao(nowTime,request.getParmeter("content"));
		
		zaepsService.insertUserData(request);
		
		result.put("num", num);
		result.put("name", name);
		result.put("location", location);
		result.put("latitude", latitude);
		result.put("longtitude", longtitude);
		result.put("s_day", day); //
		
		return result;	
	}
	private String getCurrentTime(String timeFormat) {
		return new SimpleDateFormat(timeFormat).format(System.currentTimeMillis());
	}
	
}
