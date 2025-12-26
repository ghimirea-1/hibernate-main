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
@WebServlet("/addRecipe")
public class AddRecipeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String recipe_name = request.getParameter("recipe_name");
        String recipe_category = request.getParameter("recipe_category");
        String recipe_instructions = request.getParameter("recipe_instructions");
        String ingredientStr = request.getParameter("ingredient_list");

        SessionFactory factory = new Configuration()
                .configure()
                .addAnnotatedClass(Recipe.class)
                .addAnnotatedClass(Pantry_Item.class)
                .buildSessionFactory();

        Session session = factory.openSession();
        Transaction transaction = session.beginTransaction();

        Recipe recipe = new Recipe();
        recipe.setRecipe_name(recipe_name);
        recipe.setRecipe_category(recipe_category);
        recipe.setRecipe_instructions(recipe_instructions);

        // Add ingredients
        if (ingredientStr != null && !ingredientStr.trim().isEmpty()) {
            String[] ingredients = ingredientStr.split(",");
            for (String ing : ingredients) {
                recipe.getIngredientNames().add(ing.trim());
            }
        }

        session.persist(recipe);
        transaction.commit();

        session.close();
        factory.close();

        response.sendRedirect("recipes.jsp");
    }
}
