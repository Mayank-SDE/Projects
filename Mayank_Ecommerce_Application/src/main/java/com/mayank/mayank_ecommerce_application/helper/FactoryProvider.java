
package com.mayank.mayank_ecommerce_application.helper;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author mayankchoudhary
 */

public class FactoryProvider {
 
    private static SessionFactory factory;
    
    public static SessionFactory getFactory()
    {
        try{
        
            if(factory==null)
            {
                //singelton design pattern
           factory= new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
            }
        }
        catch(Exception e)
        {
        e.printStackTrace();
        }
        
        return factory;
    
    }
}
