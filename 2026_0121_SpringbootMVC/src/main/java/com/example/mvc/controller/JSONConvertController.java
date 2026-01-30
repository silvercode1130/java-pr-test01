package com.example.mvc.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.mvc.vo.StudentVo;

@Controller
public class JSONConvertController {
	
	@RequestMapping("/map2_to_json.do")
	@ResponseBody
	public Map map2_to_json() {	// 모든 객체를 json 으로 쉽게 변환할 수 있음
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("result", true);
		
		String json = String.format("{\"result\":%b}", true);
		return map;
	}
	
	@RequestMapping("/map_to_json.do")
	@ResponseBody
	public Map map_to_json() {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("one", "하나 라는 뜻입니다.");
		map.put("two", "둘 이라는 뜻입니다.");
		map.put("three", "셋 이라는 뜻입니다.");
		map.put("four", "넷 이라는 뜻입니다.");
		map.put("five", "다섯 이라는 뜻입니다.");
		
		return map;
	}
	
	@RequestMapping("/object_to_json.do")
	@ResponseBody
	public StudentVo object_to_json() {
		
		return new StudentVo("홍길동", 30, "남자", "127.0.0.1", 5);	// Student 새 객체 리턴
	}
	
	@RequestMapping("/array_to_json.do")
	@ResponseBody
	public String [] array_to_json() {
		String [] sido_array = {"서울", "부산", "대구", "대전", "광주", "제주"};
		
		return sido_array;
	}
	
	@RequestMapping("/list_to_json.do")
	@ResponseBody
	public List<StudentVo> list_to_json(){
		
		List<StudentVo> list = new ArrayList<StudentVo>();
		
		list.add(new StudentVo("유서윤", 20, "여자", "172.30.1.24", 1));
		list.add(new StudentVo("신서완", 40, "남자", "172.30.1.35", 2));
		list.add(new StudentVo("박소정", 20, "여자", "172.30.1.47", 3));
		list.add(new StudentVo("김재우", 30, "남자", "172.30.1.89", 1));
		list.add(new StudentVo("최민수", 30, "남자", "172.30.1.75", 2));
		list.add(new StudentVo("최은정", 20, "여자", "172.30.1.97", 3));
		
		return list;
	}
	
	@RequestMapping("/list2_to_json.do")
	@ResponseBody
	public Map list2_to_json(){
		
		List<StudentVo> list = new ArrayList<StudentVo>();
		
		list.add(new StudentVo("유서윤", 20, "여자", "172.30.1.24", 1));
		list.add(new StudentVo("신서완", 40, "남자", "172.30.1.35", 2));
		list.add(new StudentVo("박소정", 20, "여자", "172.30.1.47", 3));
		list.add(new StudentVo("김재우", 30, "남자", "172.30.1.89", 1));
		list.add(new StudentVo("최민수", 30, "남자", "172.30.1.75", 2));
		list.add(new StudentVo("최은정", 20, "여자", "172.30.1.97", 3));
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("students", list);
		
		return map;
	}
}
