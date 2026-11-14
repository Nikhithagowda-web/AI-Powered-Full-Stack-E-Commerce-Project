<%@ page import="java.util.*,com.fashionstore.model.Product" %>
<%
Product p=(Product)request.getAttribute("product");
List<Product> all=(List<Product>)request.getAttribute("allProducts");
if(all==null) all=new ArrayList<>();
String ctx=request.getContextPath();
List<String> sizes=(List<String>)request.getAttribute("sizes");
if(sizes==null) sizes=Arrays.asList("Free Size");
%>
<!DOCTYPE html><html><head><title><%=p.getName()%></title>
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:Arial} body{background:linear-gradient(160deg,#1b0b38,#2e1a6b);color:#fff}
.wrap{max-width:900px;margin:auto;padding:20px}
.topsearch{display:flex;justify-content:center;margin-bottom:20px}.topsearch input{padding:9px;width:300px;border-radius:20px 0 0 20px;border:none}.topsearch button{background:#00cfff;border:none;padding:9px 16px;border-radius:0 20px 20px 0}
.back{font-size:12px;color:#fff;text-decoration:none}
.detail{display:flex;background:#3a2a63;border-radius:14px;overflow:hidden;margin:14px 0}
.detail img{width:50%;object-fit:cover;background:#fff}.right{padding:22px}
.right span{font-size:11px;opacity:.7}.right h2{margin:6px 0}.right b{font-size:11px;opacity:.8}.price{color:#4dc9ff;font-weight:bold;margin:8px 0}.right p{font-size:13px;opacity:.9}
.size{display:inline-block;background:#fff;color:#000;padding:6px 12px;border-radius:20px;font-size:12px;margin:6px 4px 12px 0;cursor:pointer;border:2px solid transparent}
.size.sel{border-color:#22c9ff}
.btn{background:#22c9ff;border:none;padding:9px 18px;border-radius:20px;font-weight:bold;cursor:pointer}.btnW{background:#fff;border:none;padding:9px 16px;border-radius:20px;cursor:pointer;margin-left:8px}
.may{background:#3a2a63;border-radius:14px;padding:16px;margin-top:16px}.may h3{margin-bottom:12px}
.mayGrid{display:grid;grid-template-columns:repeat(4,1fr);gap:12px}.mini{background:#fff;border-radius:10px;overflow:hidden;text-align:center;color:#000;padding-bottom:10px;text-decoration:none}.mini img{width:100%;height:110px;object-fit:cover}.mini b{font-size:11px;display:block;margin-top:6px}.mini span{font-size:11px}
</style></head><body>
<div class="wrap">
<form class="topsearch" action="<%=ctx%>/products"><input name="search" placeholder="Search products..."><button>Search</button></form>
<a class="back" href="<%=ctx%>/products">← Back to Products</a>
<div class="detail"><img src="<%=ctx%>/images/<%=p.getImage()%>">
<div class="right"><span><%=p.getCategory()%></span><h2><%=p.getName()%></h2><b><%=p.getBrand()%></b><div class="price">₹ <%=p.getPrice()%>.00</div><p><%=p.getDescription()%></p>
<div style="font-size:12px;margin-top:12px">Select Size:</div>
<div id="sizes"><% for(String s: sizes){ %><span class="size" onclick="sel(this)"><%=s%></span><% } %></div>
<button class="btn" onclick="add()">Add to Cart</button><a href="<%=ctx%>/products"><button type="button" class="btnW">Back</button></a>
</div></div>
<div class="may"><h3>You may also like</h3><div class="mayGrid">
<% int c=0; for(Product o: all){ if(o.getId()==p.getId()) continue; if(c++>=4) break; %>
<a class="mini" href="<%=ctx%>/product-details?id=<%=o.getId()%>"><img src="<%=ctx%>/images/<%=o.getImage()%>"><b><%=o.getName()%></b><span>₹<%=o.getPrice()%></span></a><% } %>
</div></div></div>
<script>
let selSize='<%=sizes.size()>0?sizes.get(0):"M"%>';
function sel(el){ document.querySelectorAll('.size').forEach(x=>x.classList.remove('sel')); el.classList.add('sel'); selSize=el.innerText; }
document.querySelector('.size')?.classList.add('sel');
function add(){ let cart=JSON.parse(localStorage.getItem('cart')||'[]'); let f=cart.find(x=>x.id==<%=p.getId()%> && x.size==selSize); if(f) f.qty++; else cart.push({id:<%=p.getId()%>,name:'<%=p.getName()%>',img:'<%=p.getImage()%>',price:<%=p.getPrice()%>,qty:1,size:selSize,brand:'<%=p.getBrand()%>'}); localStorage.setItem('cart',JSON.stringify(cart)); alert('<%=p.getName()%> ('+selSize+') added to cart'); }
</script></body></html>