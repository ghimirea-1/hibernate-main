package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Servlet implementation class loginServlet
 */
@WebServlet("/login")
public class loginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public loginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("login.html");
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:8889/ADVJAVAPROJ","root","root");
            Statement st = conn.createStatement();
            String query = "SELECT * FROM user_tab WHERE username='" + username + "' AND password='" + password + "'";
            ResultSet rs= st.executeQuery(query);

            if(rs.next()) {
                HttpSession session = request.getSession(true);
                session.setAttribute("username", username);

                Cookie userCookie = new Cookie("username", username);
                userCookie.setMaxAge(60*60);
                response.addCookie(userCookie);
                response.sendRedirect(request.getContextPath() + "/planner.jsp");

            }

            else {
                out.println("<h1>LoginFailed<h1>");


            }


            rs.close();
            st.close();
            conn.close();

        }
        catch( ClassNotFoundException e) {

            e.printStackTrace();

        }	catch(SQLException e) {

            e.printStackTrace();

        }



    }


}
