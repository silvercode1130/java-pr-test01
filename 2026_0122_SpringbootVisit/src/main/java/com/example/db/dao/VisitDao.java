package com.example.db.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.db.vo.VisitVo;

@Mapper
public interface VisitDao {
	
//	List<VisitVo>	selectList(); 
	List<VisitVo>	selectConditionList(Map<String, Object> map);
					// 조건결과 데이터출력(검색데이터를 담은 map 인자로 함)
	VisitVo			selectOne(int idx);
	int				insert(VisitVo vo);
	int				update(VisitVo vo);
	int				delete(int idx);
}
