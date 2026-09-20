package com.example.facebook.controller;

import com.example.facebook.dto.response.UserResponse;
import com.example.facebook.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/users")
public class UserController {
    @Autowired
    private UserService userService;

    @GetMapping("/me")
    public ResponseEntity<UserResponse> getMyProfile(Authentication authentication){
        String email = authentication.getName();
        UserResponse response = userService.getMyProfile(email);
        return ResponseEntity.ok(response);
    }
}
