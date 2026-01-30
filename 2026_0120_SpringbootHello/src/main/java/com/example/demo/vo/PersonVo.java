package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// @Getter @Setter	// 주석처리하면 getter setter 없어짐 -> HomeController 에러
// @Data = @Getter + @Setter + @toString()
 @Data
 @AllArgsConstructor	// 풀생성자 -> 기본생성자 없이 기본생성자 호출시 에러
 @NoArgsConstructor		// 기본생성자 (그 외 오버로딩 생성자는 수동으로 만드세요)
public class PersonVo {
	String	name;
	int		age;
	String	tel;
	
}
