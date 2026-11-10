<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fashion Store - Products</title>
    <style>
        * { margin:0; padding:0; box-sizing:border-box; font-family:'Segoe UI', Arial, sans-serif; }
        body { background:#2d1b4e; color:white; }
        .navbar { background:#160b2e; padding:16px 40px; display:flex; align-items:center; justify-content:space-between; }
        .navbar .logo { font-size:22px; font-weight:800; }
        .search-box { display:flex; background:white; border-radius:25px; overflow:hidden; width:380px; }
        .search-box input { border:none; outline:none; padding:10px 18px; flex:1; }
        .search-box button { background:#7dd3fc; border:none; padding:10px 22px; cursor:pointer; font-weight:700; }
        .nav-links { display:flex; gap:25px; }
        .nav-links a { color:white; text-decoration:none; font-size:14px; font-weight:600; }
        .container { max-width:1150px; margin:0 auto; padding:30px 20px 60px; }
        .hero { background: rgba(255,255,255,0.08); border:1px solid rgba(255,255,255,0.12); border-radius:18px; padding:35px; margin-bottom:30px; }
        .hero h1 { font-size:36px; margin-bottom:10px; }
        .hero p { color:#c4b5e0; font-size:14px; }
        .main { display:flex; gap:25px; align-items:flex-start; }
        .filters { width:270px; background: rgba(255,255,255,0.08); border:1px solid rgba(255,255,255,0.12); border-radius:16px; padding:20px; flex-shrink:0; }
        .filters h3 { font-size:19px; margin-bottom:15px; }
        .filters label { font-size:13px; font-weight:700; color:#e9e0ff; display:block; margin:14px 0 7px; }
        .filters input, .filters select { width:100%; padding:11px 12px; border:none; border-radius:10px; outline:none; background:#3b2666; color:white; font-size:14px; }
        .filters input::placeholder { color:#a89cc9; }
        .filters select option { background:#2d1b4e; }
        .btn-row { display:flex; gap:10px; margin-top:18px; }
        .btn-apply { background:#f1f5f9; color:#0f172a; border:none; padding:11px; border-radius:25px; font-weight:800; flex:1; cursor:pointer; }
        .btn-clear { background:#43307a; color:white; border:none; padding:11px; border-radius:25px; font-weight:700; flex:1; cursor:pointer; }
        .content { flex:1; }
        .content h2 { font-size:24px; margin-bottom:18px; }
        .product-grid { display:grid; grid-template-columns:repeat(3, 1fr); gap:18px; }
        .prod-card { background: rgba(255,255,255,0.08); border:1px solid rgba(255,255,255,0.12); border-radius:16px; overflow:hidden; }
        .prod-card img { width:100%; height:210px; object-fit:cover; background:white; display:block; }
        .prod-info { padding:14px; }
        .prod-info h3 { font-size:15px; }
        .prod-info .brand { font-size:12px; color:#c4b5e0; margin:4px 0; }
        .prod-info .price { font-weight:800; font-size:15px; margin:8px 0 12px; }
        .btn-view { background:white; color:#0f172a; border:none; padding:9px; border-radius:25px; font-weight:700; width:100%; margin-bottom:8px; cursor:pointer; font-size:13px; }
        .btn-add { background:#22d3ee; color:#0f172a; border:none; padding:9px; border-radius:25px; font-weight:700; width:100%; cursor:pointer; font-size:13px; }
        .no-result { display:none; text-align:center; padding:40px; color:#c4b5e0; }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="logo">Fashion Store</div>
        <form class="search-box" action="products" method="get" onsubmit="return topSearch()">
            <input type="text" id="topSearchInput" name="search" placeholder="Search for fashion products...">
            <button type="submit">Search</button>
        </form>
        <div class="nav-links"><a href="home">Home</a><a href="products">Products</a><a href="cart">Cart</a><a href="login">Login</a></div>
    </div>

    <div class="container">
        <div class="hero">
            <h1>Explore Our Fashion Collection</h1>
            <p>Browse products, apply filters, and discover styles that match your taste</p>
        </div>

        <div class="main">
            <div class="filters">
                <h3>Filters</h3>
                <label>Search</label>
                <input type="text" id="searchInput" placeholder="Search products..." onkeyup="applyFilters()">
                <label>Category</label>
                <select id="categoryFilter" onchange="applyFilters()">
                    <option value="All">All Categories</option>
                    <option value="Men">Men</option>
                    <option value="Women">Women</option>
                    <option value="Accessories">Accessories</option>
                </select>
                <div style="display:flex; gap:10px;">
                    <div style="flex:1;"><label>Min Price</label><input type="number" id="minPrice" value="0" onkeyup="applyFilters()"></div>
                    <div style="flex:1;"><label>Max Price</label><input type="number" id="maxPrice" value="5000" onkeyup="applyFilters()"></div>
                </div>
                <label>Sort By</label>
                <select id="sortFilter" onchange="applyFilters()">
                    <option value="Default">Default</option>
                    <option value="low">Price: Low to High</option>
                    <option value="high">Price: High to Low</option>
                </select>
                <div class="btn-row">
                    <button class="btn-apply" onclick="applyFilters()">Apply Filters</button>
                    <button class="btn-clear" onclick="clearFilters()">Clear</button>
                </div>
            </div>

            <div class="content">
                <h2>Products</h2>
                <div class="product-grid" id="productGrid">

                    <div class="prod-card" data-name="Green Hoodie" data-category="Men" data-price="1899">
                        <img src="images/hoodie.jpg"><div class="prod-info"><h3>Green Hoodie</h3><div class="brand">H&M</div><div class="price">₹ 1899.00</div>
                        <form action="product-details" method="get"><input type="hidden" name="id" value="5"><button class="btn-view">View Details</button></form>
                        <form action="cart" method="post"><input type="hidden" name="action" value="add"><input type="hidden" name="productId" value="5"><input type="hidden" name="productName" value="Green Hoodie"><input type="hidden" name="brand" value="H&M"><input type="hidden" name="size" value="L"><input type="hidden" name="image" value="images/hoodie.jpg"><input type="hidden" name="price" value="1899"><input type="hidden" name="quantity" value="1"><button class="btn-add">Add to Cart</button></form></div>
                    </div>

                    <div class="prod-card" data-name="Unisex Cap" data-category="Accessories" data-price="599">
                        <img src="images/cap.jpg"><div class="prod-info"><h3>Unisex Cap</h3><div class="brand">Puma</div><div class="price">₹ 599.00</div>
                        <form action="product-details" method="get"><input type="hidden" name="id" value="9"><button class="btn-view">View Details</button></form>
                        <form action="cart" method="post"><input type="hidden" name="action" value="add"><input type="hidden" name="productId" value="9"><input type="hidden" name="productName" value="Unisex Cap"><input type="hidden" name="brand" value="Puma"><input type="hidden" name="size" value="One Size"><input type="hidden" name="image" value="images/cap.jpg"><input type="hidden" name="price" value="599"><input type="hidden" name="quantity" value="1"><button class="btn-add">Add to Cart</button></form></div>
                    </div>

                    <div class="prod-card" data-name="Sunglasses" data-category="Accessories" data-price="1299">
                        <img src="images/sunglasses2.jpg"><div class="prod-info"><h3>Sunglasses</h3><div class="brand">RAY-BAN</div><div class="price">₹ 1299.00</div>
                        <form action="product-details" method="get"><input type="hidden" name="id" value="8"><button class="btn-view">View Details</button></form>
                        <form action="cart" method="post"><input type="hidden" name="action" value="add"><input type="hidden" name="productId" value="8"><input type="hidden" name="productName" value="Sunglasses"><input type="hidden" name="brand" value="RAY-BAN"><input type="hidden" name="size" value="One Size"><input type="hidden" name="image" value="images/sunglasses2.jpg"><input type="hidden" name="price" value="1299"><input type="hidden" name="quantity" value="1"><button class="btn-add">Add to Cart</button></form></div>
                    </div>

                    <div class="prod-card" data-name="Leather Jacket" data-category="Men" data-price="2999">
                        <img src="images/jacket.jpg"><div class="prod-info"><h3>Leather Jacket</h3><div class="brand">H&M</div><div class="price">₹ 2999.00</div>
                        <form action="product-details" method="get"><input type="hidden" name="id" value="4"><button class="btn-view">View Details</button></form>
                        <form action="cart" method="post"><input type="hidden" name="action" value="add"><input type="hidden" name="productId" value="4"><input type="hidden" name="productName" value="Leather Jacket"><input type="hidden" name="brand" value="H&M"><input type="hidden" name="size" value="L"><input type="hidden" name="image" value="images/jacket.jpg"><input type="hidden" name="price" value="2999"><input type="hidden" name="quantity" value="1"><button class="btn-add">Add to Cart</button></form></div>
                    </div>

                    <div class="prod-card" data-name="Black Sneakers" data-category="Men" data-price="2299">
                        <img src="images/sneakers.jpg"><div class="prod-info"><h3>Black Sneakers</h3><div class="brand">NIKE</div><div class="price">₹ 2299.00</div>
                        <form action="product-details" method="get"><input type="hidden" name="id" value="6"><button class="btn-view">View Details</button></form>
                        <form action="cart" method="post"><input type="hidden" name="action" value="add"><input type="hidden" name="productId" value="6"><input type="hidden" name="productName" value="Black Sneakers"><input type="hidden" name="brand" value="NIKE"><input type="hidden" name="size" value="9"><input type="hidden" name="image" value="images/sneakers.jpg"><input type="hidden" name="price" value="2299"><input type="hidden" name="quantity" value="1"><button class="btn-add">Add to Cart</button></form></div>
                    </div>

                    <div class="prod-card" data-name="Floral Summer Dress" data-category="Women" data-price="2499">
                        <img src="images/dress.jpg"><div class="prod-info"><h3>Floral Summer Dress</h3><div class="brand">ZARA</div><div class="price">₹ 2499.00</div>
                        <form action="product-details" method="get"><input type="hidden" name="id" value="2"><button class="btn-view">View Details</button></form>
                        <form action="cart" method="post"><input type="hidden" name="action" value="add"><input type="hidden" name="productId" value="2"><input type="hidden" name="productName" value="Floral Summer Dress"><input type="hidden" name="brand" value="ZARA"><input type="hidden" name="size" value="M"><input type="hidden" name="image" value="images/dress.jpg"><input type="hidden" name="price" value="2499"><input type="hidden" name="quantity" value="1"><button class="btn-add">Add to Cart</button></form></div>
                    </div>

                    <div class="prod-card" data-name="Blue Slim Fit Jeans" data-category="Men" data-price="1999">
                        <img src="images/jeans.jpg"><div class="prod-info"><h3>Blue Slim Fit Jeans</h3><div class="brand">LEVIS</div><div class="price">₹ 1999.00</div>
                        <form action="product-details" method="get"><input type="hidden" name="id" value="3"><button class="btn-view">View Details</button></form>
                        <form action="cart" method="post"><input type="hidden" name="action" value="add"><input type="hidden" name="productId" value="3"><input type="hidden" name="productName" value="Blue Slim Fit Jeans"><input type="hidden" name="brand" value="LEVIS"><input type="hidden" name="size" value="32"><input type="hidden" name="image" value="images/jeans.jpg"><input type="hidden" name="price" value="1999"><input type="hidden" name="quantity" value="1"><button class="btn-add">Add to Cart</button></form></div>
                    </div>

                    <div class="prod-card" data-name="Men Blue T-Shirt" data-category="Men" data-price="999">
                        <img src="images/tshirt.jpg"><div class="prod-info"><h3>Men Blue T-Shirt</h3><div class="brand">H&M</div><div class="price">₹ 999.00</div>
                        <form action="product-details" method="get"><input type="hidden" name="id" value="1"><button class="btn-view">View Details</button></form>
                        <form action="cart" method="post"><input type="hidden" name="action" value="add"><input type="hidden" name="productId" value="1"><input type="hidden" name="productName" value="Men Blue T-Shirt"><input type="hidden" name="brand" value="H&M"><input type="hidden" name="size" value="XL"><input type="hidden" name="image" value="images/tshirt.jpg"><input type="hidden" name="price" value="999"><input type="hidden" name="quantity" value="1"><button class="btn-add">Add to Cart</button></form></div>
                    </div>

                    <div class="prod-card" data-name="Women Handbag" data-category="Women" data-price="1899">
                        <img src="images/handbag.jpg"><div class="prod-info"><h3>Women Handbag</h3><div class="brand">ZARA</div><div class="price">₹ 1899.00</div>
                        <form action="product-details" method="get"><input type="hidden" name="id" value="7"><button class="btn-view">View Details</button></form>
                        <form action="cart" method="post"><input type="hidden" name="action" value="add"><input type="hidden" name="productId" value="7"><input type="hidden" name="productName" value="Women Handbag"><input type="hidden" name="brand" value="ZARA"><input type="hidden" name="size" value="One Size"><input type="hidden" name="image" value="images/handbag.jpg"><input type="hidden" name="price" value="1899"><input type="hidden" name="quantity" value="1"><button class="btn-add">Add to Cart</button></form></div>
                    </div>

                </div>
                <div class="no-result" id="noResult">No products found for this filter.</div>
            </div>
        </div>
    </div>

<script>
function applyFilters() {
    var search = document.getElementById('searchInput').value.toLowerCase();
    var cat = document.getElementById('categoryFilter').value;
    var min = parseInt(document.getElementById('minPrice').value) || 0;
    var max = parseInt(document.getElementById('maxPrice').value) || 5000;
    var sort = document.getElementById('sortFilter').value;
    var grid = document.getElementById('productGrid');
    var cards = Array.from(grid.getElementsByClassName('prod-card'));
    var visible = 0;
    cards.forEach(function(card){
        var name = card.getAttribute('data-name').toLowerCase();
        var category = card.getAttribute('data-category');
        var price = parseInt(card.getAttribute('data-price'));
        var show = name.includes(search) && (cat === 'All' || category === cat) && price >= min && price <= max;
        card.style.display = show ? '' : 'none';
        if(show) visible++;
    });
    if(sort === 'low') cards.sort((a,b)=> parseInt(a.getAttribute('data-price')) - parseInt(b.getAttribute('data-price')));
    if(sort === 'high') cards.sort((a,b)=> parseInt(b.getAttribute('data-price')) - parseInt(a.getAttribute('data-price')));
    cards.forEach(c => grid.appendChild(c));
    document.getElementById('noResult').style.display = visible === 0 ? 'block' : 'none';
}
function clearFilters() {
    document.getElementById('searchInput').value = '';
    document.getElementById('topSearchInput').value = '';
    document.getElementById('categoryFilter').value = 'All';
    document.getElementById('minPrice').value = 0;
    document.getElementById('maxPrice').value = 5000;
    document.getElementById('sortFilter').value = 'Default';
    applyFilters();
}
function topSearch() {
    var val = document.getElementById('topSearchInput').value;
    document.getElementById('searchInput').value = val;
    applyFilters();
    return false;
}
window.onload = function() {
    var params = new URLSearchParams(window.location.search);
    var s = params.get('search');
    if(s) {
        document.getElementById('searchInput').value = s;
        document.getElementById('topSearchInput').value = s;
        applyFilters();
    }
}
</script>
</body>
</html>