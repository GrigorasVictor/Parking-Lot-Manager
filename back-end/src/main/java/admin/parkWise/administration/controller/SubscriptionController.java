package admin.parkWise.administration.controller;

import admin.parkWise.administration.model.UserSubscription;
import admin.parkWise.administration.repository.SubscriptionRepo;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/userSubscriptions")
public class SubscriptionController extends AbstractController<UserSubscription, SubscriptionRepo>{

}
