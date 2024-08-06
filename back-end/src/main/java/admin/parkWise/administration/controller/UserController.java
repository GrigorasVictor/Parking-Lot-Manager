package admin.parkWise.administration.controller;

import admin.parkWise.administration.model.User;
import admin.parkWise.administration.repository.UserRepo;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/users")
public class UserController extends AbstractController<User, UserRepo>{

}
