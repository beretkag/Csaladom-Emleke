<template>

<div class="modal fade modal-lg" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header orange-bgc">
        <h1 class="modal-title fs-5" id="exampleModalLabel"> Felhasználók </h1>
        <div class="search-wrapper panel-heading searchbar">
    <input type="text" v-model="search" placeholder="Search" /> <br> <br>
  </div>  
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <table class="table table-hover table-dark" id="myTable">
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
    <tr v-for="felhasznalo, index in filteredFelhasznalok" :key="felhasznalo.id">
      <th scope="row" class="align-middle"> {{ index + 1}}</th>
      <td class="align-middle">{{felhasznalo.Nev}}</td>
      <td class="align-middle">{{ felhasznalo.email }}</td>
      <td class="align-middle"> <button class="btn btn-dark btn-lg" data-bs-toggle="modal" data-bs-target="#usermod" @click="ModUser(felhasznalo.ID,index)"> <i class="bi bi-pencil-square" ></i>  </button></td>
      <td class="align-middle"> <button class="btn btn-dark btn-lg" @click="DeleteUser(felhasznalo.ID,index)"> <i class="bi bi-person-x"></i></button>  </td>
    </tr>
  </tbody>
</table>
      </div>
    </div>
  </div>
</div>



<div class="modal fade modal-lg" id="usermod" tabindex="-1" aria-labelledby="usermodLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header orange-bgc">
        <h1 class="modal-title fs-5" id="usermodLabel"> {{moddeduser.newname}} </h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <table class="table table-hover table-dark">
  <thead>
    <tr>
      <th scope="col">Email-cím</th>
      <th scope="col">Jelszó</th>
      <th scope="col">Jogosultság</th>

    </tr>
  </thead>
  <tbody>
    <tr>
      <td class="align-middle" >
        <div class="input-group flex-nowrap">
          <input type="text" class="form-control" v-model="moddeduser.newmail" aria-describedby="addon-wrapping">
        </div>
      </td>
      
      <td class="align-middle" >
        <div class="input-group flex-nowrap">
          <input type="text" class="form-control" v-model="moddeduser.newpass" aria-describedby="addon-wrapping">
        </div>
      </td>

      <td class="align-middle" >
        <div class="input-group flex-nowrap">
          <input type="text" class="form-control" v-model="moddeduser.newjog" aria-describedby="addon-wrapping">
        </div>
      </td>
    </tr>
  </tbody>
</table>
        <button class="btn btn-dark" data-bs-toggle="modal" data-bs-target="#exampleModal"> Vissza </button>
        <button class="btn btn-dark" @click="ModFinished()"> Mentés </button>
      </div>
    </div>
  </div>
</div>

   </template>
   
   <script>

import axios from "axios";
import sha256 from "crypto-js/sha256";

export default{
data(){
    return {
        felhasznalok: [],
        moddeduser:[],
        moddeduserfinished:[],
        search:"",
        missings:{
          newpass:false,
          newmail:false,
          newjog:false
        }
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
computed: {
    filteredFelhasznalok() {
      return this.felhasznalok.filter(p => {
        return p.Nev.toLowerCase().indexOf(this.search.toLowerCase()) != -1;
      });
    }
  },
methods:{
  DeleteUser(id,index){
      if (this.felhasznalok[index].jogosultsag != 1) {
        axios.delete(this.$store.getters.baseURL + "/felhasznalok/ID/" + id, {headers: {"authorization": "JWT "+this.$store.getters.Token}}).then(res =>{
        console.log(res)
        this.$store.commit('ShowMsg', {text:"A felhasználó sikeresen törölve lett", type: "success"})
    })
    .catch(err => {
        console.log(err);
    })
      }
      else{
        this.$store.commit('ShowMsg', {text:"Admint nem lehet törölni", type: "danger"})
      }
  },
  ModUser(id,index){
    this.moddeduser.newname = this.felhasznalok[index].Nev;
    this.moddeduser.newpass = this.felhasznalok[index].Jelszo;
    this.moddeduser.newmail = this.felhasznalok[index].email;
    this.moddeduser.newjog = this.felhasznalok[index].jogosultsag;
    this.moddeduser.newid = this.felhasznalok[index].ID;
  },
  ModFinished(){
    this.moddeduserfinished.modepass = `${sha256(this.moddeduser.newpass)}`;
    this.moddeduserfinished.modemail = this.moddeduser.newmail;
    this.moddeduserfinished.modejog = this.moddeduser.newjog;
    this.moddeduserfinished.modid = this.moddeduser.newid;
    if (this.moddeduserfinished.modepass == "" || this.moddeduserfinished.modemail == "" || this.moddeduserfinished.modejog =="") {
            this.$store.commit('ShowMsg', {text:"Nem adott meg minden adatot!", type: "danger"})
        }
        else{
          if (!this.moddeduser.newpass.match((/^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])([a-zA-Z0-9]{8,})$/))) {
                this.$store.commit('ShowMsg', {text:"A jelszó nem felel meg a követelményeknek!", type: "danger"})
            }
            else{
              let data = {
                  Jelszo : this.moddeduserfinished.modepass,
                  email : this.moddeduserfinished.modemail,
                  jogosultsag : this.moddeduserfinished.modejog
              }
              axios.patch(this.$store.getters.baseURL + '/felhasznalok/' + this.moddeduserfinished.modid, data, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
              this.$store.commit('ShowMsg', {text:"Sikeresen módosította az adatokat", type: "success"})
            }
        }
  },
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
   </style>