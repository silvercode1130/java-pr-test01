package com.example.db.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.db.vo.DeptVo;

@Mapper
public interface DeptDao {
	List<DeptVo> selectList();
}
