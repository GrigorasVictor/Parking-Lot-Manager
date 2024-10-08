package admin.parkWise.administration.controllers;

import admin.parkWise.administration.models.UserSubscription;
import admin.parkWise.administration.repository.SubscriptionRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/userSubscriptions")
public class SubscriptionController extends AbstractController<UserSubscription, SubscriptionRepo>{
}
