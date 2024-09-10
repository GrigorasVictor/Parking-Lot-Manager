package admin.parkWise.administration.entities;

import admin.parkWise.administration.models.ParkingRecord;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ParkingRecordsRepo extends JpaRepository<ParkingRecord, Integer> {
}
