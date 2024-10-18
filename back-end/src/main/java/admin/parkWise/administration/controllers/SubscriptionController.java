package admin.parkWise.administration.controllers;

import admin.parkWise.administration.models.UserSubscription;
import admin.parkWise.administration.repository.SubscriptionRepo;

import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDate;

@RestController
@RequestMapping("/userSubscriptions")
public class SubscriptionController extends AbstractController<UserSubscription, SubscriptionRepo>{
    @Autowired
    SubscriptionRepo subsRepo;
    @DeleteMapping("/delete-old-entries")
    @Transactional
    void deleteOldEntries(){
        subsRepo.deleteByEndDateLessThan(LocalDate.now());
    }
}
