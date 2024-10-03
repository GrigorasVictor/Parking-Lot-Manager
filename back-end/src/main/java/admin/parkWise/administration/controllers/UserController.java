package admin.parkWise.administration.controllers;

import admin.parkWise.administration.models.User;
import admin.parkWise.administration.repository.UserRepo;
import admin.parkWise.administration.services.JwtService;
import io.jsonwebtoken.Jwts;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.server.Cookie;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.Optional;

@RestController
@RequestMapping("/users")
public class
UserController{
    @Autowired
    UserRepo repo;

    @PostMapping("/upload-photo")
    public ResponseEntity<String> handleFileUpload(@RequestParam("photo") MultipartFile photo, HttpServletRequest servletRequest) {

        if(photo.isEmpty()) return new ResponseEntity<>("Photo empty", HttpStatus.BAD_REQUEST);

        String uploadsDir = "/uploads/";
        String realPathToUploads = servletRequest.getServletContext().getRealPath(uploadsDir);
        if(! new File(realPathToUploads).exists()) {
            new File(realPathToUploads).mkdir();
        }

        System.out.println("realPathToUploads = { " + realPathToUploads + "}");


        String orgName = photo.getOriginalFilename();
        String filePath = realPathToUploads + orgName;
        File dest = new File(filePath);
        try {
            photo.transferTo(dest);
        } catch (Exception e) {
            e.printStackTrace();
        }


        return new ResponseEntity<>("Photo received", HttpStatus.OK);
    }

    @GetMapping()
    public ResponseEntity<User> getUserByJWToken(HttpServletRequest req){
        Optional<String> token = JwtService.getToken(req);
        if(token.isEmpty()){
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
        //maybe structure code better?
        Integer id = Jwts.parser()
                .verifyWith(JwtService.getKey())
                .build()
                .parseSignedClaims(token.get())
                .getPayload().get("id", Number.class).intValue();

        Optional<User> optUser = repo.findById(id);
        return optUser.map(user -> new ResponseEntity<>(user, HttpStatus.OK)).orElseGet(() -> new ResponseEntity<>(HttpStatus.BAD_REQUEST));

    }
}
