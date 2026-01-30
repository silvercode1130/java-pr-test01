package com.example.db.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("role")
public class RoleVo {
//=========== 역할 ============
	int				role_idx;		// pk

	String			role_name;		// user / doctor / admin
}
