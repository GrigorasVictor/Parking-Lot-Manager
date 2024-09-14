package admin.parkWise.administration.services;

import admin.parkWise.administration.models.UserAuth;
import admin.parkWise.administration.repository.UserAuthRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;

@Service
public class UserAuthDetailsService implements UserDetailsService {
    @Autowired
    private UserAuthRepo authRepo;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserAuth userAuthData = authRepo.findByEmail(username);

        if(userAuthData == null) {
            System.out.println("User not found!");
            throw new UsernameNotFoundException("user not found");
        }

        return userAuthData;
    }
}
