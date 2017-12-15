<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

Trait CRUD 
{
    
    /**
     * 
     */
    public function __construct() {
        $this -> con = new mysqli('', '', '', '');
        $this -> con -> set_charset("utf8");
        //fejlmeddelelse
        if ($this -> con -> connect_errno) {
                die('Can not connect to database: (' . $this -> con -> connect_errno . ')' . $this -> con -> connect_error);
        }
    }
    
    /**
     * List all or one thing from a table
     * 
     * @param   string   $table  Table in db
     * @param   integer  $id     Id of the item to be read
     * @return type
     * @throws Exception
     */
    public function read($table, $id = null) 
    {
        // @TODO: Make id selective.
        
        $ar  = [];
        $sql = "SELECT * FROM {$table}";
        
        if ($id != null)
        {
           $sql = "WHERE id_{$table} = {$id}"; 
        }
        
        $rs  = $this -> con -> query($sql);

        if (mysqli_num_rows($rs) == 0) {
                //Forkert sql sætning
                throw new Exception("Der gik noget galt, kontakt venligst administratoren");
        } else {
                //Korrekt sql sætning
                while ($row = $rs -> fetch_assoc()) {
                        $ar[] = $row;
                }
                return $ar;

        }
    }
    
    /**
     * Create a row in db
     * 
     * @param type $table
     * @param type $array
     * @throws Exception
     */
    public function create($table, $array) 
    {
        /*Tæller op for at afgøre hvornår sidste iteration er*/
        $i = 0;
        $length = count($array);
        /**/
        $sql = "INSERT INTO {$table}(id_{$table}, ";
        foreach ($array as $column => $value) {
                if ($i == $length - 1) {
                        $sql .= $column . ") VALUES ('',";
                }else{
                        $sql .= $column . ", ";
                }
                $i++;
        }
        $i = 0;
        foreach ($array as $column => $value) {
                /*$check = "SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS 
                                        WHERE table_name = '{$table}' 
                                        AND COLUMN_NAME = '{$value}'";*/

                if ($i == $length - 1) {
                        $sql .= "'" . $value . "')";
                } else {
                        $sql .= "'" . $value . "', ";
                }
                $i++;
        }
        echo "rs er udkommenteret";
        //$rs = $this->con->query($sql);

        if(mysqli_num_rows($rs) == 0){
                throw new Exception("Der skete en fejl ved oprettelse");
        }else{
                echo "Korrekt: " . $sql;
        }
    }
    
    /**
     * 
     * @param   string  $table  Table of the table that needs to be deleted
     * @param   integer $id     Selective id of the row that needs to be deleted;
     */
    public function delete($table, $id = null) {
        
        $sql = "DELETE FROM {$table}";
        if ($id != null)
        {
          $sql = " WHERE id_{$table} = {$id}";  
        }
        $this -> con -> query($sql);
    }
    
    /**
     * 
     * @param   string  $table  table in db
     * @param   array   $array  array with what needs to be changed
     * @param   integer $id     selective id of row that needs to be changed
     * 
     * @return  array
     */
    public function update($table, $array, $id = null) {
            /*Tæller op for at afgøre hvornår sidste iteration er*/
            $i = 0;
            $length = count($array);
            $sql = "UPDATE {$table} SET ";
            foreach ($array as $column => $value) {
                    if ($i == $length - 1) {
                            $sql .= $column . " = '" . $value . "' ";
                    }else{
                            $sql .= $column . " = '" . $value . "', ";
                    }
                    $i++;
            }
            if ($id != null)
            {
                $sql .= "WHERE id_{$table} = {$id}";
            }
            
            $rs = $this -> con -> query($sql);
            
            return $rs;
    }
    
    
}