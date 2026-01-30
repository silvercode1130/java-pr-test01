package com.example.db.vo;

import java.time.LocalDateTime;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("reply")
public class ReplyVo {
//=========== 댓글 ============
	int				reply_idx;		// pk

	int				board_idx;		// fk: board(board_idx)
	int				mem_idx;		// fk: member(mem_idx)
	String			reply_content;
	String			reply_ip;
	LocalDateTime	reply_regdate;
	LocalDateTime	reply_moddate;
}
