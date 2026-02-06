package com.example.bbs.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.bbs.dao.CommentDao;
import com.example.bbs.vo.CommentVo;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/comment/")
public class CommentController {

	@Autowired
	CommentDao commentDao;
	
	@Autowired
	HttpServletRequest request;
	
	
	// /comment/list.do?b_idx=5
	
	@RequestMapping("list.do")
	public String list(int b_idx,Model model) {
		
		List<CommentVo> list = commentDao.selectList(b_idx);
		
		// model -> request binding
		model.addAttribute("list", list);
		
		return "comment/comment_list";
	}
	
	// /comment/insert.do?b_idx=5&cmt_content=내용&mem_idx=1&mem_name=일길동....
	@RequestMapping("insert.do")
	@ResponseBody
	public Map<String, Boolean>  insert(CommentVo vo) {
		
		//ip받기
		String cmt_ip = request.getRemoteAddr();
		vo.setCmt_ip(cmt_ip);
		
		int res = commentDao.insert(vo);
		
		// JSONConverter에 의해서 map -> json을 변환되서 반환
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("result", (res==1)); // {"result" : true }
		
		return map;
	}
	
	
	
	
}
