package com.shopping.service;

import com.shopping.dao.*;
import com.shopping.entity.User;
import com.shopping.utils.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;



@Service(value = "userService")
public class UserService {

    @Autowired
    private UserDao userDao;
    @Autowired
    private UserDetailDao userDetailDao;
    @Autowired
    private ShoppingRecordDao shoppingRecordDao;
    @Autowired
    private ShoppingCarDao shoppingCarDao;
    public User getUser(int id) {
        return userDao.getUser(id);
    }

    public User getUser(String nameOrEmail) {
        return userDao.getUser(nameOrEmail);
    }

    public void addUser(User user) {
        userDao.addUser(user);
    }

    @Transactional
    public Response deleteUser(int id) {
        try {
            shoppingCarDao.deleteShoppingCarByUser(id);
            shoppingRecordDao.deleteShoppingRecordByUser(id);
            userDetailDao.deleteUserDetail(id);
            userDao.deleteUser(id);
            return new Response(1, "success", null);
        }catch (Exception e) {
            return new Response(0, "fail", null);
        }
    }

    public List<User> getAllUser() {
        return userDao.getAllUser();
    }
}
