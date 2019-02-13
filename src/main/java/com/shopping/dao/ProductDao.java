package com.shopping.dao;

import com.shopping.entity.Product;
import org.hibernate.*;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository(value = "productDao")
public class ProductDao {

    private Session session;

    public Product getProduct(int id) {
        session = MainDAO.getSession();
        Criteria criteria = session.createCriteria(Product.class);
        criteria.add(Restrictions.eq("id",id));

        Product product = (Product)criteria.uniqueResult();
        session.close();
        return product;
    }

    public Product getProduct(String name) {
        session = MainDAO.getSession();
        Criteria criteria = session.createCriteria(Product.class);
        criteria.add(Restrictions.eq("name",name));
        Product product = (Product) criteria.uniqueResult();
        session.close();
        return product;
    }

    public void addProduct(Product product) {
        session = MainDAO.getSession();
        Transaction tx = session.beginTransaction();
        session.save(product);
        tx.commit();
        session.close();
    }

    public boolean deleteProduct(int id) {
        session = MainDAO.getSession();
        String hqlSearch = "from Product where id=?";
        org.hibernate.query.Query querySearch = session.createQuery(hqlSearch);
        querySearch.setParameter(0, id);
        List<Product> list = querySearch.list();
        if(list.isEmpty()) {
            session.close();
            return true;
        }
        Transaction tx = session.beginTransaction();
        String hql = "delete Product where id=?";
        Query query = session.createQuery(hql);
        query.setParameter(0, id);
        int num = query.executeUpdate();
        tx.commit();
        session.close();
        return  num > 0;
    }
    public boolean updateProduct(Product product) {
        session = MainDAO.getSession();
        Transaction tx = session.beginTransaction();
        String hql = "update Product set name=?,description=?,price=?,counts=? where id=?";
        Query query = session.createQuery(hql);
        query.setParameter(0,product.getName());
        query.setParameter(1,product.getDescription());
        query.setParameter(2,product.getPrice());
        query.setParameter(3,product.getCounts());
        query.setParameter(4,product.getId());
        int num = query.executeUpdate();
        tx.commit();
        session.close();
        return num > 0;
    }

    public List<Product> getAllProduct() {
        String hql = "from Product";
        session = MainDAO.getSession();
        Query query = session.createQuery(hql);
        List<Product> list = query.list();
        session.close();
        return list;
    }
}
