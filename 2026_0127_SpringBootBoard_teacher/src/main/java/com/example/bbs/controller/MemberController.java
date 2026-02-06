package com.example.bbs.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.bbs.dao.MemberDao;
import com.example.bbs.vo.MemberVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class MemberController {

	@Autowired
	MemberDao memberDao;
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	HttpSession session;
	
	
	//회원조회
	@RequestMapping("/member/list.do")
	public String list(Model model) {
		
		List<MemberVo> list = memberDao.selectList();
		
		//request binding
		model.addAttribute("list", list);
		
		
		return "member/member_list";
	}
	
	//로그인폼 띄우기
	@RequestMapping("/member/login_form.do")
	public String login_form() {
		
		return "member/member_login_form";
	}
	
	
	//로그인
	// /member/login.do?mem_id=hong&mem_pwd=1234&url=http://localhost:8080/....
	@RequestMapping("/member/login.do")
	public String login(String mem_id,String mem_pwd,String url,RedirectAttributes ra) {
		
		MemberVo user = memberDao.selectOneFromId(mem_id);
		
		//mem_id 틀린경우
		if(user==null) {
			
			//  response.sendRedirect("login_form.do?reason=fail_id");
			ra.addAttribute("reason", "fail_id");
			return "redirect:login_form.do";
		}

		// mem_pwd 틀린경우
		if(!user.getMem_pwd().equals(mem_pwd)) {
           
			//response.sendRedirect("login_form.do?reason=fail_pwd&mem_id=" + mem_id);
			ra.addAttribute("reason", "fail_pwd");
			ra.addAttribute("mem_id", mem_id);
			
			return "redirect:login_form.do";
		}
		
		//세션에 로그인 정보 저장
		session.setAttribute("user", user);
		
		//돌아갈 주소가 있으면
		if(!url.isEmpty()) {
			return "redirect:" + url;
		}
		
		return "redirect:../board/list.do";
	}
	
	
	//로그아웃
	@RequestMapping("/member/logout.do")
	public String logout() {
		
		//방법1) : SessionListener에 의해서 통지 못받는다
		//session.removeAttribute("user");
		
		//방법2) : SessionListener에 의해서 통지 받는다
		session.invalidate();
		
		
		return "redirect:../board/list.do";
	}
	
	//회원가입폼 띄우기
	@RequestMapping("/member/insert_form.do")
	public String insert_form() {
		
		return "member/member_insert_form";
	}
	
	//중복아이디 체크
	@RequestMapping("/member/check_id.do")
	@ResponseBody
	public Map<String, Boolean> check_id(String mem_id){
		
		//  /member/check_id.do?mem_id=hong
		
		//1.mem_id에 해당되는 회원정보를 얻는다
		MemberVo vo = memberDao.selectOneFromId(mem_id);
		
		//2.사용유무에 대한 결과
		boolean bResult = false;
		
		if(vo==null) bResult = true;//사용가능한 아이디
		
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		
		// JSON Converter에 의해서 Map -> JSON변환
		map.put("result", bResult); // {"result": true }
				
		return map;
	}
	
	
	//  /member/insert.do?mem_name=홍길동&mem_id=hong&mem_pwd=1234&
	//                    mem_email=hong@ymca.com&mem_tel=010-999-1234&
	//                    mem_zipcode=41919&mem_addr=대구 중구 국채보상로 541 2층 교육센터
	
	//회원가입
	@RequestMapping("/member/insert.do")
	public String insert(MemberVo vo) {
		
		// ip 구하기
		String mem_ip = request.getRemoteAddr();
		vo.setMem_ip(mem_ip);
		
		//DB insert
		int res = memberDao.insert(vo);
		
		
		return "redirect:list.do";
	}
	
	
	
	
	
}
