package admin.parkWise.administration.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@Table(name = "user_images")
@AllArgsConstructor
@NoArgsConstructor
public class UserImage {
    @Id
    @Column(name = "user_id", nullable = false)
    @JsonProperty("user_id")
    private Integer userId;

    @Lob
    @Column(name = "image", nullable = false)
    @JsonProperty("image")
    private byte[] image;
}
