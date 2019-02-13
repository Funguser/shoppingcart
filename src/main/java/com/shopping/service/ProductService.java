package com.shopping.service;

import com.shopping.dao.ProductDao;
import com.shopping.dao.ShoppingCarDao;
import com.shopping.dao.ShoppingRecordDao;
import com.shopping.entity.Product;
import com.shopping.utils.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;




@Service(value = "productService")
public class ProductService {
    @Autowired
    private ProductDao productDao;
    @Autowired
    private ShoppingRecordDao shoppingRecordDao;
    @Autowired
    private ShoppingCarDao shoppingCarDao;
    public Product getProduct(int id) {
        return productDao.getProduct(id);
    }

    public Product getProduct(String name) {
        return productDao.getProduct(name);
    }

    public void addProduct(Product product) {
        productDao.addProduct(product);
    }

    @Transactional
    public Response deleteProduct(int id) {
        try {
            shoppingCarDao.deleteShoppingCarByProduct(id);
            shoppingRecordDao.deleteShoppingRecordByProductId(id);
            productDao.deleteProduct(id);
            return new Response(1, "success", null);
        }catch (Exception e){
            return new Response(0,"fail",null);
        }
    }

    public boolean updateProduct(Product product) {
        return productDao.updateProduct(product);
    }

    public List<Product> getAllProduct() {
        return productDao.getAllProduct();
    }
}
