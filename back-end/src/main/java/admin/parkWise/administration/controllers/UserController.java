package admin.parkWise.administration.controllers;

import admin.parkWise.administration.models.User;
import admin.parkWise.administration.repository.UserRepo;
import admin.parkWise.administration.services.AwsStorageService;
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

        // Upload the photo and get the CID (implement this logic in your AwsStorageService)
        String cid = awsStorageService.uploadFile(photo);

        if (cid != null) {
            String ipfsUrl = "https://ipfs.filebase.io/ipfs/" + cid; // Construct IPFS Gateway URL
            user.setImage(ipfsUrl); // Save the IPFS URL in the user's image field
            repo.save(user);
            System.out.println(user);
            return new ResponseEntity<>("{ \"msg\" : \"Photo received\", \"url\": \"" + ipfsUrl + "\" }", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("{ \"msg\" : \"Photo is not received\" }", HttpStatus.NOT_ACCEPTABLE);
        }
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
