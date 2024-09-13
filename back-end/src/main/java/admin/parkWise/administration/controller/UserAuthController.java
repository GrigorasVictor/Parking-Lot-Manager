package admin.parkWise.administration.controller;

import admin.parkWise.administration.config.SecurityConfig;
import admin.parkWise.administration.dto.LoginDto;
import admin.parkWise.administration.dto.SigninDto;
import admin.parkWise.administration.model.UserAuth;
import admin.parkWise.administration.repository.UserAuthRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/auth")
public class UserAuthController {

    @Autowired
    UserAuthRepo userAuthRepo;

    @PostMapping("/login")
    public ResponseEntity<String> logIn(@RequestBody LoginDto newEntry) {
        System.out.println(newEntry);
        if(newEntry.getPassword().isEmpty() || newEntry.getEmail().isEmpty())
            return new ResponseEntity<>("You must fill the credentials",HttpStatus.NOT_FOUND);

        Optional<UserAuth> temp = userAuthRepo.findByEmail(newEntry.getEmail());
        if(!(temp.isPresent() && temp.get().getPassword().equals(SecurityConfig.encrypt(newEntry.getPassword()))))
            return new ResponseEntity<>("Email/Password incorrect",HttpStatus.NOT_ACCEPTABLE);

        return new ResponseEntity<>("Login Successfully",HttpStatus.ACCEPTED);
    }

    @PostMapping("/signUp")
    public ResponseEntity<String> signIn(@RequestBody SigninDto newEntry) {
        System.out.println(newEntry);
        if(newEntry.getPassword().isEmpty() || newEntry.getEmail().isEmpty())
            return new ResponseEntity<>("You must fill the credentials",HttpStatus.BAD_REQUEST);

        Optional<UserAuth> temp = userAuthRepo.findByEmail(newEntry.getEmail());
        if(temp.isPresent())
            return new ResponseEntity<>("Email/Password incorrect",HttpStatus.NOT_ACCEPTABLE);

        UserAuth userAuth = new UserAuth(0, newEntry.getEmail(), SecurityConfig.encrypt(newEntry.getPassword()), null, null);
        return new ResponseEntity<>("Signup  Successfully", HttpStatus.OK);
    }
}
