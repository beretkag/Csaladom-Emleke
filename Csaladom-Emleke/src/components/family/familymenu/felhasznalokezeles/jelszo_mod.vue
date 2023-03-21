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
  created(){
        axios.get(this.$store.getters.baseURL+"/felhasznalok/ID/"+ 6, {headers: {"authorization": "JWT "+this.$store.getters.Token}})
        .then(res=>{
            this.felhasznalo=res.data[0]
        })
    },
  methods:{
    Passchange(){
        let regijelszo = `${sha256(this.oldpass)}`;
        let jelszo1 = `${sha256(this.passwd1)}`;
        let jelszo2 = `${sha256(this.passwd2)}`;
        if (regijelszo == null || jelszo1 == null || jelszo2 == null) {
              alert('Nem hagyhat üresen mezőt!');
          }
        else if( regijelszo != this.felhasznalo.Jelszo){
            alert('Nem jó a jelszó')
        }
        else if( jelszo1 != jelszo2){
            alert('A két beírt jelszó nm jó')
        }
        else{
            let adatok = {
                Jelszo: jelszo1
            }
            axios.patch(this.$store.getters.baseURL + "/felhasznalok/" + this.felhasznalo.ID, adatok, {headers: {"authorization": "JWT "+this.$store.getters.Token}})
              alert('Sikeresen megváltozott a jelszava');
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