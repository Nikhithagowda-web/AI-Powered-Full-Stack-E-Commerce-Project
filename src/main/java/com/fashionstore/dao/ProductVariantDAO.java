
package com.fashionstore.dao;

import java.util.List;
import com.fashionstore.model.ProductVariant;

public interface ProductVariantDAO {

    boolean addVariant(ProductVariant variant);

    ProductVariant getVariantById(int variantId);

    List<ProductVariant> getVariantsByProductId(int productId);

    List<ProductVariant> getAllVariants();

    boolean updateVariant(ProductVariant variant);

    boolean deleteVariant(int variantId);
}
