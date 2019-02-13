package com.shopping.dao;

import com.shopping.entity.UserDetail;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository(value = "userDetailDao")
public class UserDetailDao{

    private Session session;

    public UserDetail getUserDetail(int id) {
        session = MainDAO.getSession();
        String hql = "from UserDetail where id=?";
        Query query = session.createQuery(hql);
        query.setParameter(0, id);
        UserDetail userDetail = (UserDetail)query.uniqueResult();
        session.close();
        return userDetail;
    }

    public void addUserDetail(UserDetail userDetail) {
        session = MainDAO.getSession();
        Transaction tx = session.beginTransaction();
        session.save(userDetail);
        tx.commit();
        session.close();
    }

    public boolean deleteUserDetail(int id) {
        session = MainDAO.getSession();
        String hqlSearch = "from UserDetail where id=?";
        org.hibernate.query.Query querySearch = session.createQuery(hqlSearch);
        querySearch.setParameter(0, id);
        List<UserDetail> list = querySearch.list();
        if(list.isEmpty()) {
            session.close();
            return true;
        }
        Transaction tx = session.beginTransaction();
        String hql = "delete UserDetail where id=?";
        Query query = session.createQuery(hql);
        query.setParameter(0, id);
        int num = query.executeUpdate();
        tx.commit();
        session.close();
        return num > 0;
    }

    public List<UserDetail> getAllUserDetail() {
        session = MainDAO.getSession();
        String hql = "from UserDetail";
        Query query = session.createQuery(hql);
        List<UserDetail> list = query.list();
        session.close();
        return list;
    }
}
