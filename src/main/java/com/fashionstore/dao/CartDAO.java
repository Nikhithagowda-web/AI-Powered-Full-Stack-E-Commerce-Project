package com.fashionstore.dao;

import com.fashionstore.model.Cart;

public interface CartDAO {
    boolean addCart(Cart cart);
    Cart getCartById(int cartId);
    Cart getCartByUserId(int userId);
    boolean deleteCart(int cartId);
}