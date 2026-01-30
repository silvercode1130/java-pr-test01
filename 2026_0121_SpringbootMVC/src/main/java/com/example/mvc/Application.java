package com.example.mvc;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

//#####[ 서비스, 컨트롤러, 환경설정 ]#######
// basePackage 지정된 패키지 포함 하위패키지까지 적용
// 하위 옵션 생략하면 기본패키지(com.example.mvc) 탐색
@ComponentScan(basePackages = {
	"com.example.mvc",
	"controller"
})
// 베이스 패키지를 벗어난 영역에 폴더를 만들었다면 반드시 환경설정에 해당 경로를 포함시켜줄 것
// 경로 포함시킬 때 , 빼먹지 말기

@SpringBootApplication
public class Application {

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}

}
