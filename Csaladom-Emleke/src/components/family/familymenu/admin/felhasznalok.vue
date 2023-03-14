<template>
    <table class="table table-hover table-dark">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Név</th>
      <th scope="col">Email-cím</th>
      <th> Módosítás </th>
      <th> Törlés </th>
    </tr>
  </thead>
  <tbody>
    <tr v-for="felhasznalo, index in felhasznalok">
      <th scope="row" class="align-middle"> {{ index + 1}}</th>
      <td class="align-middle">{{felhasznalo.Nev}}</td>
      <td class="align-middle">{{ felhasznalo.email }}</td>
      <td class="align-middle"> <button class="btn btn-dark btn-lg" @click="ModUser(felhasznalo.ID,index)"> <i class="bi bi-pencil-square" ></i>  </button></td>
      <td class="align-middle"> <button class="btn btn-dark btn-lg" @click="DeleteUser(felhasznalo.ID,index)"> <i class="bi bi-person-x"></i></button>  </td>
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
  axios.get(this.$store.getters.baseURL + "/felhasznalok", {headers: {"authorization": "JWT "+this.$store.getters.Token}}).then(res => {
    let data = res.data;
    this.felhasznalok = res.data 
  })
  .catch(err => {
    console.log(err);
  });
},
methods:{
  DeleteUser(id,index){
      if (this.felhasznalok[index].jogosultsag != 1) {
        axios.delete(this.$store.getters.baseURL + "/felhasznalok/ID/" + id, {headers: {"authorization": "JWT "+this.$store.getters.Token}}).then(res =>{
        console.log(res)
    })
    .catch(err => {
        console.log(err);
    })
      }
      else{
          alert("admint nem lehet törölni")
      }

  },
  ModUser(id,index){
      
  }
}
    
}
   </script>
   
   <style>
table{
    margin-top: 2% !important;
}
   </style>