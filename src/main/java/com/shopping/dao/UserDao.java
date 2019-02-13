package com.shopping.dao;

import com.shopping.entity.User;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository(value = "userDao")
public class UserDao{

    private Session session;

    public User getUser(int id) {
        session = MainDAO.getSession();
        String hql = "from User where id=?";
        Query query = session.createQuery(hql);
        query.setParameter(0, id);
        User user = (User)query.uniqueResult();
        session.close();
        return user;
    }

    public User getUser(String nameOrEmail) {
        session = MainDAO.getSession();
        String hql = "from User where email=?";
        Query query = session.createQuery(hql);
        query.setParameter(0, nameOrEmail);
        if(query.uniqueResult() == null){
            hql = "from User where name=?";
            query = session.createQuery(hql);
            query.setParameter(0, nameOrEmail);
        }
        User user = (User)query.uniqueResult();
        session.close();
        return user;
    }

    public void addUser(User user) {
        session = MainDAO.getSession();
        Transaction tx = session.beginTransaction();
        session.save(user);
        tx.commit();
        session.close();
    }

    public boolean deleteUser(int id) {
        session = MainDAO.getSession();
        String hqlSearch = "from User where id=?";
        org.hibernate.query.Query querySearch = session.createQuery(hqlSearch);
        querySearch.setParameter(0, id);
        List<User> list = querySearch.list();
        if(list.isEmpty()) {
            session.close();
            return true;
        }
        Transaction tx = session.beginTransaction();
        String hql = "delete User where id=?";
        Query query = session.createQuery(hql);
        query.setParameter(0, id);
        int num = query.executeUpdate();
        tx.commit();
        session.close();
        return num > 0;
    }


    public List<User> getAllUser() {
        session = MainDAO.getSession();
        String hql = "from User";
        Query query = session.createQuery(hql);
        List<User> list = query.list();
        session.close();
        return list;
    }
}
