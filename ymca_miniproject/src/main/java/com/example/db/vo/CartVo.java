package com.example.db.vo;

import java.time.LocalDateTime;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("cart")
public class CartVo {
//=========== 장바구니 ============
	int				cart_idx;		// pk

	int				mem_idx;		// fk: member(mem_idx)
	LocalDateTime	cart_regdate;
}
