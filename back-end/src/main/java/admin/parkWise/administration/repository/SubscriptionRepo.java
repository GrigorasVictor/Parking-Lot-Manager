package admin.parkWise.administration.repository;

import admin.parkWise.administration.model.UserSubscription;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource
public interface SubscriptionRepo extends JpaRepository<UserSubscription, Integer>{
}
