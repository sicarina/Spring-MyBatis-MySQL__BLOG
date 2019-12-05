package com.example.blog.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeCtr {

	@GetMapping("")
	public String homePathRedirect() {
		return "redirect:/board/list/1";
	}
	
	@GetMapping("/")
	public String homePathRedirect2() {
		return "redirect:/board/list/1";
	}
}
