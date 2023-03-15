<template>

<ul class="m-3 text-start">
  <li v-for="csaladfa in csaladfak" >
    <div class="d-flex justify-content-between">
        <RouterLink :to="'/csalad/' + csaladfa.ID + '/Csaladfak'" class="link" :class="{'active' : $store.getters.CsaladfaID == csaladfa.ID}">
          <p class="btn m-0">
            {{ csaladfa.Nev }}
          </p>
        </RouterLink>
      <i class="bi bi-trash3 btn" v-if="$store.getters.CsaladfaID != csaladfa.ID" @click="DeleteTree(csaladfa.ID)"></i>
    </div>
    <hr class="orange ml-3 mr-3">
  </li>
  <li>
    <p class="text-start plus" v-if="csaladfak.length < 5">
      <i class="bi bi-plus-circle btn btn-sm m-0" data-bs-toggle="modal" data-bs-target="#newTreeModal"></i>
    </p>
  </li>
</ul>

<!-- Modal -->
<div class="modal fade" id="newTreeModal" tabindex="-1" aria-hidden="true" v-if="csaladfak.length < 5">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header orange-bgc">
        <h1 class="modal-title fs-5" >Új családfa létrehozása</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" @click="Dismiss()"></button>
      </div>
      <div class="modal-body text-start">
        <div class="mb-3">
          <label>Családfa neve:</label>
          <input type="text" placeholder="Név" class="form-control" :class="{'is-invalid' : missingname}" v-model="newTree.name" @click="SetMissingName()">
        </div>

        <hr>

        <div>
          <label class="mb-3">Első családtag:</label>
          <div class="mb-3">
            <input type="text" placeholder="Vezetéknév" class="form-control" v-model="newTree.lastName">
          </div>
          <div class="mb-3">
            <input type="text" placeholder="Keresztnév" class="form-control" v-model="newTree.firstName">
          </div>
          <div class="d-flex justify-content-start ml-3">
            <label>Neme: &nbsp</label>
            <div class="form-check mb-2">
              <input class="form-check-input" type="radio" name="inlineRadioOptions" value="male" v-model="newTree.gender">
              <label class="form-check-label" for="inlineRadio1">Férfi&nbsp</label>
            </div>
            <div class="form-check mb-2">
                <input class="form-check-input" type="radio" name="inlineRadioOptions" value="female" v-model="newTree.gender">
                <label class="form-check-label" for="inlineRadio2">Nő</label>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" @click="Dismiss()">Mégse</button>
        <button type="button" class="btn btn-primary orange-bgc" data-bs-dismiss="modal" @click="AddNewTree()">Létrehozás</button>
      </div>
    </div>
  </div>
</div>

 
</template>

<script>
import axios from 'axios';
import { RouterLink, RouterView } from 'vue-router';
import router from '../../../router';

 export default{
components: {
  axios,
  RouterLink,
  RouterView
},
data(){
    return{
      csaladfak: [],
      newTree:{},
      missingname: false
    }
},
created(){
  axios.post(this.$store.getters.baseURL+ "/user/data", {token :'JWT ' + JSON.parse(sessionStorage.getItem('csaladomemleke'))})
  .then(sajat =>{
    axios.get(this.$store.getters.baseURL + "/csaladfak/felhasznaloID/" + sajat.data.ID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
      .then(res=>{
        this.csaladfak = res.data;
      })
  })
},
methods:{
  Dismiss(){
    this.newTree = {};
    this.SetMissingName();
  },
  SetMissingName(){
    this.missingname = false;
  },
  AddNewTree(){
    if (this.newTree.name == null || this.newTree.name == "") {
      this.missingname = true;
    } else {
      axios.post(this.$store.getters.baseURL + "/user/data", {token :'JWT ' + JSON.parse(sessionStorage.getItem('csaladomemleke'))})
      .then(sajat =>{
        let data = {
          felhasznaloID: sajat.data.ID,
          Nev: this.newTree.name,
        }
        axios.post(this.$store.getters.baseURL + "/csaladfak", data, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
        .then(res=>{
          data.ID = res.data.insertId;
          this.csaladfak.push(data);
          let settings = {
            csaladfaID: res.data.insertId,
            publikus: "0",
          }
          axios.post(this.$store.getters.baseURL + "/beallitasok", settings, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
          data = {
            csaladfaID: res.data.insertId,
            belsofaID: 'aaaa',
            keresztnev: this.newTree.firstName,
            vezeteknev: this.newTree.lastName,
            gender: this.newTree.gender == null ? "" : this.newTree.gender
          }
          axios.post(this.$store.getters.baseURL + "/csaladtagok", data, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
          .then(res => {
            this.Dismiss();
            router.push('/csalad/' + settings.csaladfaID + "/Csaladfak");
          })
        })
      })
    }
  },
  DeleteTree(treeID){
    axios.delete(this.$store.getters.baseURL + "/fileDelete/kepek/csaladfaID/" + treeID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
    .then(res => {
      axios.delete(this.$store.getters.baseURL + "/kepek/csaladfaID/" + treeID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
      .then(res => {
        axios.delete(this.$store.getters.baseURL + "/csaladtagok/csaladfaID/" + treeID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
        .then(res => {
          axios.delete(this.$store.getters.baseURL + "/beallitasok/csaladfaID/" + treeID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
          .then(res => {
            axios.delete(this.$store.getters.baseURL + "/csaladfak/ID/" + treeID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
            this.csaladfak.splice(this.csaladfak.findIndex(x => x.ID == treeID), 1)
          })
        })
      })
    })

  }
}

 }

</script>

<style>


.plus:hover{
  color: #ff7112;
}

.active, .active *{
  font-weight: bold;
  color: #ff7112 !important;
  margin-left: 30px !important;
  transition: 0.5s;
}

.link:hover{
  margin-left: 30px;
}

.link{
  text-decoration: none;
  color: black;
  margin-left: 0px;
  transition: 0.5s;
}

.bi-plus-circle{
  font-size: x-large;
}

.orange{
  color: #ff7112;
}

.orange-bgc{
  background-color: #ff7112;
  border-color: #8b3800;
  color: white;
}


.modal-backdrop{
  z-index: -1 !important;
}


</style>