package admin.parkWise.administration.controller;

import admin.parkWise.administration.model.UserImage;
import admin.parkWise.administration.repository.UserImageRepo;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@RestController
@RequestMapping("/userImages")
public class UserImageController extends AbstractController<UserImage, UserImageRepo>{

    @Override
    public ResponseEntity<UserImage> add(UserImage newEntry) {
        return super.add(newEntry);
    }

    @Override
    public ResponseEntity<Optional<UserImage>> get(Integer id) {
        return super.get(id);
    }
}
