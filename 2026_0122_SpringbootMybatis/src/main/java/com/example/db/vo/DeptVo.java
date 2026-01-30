package com.example.db.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("dept")
public class DeptVo {
	int deptno;
	String dname;
	String loc;
}
