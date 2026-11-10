<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fashion Store - Home</title>
    <style>
        * { margin:0; padding:0; box-sizing:border-box; font-family:'Segoe UI', Arial, sans-serif; }
        body { background:#2d1b4e; color:white; }
        .navbar { background:#160b2e; padding:16px 40px; display:flex; align-items:center; justify-content:space-between; }
        .navbar .logo { font-size:22px; font-weight:800; }
        .search-box { display:flex; background:white; border-radius:25px; overflow:hidden; width:380px; }
        .search-box input { border:none; outline:none; padding:10px 18px; flex:1; }
        .search-box button { background:#7dd3fc; border:none; padding:10px 22px; cursor:pointer; }
        .nav-links { display:flex; gap:25px; }
        .nav-links a { color:white; text-decoration:none; font-size:14px; font-weight:600; }
        .container { max-width:1150px; margin:0 auto; padding:30px 20px 60px; }
        .hero { display:flex; gap:25px; background: rgba(255,255,255,0.08); border:1px solid rgba(255,255,255,0.12); border-radius:18px; padding:30px; align-items:center; }
        .hero-text { flex:1; }
        .hero-text h1 { font-size:42px; line-height:1.2; margin-bottom:12px; }
        .hero-text p { color:#c4b5e0; font-size:15px; line-height:1.6; margin-bottom:22px; }
        .btn-shop { background:#7dd3fc; color:#0f172a; padding:13px 28px; border-radius:25px; font-weight:800; text-decoration:none; display:inline-block; }
        .hero-img { width:480px; height:320px; border-radius:16px; overflow:hidden; flex-shrink:0; background:white; }
        .hero-img img { width:100%; height:100%; object-fit:cover; }
        .section-title { font-size:24px; margin:35px 0 18px; }
        .category-grid { display:grid; grid-template-columns:repeat(3, 1fr); gap:18px; }
        .cat-card { background: rgba(255,255,255,0.08); border:1px solid rgba(255,255,255,0.12); border-radius:16px; overflow:hidden; text-decoration:none; color:white; display:block; }
        .cat-card img { width:100%; height:240px; object-fit:cover; background:white; display:block; }
        .cat-info { padding:16px; text-align:center; }
        .cat-info h3 { font-size:19px; margin:6px 0 5px; }
        .cat-info p { font-size:13px; color:#c4b5e0; margin-bottom:12px; }
        .btn-explore { background:#7dd3fc; color:#0f172a; border:none; padding:8px 20px; border-radius:20px; font-weight:700; font-size:13px; display:inline-block; }
        .product-grid { display:grid; grid-template-columns:repeat(3, 1fr); gap:20px; }
        .prod-card { background: rgba(255,255,255,0.08); border:1px solid rgba(255,255,255,0.12); border-radius:16px; overflow:hidden; }
        .prod-card img { width:100%; height:300px; object-fit:cover; background:white; display:block; }
        .prod-info { padding:14px; }
        .prod-info h3 { font-size:16px; margin:5px 0; }
        .prod-info .price { font-weight:800; margin:6px 0 10px; }
        .btn-add { background:#7dd3fc; color:#0f172a; border:none; padding:9px 16px; border-radius:20px; font-weight:700; cursor:pointer; width:100%; }
        .footer { background:#120824; padding:28px 40px; display:flex; justify-content:space-between; margin-top:20px; }
        .footer-bottom { background:#0d0620; text-align:center; padding:12px; font-size:12px; color:#8a7ab5; }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="logo">Fashion Store</div>
        <div class="search-box"><input type="text" placeholder="Search for fashion products..."><button>Search</button></div>
        <div class="nav-links"><a href="home">Home</a><a href="products">Products</a><a href="cart">Cart</a><a href="login">Login</a></div>
    </div>
    <div class="container">
        <div class="hero">
            <div class="hero-text">
                <h1>Trendy Fashion<br>Collection 2026</h1>
                <p>Discover the latest styles in fashion. From casual wear to premium outfits, find your perfect look at best prices.</p>
                <a href="products" class="btn-shop">Shop Now</a>
            </div>
            <div class="hero-img"><img src="images/jacket.jpg" alt="Fashion"></div>
        </div>
        <h2 class="section-title">Shop by Category</h2>
        <div class="category-grid">
            <a href="products" class="cat-card"><img src="images/dress.jpg"><div class="cat-info"><h3>Women</h3><p>Fashion products for women</p><span class="btn-explore">Explore</span></div></a>
            <a href="products" class="cat-card"><img src="images/jacket.jpg"><div class="cat-info"><h3>Men</h3><p>Fashion products for men</p><span class="btn-explore">Explore</span></div></a>
            <a href="products" class="cat-card"><img src="images/cap.jpg"><div class="cat-info"><h3>Accessories</h3><p>Fashion accessories</p><span class="btn-explore">Explore</span></div></a>
        </div>
        <h2 class="section-title">Latest Products</h2>
        <div class="product-grid">
            <div class="prod-card">
                <img src="images/sunglasses2.jpg" alt="Sunglasses">
                <div class="prod-info">
                    <h3>Sunglasses</h3>
                    <div class="price">Rs. 1299.00</div>
                    <form action="cart" method="post">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="8">
                        <input type="hidden" name="productName" value="Sunglasses">
                        <input type="hidden" name="brand" value="RAY-BAN">
                        <input type="hidden" name="size" value="One Size">
                        <input type="hidden" name="image" value="images/sunglasses.jpg">
                        <input type="hidden" name="price" value="1299">
                        <input type="hidden" name="quantity" value="1">
                        <button type="submit" class="btn-add">Add to Cart</button>
                    </form>
                </div>
            </div>
            <div class="prod-card">
                <img src="images/jacket.jpg" alt="Leather Jacket">
                <div class="prod-info">
                    <h3>Leather Jacket</h3>
                    <div class="price">Rs. 2999.00</div>
                    <form action="cart" method="post">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="4">
                        <input type="hidden" name="productName" value="Leather Jacket">
                        <input type="hidden" name="brand" value="H&M">
                        <input type="hidden" name="size" value="L">
                        <input type="hidden" name="image" value="images/jacket.jpg">
                        <input type="hidden" name="price" value="2999">
                        <input type="hidden" name="quantity" value="1">
                        <button type="submit" class="btn-add">Add to Cart</button>
                    </form>
                </div>
            </div>
            <div class="prod-card">
                <img src="images/sneakers.jpg" alt="Black Sneakers">
                <div class="prod-info">
                    <h3>Black Sneakers</h3>
                    <div class="price">Rs. 2299.00</div>
                    <form action="cart" method="post">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="6">
                        <input type="hidden" name="productName" value="Black Sneakers">
                        <input type="hidden" name="brand" value="NIKE">
                        <input type="hidden" name="size" value="9">
                        <input type="hidden" name="image" value="images/sneakers.jpg">
                        <input type="hidden" name="price" value="2299">
                        <input type="hidden" name="quantity" value="1">
                        <button type="submit" class="btn-add">Add to Cart</button>
                    </form>
                </div>
            </div>
            <div class="prod-card">
                <img src="images/dress.jpg" alt="Floral Summer Dress">
                <div class="prod-info">
                    <h3>Floral Summer Dress</h3>
                    <div class="price">Rs. 2499.00</div>
                    <form action="cart" method="post">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="2">
                        <input type="hidden" name="productName" value="Floral Summer Dress">
                        <input type="hidden" name="brand" value="ZARA">
                        <input type="hidden" name="size" value="M">
                        <input type="hidden" name="image" value="images/dress.jpg">
                        <input type="hidden" name="price" value="2499">
                        <input type="hidden" name="quantity" value="1">
                        <button type="submit" class="btn-add">Add to Cart</button>
                    </form>
                </div>
            </div>
            <div class="prod-card">
                <img src="images/jeans.jpg" alt="Blue Slim Fit Jeans">
                <div class="prod-info">
                    <h3>Blue Slim Fit Jeans</h3>
                    <div class="price">Rs. 1999.00</div>
                    <form action="cart" method="post">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="3">
                        <input type="hidden" name="productName" value="Blue Slim Fit Jeans">
                        <input type="hidden" name="brand" value="LEVIS">
                        <input type="hidden" name="size" value="32">
                        <input type="hidden" name="image" value="images/jeans.jpg">
                        <input type="hidden" name="price" value="1999">
                        <input type="hidden" name="quantity" value="1">
                        <button type="submit" class="btn-add">Add to Cart</button>
                    </form>
                </div>
            </div>
            <div class="prod-card">
                <img src="images/tshirt.jpg" alt="Men Blue T-Shirt">
                <div class="prod-info">
                    <h3>Men Blue T-Shirt</h3>
                    <div class="price">Rs. 999.00</div>
                    <form action="cart" method="post">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="1">
                        <input type="hidden" name="productName" value="Men Blue T-Shirt">
                        <input type="hidden" name="brand" value="H&M">
                        <input type="hidden" name="size" value="XL">
                        <input type="hidden" name="image" value="images/tshirt.jpg">
                        <input type="hidden" name="price" value="999">
                        <input type="hidden" name="quantity" value="1">
                        <button type="submit" class="btn-add">Add to Cart</button>
                    </form>
                </div>
            </div>
            <div class="prod-card">
                <img src="images/hoodie.jpg" alt="Green Hoodie">
                <div class="prod-info">
                    <h3>Green Hoodie</h3>
                    <div class="price">Rs. 1599.00</div>
                    <form action="cart" method="post">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="5">
                        <input type="hidden" name="productName" value="Green Hoodie">
                        <input type="hidden" name="brand" value="NIKE">
                        <input type="hidden" name="size" value="L">
                        <input type="hidden" name="image" value="images/hoodie.jpg">
                        <input type="hidden" name="price" value="1599">
                        <input type="hidden" name="quantity" value="1">
                        <button type="submit" class="btn-add">Add to Cart</button>
                    </form>
                </div>
            </div>
            <div class="prod-card">
                <img src="images/handbag.jpg" alt="Women Handbag">
                <div class="prod-info">
                    <h3>Women Handbag</h3>
                    <div class="price">Rs. 1899.00</div>
                    <form action="cart" method="post">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="7">
                        <input type="hidden" name="productName" value="Women Handbag">
                        <input type="hidden" name="brand" value="ZARA">
                        <input type="hidden" name="size" value="One Size">
                        <input type="hidden" name="image" value="images/handbag.jpg">
                        <input type="hidden" name="price" value="1899">
                        <input type="hidden" name="quantity" value="1">
                        <button type="submit" class="btn-add">Add to Cart</button>
                    </form>
                </div>
            </div>
            <div class="prod-card">
                <img src="images/cap.jpg" alt="Unisex Cap">
                <div class="prod-info">
                    <h3>Unisex Cap</h3>
                    <div class="price">Rs. 499.00</div>
                    <form action="cart" method="post">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="9">
                        <input type="hidden" name="productName" value="Unisex Cap">
                        <input type="hidden" name="brand" value="NIKE">
                        <input type="hidden" name="size" value="One Size">
                        <input type="hidden" name="image" value="images/cap.jpg">
                        <input type="hidden" name="price" value="499">
                        <input type="hidden" name="quantity" value="1">
                        <button type="submit" class="btn-add">Add to Cart</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="footer"><div><h3>Fashion Store</h3><p>Your one-stop destination for stylish fashion</p></div><div><a href="#" style="color:white;">Privacy Policy</a></div></div>
    <div class="footer-bottom">&copy; 2026 Fashion Store. All rights reserved.</div>
</body>
</html>