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
            E-mail cím módosítás
        </h1>
       <label for="passwd"> Jelszó: </label>
       <input type="password" v-model="passwd" class="form-control mb-3">
       <label for="newmail"> Új e-mail cím: </label>
       <input type="email" v-model="newmail" class="form-control mb-3">
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
          newmail: ""
      }
      felhasznalo:{};
      
    },
    created(){
        axios.get(this.$store.getters.baseURL+"/felhasznalok/ID/"+ 7)
        .then(res=>{
            this.felhasznalo=res.data[0]
            console.log(res.data)
        })
    },
    methods:{
      Emailchange(){
          let password = `${sha256(this.passwd)}`;
          let ujemail = this.newmail;
          if (ujemail == null || password == null) {
                alert('Nem hagyhat üresen mezőt!');
            }
            else if( password != this.felhasznalo.Jelszo){
            alert('Nem jó a jelszó')
        }
        else{
            let adatok = {
                email: ujemail
            }
            axios.patch(this.$store.getters.baseURL + "/felhasznalok/" + 7, adatok)
              alert('Sikeresen megváltozott az e-mail címe');
        }
      }
    }
}

</script>

<style>

</style>