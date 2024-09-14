package admin.parkWise.administration.controllers;

import admin.parkWise.administration.models.UserSubscription;
import admin.parkWise.administration.repository.SubscriptionRepo;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/userSubscriptions")
public class SubscriptionController extends AbstractController<UserSubscription, SubscriptionRepo>{

}
