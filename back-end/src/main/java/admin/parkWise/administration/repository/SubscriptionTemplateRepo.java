package admin.parkWise.administration.repository;

import admin.parkWise.administration.models.SubscriptionTemplate;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;

public interface SubscriptionTemplateRepo extends JpaRepository<SubscriptionTemplate, Integer> {
}
