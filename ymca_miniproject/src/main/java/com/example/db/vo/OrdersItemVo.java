package com.example.db.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("orders_item")
public class OrdersItemVo {
//=========== 주문 아이템 정보 ============
	int				orders_item_idx;			// pk

	int				orders_idx;				// fk: orders(orders_idx)
	int				item_idx;				// fk: item(item_idx)
	int				orders_item_quantity;
	int				orders_price_at; 		// 주문시점 단가
}