package com.example.bbs.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.bbs.vo.BoardVo;

@Mapper
public interface BoardDao {

	List<BoardVo>		selectList();
	List<BoardVo>		selectConditionList(Map<String, Object> map);
	
	BoardVo				selectOne(int b_idx);
	
	//전체 게시물수 구하기
	int 				selectRowTotal(Map<String, Object> map);
	
	int 				insert(BoardVo vo);
	int 				reply(BoardVo vo);
	
	
	int					update(BoardVo vo);
	int					updateReadhit(int b_idx);
	int 				updateStep(BoardVo baseVo);
	int 				updateNoUse(int b_idx);
	
		
}
