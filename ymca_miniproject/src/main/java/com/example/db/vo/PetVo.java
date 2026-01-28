package com.example.db.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("pet")
public class PetVo {
//=========== 반려동물정보 ============
	int				pet_idx;		// pk

	int				mem_idx;		// fk: member(mem_idx)
	String			pet_name;
	String			is_primary;		// 대표동물여부 (y/n)
	String			pet_species;
	String			pet_gender;
	String			pet_breed;
	int				pet_age;
	String			pet_bday;
}

