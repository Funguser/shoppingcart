package com.shopping.service;

import com.shopping.dao.UserDetailDao;
import com.shopping.entity.UserDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;



@Service(value = "userDetailService")
public class UserDetailService{

    @Autowired
    private UserDetailDao userDetailDao;

    public UserDetail getUserDetail(int id) {
        return userDetailDao.getUserDetail(id);
    }

    public void addUserDetail(UserDetail userDetail) {
        userDetailDao.addUserDetail(userDetail);
    }

    public boolean deleteUserDetail(int id) {
        return userDetailDao.deleteUserDetail(id);
    }

    public List<UserDetail> getAllUserDetail() {
        return userDetailDao.getAllUserDetail();
    }
}
