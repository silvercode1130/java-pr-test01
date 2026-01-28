package com.example.db.vo;

import java.math.BigDecimal;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("grade")
public class GradeVo {
//=========== 등급 ============
	int				grade_idx;				// pk

	String			grade_name;				// basic / silver / gold / vip
	BigDecimal 		grade_discount_rate;	// 등급별 할인율 (0.05 / 0.1 / 0.2)

}
