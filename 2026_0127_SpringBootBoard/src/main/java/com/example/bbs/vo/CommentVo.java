package com.example.bbs.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("comment")
public class CommentVo {

	int    cmt_idx;
	String cmt_content;
	String cmt_ip;
	String cmt_regdate;
	int    b_idx;
	int    mem_idx;
	String mem_name;
	
}
