
package com.fashionstore.dao;

import java.util.List;
import com.fashionstore.model.User;

public interface UserDAO {

    boolean addUser(User user);

    User getUserById(int userId);

    User getUserByEmail(String email);

    List<User> getAllUsers();

    boolean updateUser(User user);

    boolean deleteUser(int userId);

    // Login method
    User login(String email, String password);
}
