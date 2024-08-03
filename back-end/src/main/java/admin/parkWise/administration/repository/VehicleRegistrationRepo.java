package admin.parkWise.administration.repository;

import admin.parkWise.administration.model.VehicleRegistration;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VehicleRegistrationRepo extends JpaRepository<VehicleRegistration, Integer> {
}
