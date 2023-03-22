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
            Név módosítás
        </h1>
       <label for="passwd"> Jelszó: </label>
       <input type="password" v-model="passwd" class="form-control mb-3 familytreeinput" :class="{'is-invalid' : missings.passwd}" @click="SetMissing('passwd')">
       <label for="newname"> Új név: </label>
       <input type="text" v-model="newname" class="form-control mb-3 familytreeinput" :class="{'is-invalid' : missings.newname}" @click="SetMissing('newname')">
       <button class="btn btn-dark" @click="Namechange()">
           Név módosítása 
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
        newname:"",
        missings:{
            passwd: false,
            newname: false
        }
    }
      
    },
    methods:{
      Namechange(){
        if (this.Missings(this.missings).length > 0) {
            this.$store.commit('ShowMsg', {text:"Nem töltött ki minden adatot!", type: "danger"})
        }
        else {
            axios.post(this.$store.getters.baseURL+ "/user/data", {token :'JWT ' + JSON.parse(sessionStorage.getItem('csaladomemleke'))})
            .then(sajat => {
                axios.get(this.$store.getters.baseURL + '/felhasznalok/ID/' + sajat.data.ID, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
                .then(res => {
                    if (res.data[0].Jelszo != `${sha256(this.passwd)}`) {
                        this.missings.passwd = true;
                        this.$store.commit('ShowMsg', {text:"Hibás jelszót adott meg!", type: "danger"})
                    }
                    else {
                        let data = {
                            Nev: this.newname
                        }
                        axios.patch(this.$store.getters.baseURL + '/felhasznalok/' + res.data[0].ID, data, {headers: {"authorization": "JWT "+ JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
                        .then(res => {
                            data = {
                                table: "felhasznalok",
                                email: sajat.data.email,
                                password: `${sha256(this.passwd)}`
                            }
                            axios.post(this.$store.getters.baseURL + '/login', data)
                            .then(res => {
                                console.log(res.data);
                                sessionStorage.setItem('csaladomemleke', JSON.stringify(res.data));
                                this.$store.commit('SetNev', this.newname);
                                this.$store.commit('ShowMsg', {text:"Név sikeresen megváltoztatva!", type: "success"})
                                this.passwd = "";
                                this.newname = "";
                            })
                        })
                    }
                })
            })
        } 
      },
      Missings(){
        let required = Object.keys(this.missings);
        let missed = [];
        required.forEach(item => {
          if (this[item] == null || this[item].length == 0) {
            missed.push(item);
            this.missings[item] = true;
          }
        });
        return missed;
      },
      SetMissing(missing){
        this.missings[missing]=false;
      },
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