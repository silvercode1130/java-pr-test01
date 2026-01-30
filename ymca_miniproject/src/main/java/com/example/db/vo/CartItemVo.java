package com.example.db.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("cart_item")
public class CartItemVo {
//=========== 장바구니 아이템 ============
	int				cart_item_idx;	// pk

	int				cart_idx;		// fk: cart(cart_idx)
	int				item_idx;		// fk: item(item_idx)
	int				cart_item_quantity;
}
