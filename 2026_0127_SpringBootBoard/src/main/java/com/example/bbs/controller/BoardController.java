package com.example.bbs.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.bbs.constant.MyConstant;
import com.example.bbs.dao.BoardDao;
import com.example.bbs.dao.MemberDao;
import com.example.bbs.util.Paging;
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
	// /board/list.do
	// /board/list.do?page=1
	@RequestMapping("list.do")
	public String list(@RequestParam(name="page", defaultValue = "1") int nowPage, Model model){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		// page 의 범위 계산
		int start	= (nowPage-1) * MyConstant.Board.BLOCK_LIST +1 ;
		// 첫페이지일 때 : (1-1) * 5 +1 = 1
		int end		= start + MyConstant.Board.BLOCK_LIST -1 ;
		
		map.put("start", start);
		map.put("end", end);
		
		List<BoardVo> list = boardDao.selectConditionList(map);
		// board.xml 문의 selectConditionList 로 전송 -> #{start} 와 #{end} 에 들어감
		
		// Paging Menu 만들기
		int rowTotal = boardDao.selectRowTotal(map);
		
		String pageMenu = Paging.getPaging2("list.do",
											nowPage,
											rowTotal,
											MyConstant.Board.BLOCK_LIST,
											MyConstant.Board.BLOCK_PAGE);
		
		System.out.println(pageMenu);
		
		// 이전 게시물 보기에서 설정한 show 값을 세션에서의 값을 삭제
		session.removeAttribute("show");
		
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
		
		return "board/board_list";
	}
	
	// 게시글 상세
	@RequestMapping("view.do")
	public String select_one(int b_idx, Model model) {
		
		BoardVo vo = boardDao.selectOne(b_idx);
		
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
	
	
	// 답글쓰기 폼 띄우기
	@GetMapping("reply_form.do")
	public String reply_form(int b_idx, Model model) {
		
		model.addAttribute("b_idx", b_idx);
		
		return "board/board_reply_form";
	}
	
	// 답글쓰기
	// f.method = "POST"
	// board/reply.do?b_idx=23&b_subject=제목&b_content=내용&page=3...
	@PostMapping("reply.do")
	public String reply(BoardVo vo, int page, RedirectAttributes ra) {
		
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
		
		// 기준글(baseVo) 정보를 구한다
		BoardVo baseVo = boardDao.selectOne(vo.getB_idx());
		
		// 기준글보다 b_step 이 큰 게시물의 b_step 을 1씩 증가시켜야 한다
		// db xml 에서 값 수정
		int res = boardDao.updateStep(baseVo);
		
		// b_ref b_step b_depth 계산을 vo 에 넣는다
		// 자리를 만든 다음 값 넣기
		vo.setB_ref(baseVo.getB_ref());
		vo.setB_step(baseVo.getB_step()+1);
		vo.setB_depth(baseVo.getB_depth()+1);
		
		// db reply
		res = boardDao.reply(vo);
		
		// page 값 넘겨주기
		ra.addAttribute("page", page);
		
		return "redirect:list.do";
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
		
		// db insert
		int res = boardDao.insert(vo);
		
		return "redirect:list.do";
	}
	
	// /board/delete.do?b_idx=5
	// 삭제
	@PostMapping("delete.do")
	public String delete(int b_idx, int page, RedirectAttributes ra) {
		
		// db delete 처리 : b_use='n' 변경
		int res = boardDao.delete(b_idx);
		
		ra.addAttribute("page", page);	// list.do?page=3
		
		return "redirect:list.do";
	}
}
