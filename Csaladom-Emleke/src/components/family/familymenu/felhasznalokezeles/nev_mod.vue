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
        <h1>
            Név módosítás
        </h1>
       <label for="passwd"> Jelszó: </label>
       <input type="password" v-model="passwd" class="form-control mb-3">
       <label for="newname"> Új név: </label>
       <input type="text" v-model="newname" class="form-control mb-3">
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
    }
    felhasznalo:{};
      
    },
    created(){
        axios.get(this.$store.getters.baseURL+"/felhasznalok/ID/"+ 7)
        .then(res=>{
            this.felhasznalo=res.data[0]
        })
        
    },
    methods:{
      Namechange(){
        let password =  `${sha256(this.passwd)}`;
        let ujnev = this.newname;
          if (ujnev == null || password == null) {
              alert('Nem hagyhat üresen mezőt!');
          }
          else if(password != this.felhasznalo.Jelszo){
              alert('Nem egyezik a jelszó!');
          }
          else if(ujnev == this.felhasznalo.Nev){
              alert('Az új név nem egyezhet meg a régivel!');
          }
          else{
              let adatok = {
                  Nev: ujnev
              }
              axios.patch(this.$store.getters.baseURL + "/felhasznalok/" + 7, adatok)
              alert('Sikeresen megváltozott a neve');
          }
      }
    }
}

</script>

<style>
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