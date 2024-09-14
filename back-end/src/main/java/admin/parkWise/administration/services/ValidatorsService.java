package admin.parkWise.administration.services;

import admin.parkWise.administration.models.UserAuth;

import java.util.regex.Pattern;

public class ValidatorsService {
    private static final String EMAIL_PATTERN = "^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$";

    public static void validate(UserAuth userObject) throws Exception{
        Pattern pattern = Pattern.compile(EMAIL_PATTERN);
        if (!pattern.matcher(userObject.getEmail()).matches()) {
            throw new IllegalArgumentException("Email is not a valid email!");
        }
    }
}
