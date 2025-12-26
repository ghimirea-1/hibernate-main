package org.example;

import java.util.Set;
import java.util.HashSet;

import jakarta.persistence.*;

import java.util.HashSet;

@Entity
public class Recipe {



    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int recipe_id;
    private String recipe_name;
    private String recipe_category;
    private String recipe_instructions;

    @ElementCollection
    @JoinTable(
            name = "recipe_ingredient",
            joinColumns = @JoinColumn(name = "recipe_id")
    )
    private Set<String> ingredientNames = new HashSet<>();

    public int getRecipe_id() {
        return recipe_id;
    }

    public void setRecipe_id(int recipe_id) {
        this.recipe_id = recipe_id;
    }

    public String getRecipe_name() {
        return recipe_name;
    }

    public void setRecipe_name(String recipe_name) {
        this.recipe_name = recipe_name;
    }

    public String getRecipe_category() {
        return recipe_category;
    }

    public void setRecipe_category(String recipe_category) {
        this.recipe_category = recipe_category;
    }

    public String getRecipe_instructions() {
        return recipe_instructions;
    }

    public void setRecipe_instructions(String recipe_instructions) {
        this.recipe_instructions = recipe_instructions;
    }

    public Set<String> getIngredientNames() {
        return ingredientNames;
    }

    public void setIngredientNames(Set<String> ingredientNames) {
        this.ingredientNames = ingredientNames;
    }

    @Override
    public String toString() {
        return "Recipe{" +
                "recipe_id=" + recipe_id +
                ", recipe_name='" + recipe_name + '\'' +
                ", recipe_category='" + recipe_category + '\'' +
                ", recipe_instructions='" + recipe_instructions + '\'' +
                ", ingredientNames=" + ingredientNames +
                '}';
    }

}
