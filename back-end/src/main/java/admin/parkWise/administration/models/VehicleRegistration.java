package admin.parkWise.administration.models;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "vehicle_registration")
public class VehicleRegistration {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "registration_id")
    private Integer registrationId;

    @Column(name = "user_id")
    @JsonProperty("user_id")
    private Integer user;

    @Column(name = "registration_number", nullable = false)
    @JsonProperty("registration_number")
    private String registrationNumber;
}
