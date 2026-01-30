package com.example.mvc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class HomeController {
	public HomeController() {
		// TODO Auto-generated constructor stub
		System.out.println("--HomeController()--");
		System.out.println("생성됐는지 확인");
	}
	
	@RequestMapping("/")
	public String home(HttpServletRequest request) {
		
		String ip = request.getRemoteAddr();
		System.out.println(ip);
		return "home";	// ViewName만 설정
						// Spring 이 View Resolver 에게 앞/뒤 붙여서 forward 지시
	}
	
	@RequestMapping("/member/list.do")
	public String list() {
		return "member/member_list";	// views 하위에 member/member_list.jsp
	}
	
	@RequestMapping("/boardlist.do")
	public String blist() {
		return "boardlist";
	}
	
	@RequestMapping("/visit/list.do")
	public String vlist() {
		return "visit/list";
	}
	
}
