package org.example;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;


@Entity
public class User {
    @Id
    private int user_id;
    private String f_name;
    private String l_name;
    private String username;
    private String password;


    public int getUser_id() {
        return user_id;
    }

    public String getF_name() {
        return f_name;
    }

    public String getL_name() {
        return l_name;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }


    @Override
    public String toString() {
        return "User{" +
                "user_id=" + user_id +
                ", f_name='" + f_name + '\'' +
                ", l_name='" + l_name + '\'' +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                '}';
    }

}


