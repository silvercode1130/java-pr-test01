package com.example.bbs.vo;

import java.time.LocalDateTime;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("board")
public class BoardVo {
	int				b_idx;
	String			b_subject;
	String			b_content;
	String			b_ip;
	int				b_readhit;
	LocalDateTime	b_regdate;
	LocalDateTime	b_moddate;
	int				mem_idx;
	String			mem_id;
	int				b_ref;
	int				b_step;
	int				b_depth;
	String			b_use;
	
}
