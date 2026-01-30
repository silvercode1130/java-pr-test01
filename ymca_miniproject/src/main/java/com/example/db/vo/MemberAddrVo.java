package com.example.db.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("member_addr")
public class MemberAddrVo {
//=========== 회원 주소 ============
	int				addr_idx;		// pk

	int				mem_idx;		// fk: member(mem_idx)
	String			mem_zipcode;
	String			mem_addr;
	String			mem_addr_detail;
}
