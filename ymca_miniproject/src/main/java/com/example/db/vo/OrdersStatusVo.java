package com.example.db.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("orders_status")
public class OrdersStatusVo {
//=========== 주문상태 ============
	int				orders_status_idx;		// pk
	String			orders_status_name;		// 주문상태 (결제됨 / 취소됨 / 배송중 등)
}
