package admin.parkWise.administration.repository;

import admin.parkWise.administration.models.VehicleRegistration;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VehicleRegistrationRepo extends JpaRepository<VehicleRegistration, Integer> {
//    List<VehicleRegistration> findByUserId(User userId);
}
