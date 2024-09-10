package admin.parkWise.administration.dtos;

import lombok.Getter;
import lombok.Setter;

public class RegisterUserAuthDto {

    @Getter @Setter
    private String email;

    @Getter @Setter
    private String password;
}
