<template>

<div class="modal fade modal-lg" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header orange-bgc">
        <h1 class="modal-title fs-5" id="exampleModalLabel"> Felhasználók </h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
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
      </div>
    </div>
  </div>
</div>

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
          alert("Admint nem lehet törölni")
      }

  },
  ModUser(id,index){
      
  }
}
    
}
   </script>
   
   <style>
.orange-bgc{
  background-color: #ff7112;
  border-color: #8b3800;
  color: white;
}
   </style>