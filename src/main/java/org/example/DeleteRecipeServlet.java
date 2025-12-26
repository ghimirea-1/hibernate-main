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

@WebServlet("/deleteRecipe")
public class DeleteRecipeServlet extends HttpServlet{

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String idString = request.getParameter("id");

        int itemId = Integer.parseInt(idString);

        SessionFactory factory = new Configuration()
                .addAnnotatedClass(org.example.Recipe.class)
                .configure()
                .buildSessionFactory();

        Session session = factory.openSession();

        Transaction transaction;

        transaction = session.beginTransaction();

        Recipe item = session.find(Recipe.class, itemId);
        session.remove(item);

        transaction.commit();
        response.sendRedirect("recipe.jsp");

        session.close();
        factory.close();


    }

}

