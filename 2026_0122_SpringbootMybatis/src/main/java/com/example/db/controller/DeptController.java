package com.example.db.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.db.dao.DeptDao;
import com.example.db.vo.DeptVo;

@Controller
public class DeptController {
	
	@Autowired
	DeptDao deptDao;
	
	@RequestMapping("/dept/list.do")
	public String list(Model model) {
		
		List<DeptVo> list = deptDao.selectList();
		
		model.addAttribute("list", list);
		
		return "dept/dept_list";
	}
}
