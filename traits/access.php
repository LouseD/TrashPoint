<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

Trait Access {
    
    
    /**
     * Login
     * 
     * @param   string  $username  Username
     * @param   string  $password  Password
     * 
     * @return string | Exception
     * $throws exception
     */
    public function login($username, $password) {
        // knap så dynamisk..
        $sql = "SELECT name_user, password_user FROM user WHERE name_user = '{$username}' AND password_user = '{$password}'";
        $rs = $this -> con -> query($sql);
        //sql sætningen dur.
        if (mysqli_num_rows($rs) == 0) {
                //Forkert password eller username
                throw new Exception("Der gik noget galt under login - prøv igen.");
        } else if (mysqli_num_rows($rs) > 1) {
                //Der er flere brugere med samme brugernavn
                throw new Exception("Der er flere brugere ved dette navn, kontakt venligst administratoren");
        } else {
                //Kør sessions
                $aut_user = $rs -> fetch_object();
                $_SESSION['id'] = $aut_user -> id_user;
                $_SESSION['name'] = $aut_user -> name_user;
                $succes = "<p class='text-center pad-top-50'>Du er nu logget ind som '" . ucfirst($_SESSION['name']) . "'</p>";
                return $succes;
        }
    }
    
    /**
     * 
     */
    public function logout()
    {
        
    }
    
}