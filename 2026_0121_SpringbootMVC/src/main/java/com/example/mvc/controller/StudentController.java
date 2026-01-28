package com.example.mvc.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.mvc.vo.StudentVo;

@Controller
public class StudentController {
	
	@RequestMapping("/student/list.do")
	public String list(Model model) {
		
		List<StudentVo> list = new ArrayList<StudentVo>();
		
		list.add(new StudentVo("유서윤", 20, "여자", "172.30.1.24", 1));
		list.add(new StudentVo("신서완", 40, "남자", "172.30.1.35", 2));
		list.add(new StudentVo("박소정", 20, "여자", "172.30.1.47", 3));
		list.add(new StudentVo("김재우", 30, "남자", "172.30.1.89", 1));
		list.add(new StudentVo("최민수", 30, "남자", "172.30.1.75", 2));
		list.add(new StudentVo("최은정", 20, "여자", "172.30.1.97", 3));
		
		model.addAttribute("list", list);
		
		return "student/student_list";
	}
	
	@RequestMapping("/student/student_list2.do")
	public ModelAndView list2() {
		
		List<StudentVo> list2 = new ArrayList<StudentVo>();
		
		list2.add(new StudentVo("유서윤", 20, "여자", "172.30.1.24", 1));
		list2.add(new StudentVo("신서완", 40, "남자", "172.30.1.35", 2));
		list2.add(new StudentVo("박소정", 20, "여자", "172.30.1.47", 3));
		list2.add(new StudentVo("김재우", 30, "남자", "172.30.1.89", 1));
		list2.add(new StudentVo("최민수", 30, "남자", "172.30.1.75", 2));
		list2.add(new StudentVo("최은정", 20, "여자", "172.30.1.97", 3));
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("list2", list2);
		
		mv.setViewName("student/student_list2");
		
		return mv;
	}
}
