package com.example.db.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("gogek")
public class GogekVo {
	int gobun;
	String goname;
	String goaddr;
	String gojumin;
	int godam;
}
