package admin.parkWise.administration.controllers;

import admin.parkWise.administration.dtos.LoginResponse;
import admin.parkWise.administration.dtos.LoginUserAuthDto;
import admin.parkWise.administration.dtos.RegisterUserAuthDto;
import admin.parkWise.administration.models.UserAuth;
import admin.parkWise.administration.services.AuthenticationService;
import admin.parkWise.administration.services.JwtService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/auth")
@RestController
public class AuthenticationController {
    private final JwtService jwtService;

    private final AuthenticationService authenticationService;

    public AuthenticationController(JwtService jwtService, AuthenticationService authenticationService) {
        this.jwtService = jwtService;
        this.authenticationService = authenticationService;
    }

    @PostMapping("/signup")
    public ResponseEntity<UserAuth> register(@RequestBody RegisterUserAuthDto registerUserDto) {
        UserAuth registeredUserAuth = authenticationService.signup(registerUserDto);

        return ResponseEntity.ok(registeredUserAuth);
    }

    @PostMapping("/login")
    public ResponseEntity<LoginResponse> authenticate(@RequestBody LoginUserAuthDto loginUserAuthDto) {
        UserAuth authenticatedUserAuth = authenticationService.authenticate(loginUserAuthDto);

        String jwtToken = jwtService.generateToken(authenticatedUserAuth);

        LoginResponse loginResponse = new LoginResponse().setToken(jwtToken).setExpiresIn(jwtService.getExpirationTime());

        return ResponseEntity.ok(loginResponse);
    }
}
