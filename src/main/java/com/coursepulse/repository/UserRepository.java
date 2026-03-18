package com.coursepulse.repository;

import com.coursepulse.model.User;
import com.coursepulse.model.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;
import java.util.List;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByUsername(String username);
    List<User> findByRole(Role role);
    List<User> findByRoleAndApproved(Role role, boolean approved);
}
