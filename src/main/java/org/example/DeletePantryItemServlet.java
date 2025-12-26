package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

@WebServlet("/deletePantryItem")
public class DeletePantryItemServlet extends HttpServlet{

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String idString = request.getParameter("id");

        int itemId = Integer.parseInt(idString);

        SessionFactory factory = new Configuration()
                .addAnnotatedClass(org.example.Pantry_Item.class)
                .configure()
                .buildSessionFactory();

        Session session = factory.openSession();

        Transaction transaction;

        transaction = session.beginTransaction();

        Pantry_Item item = session.find(Pantry_Item.class, itemId);
        session.remove(item);

        transaction.commit();
        response.sendRedirect("pantry.jsp");

                session.close();
                factory.close();


    }

}

