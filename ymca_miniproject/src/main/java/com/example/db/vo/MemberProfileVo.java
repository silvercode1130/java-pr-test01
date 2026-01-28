package com.example.db.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("member_profile")
public class MemberProfileVo {
//=========== 회원 프로필 ============
	int				mem_idx;		// pk

	String			mem_nickname;
	String			mem_intro;
	String			mem_img;
}
