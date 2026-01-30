package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.vo.PersonVo;

@Controller	// Spring에게 이걸 component로 사용할 거라고 지정
public class HomeController {	// 과연 spring이 HomeController 객체를 생성할까?
	public HomeController() {
		// TODO Auto-generated constructor stub
		System.out.println("-HomeController()-");	// 기본 생성자 내부에 출력문 넣어서 생성여부 체크
	}
	
	// / (기본폼)
	@RequestMapping("/")		// RequestMapping 해달라고 지정
	@ResponseBody
	public String home() {
		
		PersonVo p = new PersonVo();	// 기본 생성자로 p 객체 생성
		System.out.println(p);			// 갓 만들어진 p 객체 확인 -> 기본값이므로 null, 0, null
		
		p.setName("장정은");
		p.setAge(30);
		p.setTel("010-1111-1111");
		
		System.out.println(p);	// @toString() 오버라이딩(재정의) 체크
		
		PersonVo p1 = new PersonVo("이길동", 30, "010-3333-3333");
		System.out.println(p1);
		
		return "Welcome to My Home";
	}
	
	// /hello.do
	@RequestMapping("/hello.do")
	@ResponseBody
	public String hello() {
		return "Hello Spring!";
	}
	
	
}
