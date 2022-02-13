<%-- 
    Document   : admin
    Created on : 12-Feb-2022, 1:21:56 am
    Author     : mayankchoudhary
--%>
<%@page import="java.util.Map"%>
<%@page import="com.mayank.mayank_ecommerce_application.helper.Helper"%>
<%@page import="java.util.List"%>
<%@page import="com.mayank.mayank_ecommerce_application.entities.Category"%>
<%@page import="com.mayank.mayank_ecommerce_application.dao.CategoryDao"%>
<%@page import="com.mayank.mayank_ecommerce_application.helper.FactoryProvider"%>
<%@page import="com.mayank.mayank_ecommerce_application.entities.User"%>
<%--    Providing Protection from normal user and non registerred user  --%>
<%
    User user = (User) session.getAttribute("current-user");
    if (user == null) {
        session.setAttribute("message", "You are not logged in !! Log in first");
        response.sendRedirect("login.jsp");
        return;
    } else {
        //kuch na kuch to hai bhai password

        if (user.getUserType().equals("normal")) {
            session.setAttribute("message", "You are not ADMIN !! Do not acces this page !! ");
            response.sendRedirect("login.jsp");

            return;

        }
    }
%>
 
            <% 
               CategoryDao cdao=new CategoryDao(FactoryProvider.getFactory());
               
               List<Category> list=cdao.getCategories();
               
//getting count

     Map<String,Long> m=Helper.getCounts(FactoryProvider.getFactory());
              

            %>
           

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>

        <%@include file="Components/common_css_js.jsp" %>
    </head>
    <body>

        <%@include file="Components/navbar.jsp" %>


        <div class="container admin">

            
            <div class="container-fluid mt-3">
                
                <%@include file="Components/message.jsp" %>
            </div>
            
            <!--first row-->
            <div class="row mt-3">
                <!--first column-->
                <div class="col-md-4">

                    <!--first box-->
                    <div class="card">

                        <div class="card-body text-center">

                            <div class="container">

                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/users.png" alt="user_icon"/>
                            </div>
                            <h1><%=m.get("userCount")%></h1>
                            <h1 class="text-uppercase text-muted">Users</h1>
                        </div>
                    </div>
                </div>
                <!--second column-->
                <div class="col-md-4">

                    <div class="card">

                        <div class="card-body text-center">

                            <div class="container">

                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/categories.png" alt="user_icon"/>
                            </div>
                            <h1><%=list.size()%></h1>
                            
                            <h1 class="text-uppercase text-muted">Categories</h1>
                        </div>
                    </div>
                </div>
                <!--third column-->
                <div class="col-md-4">

                    <div class="card">

                        <div class="card-body text-center">
                            <div class="container">

                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/products.png" alt="user_icon"/>
                            </div>
                            <h1><%=m.get("productCount")%></h1>
                            <h1 class="text-uppercase text-muted">Products</h1>
                        </div>
                    </div>
                </div>

            </div>
            <!--second row-->
            <div class="row mt-3">

                <!--second row first column-->
                <div class="col-md-6">

                    <div class="card" data-toggle="modal" data-target="#add-category-modal">

                        <div class="card-body text-center">
                            <div class="container">

                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/addcategory.png" alt="user_icon"/>
                            </div>
                            <p class="mt-2">Click here to add new category</p>
                            <h1 class="text-uppercase text-muted">Add Category</h1>
                        </div>
                    </div>

                </div>

                <!--second row second column-->
                <div class="col-md-6">

                    <div class="card" data-toggle="modal" data-target="#add-product-modal">

                        <div class="card-body text-center">
                            <div class="container">

                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/addproduct.png" alt="user_icon"/>
                            </div>
                            <p class="mt-2">Click here to add new Product.</p>
                            <h1 class="text-uppercase text-muted">Add Product</h1>
                        </div>
                    </div>

                </div>

            </div>

        </div>
        <!--add category model-->


        <!-- Modal -->
        <div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Fill Category Details.</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        
                        <form action="ProductOperationServlet" method="post">
                            
                            <input type="hidden" name="operation" value="addcategory"/> 
                            
                            <div class="form-group">
                                
                                <input type="text" class="form-control" name="catTitle" placeholder="Enter Category Title" required/>
                            </div>
                            <div class="form-group">
                                
                                <textarea  style=" height:300px;" class="form-control" placeholder="Enter category description" name="catDescription" required></textarea>
                            </div>
                            <div class="container text-center">
                                
                                <button class="btn btn-outline-success">Add Category</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                            
                        </form>
                    </div>
                    
                </div>
            </div>
        </div>
        <!--End add category modal-->
        
        <!--++++++++++++++++++++++++++++++++++++++++++++++++++-->
        
        
        <!--start of product model-->

<!-- Modal -->
<div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="add-product-modal">Product Details</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <!--start form-->
        
        
        <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
            
            <input type="hidden" name="operation" value="addproduct"/>
            <!--product title-->
            
            <div class="form-group">
                <input type="text" class="form-control" placeholder="Enter title of product." name="pName" required/>
                 </div>
            
            <!--product description-->
            
            <div class="form-group">
                
                <textarea style="height:150px;" class="form-control" placeholder="Enter Product description." name="pDesc"></textarea>
            </div>
            
            <!--product price-->
            
            <div class="form-group">
                <input type="number" class="form-control" placeholder="Enter price of product." name="pPrice" required/>
                 </div>
            
            <!--product disount-->
            
            <div class="form-group">
                <input type="number" class="form-control" placeholder="Enter discount of product." name="pDiscount" required/>
                 </div>
            
            <!--product quantity-->
            
            <div class="form-group">
                <input type="number" class="form-control" placeholder="Enter Product quantity." name="pQuantity" required/>
                 </div>
            <!--categories dropdown fetch from database-->
            
            <div class="form-group">
            
                
                <select name="catId" id="" class="form-control">
                  
                    <%
                      for(Category c:list){
                    %>
                    <option value="<%=c.getCategoryId()%>"><%=c.getCategoryTitle()%></option>
                    
                    <%
                        }
                    %>
                </select>
            
            </div>
            
            <!--product files-->
            
            <div class="form-group">
                
                <label for="pPic">Select picture of products</label>
                <br>
                <input type="file" id=pPic" name="pPic" required/>
                
            </div>
            
            <!--submit button-->
            
            <div class="container text-center">
                
                <button class="btn btn-outline-success">Add Product</button>
            </div>
            
        </form>
        
        <!--end form-->
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
        
        <!--end of product model-->
        
        <%@include file="Components/common_modals.jsp" %>
    </body>
</html>
