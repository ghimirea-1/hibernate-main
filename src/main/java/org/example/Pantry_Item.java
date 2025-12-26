package org.example;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;


import java.util.Date;
@Entity
public class Pantry_Item {
    @Id
    private int item_id;
    private String item_name;
    private String item_category;
    private int item_quantity;
    private String item_unit;
    private Date exp_date;
    private Date last_bought;


    public int getItem_id() {
        return item_id;
    }

    public void setItem_id(int item_id) {
        this.item_id = item_id;
    }

    public String getItem_name() {
        return item_name;
    }

    public void setItem_name(String item_name) {
        this.item_name = item_name;
    }

    public String getItem_category() {
        return item_category;
    }

    public void setItem_category(String item_category) {
        this.item_category = item_category;
    }


    public int getItem_quantity() {
        return item_quantity;
    }

    public void setItem_quantity(int item_quantity) {
        this.item_quantity = item_quantity;
    }

    public String getItem_unit() {
        return item_unit;
    }

    public void setItem_unit(String item_unit) {
        this.item_unit = item_unit;
    }

    public Date getExp_date() {
        return exp_date;
    }

    public void setExp_date(Date exp_date) {
        this.exp_date = exp_date;
    }

    public Date getLast_bought() {
        return last_bought;
    }

    public void setLast_bought(Date last_bought) {
        this.last_bought = last_bought;
    }

    @Override
    public String toString() {
        return "Pantry_Item{" +
                "item_id=" + item_id +
                ", item_name='" + item_name + '\'' +
                ", item_category='" + item_category + '\'' +
                ", item_quantity=" + item_quantity +
                ", item_unit='" + item_unit + '\'' +
                ", exp_date=" + exp_date +
                ", last_bought=" + last_bought +
                '}';
    }



}


