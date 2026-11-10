package com.fashionstore.dao;

import com.fashionstore.model.CartItem;
import java.util.List;

public interface CartItemDAO {

    boolean addToCart(int userId, int productId, int quantity);

    List<CartItem> getCartByUser(int userId);

    boolean updateQuantity(int userId, int productId, int quantity);

    boolean removeFromCart(int userId, int productId);

    boolean clearCart(int userId);
}