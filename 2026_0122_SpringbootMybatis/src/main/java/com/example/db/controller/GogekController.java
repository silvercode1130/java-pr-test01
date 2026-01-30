package com.example.db.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.db.dao.GogekDao;
import com.example.db.vo.GogekVo;

@Controller
public class GogekController {
	
	@Autowired
	GogekDao gogekDao;
	
	
	@RequestMapping("/gogek/list.do")
	public String list(Model model) {
		
		List<GogekVo> list = gogekDao.selectList();
		
		model.addAttribute("list", list);
		
		return "gogek/gogek_list";
	}
}
