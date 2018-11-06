package com.zaeps.www.controller;

import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.zaeps.www.dao.ZaepsDao;
import com.zaeps.www.dto.AniType;
import com.zaeps.www.dto.UserReq;
import com.zaeps.www.dto.Zoo;
import com.zaeps.www.service.ZaepsService;
import com.zaeps.www.util.AuthInfo;
import com.zaeps.www.util.RegisterRequest;

@Controller
public class ZaepsController {
	@Autowired
	private ZaepsService zaepsService;
	
	@Autowired
	private ZaepsDao zaepsDao;
	
	static String RSA_WEB_KEY = "_RSA_WEB_KEY"; // 개인키 session key
	static String RSA_INSTANCE = "RSA"; // rsa transformation
	
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		return "login";
	}
	
	@RequestMapping(value = "/wsTest")
	public String wsTest() {
		return "ws_test";
	}
	
	// 로그인 폼
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(HttpServletRequest request, HttpServletResponse response) {
		initRsa(request);
		HttpSession session = request.getSession();
		System.out.println("session 체크2 : " + session.getAttribute(RSA_WEB_KEY));
		return "login";
	}
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main() {
		return "index";
	}
	
	@RequestMapping(value = "/404", method = RequestMethod.GET)
	public String form404() {
		return "404";
	}
	
	@RequestMapping(value = "/blank", method = RequestMethod.GET)
	public String blank() {
		return "blank";
	}
	

	
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}
	
	// 로그인 시 회원 등급에 따라 뷰 페이지 리턴
	@RequestMapping(value = "/result", method = RequestMethod.GET)
	public String doLogin(HttpSession session, Model model) {
		AuthInfo authInfo = (AuthInfo) session.getAttribute("authInfo");
		model.addAttribute("grade", authInfo.getGrade());
		if(authInfo.getGrade() == 1) { // 등급이 관리자일 때
			return "admin_page";
		} else if(authInfo.getGrade() == 2) { // 사용자 설정을 완료 후 관리자가 승인할 회원일 떄
			return "user_page";
		} else if(authInfo.getGrade() == 3) { // 사용자 설정을 하지 않은 회원일 때
			return "redirect:/userReqForm";
		}
		return "test";
	}
	
	//사용자 설정 창
	@RequestMapping(value = "/userReqForm", method = RequestMethod.GET)
	public String userReqPage(HttpSession session, Model model) {
		List<AniType> aniTypeList = zaepsDao.selectAniType();
		System.out.println("list 개수 : " + aniTypeList.size());
		
		AuthInfo authInfo = (AuthInfo)session.getAttribute("authInfo");
		Zoo memberInfo = zaepsService.selectZooById(authInfo.getId());
		model.addAttribute("aniTypeList", aniTypeList);
		model.addAttribute("memberInfo", memberInfo);
		return "user_req_page";
	}
	
	// 회원가입 폼
	@RequestMapping(value = "/registerForm", method = RequestMethod.GET)
	public String registerForm() {
		return "register";
	}
	
	@RequestMapping(value = "/forgotPassword", method = RequestMethod.GET)
	public String forgotPassword() {
		return "forgot-password";
	}
	
	@RequestMapping(value = "charts", method = RequestMethod.GET)
	public String charts() {
		return "charts";
	}
	
	@RequestMapping(value = "tables", method = RequestMethod.GET)
	public String tables() {
		return "tables";
	}
	
	// 회원가입 실시
	@RequestMapping(value = "/register.do", method = RequestMethod.POST)
	public String doRegister(RegisterRequest regReq, RedirectAttributes redirectAttributes, Model model) {
		System.out.println("reqReq 체크: " + regReq);
		try {
			int regResult = zaepsService.doRegister(regReq);
			if (regResult == 1) {
				redirectAttributes.addFlashAttribute("regResult", 1);
				return "redirect:/login";
			} else {
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("regResult", 0);
			return "register";
		}
	}
	
	//사용자 요청 사항 인서트
	@RequestMapping(value = "/insertUserReq.do", method = RequestMethod.POST)
	public String insertUserReq(UserReq userReq, HttpSession session, Model model) {
		System.out.println("userReq : " + userReq);
		int result = zaepsService.insertUserReq(userReq.getList(), session);
		if(result == 1) {
			return "resultForm";
		} else {
			model.addAttribute("insertResult", "fail");
			return "userReqForm";
		}
	}
	
	@RequestMapping(value = "/userInfoForm", method = RequestMethod.GET)
	public String userInfoForm(Model model) {
		List<Zoo> userList = zaepsDao.selectUnAuthUser();
		for(Zoo user : userList) {
			String regdate = user.getRegdate();
			String[] splitRegdate = regdate.split(" ");
			user.setRegdate(splitRegdate[0]);
		}
		model.addAttribute("userList", userList);
		return "userInfoForm";
	}
	
	@RequestMapping(value = "/userInfoDetail", method = RequestMethod.GET)
	public String userInfoDetail(@RequestParam(value = "zooNo", defaultValue = "null")int zooNo, Model model) {
		List<UserReq> reqList = zaepsDao.selectUnAuthUserReqByNo(zooNo);
		model.addAttribute("reqList", reqList);
		return "setUserInfo";
	}
	
	// rsa 공개키, 개인키 생성
	private void initRsa(HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		KeyPairGenerator generator;
		try {
			generator = KeyPairGenerator.getInstance(RSA_INSTANCE);
			generator.initialize(1024);

			KeyPair keyPair = generator.genKeyPair();
			KeyFactory keyFactory = KeyFactory.getInstance(RSA_INSTANCE);
			PublicKey publicKey = keyPair.getPublic();
			PrivateKey privateKey = keyPair.getPrivate();

			session.setAttribute(RSA_WEB_KEY, privateKey); // session에 RSA 개인키를 세션에 저장
			RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
			String publicKeyModulus = publicSpec.getModulus().toString(16);
			String publicKeyExponent = publicSpec.getPublicExponent().toString(16);
			
			request.setAttribute("RSAModulus", publicKeyModulus); // rsa modulus 를 request 에 추가
			request.setAttribute("RSAExponent", publicKeyExponent); // rsa exponent 를 request 에 추가
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
