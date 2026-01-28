package controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TestController {
	public TestController() {
		System.out.println("--TestController()--");
		System.out.println("베이스 페키지를 벗어난 폴더는 생성되지 않음!");
		System.out.println("Application.java 에서 경로 포함시켜주기");
		// com.example.mvc.controller 외에 별도로 폴더를 만들면 컨트롤러 지정을 해줘도 실행이 안됨
	}
	
	@RequestMapping("/test.do")
	public String test(Model model) { 	// Model 은 인터페이스 : org.springframework.ui.Model
		
		String msg = "안녕";
		
		// model 통해서 데이터를 DS에 전달하면
		// DS는 해당 데이터를 requestScope 에 binding
		model.addAttribute("msg", msg);
		
		return "test";	// ViewName 을 DS 전달하면
						// DS -> ViewResolver 에게 앞/뒤 경로 붙이도록 지시
						// "/WEB-INF/views/" + "test"	+ ".jsp"
						// prefix			 + viewName	+ suffix
						// "/WEB-INF/views/test.jsp"
						// 완성된 경로로 forward 시킴
		
	}
	
	// View + DATA 하나로 묶어서 전달하는 방법
	@RequestMapping("/test2.do")
	public ModelAndView test2() {
		
		String msg = "<h2>아~~~ 잠이온다</h2>";
		String [] fruit_arr = {"수박", "참외", "포도", "딸기", "귤", "사과"};
		
		ModelAndView mv = new ModelAndView();
		
		// data -> 결과적으로 request binding
		mv.addObject("msg", msg);
		mv.addObject("fruit_arr", fruit_arr);
		
		// view -> /WEB-INF/views/test2.jsp forward 시킴
		mv.setViewName("test2");
		
		return mv;
	}
	
	@RequestMapping("/test3.do")
	@ResponseBody	// return 값을 그냥 반환 (View 사용하지 말 것)
	public String test3() {
		
		return "나는 그냥 반환해줘";
	}
}
