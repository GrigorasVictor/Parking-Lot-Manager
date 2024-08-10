package admin.parkWise.administration.repository;

import admin.parkWise.administration.model.User;
import admin.parkWise.administration.model.VehicleRegistration;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface VehicleRegistrationRepo extends JpaRepository<VehicleRegistration, Integer> {
//    List<VehicleRegistration> findByUserId(User userId);
}
