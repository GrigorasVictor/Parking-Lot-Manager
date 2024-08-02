package admin.parkWise.administration.repository;

import admin.parkWise.administration.model.ParkingRecord;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ParkingRecordsRepo extends JpaRepository<ParkingRecord, Integer> {
}
