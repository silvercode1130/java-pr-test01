package com.example.bbs.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.bbs.vo.CommentVo;

@Mapper
public interface CommentDao {

	List<CommentVo>		selectList(int b_idx);
	List<CommentVo>		selectPageList(Map<String, Object> map);
	CommentVo			selectOne(int cmt_idx);
	
	int					insert(CommentVo vo);
	int					update(CommentVo vo);
	int					delete(int cmt_idx);
	
}
