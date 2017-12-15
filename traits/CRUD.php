<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

Trait CRUD 
{
    
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
    
    
    
    
}