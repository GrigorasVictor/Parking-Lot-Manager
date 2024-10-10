package admin.parkWise.administration.repository;

import admin.parkWise.administration.models.SubscriptionTemplate;
import jakarta.persistence.criteria.CriteriaBuilder;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SubscriptionTemplateRepo extends JpaRepository<SubscriptionTemplate, Integer> {

}
