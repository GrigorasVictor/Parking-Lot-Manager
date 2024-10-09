package admin.parkWise.administration.controllers;

import admin.parkWise.administration.models.User;
import admin.parkWise.administration.repository.UserRepo;
import admin.parkWise.administration.services.JwtService;
import io.jsonwebtoken.Jwts;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
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
    public ResponseEntity<String> handleFileUpload(HttpServletRequest req, @RequestParam("photo") MultipartFile photo, HttpServletRequest servletRequest) {

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

        Optional<String> token = JwtService.getToken(req);

        if(token.isEmpty()) return new ResponseEntity<>("Missing token!", HttpStatus.BAD_REQUEST);
        Integer userId = JwtService.staticExtractId(token.get());

        Optional<User> optUser = repo.findById(userId);
        if(optUser.isEmpty()) return new ResponseEntity<>("Missing user!", HttpStatus.BAD_REQUEST);
        User user = optUser.get();

        user.setImage(filePath);

        repo.save(user);

        return new ResponseEntity<>("{ \"msg\" : \"Photo received\"}", HttpStatus.OK);
    }

    @GetMapping()
    public ResponseEntity<User> getUserByJWToken(HttpServletRequest req){
        Optional<String> token = JwtService.getToken(req);
        if(token.isEmpty()){
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }

        Integer id = JwtService.staticExtractId(token.get());

        Optional<User> optUser = repo.findById(id);
        return optUser.map(user -> new ResponseEntity<>(user, HttpStatus.OK)).orElseGet(() -> new ResponseEntity<>(HttpStatus.BAD_REQUEST));

    }
}
