<template>
    <div class="d-flex flex-row justify-content-around">
        <div>
            <RouterLink :to="{name: 'namemod'}"><button class="btn btn-dark"> Név </button></RouterLink>
        </div>
        <div>
            <RouterLink :to="{name: 'emailmod'}"><button class="btn btn-dark"> E-mail </button></RouterLink>
        </div>
        <div>
            <RouterLink :to="{name: 'passmod'}"><button class="btn btn-dark"> Jelszó </button></RouterLink>
        </div>
    </div>
    <div class="d-flex flex-column justify-content-between m-3">
        <h1 class="familytreetext">
            Jelszó módosítás
        </h1>
       <label for="oldpass"> Régi jelszó: </label>
       <input type="password" v-model="oldpass" class="form-control mb-3 familytreeinput">
       <label for="passwd1"> Új jelszó: </label>
       <input type="password" v-model="passwd1" class="form-control mb-3 familytreeinput">
       <label for="passwd2"> Új jelszó újra: </label>
       <input type="password" v-model="passwd2" class="form-control mb-3 familytreeinput">
       <button class="btn btn-dark" @click="Passchange()">
           Jelszó módosítása 
       </button>
   </div>
    
</template>

<script>
  import axios from 'axios';
 import { RouterLink, RouterView } from 'vue-router';
 import sha256 from "crypto-js/sha256";

export default {
  name: 'felhasznalokezeles',
  components:{
    RouterLink,
    RouterView
  },
  data(){
      return{
        oldpass:"",
        passwd1:"",
        passwd2:""
      }
      felhasznalo:{};
  },
  methods:{
    Passchange(){
        if (this.passwd1 == "" || this.passwd2 == "" || this.oldpass == "") {
            this.$store.commit('ShowMsg', {text:"Nem töltött ki minden adatot!", type: "danger"})
        }
        else {
            if (this.passwd1 != this.passwd2) {
                this.$store.commit('ShowMsg', {text:"Nem egyeznek a jelszavak!", type: "danger"})
            }
            else{
                if (!this.passwd1.match((/^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])([a-zA-Z0-9]{8,})$/))) {
                    this.$store.commit('ShowMsg', {text:"A jelszó nem felel meg a követelményeknek!", type: "danger"})
                }
                else{
                    axios.post(this.$store.getters.baseURL+ "/user/data", {token :'JWT ' + JSON.parse(sessionStorage.getItem('csaladomemleke'))})
                    .then(sajat => {
                        axios.get(this.$store.getters.baseURL + '/felhasznalok/ID/' + sajat.data.ID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
                        .then(res => {
                            if (res.data[0].Jelszo != `${sha256(this.passwd)}`) {
                                this.$store.commit('ShowMsg', {text:"Hibás jelszót adott meg!", type: "danger"})
                            }
                            else {
                                let data = {
                                    Jelszo: this.passwd1
                                }
                                axios.patch(this.$store.getters.baseURL + '/felhasznalok/' + res.data[0].ID, data, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
                                .then(res => {
                                    this.$store.commit('ShowMsg', {text:"Jelszó sikeresen megváltoztatva!", type: "success"})
                                    this.passwd1 = "";
                                    this.passwd1 = "";
                                    this.oldpass = "";
                                })
                            }
                        })
                    })
                }
            }
        } 
    }
  }
}

</script>

<style scoped>
h1{
    font-size: 200%;
    margin-top: 5%;
    margin-bottom: 5%;
    color: black;
}
button:hover{
    border: 1px solid #ff7112  !important;
    background-color: black;
}
</style>