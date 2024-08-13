package admin.parkWise.administration.controller;

import admin.parkWise.administration.model.User;
import admin.parkWise.administration.repository.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.Optional;

@RestController
@RequestMapping("/users")
public class UserController extends AbstractController<User, UserRepo>{
    @Autowired
    UserRepo repo;
    @GetMapping("/{id}/name")
    public ResponseEntity<String> getName(@PathVariable Integer id){
        Optional<User> userOpt = repo.findById(id);

        if (userOpt.isEmpty()) {
            return new ResponseEntity<>("User not found", HttpStatus.NOT_FOUND);
        }
        String surname = Arrays.stream(userOpt.get().getFullName().trim().split("\\s+"))
                                    .reduce((first, second) -> second)
                                    .orElse("");
        return new ResponseEntity<>(surname, HttpStatus.OK);
    }
}
