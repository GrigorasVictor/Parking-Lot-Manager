package admin.parkWise.administration.controllers;

import admin.parkWise.administration.models.UserSubscription;
import admin.parkWise.administration.entities.SubscriptionRepo;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/userSubscriptions")
public class SubscriptionController extends AbstractController<UserSubscription, SubscriptionRepo>{

}
