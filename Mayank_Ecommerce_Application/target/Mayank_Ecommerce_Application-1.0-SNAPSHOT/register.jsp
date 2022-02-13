<%-- 
    Document   : register
    Created on : 11-Feb-2022, 8:42:28 am
    Author     : mayankchoudhary
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New User Registration</title>
        <%@ include file="Components/common_css_js.jsp"%>

    </head>
    <body>
         <%@include file="Components/navbar.jsp" %>
         <div class="container-fluid">
             
         <div class="row mt-3">
             
             <div class="col-md-6 offset-md-3">
                 
                 <div class="card">
                     <%@include file="Components/message.jsp"%>
                 <div class="card-body px-5">
                     <div class="container text-center">
                         <img src="img/add-friend.png" style="max-width: 100px;" class="img-fluid">
                     </div>
                           <h3 class="text-center my-3">Sign Up here !</h3>
                 <form action="RegisterServlet" method="post">
                      <div class="form-group">
    <label for="name">User Name</label>
    <input name="user_name" type="text" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Enter here">
  </div>
                     
                      <div class="form-group">
    <label for="email">User Email</label>
    <input name="user_email" type="email" class="form-control" id="email" aria-describedby="emailHelp" placeholder="Enter here">
  </div>
                      <div class="form-group">
    <label for="password">User password</label>
    <input name="user_password" type="password" class="form-control" id="password" aria-describedby="emailHelp" placeholder="Enter here">
  </div>
             <div class="form-group">
    <label for="phone">User phone</label>
    <input name="user_phone" type="number" class="form-control" id="phone" aria-describedby="emailHelp" placeholder="Enter here">
  </div>
             <div class="form-group">
    <label for="address">User Address</label>
    
    <textarea name="user_address" style="height:200px;" class="form-control" placeholder="Enter your Address.">
       
    </textarea>
        </div>
                      
                     <div class="container text-center">
                         
                         <button class="btn btn-outline-success">Register</button>
                         <button class="btn btn-outline-warning">Reset</button>
                         
                     </div>
             
                 </form>
                 
                 </div> 
             </div>
         </div>
         </div>
         </div>
        
    </body>
</html>
