package com.example.demo.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.vo.PersonVo;

@Controller	// controller 지정
public class ParamController {
	
	// /insert1.do?name=일길동&age=20&tel=010-1111-1111
	@RequestMapping("/insert1.do")
	@ResponseBody
	public String insert1(
						@RequestParam("name") String irum,
						int age,	// Integer.ParseInt(request.getParameter("age"))
						String tel) {
		
		PersonVo p = new PersonVo(irum, age, tel);
		System.out.println("---------insert1.do의 결과");
		System.out.println(p);
		System.out.println();
		
		return "insert1.do의 처리결과";
	}
	
	// /insert2.do
	@RequestMapping("/insert2.do")
	@ResponseBody
	public String insert2(PersonVo vo) {
		// method 인자 : Spring 에 대한 요구사항
		
		vo.setName("이길동");
		vo.setAge(20);
		vo.setTel("010-2222-2222");
		System.out.println("---------insert2.do의 결과");
		System.out.println(vo);
		System.out.println();
		
		return "insert2.do의 처리결과";
	}
	
	// /insert3.do
	@RequestMapping("/insert3.do")
	@ResponseBody
	public String insert3(@RequestParam Map map) {		

		System.out.println("---------insert3.do의 결과");
		System.out.println(map);
		System.out.println();
		
		return "insert3.do의 처리결과";
	}
	

}
