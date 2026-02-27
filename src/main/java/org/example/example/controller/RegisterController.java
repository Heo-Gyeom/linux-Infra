package org.example.example.controller;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RegisterController {

    @GetMapping("/register")
    public String showRegisterForm() {
        return "register";  // JSP 대신 문자열 반환 테스트
    }

    @GetMapping("/")
    public String home() {
        return "redirect:/register";
    }
}
