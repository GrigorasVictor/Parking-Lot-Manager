package admin.parkWise.administration.controller;

import admin.parkWise.administration.model.User;
import admin.parkWise.administration.repository.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/users")
public class UserController {

    @Autowired
    UserRepo repo;

    @PostMapping("/addUser")
    public void addUser(@RequestBody User user){
        System.out.println(user);
        repo.save(user);
    }

    @DeleteMapping("/delete/{id}")
    public void deleteUser(@PathVariable Integer id){
        repo.deleteById(id);
    }

    @GetMapping("/getUsers")
    public List<User> getAllUsers(){
        return repo.findAll();
    }

    @GetMapping("/getUser/{id}")
    public Optional<User> getUser(@PathVariable Integer id){
        System.out.println(id);
        return repo.findById(id);
    }
}
