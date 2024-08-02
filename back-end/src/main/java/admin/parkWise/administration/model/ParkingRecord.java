package admin.parkWise.administration.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;
@Data
@Entity
@Table(name = "parking_records")
public class ParkingRecord {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "record_id")
    private int recordId;

    @Column(name = "user_id", nullable = false)
    @JsonProperty("user_id")
    private String userId;

    @Column(name = "entry_time", nullable = false)
    @JsonProperty("entry_time")
    private String entryTime;

    @Column(name = "leave_time", nullable = false)
    @JsonProperty("leave_time")
    private String leaveTime;

    @Column(name = "parking_space", nullable = false)
    @JsonProperty("parking_space")
    private String parkingSpace;
}
