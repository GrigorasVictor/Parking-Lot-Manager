package admin.parkWise.administration.controllers;

import admin.parkWise.administration.models.User;
import admin.parkWise.administration.repository.UserRepo;
import admin.parkWise.administration.services.AwsStorageService;
import admin.parkWise.administration.services.JwtService;
import admin.parkWise.administration.services.SHAService;
import io.jsonwebtoken.Jwts;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.servlet.http.HttpServletRequest;
import org.apache.tomcat.util.file.ConfigurationSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.server.Cookie;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Optional;

@RestController
@RequestMapping("/users")
public class
UserController{
    @Autowired
    UserRepo repo;

    @Autowired
    AwsStorageService awsStorageService;

    /*@PostMapping("/upload-photo")
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
    }*/
    @PostMapping("/upload-photo")
    public ResponseEntity<String> handleFileUpload(HttpServletRequest req, @RequestParam("photo") MultipartFile photo) {
        if (photo.isEmpty()) return new ResponseEntity<>("Photo empty", HttpStatus.BAD_REQUEST);

        Optional<String> token = JwtService.getToken(req);

        if (token.isEmpty()) return new ResponseEntity<>("Missing token!", HttpStatus.BAD_REQUEST);
        Integer userId = JwtService.staticExtractId(token.get());

        Optional<User> optUser = repo.findById(userId);
        if (optUser.isEmpty()) return new ResponseEntity<>("Missing user!", HttpStatus.BAD_REQUEST);
        User user = optUser.get();

        String imageHashed = SHAService.SHA256(userId.toString());
        awsStorageService.uploadFile(photo, imageHashed);

        String ipfsUrl = "http://localhost:8080/users/image/" + imageHashed;
        user.setImage(ipfsUrl);
        repo.save(user);
        System.out.println(user);
        return new ResponseEntity<>("{ \"msg\" : \"Photo received\", \"url\": \"" + ipfsUrl + "\" }", HttpStatus.OK);
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

    @GetMapping("/image/{imageName}")
    public ResponseEntity<byte[]> getImage(@PathVariable String imageName) throws Exception {
        byte[] imageBytes = awsStorageService.getImage(imageName);

        // Build the HTTP response with the image bytes and appropriate content type
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_PNG); // Set appropriate content type
        headers.setContentLength(imageBytes.length);

        return new ResponseEntity<>(
                imageBytes,
                headers, HttpStatus.OK);
    }
}
