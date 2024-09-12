package admin.parkWise.administration.controller;

import admin.parkWise.administration.dto.LoginDto;
import admin.parkWise.administration.model.UserAuth;
import admin.parkWise.administration.repository.UserAuthRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
public class UserAuthController {

    @Autowired
    UserAuthRepo userAuthRepo;

    @PostMapping("/login")
    public ResponseEntity<String> logIn(@RequestBody LoginDto newEntry) {
        System.out.println(newEntry);

        return new ResponseEntity<>("Login Successfully",HttpStatus.OK);
    }

    @PostMapping("/signUp")
    public ResponseEntity<UserAuth> signIn(@RequestBody UserAuth newEntry) {
        System.out.println(newEntry);
        //UserAuth userAuth = new UserAuth(0, newEntry.getEmail(), newEntry.getPassword(), null, null);


        return new ResponseEntity<>(newEntry, HttpStatus.OK);
    }
}
