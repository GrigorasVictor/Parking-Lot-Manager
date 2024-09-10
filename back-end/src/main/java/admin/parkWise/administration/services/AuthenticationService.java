package admin.parkWise.administration.services;

import admin.parkWise.administration.dtos.LoginUserAuthDto;
import admin.parkWise.administration.dtos.RegisterUserAuthDto;
import admin.parkWise.administration.entities.UserAuthRepo;
import admin.parkWise.administration.models.UserAuth;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AuthenticationService {
    private final UserAuthRepo userAuthRepo;

    private final PasswordEncoder passwordEncoder;

    private final AuthenticationManager authenticationManager;

    public AuthenticationService(
            UserAuthRepo userAuthRepo,
            AuthenticationManager authenticationManager,
            PasswordEncoder passwordEncoder
    ) {
        this.authenticationManager = authenticationManager;
        this.userAuthRepo = userAuthRepo;
        this.passwordEncoder = passwordEncoder;
    }

    public UserAuth signup(RegisterUserAuthDto input) {
        System.out.println("wow");
        UserAuth user = new UserAuth()
                .setEmail(input.getEmail())
                .setPassword(passwordEncoder.encode(input.getPassword()));

        return userAuthRepo.save(user);
    }

    public UserAuth authenticate(LoginUserAuthDto input) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        input.getEmail(),
                        input.getPassword()
                )
        );

        return userAuthRepo.findByEmail(input.getEmail())
                .orElseThrow();
    }
}
