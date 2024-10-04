package admin.parkWise.administration.repository;

import admin.parkWise.administration.models.ParkingLot;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ParkingLotRepo extends JpaRepository<ParkingLot, Integer> {
}
