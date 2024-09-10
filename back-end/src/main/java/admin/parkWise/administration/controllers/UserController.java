package admin.parkWise.administration.controllers;

import admin.parkWise.administration.models.User;
import admin.parkWise.administration.entities.UserRepo;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;

@RestController
@RequestMapping("/users")
public class UserController extends AbstractController<User, UserRepo>{
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
}
