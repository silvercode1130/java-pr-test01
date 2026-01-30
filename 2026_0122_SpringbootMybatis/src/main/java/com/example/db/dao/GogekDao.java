package com.example.db.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.db.vo.GogekVo;

@Mapper
public interface GogekDao {
	// GogekVo를 요소로 하는 List를 리턴하는 메서드여야 한다는 인터페이스
	List<GogekVo> selectList();
}
