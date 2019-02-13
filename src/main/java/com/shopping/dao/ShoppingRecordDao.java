package com.shopping.dao;

import com.shopping.entity.ShoppingRecord;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository(value = "shoppingRecordDao")
public class ShoppingRecordDao {
    private Session session;

    public ShoppingRecord getShoppingRecord(int userId, int productId,String time) {
        session = MainDAO.getSession();
        String hql = "from ShoppingRecord where userId=? and productId=? and time=?";
        Query query = session.createQuery(hql);
        query.setParameter(0, userId);
        query.setParameter(1, productId);
        query.setParameter(2, time);
        ShoppingRecord shoppingRecord = (ShoppingRecord) query.uniqueResult();
        session.close();
        return shoppingRecord;
    }

    public void addShoppingRecord(ShoppingRecord shoppingRecord) {
        session = MainDAO.getSession();
        Transaction tx = session.beginTransaction();
        session.save(shoppingRecord);
        tx.commit();
        session.close();
    }

    public boolean deleteShoppingRecord(int userId, int productId) {
        session = MainDAO.getSession();
        String hqlSearch = "from ShoppingRecord where userId=? and productId=?";
        org.hibernate.query.Query querySearch = session.createQuery(hqlSearch);
        querySearch.setParameter(0, userId);
        querySearch.setParameter(0, productId);
        List<ShoppingRecord> list = querySearch.list();
        if(list.isEmpty()) {
            session.close();
            return true;
        }
        Transaction tx = session.beginTransaction();
        String hql = "delete ShoppingRecord where userId=? and productId=?";
        Query query = session.createQuery(hql);
        query.setParameter(0, userId);
        query.setParameter(1, productId);
        int num = query.executeUpdate();
        tx.commit();

        return num > 0;
    }

    public boolean updateShoppingRecord(ShoppingRecord shoppingRecord) {
        session = MainDAO.getSession();
        Transaction tx = session.beginTransaction();
        String hql = "update ShoppingRecord set orderStatus=? where userId=? and productId=? and time=? ";
        Query query = session.createQuery(hql);
        query.setParameter(0, shoppingRecord.getOrderStatus());
        query.setParameter(1, shoppingRecord.getUserId());
        query.setParameter(2, shoppingRecord.getProductId());
        query.setParameter(3, shoppingRecord.getTime());
        int num = query.executeUpdate();
        tx.commit();
        session.close();
        return num > 0;
    }

    public List<ShoppingRecord> getShoppingRecords(int userId) {
        session = MainDAO.getSession();
        String hql = "from ShoppingRecord where userId=?";
        Query query = session.createQuery(hql);
        query.setParameter(0,userId);
        List<ShoppingRecord> list = query.list();
        session.close();
        return list;
    }

    public List<ShoppingRecord> getAllShoppingRecords() {
        session = MainDAO.getSession();
        String hql = "from ShoppingRecord";
        Query query = session.createQuery(hql);
        List<ShoppingRecord> list = query.list();
        session.close();
        return list;
    }

    public List<ShoppingRecord> getShoppingRecordsByOrderStatus(int orderStatus) {
        session = MainDAO.getSession();
        String hql = "from ShoppingRecord where orderStatus=?";
        Query query = session.createQuery(hql);
        query.setParameter(0,orderStatus);
        List<ShoppingRecord> list = query.list();
        session.close();
        return list;
    }

    public boolean getUserProductRecord(int userId,int productId) {
        session = MainDAO.getSession();
        String hql = "from ShoppingRecord where userId=? and productId=?";
        Query query = session.createQuery(hql);
        query.setParameter(0,userId);
        query.setParameter(1,productId);
        session.close();
        return query.list().size()>0;
    }

    public boolean deleteShoppingRecordByUser(int userId) {
        session = MainDAO.getSession();
        String hqlSearch = "from ShoppingRecord where userId=?";
        org.hibernate.query.Query querySearch = session.createQuery(hqlSearch);
        querySearch.setParameter(0, userId);
        List<ShoppingRecord> list = querySearch.list();
        if(list.isEmpty()) {
            session.close();
            return true;
        }
        Transaction tx = session.beginTransaction();
        String hql = "delete ShoppingRecord where userId=?";
        Query query = session.createQuery(hql);
        query.setParameter(0, userId);
        int num = query.executeUpdate();
        tx.commit();
        session.close();
        return  num > 0;
    }

    public boolean deleteShoppingRecordByProductId(int productId) {
        session = MainDAO.getSession();
        String hqlSearch = "from ShoppingRecord where productId=?";
        org.hibernate.query.Query querySearch = session.createQuery(hqlSearch);
        querySearch.setParameter(0, productId);
        List<ShoppingRecord> list = querySearch.list();
        if(list.isEmpty()) {
            session.close();
            return true;
        }
        Transaction tx = session.beginTransaction();
        String hql = "delete ShoppingRecord where productId=?";
        Query query = session.createQuery(hql);
        query.setParameter(0, productId);
        int num = query.executeUpdate();
        tx.commit();
        session.close();
        return  num > 0;
    }
}
