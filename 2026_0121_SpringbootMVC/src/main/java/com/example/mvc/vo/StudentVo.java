package com.example.mvc.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StudentVo {
	
	String	name;
	int		age;
	String	gender;
	String	ip;
	int		seat_no;
	
}
