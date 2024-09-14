package admin.parkWise.administration.repository;

import admin.parkWise.administration.models.TransactionRecord;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TransactionRecordRepo extends JpaRepository<TransactionRecord, Integer> {
}
