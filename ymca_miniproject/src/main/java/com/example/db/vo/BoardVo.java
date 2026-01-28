package com.example.db.vo;

import java.time.LocalDateTime;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("board")
public class BoardVo {
//=========== 게시판 ============
	int				board_idx;		// pk

	int				mem_idx;		// fk: member(mem_idx)
	String			board_title;
	String			board_content;
	String			board_ip;
	int				board_type_idx;		// fk: board_type(board_type_idx)
	LocalDateTime	board_regdate;
	LocalDateTime	board_moddate;
}
