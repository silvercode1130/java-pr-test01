package com.example.db.vo;

import java.time.LocalDateTime;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("member")
public class MemberVo {
//=========== 회원정보 ============
	int				mem_idx;		// pk

	String			mem_id;			// unique
	String			mem_pwd;
	String			mem_name;
	String			mem_tel;
	String			mem_email;
	int				mem_role_idx;	// fk: role(role_idx)
	int				mem_grade_idx;	// fk: grade(grade_idx)
	String			mem_bday;
	LocalDateTime	mem_regdate;
}
