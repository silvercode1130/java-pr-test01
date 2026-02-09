package com.example.bbs.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.bbs.constant.MyConstant;
import com.example.bbs.dao.BoardDao;
import com.example.bbs.util.Paging;
import com.example.bbs.vo.BoardVo;
import com.example.bbs.vo.MemberVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/board/")
public class BoardController {

	@Autowired
	BoardDao boardDao;
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	HttpSession session;
	
	
	//board/list.do
	//board/list.do?search=name&search_text=길동&page=2
	//board/list.do?page=2
	
	@RequestMapping("list.do")
	public String list(	@RequestParam(name="search", defaultValue = "all") String search,
						@RequestParam(name="search_text", defaultValue = "") String search_text,
						@RequestParam(name="page",defaultValue = "1") int nowPage,
						Model model) throws Exception {
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 검색조건 추가
		if(search.equals("name_subject_content")) {
			
			// 이름+제목+내용
			map.put("mem_name", search_text);
			map.put("b_subject", search_text);
			map.put("b_content", search_text);
			
		}else if(search.equals("name")) {
			map.put("mem_name", search_text);
		
		}else if(search.equals("subject")) {
			map.put("b_subject", search_text);
		
		}else if(search.equals("content")) {
			map.put("b_content", search_text);
			
		}else if(search.equals("subject_content")) {
			map.put("b_subject", search_text);
			map.put("b_content", search_text);
		}
		
		System.out.println(map);                   
		
		//page의 범위 계산
		int start 	= (nowPage-1) * MyConstant.Board.BLOCK_LIST + 1 ;
		int end		= start + MyConstant.Board.BLOCK_LIST - 1;
		
		map.put("start", start);
		map.put("end", end);
		
		
		List<BoardVo> list = boardDao.selectConditionList(map);
		
		// Paging Menu 만들기
		
		//전체 게시물수
		int rowTotal = boardDao.selectRowTotal(map);
		//페이지 만드는 코드
		String searchFilter = String.format("search=%s&search_text=%s", search,
																		URLEncoder.encode(search_text, "utf-8")
																		);
		String pageMenu = Paging.getPaging3("list.do",
											searchFilter,
				                            nowPage, 
				                            rowTotal,
				                            MyConstant.Board.BLOCK_LIST,
				                            MyConstant.Board.BLOCK_PAGE);
		//System.out.println(pageMenu);
		
		//이전게시물보기에서 설정한 show값을 세션에서 삭제
		session.removeAttribute("show");
		
		//request binding
		model.addAttribute("list", list);
		model.addAttribute("pageMenu",pageMenu);
		
		return "board/board_list";
	}
	
	//새글쓰기 폼 띄우기
	@RequestMapping("insert_form.do")
	public String insert_form() {
		
		return "board/board_insert_form";
	}
	
	//새글쓰기
	// f.method = "POST"
	//  /board/insert.do?b_subject=제목&b_content=내용
	
	@PostMapping("insert.do")
	public String insert(BoardVo vo,RedirectAttributes ra) {
		
		//login 상태유무 체크
		MemberVo user = (MemberVo) session.getAttribute("user");
		
		//로그아웃상태면
		if(user==null) {
			
			ra.addAttribute("reason", "session_timeout");
			// response.sendRedirect("../member/login_form.do?reason=session_timeout");
			return "redirect:../member/login_form.do";
		}
		
		//내용 : \n -> <br> 변경
//		String b_content = vo.getB_content().replaceAll("\n", "<br>");
//		vo.setB_content(b_content);
		
		//IP
		String b_ip = request.getRemoteAddr();
		vo.setB_ip(b_ip);
		
		//회원정보 넣기
		vo.setMem_idx(user.getMem_idx());
		vo.setMem_id(user.getMem_id());
		vo.setMem_name(user.getMem_name());
				
		
		
		//DB insert
		int res = boardDao.insert(vo);
				
		return "redirect:list.do";
		
	}//end:insert()
	
