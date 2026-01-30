package com.example.db.vo;

import java.time.LocalDateTime;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("board_file")
public class BoardFileVo {
//=========== 게시글 첨부파일 ============
	int				file_idx;			// pk

	int				board_idx;			// fk: board(board_idx)
	String			file_original_name;	// 유저가 본래 저장한 파일 이름
	String			file_saved_name;	// 서버에서 중복을 피하기 위해 임의로 붙이는 이름
	String			file_path;
	int				file_size;			// 파일 용량 확인. db 관리에 필요
	String			file_type;			// jpeg, png 등의 확장자
	LocalDateTime	file_regdate;

}
