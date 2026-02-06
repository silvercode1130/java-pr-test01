package com.example.db.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.db.dao.BoardDao;
import com.example.db.vo.BoardVo;
import com.example.db.vo.MemberVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class BoardController {
	
	@Autowired
	BoardDao boardDao;
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	HttpSession session;
	
	
//	===== 게시글 조회 =====
	// 사이트 전체글 조회
	@RequestMapping("/board/list.do")
	public String list(Model model){
		
		List<BoardVo> list = boardDao.selectList();
		model.addAttribute("list", list);
		
		return "board/board_list";
	}
	
	// 공지사항 조회
    @GetMapping("/notice/list.do")
    public String noticeList(Model model) {
    	
    	List<BoardVo> list = boardDao.selectListByTypeCode("NOTICE");
    	model.addAttribute("list", list);
		
        return "board/notice_list";
    }

    // 이벤트 조회
    @GetMapping("/event/list.do")
    public String eventList(Model model) {
    	
    	List<BoardVo> list = boardDao.selectListByTypeCode("EVENT");
    	model.addAttribute("list", list);
        
        return "board/event_list";
    }

    // 연구소 내 태그별 조회 (tag 로 DOG/CAT/NONE 필터)
    @GetMapping("/lab/list.do")
    public String labList(@RequestParam(defaultValue = "ALL") String tag,
                          Model model) {
		
    	// tag 값에 따라 조회 내용이 바뀜
        List<BoardVo> list = boardDao.selectListByTypeCodeAndTag("LAB", tag);
        model.addAttribute("list", list);
        model.addAttribute("tag", tag);
        
        return "lab/lab_list";
    }

    // QnA 태그별 조회 (tag 필터)
    @GetMapping("/qna/list.do")
    public String qnaList(@RequestParam(defaultValue = "ALL") String tag,
                          Model model) {
    	
        List<BoardVo> list = boardDao.selectListByTypeCodeAndTag("QNA", tag);
        model.addAttribute("list", list);
        model.addAttribute("tag", tag);
        
        return "board/qna_list";
    }

    // 자유게시판 내 태그별 조회 (tag 필터)
    @GetMapping("/free/list.do")
    public String freeList(@RequestParam(defaultValue = "ALL") String tag,
    		Model model) {
    	
    	List<BoardVo> list = boardDao.selectListByTypeCodeAndTag("FREE", tag);
    	model.addAttribute("list", list);
    	model.addAttribute("tag", tag);
    	
    	return "board/free_list";
    }
	
//	===== 게시글 상세 =====
    @GetMapping("/{boardType}/view.do")
    public String view(@PathVariable String boardType,	// PathVariable : url 에서 값 받음
                       @RequestParam int board_idx,		// request 호출시 parameter 값 받음
                       @RequestParam(required = false, defaultValue = "1") int page,
                       Model model) {
        
        BoardVo vo = boardDao.selectOneByIdxAndTypeCode(board_idx, boardType);
        
        // 조회수 증가
        if (session.getAttribute("show") == null) {
            boardDao.updateReadhit(board_idx);
            session.setAttribute("show", true);
        }
        
        model.addAttribute("vo", vo);
        model.addAttribute("boardType", boardType);
        model.addAttribute("page",page);
        
        return "board/board_view";  // 같은 jsp 사용 가능!(동적 url 이므로)
    }
	
//	===== 글쓰기 폼 =====
    @GetMapping("/{boardType}/insert_form.do")
    public String insertForm(@PathVariable String boardType,
    						 Model model) {
    	
        model.addAttribute("boardType", boardType);
        
        return "board/board_insert_form";
    }
	
//	===== 글쓰기 =====
	// f.method = "POST"
	// board/insert.do?board_title=제목&board_content=...
    @PostMapping("/{boardType}/insert.do")
    public String insert(@PathVariable String boardType,
			             BoardVo vo,
			             RedirectAttributes ra) {

	    // 1) 로그인 체크
	    MemberVo user = (MemberVo) session.getAttribute("user");
	    if (user == null) {
	        ra.addAttribute("reason", "session_timeout");
	        return "redirect:../member/login_form.do";
	    }

	    // 2) ip 넣기
	    String board_ip = request.getRemoteAddr();
	    vo.setBoard_ip(board_ip);

//	    // 3) 아이피 밴 체크
//	    if ("172.30.1.00".equals(board_ip)) {
//	        ra.addAttribute("reason", "ban_ip");
//	        return "redirect:/" + boardType + "/list.do";
//	    }

	    // 4) 내용 줄바꿈 치환
	    if (vo.getBoard_content() != null) {
	        vo.setBoard_content(vo.getBoard_content().replace("\n", "<br>"));
	    }

	    // 5) 회원정보 넣기
	    vo.setMem_idx(user.getMem_idx());


	    // 6) boardType 사용해 board_type_idx 조회
	    int board_type_idx = boardDao.selectTypeIdxByCode(boardType);
	    vo.setBoard_type_idx(board_type_idx);

	    // 7) insert
	    int res = boardDao.insert(vo);

	    return "redirect:/" + boardType + "/list.do";
	}

 // ===== 수정 폼 =====
    @GetMapping("/{boardType}/modify_form.do")
    public String updateForm(@PathVariable String boardType,
                             @RequestParam int board_idx,
                             @RequestParam(required = false, defaultValue = "1") int page,
                             Model model) {
        
        BoardVo vo = boardDao.selectOneByIdxAndTypeCode(board_idx, boardType);
        
        // 본인 글 체크
        MemberVo user = (MemberVo) session.getAttribute("user");
        if (user == null || vo.getMem_idx() != user.getMem_idx()) {
            return "redirect:/board/" + boardType + "/list.do?page=" + page;
        }
        
        model.addAttribute("vo", vo);
        model.addAttribute("boardType", boardType);
        model.addAttribute("page", page);
        
        return "board/board_modify_form";
    }

    // ===== 수정 처리 =====
    @PostMapping("/{boardType}/modify.do")
    public String update(@PathVariable String boardType,
                         @RequestParam int board_idx,
                         @RequestParam(required = false, defaultValue = "1") int page,
                         BoardVo vo,
                         RedirectAttributes ra) {
        
        // 로그인 체크
        MemberVo user = (MemberVo) session.getAttribute("user");
        if (user == null) {
            ra.addAttribute("reason", "session_timeout");
            ra.addAttribute("page", page);
            return "redirect:../member/login_form.do";
        }
        
        // 권한 체크
        BoardVo originVo = boardDao.selectOne(board_idx);
        if (originVo.getMem_idx() != user.getMem_idx()) {
            ra.addAttribute("reason", "no_permission");
            ra.addAttribute("page", page);
            return "redirect:/board/" + boardType + "/list.do";
        }
        
        // 수정 날짜 업데이트
        vo.setBoard_moddate(null);  // mapper에서 SYSDATE로 세팅되므로 null
        vo.setBoard_idx(board_idx);  // 기존 PK 유지
        
        // update
        int res = boardDao.update(vo);
        
        ra.addAttribute("page", page);
        return "redirect:/board/" + boardType + "/list.do";
    }

//	===== 게시글 삭제(soft delete) =====	
    @PostMapping("/{boardType}/delete.do")
    public String delete(@PathVariable String boardType,  // PathVariable 먼저 받아야 함
			             @RequestParam int board_idx,
			             @RequestParam(required = false, defaultValue = "1") int page,
			             RedirectAttributes ra) {
		
		// 로그인 체크
	    MemberVo user = (MemberVo) session.getAttribute("user");
	    if (user == null) {
	        ra.addAttribute("reason", "session_timeout");
	        return "redirect:../member/login_form.do";
	    }
	    
	    // 본인 글 아니거나 권한없음
	    BoardVo vo = boardDao.selectOne(board_idx);
	    if (vo == null || vo.getMem_idx() != (user.getMem_idx())) {
	        ra.addAttribute("reason", "no_permission");
	        return "redirect:/" + boardType + "/list.do";
	    }
	    
	    // DB 값 변경(update) board_is_deleted 값 'y' 로 변경
	    int res = boardDao.softDelete(board_idx);
	    
	    ra.addAttribute("page", page);
	    
	    return "redirect:/" + boardType + "/list.do";
	}

}