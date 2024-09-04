package admin.parkWise.administration.repository;

import admin.parkWise.administration.model.UserImage;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserImageRepo extends JpaRepository<UserImage, Integer> {
}
