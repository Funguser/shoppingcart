package com.shopping.dao;

import com.shopping.entity.ShoppingCar;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import java.util.List;




@Repository(value = "shoppingCarDao")
public class ShoppingCarDao {
    private Session session;

    public ShoppingCar getShoppingCar(int userId, int productId) {
        session = MainDAO.getSession();
        String hql = "from ShoppingCar where userId=? and productId=?";
        Query query = session.createQuery(hql);
        query.setParameter(0, userId);
        query.setParameter(1, productId);
        ShoppingCar shoppingCar = (ShoppingCar) query.uniqueResult();
        session.close();
        return shoppingCar;
    }

    public void addShoppingCar(ShoppingCar shoppingCar) {
        session = MainDAO.getSession();
        Transaction tx = session.beginTransaction();

        session.save(shoppingCar);
        tx.commit();
        session.close();
    }

    public boolean deleteShoppingCar(int userId, int productId) {
        session = MainDAO.getSession();
        String hqlSearch = "from ShoppingCar where userId=? and productId=?";
        org.hibernate.query.Query querySearch = session.createQuery(hqlSearch);
        querySearch.setParameter(0, userId);
        querySearch.setParameter(1, productId);
        List<ShoppingCar> list = querySearch.list();
        if (list.isEmpty()) {
            session.close();
            return true;
        }
        Transaction tx = session.beginTransaction();
        String hql = "delete ShoppingCar where userId=? and productId=?";
        Query query = session.createQuery(hql);
        query.setParameter(0, userId);
        query.setParameter(1, productId);
        int num = query.executeUpdate();
        tx.commit();
        session.close();
        return num > 0;
    }


    public boolean updateShoppingCar(ShoppingCar shoppingCar) {
        session = MainDAO.getSession();
        Transaction tx = session.beginTransaction();
        String hql = "update ShoppingCar set productPrice=?,counts=? where userId=? and productId=?";
        Query query = session.createQuery(hql);
        query.setParameter(0, shoppingCar.getProductPrice());
        query.setParameter(1, shoppingCar.getCounts());
        query.setParameter(2, shoppingCar.getUserId());
        query.setParameter(3, shoppingCar.getProductId());
        int num = query.executeUpdate();
        tx.commit();
        session.close();
        return num > 0;
    }

    public List<ShoppingCar> getShoppingCars(int userId) {
        session = MainDAO.getSession();
        String hql = "from ShoppingCar where userId=?";
        Query query = session.createQuery(hql);
        query.setParameter(0, userId);
        List<ShoppingCar> list = query.list();
        session.close();
        return list;
    }

    public boolean deleteShoppingCarByUser(int userId) {
        session = MainDAO.getSession();
        String hqlSearch = "from ShoppingCar where userId=?";
        org.hibernate.query.Query querySearch = session.createQuery(hqlSearch);
        querySearch.setParameter(0, userId);
        List<ShoppingCar> list = querySearch.list();
        if (list.isEmpty()) {
            session.close();
            return true;
        }
        Transaction tx = session.beginTransaction();
        String hql = "delete ShoppingCar where userId=?";
        Query query = session.createQuery(hql);
        query.setParameter(0, userId);
        int num = query.executeUpdate();
        tx.commit();
        session.close();
        return num > 0;
    }

    public boolean deleteShoppingCarByProduct(int productId) {
        session = MainDAO.getSession();
        String hqlSearch = "from ShoppingCar where productId=?";
        org.hibernate.query.Query querySearch = session.createQuery(hqlSearch);
        querySearch.setParameter(0, productId);
        List<ShoppingCar> list = querySearch.list();
        if (list.isEmpty()) {
            session.close();
            return true;
        }
        Transaction tx = session.beginTransaction();
        String hql = "delete ShoppingCar where productId=?";
        Query query = session.createQuery(hql);
        query.setParameter(0, productId);
        int num = query.executeUpdate();
        tx.commit();
        return num > 0;
    }
}
