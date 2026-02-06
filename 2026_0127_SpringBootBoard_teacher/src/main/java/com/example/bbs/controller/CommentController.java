package com.example.bbs.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.bbs.constant.MyConstant;
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
	public String list(int b_idx,
						@RequestParam(name="page", defaultValue="1") int nowPage,
						Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("b_idx", b_idx);
		
		// start / end 계산
		int start	= (nowPage-1) * MyConstant.Comment.BLOCK_LIST + 1;
		int end		= start + MyConstant.Comment.BLOCK_LIST - 1;
		
		map.put("start", start);
		map.put("end", end);
		
		List<CommentVo> list = commentDao.selectPageList(map);
		
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
		
		System.out.println(vo);
		
		int res = commentDao.insert(vo);
		
		// JSONConverter에 의해서 map -> json을 변환되서 반환
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("result", (res==1)); // {"result" : true }
		
		return map;
	}
	
	@RequestMapping("delete.do")
	@ResponseBody
	public  Map<String, Boolean> delete(int cmt_idx) {

		int res = commentDao.delete(cmt_idx);
		
		// JSONConverter에 의해서 map -> json을 변환되서 반환
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("result", (res==1)); // {"result" : true }	성공유무를 true false 로 반환
		
		return map;
	}
	
	
	
	
}
