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
    @JsonProperty("full_name")
    private String fullName;

    @Column(name = "email", nullable = false)
    @JsonProperty("email")
    private String email;

<<<<<<< HEAD:back-end/src/main/java/admin/parkWise/administration/models/User.java
=======
//    @Column(name = "password", nullable = false)
//    @JsonProperty("password")
//    private String password;

>>>>>>> 3522140b63e507ca1f979ace265ee83b18bf6ef5:back-end/src/main/java/admin/parkWise/administration/model/User.java
    @Column(name = "phone_number", nullable = false)
    @JsonProperty("phone_number")
    private String phoneNumber;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonProperty("licencePlates")
    private List<VehicleRegistration> licencePlates = new ArrayList<>();

    public User(Integer id){
        this.userId = id;
    }
}
