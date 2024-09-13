package admin.parkWise.administration.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
@Setter
@Getter
@ToString
public class SigninDto {
    private String email;
    private String password;
    private String fullName;
    private String numberPhone;
}
