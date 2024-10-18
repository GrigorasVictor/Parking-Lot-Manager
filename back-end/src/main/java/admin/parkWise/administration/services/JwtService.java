package admin.parkWise.administration.services;

import admin.parkWise.administration.models.UserAuth;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import java.security.NoSuchAlgorithmException;
import java.util.*;

@Service
public class JwtService {

    private static String secretkey = "";

    public JwtService() {

        try {
            KeyGenerator keyGen = KeyGenerator.getInstance("HmacSHA256");
            SecretKey sk = keyGen.generateKey();
            secretkey = Base64.getEncoder().encodeToString(sk.getEncoded());
            System.out.println(secretkey);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    public static String genToken(UserAuth authData) {
        Map<String, Object> claims = new HashMap<>();
        claims.put("id", authData.getUserId());
        claims.put("email", authData.getEmail());

        return Jwts.builder()
                .claims()
                .add(claims)
                .issuedAt(new Date(System.currentTimeMillis()))
                .expiration(new Date(System.currentTimeMillis() + 10000 * 60 * 360))
                .and()
                .signWith(getKey())
                .compact();
    }

    public static SecretKey getKey() {
        byte[] keyBytes = Decoders.BASE64.decode(secretkey);
        return Keys.hmacShaKeyFor(keyBytes);
    }

    public static Optional<String> getToken(HttpServletRequest request){
        Cookie[] cookies = request.getCookies();
        if(cookies == null){
            return Optional.empty();
        }

        return Arrays.stream(cookies)
                .filter(cookie->cookie.getName().equals("jwToken"))
                .map(Cookie::getValue)
                .findAny();
    }

    public boolean validateToken(String token, UserDetails userDetails) {
        final String email = extractEmail(token);
        return (email.equals(userDetails.getUsername()) && !isTokenExpired(token));
    }

    public String extractEmail(String token) {
        return extractAllClaims(token).get("email", String.class); // Extracting email from claims
    }

    public Integer extractId(String token) {
        return extractAllClaims(token).get("id", Number.class).intValue(); // Extracting email from claims
    }

    private boolean isTokenExpired(String token) {
        return extractExpiration(token).before(new Date());
    }

    private Date extractExpiration(String token) {
        return extractAllClaims(token).getExpiration();
    }

    public Claims extractAllClaims(String token) {
        return Jwts.parser()
                .verifyWith(getKey())
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }

    public static Integer staticExtractId(String token){ // TODO: needs renaming
        return
                Jwts.parser()
                .verifyWith(getKey())
                .build()
                .parseSignedClaims(token)
                .getPayload()
                .get("id", Number.class)
                .intValue();
    }
}
