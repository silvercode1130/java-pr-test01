package com.example.db.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

// @Data = getter + setter + toString()
@Data
@Alias("sawon")
// alias : 가명
// sawon.xml 에서 resultType="com.example.db.vo.SawonVo" -> "sawon" 으로 쓸 수 있음
public class SawonVo {
	 int sabun;
	 String saname;
	 String sagender;
	 int deptno;
	 String sajob;
	 String sahire;
	 int samgr;
	 int sapay;

}
