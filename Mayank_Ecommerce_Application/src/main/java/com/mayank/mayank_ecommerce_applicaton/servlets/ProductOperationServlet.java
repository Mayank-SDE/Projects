/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mayank.mayank_ecommerce_applicaton.servlets;

import com.mayank.mayank_ecommerce_application.dao.CategoryDao;
import com.mayank.mayank_ecommerce_application.dao.ProductDao;
import com.mayank.mayank_ecommerce_application.entities.Category;
import com.mayank.mayank_ecommerce_application.entities.Product;
import com.mayank.mayank_ecommerce_application.helper.FactoryProvider;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author mayankchoudhary
 */

@MultipartConfig
public class ProductOperationServlet extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
          
            //servlet 2 kam kar rha hai
            //1.add category
            //2.add product
            
           String op=request.getParameter("operation");
            
            if(op.trim().equals("addcategory"))
            {
                //1.add category
             
                   //Fetching Category data
            String title=request.getParameter("catTitle");
            String description=request.getParameter("catDescription");
         
               Category category=new Category();
               category.setCategoryTitle(title);
               category.setCategoryDescription(description);
            
               //saving category inside database
               //with the help of dao layer
               CategoryDao categoryDao=new CategoryDao(FactoryProvider.getFactory());
             int catId=categoryDao.saveCategory(category);
             
             //out.println("Category Saved.");
             
            HttpSession httpSession=request.getSession();
            httpSession.setAttribute("message","Category added successfully : "+catId);
            response.sendRedirect("admin.jsp");
            return;
            }
            else if(op.trim().equals("addproduct"))
            {
                //2.add product
                     //  out.println("Product saved");
                
               String pName=request.getParameter("pName");
               String pDesc=request.getParameter("pDesc");
               int pPrice=Integer.parseInt(request.getParameter("pPrice"));
               int pDiscount=Integer.parseInt(request.getParameter("pDiscount"));
               int pQuantity=Integer.parseInt(request.getParameter("pQuantity"));
               
               int catId=Integer.parseInt(request.getParameter("catId"));
               
               Part part=request.getPart("pPic");
               
               Product p=new Product();
               
               p.setpName(pName);
               p.setpDesc(pDesc);
               p.setpDiscount(pDiscount);
               p.setpPrice(pPrice);
               p.setpId(catId);
               p.setpPhoto(part.getSubmittedFileName());
              
               //now i want category by id
               
               CategoryDao cdao=new CategoryDao(FactoryProvider.getFactory());
               Category category=cdao.getCategoryById(catId);
               p.setCategory(category);
               
               //saving product into database
               
               ProductDao pDao=new ProductDao(FactoryProvider.getFactory());
               pDao.saveProduct(p);
               
              
                //pic upload
                
//                find out the path to upload photo


                String path=request.getRealPath("img")+File.separator+"products"+File.separator+part.getSubmittedFileName();
                System.out.println(path);
               
                //uploading code
                
                try{
                FileOutputStream fos=new FileOutputStream(path);
                
                InputStream is= part.getInputStream();
                
                //reading data
                
                byte[] data=new byte[is.available()];
                is.read(data);
                
                
                //writing data
                
                
                fos.write(data);
                
                fos.close();
                }
                catch(Exception e)
                {
                e.printStackTrace();
                
                }
                
               out.println("Product save success....");
               
               HttpSession httpSession=request.getSession();
            httpSession.setAttribute("message","Product added successfully : "+catId);
            response.sendRedirect("admin.jsp");
            return;
            
            }
            else
            {
                      // out.println("nothing is saved");
            
            }
            
            
            
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