	// 게시글 상세보기
	// /borad/view.do?b_idx=5
	@RequestMapping("view.do")
	public String view(int b_idx,Model model) {
		
		BoardVo vo = boardDao.selectOne(b_idx);
		
		//현재 게시물을 봤냐?
		if(session.getAttribute("show")==null) {
			
			//조회수 증가
			int res  = boardDao.updateReadhit(b_idx);
			
			//봤다는 정보를 세션에 넣는다
			session.setAttribute("show", true);
			
		}
		
		//model통해서 전달 : request binding
		model.addAttribute("vo", vo);
		
		return "board/board_view";
	}
	
	
	//답글쓰기 폼 띄우기
	@RequestMapping("reply_form.do")
	public String reply_form() {
		
		return "board/board_reply_form";
	}
	
	
	// 답글쓰기
	// f.method = "POST"
	// /board/reply.do?b_idx=23&b_subject=제목&b_content=내용&page=3
	
	@PostMapping("reply.do")
	public String reply(BoardVo vo,int page,RedirectAttributes ra) {
		
		//login 상태유무 체크
		MemberVo user = (MemberVo) session.getAttribute("user");
		
		//로그아웃상태면
		if(user==null) {
			
			ra.addAttribute("reason", "session_timeout");
			// response.sendRedirect("../member/login_form.do?reason=session_timeout");
			return "redirect:../member/login_form.do";
		}
		
		//내용 : \n -> <br> 변경
		String b_content = vo.getB_content().replaceAll("\n", "<br>");
		vo.setB_content(b_content);
		
		//IP
		String b_ip = request.getRemoteAddr();
		vo.setB_ip(b_ip);
		
		//회원정보 넣기
		vo.setMem_idx(user.getMem_idx());
		vo.setMem_id(user.getMem_id());
		vo.setMem_name(user.getMem_name());
		
		//기준글 정보를 구한다
		BoardVo  baseVo = boardDao.selectOne(vo.getB_idx());
		
		//기준글보다 b_step이 큰 게시물의 b_step을 1씩 증가 시켜야 한다
		int res = boardDao.updateStep(baseVo);
		
		// b_ref b_step b_depth 계산 vo에 넣는다
		vo.setB_ref(baseVo.getB_ref());
		vo.setB_step(baseVo.getB_step()+1);
		vo.setB_depth(baseVo.getB_depth()+1);
				
		//DB reply
		res = boardDao.reply(vo);
		
		ra.addAttribute("page", page);
				
		return "redirect:list.do"; // list.do?page=3
		
	}//end:reply()
	
	
	// 수정하기 폼
		@RequestMapping("modify_form.do")
		public String modify_form(int b_idx, @RequestParam(defaultValue="1") int page, Model model) {
			
			BoardVo vo = boardDao.selectOne(b_idx);
			
			// 수정창에서 보이는 줄바꿈 <br> 제어문 \n 으로 바꾸기
			String b_content = vo.getB_content().replaceAll("<br>", "\n");
			vo.setB_content(b_content);
			
			model.addAttribute("page", page);
			model.addAttribute("vo", vo);
			
			
			return "board/board_modify_form";
		}
		
		
	// /board/modify.do?b_idx=5&page=3
	// 수정하기
	@PostMapping("modify.do")
	public String modify(BoardVo vo, @RequestParam(defaultValue="1") int page, RedirectAttributes ra, Model model) {
		
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
		
		if(b_ip.equals("172.30.1.00")) {
			ra.addAttribute("reason", "ban_ip");
			
			return "redirect:../board/list.do";
		}
		
		// 내용 : \n -> <br> 변경
		String b_content = vo.getB_content().replaceAll("\n", "<br>");
		
		// 수정된 본문 넣기
		vo.setB_content(b_content);
		
		// 회원정보 넣기
		vo.setMem_idx(user.getMem_idx());
		vo.setMem_id(user.getMem_id());
		vo.setMem_name(user.getMem_name());
		
		int res = boardDao.update(vo);
		
		ra.addAttribute("b_idx", vo.getB_idx());	// list.do?b_idx=5
		ra.addAttribute("page", page);				// list.do?page=3
		
		return "redirect:view.do";
	}

	//     /board/delete.do?b_idx=5&page=3&search=name&search_text=길동
	//삭제
	@PostMapping("delete.do")
	public String delete(	String search, String search_text,
							int b_idx,int page,RedirectAttributes ra) {
		
		//DB delete처리 :  b_use='n' 변경
		int res = boardDao.updateNoUse(b_idx);
		
		ra.addAttribute("search", search);
		ra.addAttribute("search_text", search_text);	// &search=name&search_text=길동
		ra.addAttribute("page", page); // list.do?page=3
		
		return "redirect:list.do";
	}
	
	
	
	
	
	
	
}
