<template>
<a data-bs-toggle="modal" data-bs-target="#adminModal" class="mb-3"><span class="link btn">Felhasználók</span></a>

<div class="modal fade modal-lg" id="adminModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header orange-bgc">
        <h1 class="modal-title fs-5">Felhasználók</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body themebg">
        <div class="input-group">
          <input class="form-control mb-3 familytreeinput" type="text" v-model="search" placeholder="Keresés">
        </div>  
        <table class="table table-hover" :class="$store.getters.Settings.darkmode ? 'table-dark' : 'table-striped'" id="myTable">
          <thead>
            <tr>
              <th scope="col">#</th>
              <th scope="col">Név</th>
              <th class="text-center" scope="col">Email-cím</th>
              <th class="text-center"> Tiltás / Engedélyezés </th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="felhasznalo, index in filteredFelhasznalok" :key="felhasznalo.id">
              <th scope="row" class="align-middle"> {{ index + 1}}</th>
              <td class="align-middle">{{felhasznalo.Nev}}</td>
              <td class="align-middle text-center">{{ felhasznalo.email }}</td>
              <td class="align-middle text-center">
                <button class="btn btn-lg" data-bs-target="#banModal" data-bs-toggle="modal" v-if="true" @click="ChooseUser(felhasznalo)">
                  <i class="bi bi-person-x familytreetext" v-if="!felhasznalo.tiltas"></i>
                  <i class="bi bi-person-check familytreetext" v-else></i>
                </button>
                <div v-else class="btn">Admin</div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<div class="modal fade modal-lg" id="banModal" aria-hidden="true" aria-labelledby="adminModalToggleLabel2" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header orange-bgc">
        <h1 class="modal-title fs-5">{{ banningUser.Nev }} Tiltása</h1>
        <button type="button" class="btn-close" data-bs-target="#adminModal" data-bs-toggle="modal"></button>
      </div>
      <div class="modal-body">
        Hide this modal and show the first with the button below.
      </div>
      <div class="modal-footer">
        <button class="btn btn-primary" data-bs-target="#adminModal" data-bs-toggle="modal">Back to first</button>
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
        felhasznalok: [],
        search:"",
        banningUser:{}
    }
},
   
created(){
  axios.get(this.$store.getters.baseURL + "/felhasznalok", {headers: {"authorization": "JWT "+this.$store.getters.Token}})
  .then(res => {
    this.felhasznalok = res.data 
  })
  .catch(err => {
    console.log(err);
  });
},
computed: {
    filteredFelhasznalok() {
      return this.felhasznalok.filter(p => {
        return p.Nev.toLowerCase().indexOf(this.search.toLowerCase()) != -1;
      });
    }
  },
methods:{
  ToggleUserBan(felhasznaloID){

  },
  ChooseUser(felhasznalo){
    this.banningUser = felhasznalo;
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

  .searchbar{
    margin-left: 10%;
  }

  .link{
    font-size:larger;
  }

  .link:active{
    border-color: transparent !important;
  }
</style>