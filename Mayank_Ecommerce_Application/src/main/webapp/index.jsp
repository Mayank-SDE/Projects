<%-- 
    Document   : index.jsp
    Created on : 11-Feb-2022, 7:19:02 am
    Author     : mayankchoudhary
--%>

<%@page import="com.mayank.mayank_ecommerce_application.helper.Helper"%>
<%@page import="com.mayank.mayank_ecommerce_application.entities.Category"%>
<%@page import="com.mayank.mayank_ecommerce_application.dao.CategoryDao"%>
<%@page import="java.util.List"%>
<%@page import="java.lang.*"%>

<%@page import="com.mayank.mayank_ecommerce_application.entities.Product"%>
<%@page import="com.mayank.mayank_ecommerce_application.dao.ProductDao"%>
<%@page import="com.mayank.mayank_ecommerce_application.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MayankCart - Home</title>
<%@ include file="Components/common_css_js.jsp"%>

    </head>
    <body>
        <%@include file="Components/navbar.jsp" %>
        
        <script src="js/script.js"></script>

        <div class="container-fluid">
        <div class="row mt-3 mx-2">
            
            <%
                
                String cat=request.getParameter("category");
              //  out.println(cat);
                
                
              ProductDao dao=new ProductDao(FactoryProvider.getFactory());
            List<Product> list=null; 
           
            if(cat==null || cat.trim().equals("all"))
              {
            list=dao.getAllProducts();
              
            }
            else 
            {
            int cid=Integer.parseInt(cat.trim());
            list=dao.getAllProductsById(cid);
            }
            
              CategoryDao cdao=new CategoryDao(FactoryProvider.getFactory());
              List<Category> clist=cdao.getCategories();
              

            %>
            <!--show categories-->
            <div class="col-md-2">
                
                <div class="list-group mt-4">
                    
                     <a href="index.jsp?category=all" class="list-group-item list-group-item-action active">All Products</a>
                     
                <%
                for(Category c:clist)
                {
                
                %>
                <a href="index.jsp?category=<%=c.getCategoryId()%>" class="list-group-item list-group-item-action"><%=c.getCategoryTitle()%></a>
                    <%
                        }
                
                %>
                  </div>
              
            </div>
            <!--show products-->
            <div class="col-md-10">
                
              <!--row-->
              <div class="row mt-4">
                  
                  <div class="col-md-12">
                      
                      <div class="card-columns">
                          
                          <!--traversing products-->
                          
                          <%
                           if(list!=null)
                           {
                           for(Product p:list)
                           {
                          %>
                          
                          
                          <!--//product card-->
                          <div class="card product-card">
                              <div class="container text-center">
                              <img class="card-img-top m-2" src="img/products/<%=p.getpPhoto()%>" style="max-height: 200px; max-width: 100%; width: auto;" alt="Card image cap">
                          </div>
                          
                          <div class="card-body">
                                  
                                  
                                  <h5 class="card-title"><%=p.getpName()%></h5>
                                  <p class="card-text">
                                      
                                      <%=Helper.get10Words(p.getpDesc())%>
                                      
                                  </p>
                                  
                              </div>
                                      <div class="card-footer text-center">
                                          
                                          <button class="btn custom-bg text-white" onclick="add_to_cart(<%=p.getpId()%>,'<%=p.getpName()%>',<%=p.getPriceAfterApplyingDiscount()%>)">ADD TO CART</button>
                                          <button class="btn btn-outline-success "> &#x20B9; <%=p.getPriceAfterApplyingDiscount()%>/-  <span class="text-secondary discount-label">&#x20B9;<%=p.getpPrice()%> <%=p.getpDiscount()%>% off</span></button>
                                      
                                      </div>
                          </div>
                          <%
                          }
}
else
{
   out.println("<h3>No item in this category</h3>");
}
                          %>
                          
                          
                      </div>
                      
                      
                  </div>
              </div>
            </div>
        </div>
                          </div>
                          
                          <%@include file="Components/common_modals.jsp"%>
                          
    </body>
</html>
