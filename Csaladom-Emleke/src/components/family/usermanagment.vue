<template>
    <table class="table table-hover table-dark">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Családnév</th>
      <th scope="col">Keresztnév</th>
      <th scope="col">Email-cím</th>
      <th> Módosítás </th>
      <th> Törlés </th>
    </tr>
  </thead>
  <tbody>
    <tr v-for="felhasznalo, index in felhasznalok">
      <th scope="row" class="align-middle"> {{ index + 1}}</th>
      <td class="align-middle">{{felhasznalo.Nev.split(' ')[1]}}</td>
      <td class="align-middle">{{felhasznalo.Nev.split(' ')[0]}}</td>
      <td class="align-middle">{{ felhasznalo.email }}</td>
      <td class="align-middle"> <button class="btn btn-dark btn-lg "> <i class="bi bi-pencil-square" ></i>  </button></td>
      <td class="align-middle"> <button class="btn btn-dark btn-lg" @click="DeleteUser(felhasznalo.id)"> <i class="bi bi-person-x"></i></button>  </td>
    </tr>
  </tbody>
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
    axios.get(this.$store.getters.baseURL + "/felhasznalok").then(res => {
        let data = res.data;
            this.felhasznalok = res.data 
    })
    .catch(err => {
        console.log(err);
    });
    },
    
}


   </script>
   
   <style>
   </style>