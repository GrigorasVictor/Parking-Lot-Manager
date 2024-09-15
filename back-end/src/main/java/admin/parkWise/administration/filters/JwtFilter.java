package admin.parkWise.administration.filters;

import admin.parkWise.administration.models.UserAuth;
import admin.parkWise.administration.repository.UserAuthRepo;
import admin.parkWise.administration.services.JwtService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.Optional;

@Component
public class JwtFilter extends OncePerRequestFilter {
    @Autowired
    private JwtService jwtService;
    @Autowired
    UserAuthRepo authRepo;
    @Autowired
    private ApplicationContext context;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        if(request.getRequestURL().toString().endsWith("/login") ||
                request.getRequestURL().toString().endsWith("/register")) {
            filterChain.doFilter(request, response);
            return;
        }

        System.out.println("do internal filtrer");

        Optional<String> optToken = JwtService.getToken(request);
        String token = null;

        Integer userId = null;
        String userEmail = null;

        if (optToken.isEmpty()) {
            //TODO: maybe throw an error or smth
            filterChain.doFilter(request, response);
            System.out.println("null");
            return;
        } else {
            token = optToken.get();
            System.out.println(token);

            userId = jwtService.extractId(token);
            userEmail = jwtService.extractEmail(token);
        }

        if ((userEmail != null) &&
                SecurityContextHolder.getContext().getAuthentication() == null) {

//            UserDetails counterData = context.getBean(UserAuth.class).;
            UserDetails counterData = authRepo.findByEmail(userEmail);
            System.out.println(counterData);

            if (jwtService.validateToken(token, counterData)) {
                UsernamePasswordAuthenticationToken basicAuthToken =
                        new UsernamePasswordAuthenticationToken(counterData, null, counterData.getAuthorities());
                basicAuthToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                SecurityContextHolder.getContext().setAuthentication(basicAuthToken);
                /*
                    MAKES NO SENSE!
                    WTF IS EVEN HAPPENING HERE??
                 */

            } else {
                //TODO: maybe throw some error
            }
        }

        filterChain.doFilter(request, response);
    }
}
