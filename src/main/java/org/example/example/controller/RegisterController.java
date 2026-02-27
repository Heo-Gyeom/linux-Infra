package org.example.example.controller;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@ComponentScan(basePackages = {"org.example.example", "org.example.example.controller"})  // 명시적 추가
public class RegisterController {

    @GetMapping("/register")
    public String showRegisterForm() {
        return "register";
    }

    @GetMapping("/")
    public String home() {
        return "redirect:/register";
    }
}
