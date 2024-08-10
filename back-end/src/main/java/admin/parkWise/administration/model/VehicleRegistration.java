package admin.parkWise.administration.model;

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

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    @JsonProperty("user_id")
    private User userId;

    @Column(name = "registration_number", nullable = false)
    @JsonProperty("registration_number")
    private String registrationNumber;
}
