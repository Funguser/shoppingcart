package com.shopping.service;

import com.shopping.dao.ShoppingCarDao;
import com.shopping.entity.ShoppingCar;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;




@Service(value = "shoppingCarService")
public class ShoppingCarService{
    @Autowired
    private ShoppingCarDao shoppingCarDao;

    public ShoppingCar getShoppingCar(int userId, int productId) {
        return shoppingCarDao.getShoppingCar(userId,productId);
    }

    public void addShoppingCar(ShoppingCar shoppingCar) {
        shoppingCarDao.addShoppingCar(shoppingCar);
    }

    public boolean deleteShoppingCar(int userId, int productId) {
        return shoppingCarDao.deleteShoppingCar(userId,productId);
    }

    public boolean updateShoppingCar(ShoppingCar shoppingCar) {
        return shoppingCarDao.updateShoppingCar(shoppingCar);
    }

    public List<ShoppingCar> getShoppingCars(int userId) {
        return shoppingCarDao.getShoppingCars(userId);
    }
}
