package admin.parkWise.administration.services;

import admin.parkWise.administration.models.UserSubscription;
import admin.parkWise.administration.repository.SubscriptionRepo;
import admin.parkWise.administration.repository.SubscriptionTemplateRepo;
import jakarta.transaction.Transactional;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.sql.SQLOutput;
import java.time.LocalDate;

@Component
public class SubscriptionCleanupService {
    private static final int CLEAN_UP_RATE = 86400;

    @Autowired
    SubscriptionRepo subscriptionRepo;

    @Scheduled(fixedRate = CLEAN_UP_RATE)
    @Transactional
    public void expiredSubscriptionCleanup(){
        System.out.println("Ran subscription clean-up duty.");
        LocalDate curTime = LocalDate.now();
        subscriptionRepo.deleteByEndDateLessThan(curTime);
    }
}
