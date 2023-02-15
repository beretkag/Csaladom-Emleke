<template>
    
    <table v-for="felhasznalo in felhasznalok">
        <tr>
            <td>
                {{felhasznalo}}
            </td>
            <td>
                Módosítás
            </td>
            <td>
                Törlés
            </td>
        </tr>
    </table>

   </template>
   
   <script>

import axios from "axios";

export default{
data(){
    return {
        felhasznalok: []
           }
      },
   
created(){
    axios.get(this.$store.baseURL + "/felhasznalok/nev").then(res => {
        let data = res.data;
            this.felhasznalok = res.data 
    })
    .catch(err => {
        console.log(err);
    });
    }
}

   </script>
   
   <style>
   
   </style>