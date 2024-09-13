package admin.parkWise.administration.config;

import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

public class SecurityConfig {
    private static final int NUMBER_OF_HASHES = 5;
    private static BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(NUMBER_OF_HASHES);

    // Method to encrypt the password
    public static String encrypt(String password) {
        return encoder.encode(password);
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .csrf(AbstractHttpConfigurer::disable)  // Disable CSRF protection
                .authorizeHttpRequests(authorize -> authorize
                        .requestMatchers("/auth/login", "/auth/signup").permitAll()  // Public endpoints
                        .anyRequest().authenticated()  // Protect all other endpoints
                )
                .formLogin(AbstractHttpConfigurer::disable);  // Disable form login

        return http.build();
    }
}
