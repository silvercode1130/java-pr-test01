package com.example.bbs.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.bbs.vo.BoardVo;

@Mapper
public interface BoardDao {
	
	List<BoardVo>		selectList();
	List<BoardVo>		selectConditionList(Map<String, Object> map);	// 조건별 페이징 조회
	BoardVo				selectOne(int b_idx);
	
	// 전체 게시물 수 구하기
	int 				selectRowTotal(Map<String, Object> map);
	
	int					insert(BoardVo vo);				// 새글쓰기
	int					reply(BoardVo vo);				// 답글쓰기
	
	int					update(BoardVo vo);				// 글수정
	int					delete(int b_idx);				// 글삭제
	
	int					updateReadhit(int b_idx);		// 조회수 업데이트
	int 				updateStep(BoardVo baseVo);		// 답글 스텝 업데이트
	
}
