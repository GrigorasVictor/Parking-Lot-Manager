package admin.parkWise.administration.controller;

import admin.parkWise.administration.model.UserSubscription;
import admin.parkWise.administration.repository.SubscriptionRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/userSubcriptions")
public class SubscriptionController {
    @Autowired
    SubscriptionRepo repo;

    @PostMapping("/addSubscription")
    public void addSubscription(@RequestBody UserSubscription userSubs){
        System.out.println(userSubs);
        repo.save(userSubs);
    }

    @DeleteMapping("/delete/{id}")
    public void deleteSubscription(@PathVariable Integer id){
        repo.deleteById(id);
    }

    @GetMapping("/getSubscriptions")
    public List<UserSubscription> getAllSubscriptions(){
        return repo.findAll();
    }

    @GetMapping("/getSubscription/{id}")
    public Optional<UserSubscription> getSubscription(@PathVariable Integer id){
        System.out.println(id);
        return repo.findById(id);
    }
}
