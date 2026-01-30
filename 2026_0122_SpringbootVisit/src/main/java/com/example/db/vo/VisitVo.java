package com.example.db.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("visit")
public class VisitVo {
	int		idx;
	String	name;
	String	content;
	String	pwd;
	String	ip;
	String	regdate;
	String	modifydate;
}
