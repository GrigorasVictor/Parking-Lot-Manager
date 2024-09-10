package admin.parkWise.administration.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .csrf(AbstractHttpConfigurer::disable)// Use basic authentication (or formLogin() for form-based auth)
                .authorizeHttpRequests(authorizeRequests ->
                        authorizeRequests
                        .requestMatchers("*").permitAll()  // Public routes
                        .anyRequest().authenticated()  // All other routes require authentication
                );

        return http.build();
    }
}
