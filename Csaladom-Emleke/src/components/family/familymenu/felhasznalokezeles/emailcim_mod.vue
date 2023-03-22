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
            E-mail cím módosítás
        </h1>
       <label for="passwd"> Jelszó: </label>
       <input type="password" v-model="passwd" class="form-control mb-3 familytreeinput">
       <label for="newmail"> Új e-mail cím: </label>
       <input type="email" v-model="newmail" class="form-control mb-3 familytreeinput">
       <button class="btn btn-dark" @click="Emailchange()">
           E-mail cím módosítása 
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
          passwd: "",
          newmail: "",
      }
    },
    methods:{
      Emailchange(){
        if (this.passwd == "" || this.newmail == "") {
            this.$store.commit('ShowMsg', {text:"Nem töltött ki minden adatot!", type: "danger"})
        }
        else {
            if (!this.newmail.match(/(?:[a-z0-9+!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/gi)) {
                this.$store.commit('ShowMsg', {text:"Helytelen e-mail cím formátum!", type: "danger"})
            }
            else{
                axios.get(this.$store.getters.baseURL + '/felhasznalok/email/' + this.newmail, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
                .then(res => {
                    if (res.data.length > 0) {
                        this.$store.commit('ShowMsg', {text:"Ezzel az e-mail címmel már regisztráltak!", type: "danger"})
                    }
                    else {
                        axios.post(this.$store.getters.baseURL+ "/user/data", {token :'JWT ' + JSON.parse(sessionStorage.getItem('csaladomemleke'))})
                        .then(sajat => {
                            axios.get(this.$store.getters.baseURL + '/felhasznalok/ID/' + sajat.data.ID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
                            .then(res => {
                                if (res.data[0].Jelszo != `${sha256(this.passwd)}`) {
                                    this.$store.commit('ShowMsg', {text:"Hibás jelszót adott meg!", type: "danger"})
                                }
                                else {
                                    let data = {
                                        email: this.newmail
                                    }
                                    axios.patch(this.$store.getters.baseURL + '/felhasznalok/' + res.data[0].ID, data, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
                                    .then(res => {
                                        this.passwd = "";
                                        this.newmail = "";
                                    })
                                }
                            })
                        })
                    }
                })


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