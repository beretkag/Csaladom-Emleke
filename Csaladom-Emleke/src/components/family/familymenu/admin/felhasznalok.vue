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
        <table class="table table-hover" :class="$store.getters.Settings.darkmode ? 'table-dark' : 'table-striped'">
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
              <td class="align-middle text-center text-wrap text-break">{{ felhasznalo.email }}</td>
              <td class="align-middle text-center">
                <button class="btn btn-lg" :data-bs-target="ToggleUserBan(felhasznalo).target" :data-bs-toggle="ToggleUserBan(felhasznalo).toggle" v-if="felhasznalo.jogosultsag != 2" @click="ChooseUser(felhasznalo)">
                  <i class="bi bi-person-x red" v-if="!felhasznalo.tiltas"></i>
                  <i class="bi bi-person-check green" v-else></i>
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

<div class="modal fade modal-lg" id="banModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header orange-bgc">
        <h1 class="modal-title fs-5">{{ banningUser.Nev }} Tiltása</h1>
        <button type="button" class="btn-close" data-bs-target="#adminModal" data-bs-toggle="modal"></button>
      </div>
      <div class="modal-body themebg">
        <input class="form-control mb-3 familytreeinput" type="text" v-model="banMessage" placeholder="Tiltás oka">
        <div class="d-flex flex-row-reverse">
          <button type="button" class="btn btn-primary orange-bgc m-3" data-bs-target="#adminModal" data-bs-toggle="modal" @click="BanUser(1)">Tiltás</button>
          <button type="button" class="btn btn-secondary m-3" data-bs-target="#adminModal" data-bs-toggle="modal" @click="Dismiss()">Mégse</button>
        </div>
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
        search: "",
        banningUser:{},
        banMessage: ""
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
      return this.felhasznalok.filter(p => p.Nev.toLowerCase().includes(this.search.toLowerCase()) || p.email.toLowerCase().includes(this.search.toLowerCase()));
    }
  },
methods:{
  Dismiss(){
    this.banMessage = "";
  },
  ToggleUserBan(felhasznalo){
    return felhasznalo.tiltas ? {target: undefined, toggle: undefined} : {target: '#banModal', toggle: 'modal'};
  },
  BanUser(ban){
    let data={
      tiltas: ban,
      tiltasmessage: ban == 1 ? this.banMessage : "",
    }
    axios.patch(this.$store.getters.baseURL + "/felhasznalok/" + this.banningUser.ID, data, {headers: {"authorization": "JWT "+this.$store.getters.Token}})
    .then(res => {
      this.banningUser.tiltas = data.tiltas;
      this.banningUser.tiltasmessage = data.tiltasmessage;
    })
  },
  ChooseUser(felhasznalo){
    this.banningUser = felhasznalo;
    if (felhasznalo.tiltas) {
      this.BanUser(0);
    }
  }
}
}
</script>
   
<style scoped>

  .modal{
    overflow: hidden !important;  
  }
  .red{
    color: red !important;
    font-size: x-large;
  }

  .green{
    color: green !important;
    font-size: x-large;
  }

  .orange-bgc{
    background-color: #ff7112;
    border-color: #8b3800;
  }

  .link{
    font-size:larger;
  }

  .link:active{
    border-color: transparent !important;
  }

  #banModal .btn{
    color: white !important;
  }
</style>