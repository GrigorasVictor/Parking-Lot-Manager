package admin.parkWise.administration.models;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@Entity
@Table(name = "users")
@AllArgsConstructor
@NoArgsConstructor
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private Integer userId;

    @Column(name = "full_name", nullable = false)
    @JsonProperty("fullName")
    private String fullName;

    @Column(name = "image")
    @JsonProperty("image")
    private String image;

    @Column(name = "email", nullable = false)
    @JsonProperty("email")
    private String email;

    @Column(name = "phoneNumber", nullable = false)
    @JsonProperty("phone_number")
    private String phoneNumber;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonProperty("licencePlates")
    private List<VehicleRegistration> licencePlates = new ArrayList<>();

    @OneToMany(mappedBy = "userId", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonProperty("subscriptions")
    private List<UserSubscription> userSubscriptions = new ArrayList<>();

    @OneToMany(mappedBy = "userId", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonProperty("parkingRecords")
    private List<ParkingRecord> parkingRecords = new ArrayList<>();

    public User(Integer id){
        this.userId = id;
    }
}
