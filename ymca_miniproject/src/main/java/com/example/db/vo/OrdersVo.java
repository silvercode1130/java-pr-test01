package com.example.db.vo;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("orders")
public class OrdersVo {
//=========== 주문정보 ============
	int				orders_idx;				// pk

	int				mem_idx;				// fk: member(mem_idx)
	int				orders_total_price;
	BigDecimal 		orders_grade_discount;	// 등급할인액
	BigDecimal 		orders_coupon_discount;	// 쿠폰할인액
	int				orders_status_idx;		// fk: orders_status(orders_status_idx)
	LocalDateTime	orders_regdate;
}