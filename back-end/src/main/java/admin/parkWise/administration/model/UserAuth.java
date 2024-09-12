package admin.parkWise.administration.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.util.Collection;
import java.util.Date;
import java.util.List;

@Data
@Entity
@Table(name = "user_auth")
@AllArgsConstructor
@NoArgsConstructor
public class UserAuth
//        implements UserDetails
        {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    @Getter
    @Setter
    private Integer userId;

    @Column(name = "email", nullable = false)
    @JsonProperty("email")
    @Getter @Setter
    private String email;

    @Column(name = "password", nullable = false)
    @JsonProperty("password")
    @Getter @Setter
    private String password;

    @CreationTimestamp
    @Column(updatable = false, name = "created_at")
    private Date createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private Date updatedAt;

//    @Override
//    public Collection<? extends GrantedAuthority> getAuthorities() {
//        return List.of();
//    }

//    @Override
    public String getUsername() {
        return email;
    }

//    @Override
    public boolean isEnabled() {return true;}
//    @Override
    public boolean isAccountNonExpired() {return true;}
//    @Override
    public boolean isAccountNonLocked() {return true;}
//    @Override
    public boolean isCredentialsNonExpired() {return true;}
}
