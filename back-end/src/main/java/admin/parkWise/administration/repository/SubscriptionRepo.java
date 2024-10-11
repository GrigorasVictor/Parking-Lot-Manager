package admin.parkWise.administration.repository;

import admin.parkWise.administration.models.UserSubscription;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import java.time.LocalDate;

@RepositoryRestResource
public interface SubscriptionRepo extends JpaRepository<UserSubscription, Integer>{
    void deleteByEndDateLessThan(LocalDate dateTime);
}
