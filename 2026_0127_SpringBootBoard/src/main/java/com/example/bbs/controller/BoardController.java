package com.example.bbs.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.bbs.dao.BoardDao;
import com.example.bbs.dao.MemberDao;
import com.example.bbs.vo.BoardVo;
import com.example.bbs.vo.MemberVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.websocket.Session;

@Controller
@RequestMapping("/board/")
public class BoardController {
	
	@Autowired
	BoardDao boardDao;
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	HttpSession session;
	
	// 게시글 조회
	@RequestMapping("list.do")
	public String list(Model model){
		
		List<BoardVo> list = boardDao.selectList();
		
		model.addAttribute("list", list);
		
		return "board/board_list";
	}
	
	// 게시글 상세
	@RequestMapping("view.do")
	public String select_one(int b_idx, Model model) {
		
		BoardVo vo = boardDao.selectOneFromIdx(b_idx);
		
		// 게시물 조회수 카운팅을 최초 1번으로 제한하는 법
		// 현재 게시물을 봤냐? 를 얻기
		// 싱글톤과 같은 구조. 객체가 없으면 만들기 -> 객체가 생긴 후엔 호출 안됨
		if(session.getAttribute("show")==null) {
			
			// 조회수 증가 mapper 호출
			int res = boardDao.updateReadhit(b_idx);
			
			// 봤다는 정보를 세션에 넣음
			session.setAttribute("show", true);
		}
		
		
		
		model.addAttribute("vo", vo);
		
		return "board/board_view";
	}
	
	// 글쓰기 폼
	@RequestMapping("insert_form.do")
	public String insert_form() {
		
		return "board/board_insert_form";
	}
	
	
	// 글쓰기
	// f.method = "POST"
	// board/insert.do?b_subject=제목&b_content=...
	@PostMapping("insert.do")
	public String insert(BoardVo vo, RedirectAttributes ra) {
		
		// ip 얻어오기
		String b_ip = request.getRemoteAddr();
		vo.setB_ip(b_ip);
		// login 상태유무 체크
		MemberVo user = (MemberVo) session.getAttribute("user");
		// 				강제 캐스팅해서 타입을 맞춰줘야함
		if(user==null) {	// 세션이 만료되었거나 로그아웃된 상태
			ra.addAttribute("reason", "session_timeout");
			// response.sendRedirect("../member/login_form.do?reason=session_timeout");
			return "redirect:../member/login_form.do";
		}	// 세션 트래킹 : 세션 정보가 변경되었을 때 클라이언트에게 변경사항을 알려주는 것
		
		if(b_ip.equals("172.30.1.98")) {
			ra.addAttribute("reason", "ban_ip");
			return "redirect:../board/list.do";
		}
		
		// 내용 : \n -> <br> 변경
		String b_content = vo.getB_content().replaceAll("\n", "<br>");
		
		
		// 회원정보 넣기
		vo.setMem_idx(user.getMem_idx());
		vo.setMem_id(user.getMem_id());
		vo.setMem_name(user.getMem_name());
		
	
		int res = boardDao.insert(vo);
		
		return "redirect:list.do";
	}
	
	@PostMapping("delete.do")
	public String delete(int b_idx) {
		
		int res = boardDao.delete(b_idx);
		
		return "redirect:list.do";
	}
}
