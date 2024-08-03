package admin.parkWise.administration.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.JoinColumn;
import lombok.Data;

@Data
@Entity
@Table(name = "vehicle_registration")
public class VehicleRegistration {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "registration_id")
    private int registrationId;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    @JsonProperty("user_id")
    private User user;

    @Column(name = "registration_number", nullable = false)
    @JsonProperty("registration_number")
    private String registrationNumber;
}
