package admin.parkWise.administration.services;

import admin.parkWise.administration.models.UserAuth;
import admin.parkWise.administration.repository.UserAuthRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserAuthDBService {
    @Autowired
    UserAuthRepo authRepo;
    @Autowired
    AuthenticationManager authManager;

    private BCryptPasswordEncoder bCryptEncoder = new BCryptPasswordEncoder(10);

    public void register(UserAuth userAuth) throws Exception {
        ValidatorsService.validate(userAuth);
        userAuth.setPassword(bCryptEncoder.encode(userAuth.getPassword()));
        authRepo.save(userAuth);
    }

    public String verify(UserAuth authData) {
        Authentication authentication = authManager.authenticate(new UsernamePasswordAuthenticationToken(authData.getUsername(), authData.getPassword()));
        UserAuth authDataWithId = authRepo.findByEmail(authData.getEmail());

        System.out.println(authDataWithId);

        if(authentication.isAuthenticated())
            return JwtService.genToken(authDataWithId);
        return "failed";
    }
}
