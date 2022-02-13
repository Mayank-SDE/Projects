/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mayank.mayank_ecommerce_application.dao;

import com.mayank.mayank_ecommerce_application.entities.Category;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

/**
 *
 * @author mayankchoudhary
 */
public class CategoryDao {
    
    private SessionFactory factory;

    public CategoryDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    //saves the category to db
    public int saveCategory(Category cat)
    {
         Session session=this.factory.openSession();
         Transaction tx=session.beginTransaction();
     
          int catId=(int)session.save(cat);
        
        tx.commit();
        session.close(); 
    return catId;
    }
    
    
    //fetching list of categories
    
    public List<Category> getCategories()
    {
         Session s=this.factory.openSession();
         Query query=s.createQuery("from Category");
         List<Category> list=query.list();
         
         return list;
    }
    
    //getting category object by id
    
    public Category getCategoryById(int cid)
    {
        Category cat=null;
    try{
    
        Session session=this.factory.openSession();
        session.get(Category.class,cid);
        session.close();
    }
    catch(Exception e)
    {
    e.printStackTrace();
    }
    return cat;
    }
    
}
