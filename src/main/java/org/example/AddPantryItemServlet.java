package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import java.io.IOException;
import java.util.Date;

@WebServlet("/addPantryItem")
public class AddPantryItemServlet extends HttpServlet{

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String item_name = request.getParameter("item_name");
        String item_category = request.getParameter("item_category");
        int item_quantity = Integer.parseInt(request.getParameter("item_quantity"));
        String item_unit = request.getParameter("item_unit");
        String last_bought_str = request.getParameter("last_bought");
        String exp_date_str = request.getParameter("exp_date");

        Date last_bought = java.sql.Date.valueOf(last_bought_str);
        Date exp_date = java.sql.Date.valueOf(exp_date_str);

        SessionFactory factory = new Configuration()
                .addAnnotatedClass(Pantry_Item.class)
                .configure()
                .buildSessionFactory();

        Session session = factory.openSession();
        Transaction transaction;


        transaction = session.beginTransaction();

        Pantry_Item item = new Pantry_Item();
        item.setItem_name(item_name);
        item.setItem_category(item_category);
        item.setItem_quantity(item_quantity);
        item.setItem_unit(item_unit);
        item.setLast_bought(last_bought);
        item.setExp_date(exp_date);

        session.persist(item);


        transaction.commit();
        response.sendRedirect("pantry.jsp");

        session.close();
        factory.close();


    }

}

