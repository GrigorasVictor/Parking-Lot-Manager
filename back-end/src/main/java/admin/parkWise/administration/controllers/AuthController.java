package admin.parkWise.administration.controllers;

import admin.parkWise.administration.models.UserAuth;
import admin.parkWise.administration.services.UserAuthDBService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.sql.PreparedStatement;

@RestController
public class AuthController {
    @Autowired
    UserAuthDBService authDBService;

    @PostMapping("/register")
    public ResponseEntity<String> signup(@RequestBody UserAuth authData){
        authDBService.register(authData);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PostMapping("/login")
    public String login(HttpServletResponse response, @RequestBody UserAuth authData){
        String token = authDBService.verify(authData);

        response.addCookie(new Cookie("jwToken", token));

        return token;
    }
}
