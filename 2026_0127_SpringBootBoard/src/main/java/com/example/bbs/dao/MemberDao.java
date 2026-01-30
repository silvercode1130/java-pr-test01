package com.example.bbs.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.bbs.vo.MemberVo;

@Mapper
public interface MemberDao {

	List<MemberVo>	selectList();
	MemberVo		selectOneFromIdx(int mem_idx);
	MemberVo		selectOneFromId(String mem_id);
	int				insert(MemberVo vo);
	int				update(MemberVo vo);
	int				delete(int mem_idx);
	
}
