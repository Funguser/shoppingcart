package com.shopping.service;

import com.shopping.dao.ShoppingRecordDao;
import com.shopping.entity.ShoppingRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;



@Service(value = "shoppingRecordService")
public class ShoppingRecordService{
    @Autowired
    private ShoppingRecordDao shoppingRecordDao;

    public ShoppingRecord getShoppingRecord(int userId, int productId, String time) {
        return shoppingRecordDao.getShoppingRecord(userId,productId, time);
    }

    public void addShoppingRecord(ShoppingRecord shoppingRecord) {
        shoppingRecordDao.addShoppingRecord(shoppingRecord);
    }

    public boolean deleteShoppingRecord(int userId, int productId) {
        return shoppingRecordDao.deleteShoppingRecord(userId,productId);
    }

    public boolean updateShoppingRecord(ShoppingRecord shoppingRecord) {
        return shoppingRecordDao.updateShoppingRecord(shoppingRecord);
    }

    public List<ShoppingRecord> getShoppingRecordsByOrderStatus(int orderStatus) {
        return shoppingRecordDao.getShoppingRecordsByOrderStatus(orderStatus);
    }

    public List<ShoppingRecord> getShoppingRecords(int userId) {
        return shoppingRecordDao.getShoppingRecords(userId);
    }

    public List<ShoppingRecord> getAllShoppingRecords() {
        return shoppingRecordDao.getAllShoppingRecords();
    }

    public boolean getUserProductRecord(int userId,int productId) {
        return shoppingRecordDao.getUserProductRecord(userId,productId);
    }
}
