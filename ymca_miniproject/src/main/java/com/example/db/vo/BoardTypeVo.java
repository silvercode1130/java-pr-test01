package com.example.db.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("board_type")
public class BoardTypeVo {
//=========== 게시판 타입 ============
	int				board_type_idx;		// pk
	
	String			board_type_code;
	String			board_type_name;
	String			board_can_comment;	// 댓글여부 (y/n)
	int				board_min_role;		// 쓰기권한. role
}