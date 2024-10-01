package admin.parkWise.administration.controllers;

import admin.parkWise.administration.models.UserAuth;
import admin.parkWise.administration.services.JwtService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@RestController
public class CookieTester {

    @PostMapping("/send")
    public ResponseEntity<String> sendCookie(HttpServletRequest request, HttpServletResponse response){

        Optional<String> mToken = JwtService.getToken(request);

        if(mToken.isEmpty()){
            String token = "doar_acum_e_succ";
            response.addCookie(new Cookie("jwToken", token));

            System.out.println("nu avea cookie");

            return new ResponseEntity<String>(token, HttpStatus.OK);
        }

        System.out.println("am ajuns aici");

        String token = mToken.get();
        System.out.println(token);

        return new ResponseEntity<>(HttpStatus.OK);
    }

//    @PostMapping("/get")
//    public String getCookie(HttpServletResponse response){
//        String token = "successful";
//
//        response.addCookie(new Cookie("jwToken", token));
//
//        return token;
//    }

}
