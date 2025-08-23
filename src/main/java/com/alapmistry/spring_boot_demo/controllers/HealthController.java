package com.alapmistry.spring_boot_demo.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class HealthController {

    @GetMapping("/health")
    public String healthCheck() {
        return "OK";
    }

    @GetMapping("/redirect")
    public ModelAndView redirect(@RequestParam("url") String url) {
        String view = "redirect:" + url;
        return new ModelAndView(view);
    }
}
