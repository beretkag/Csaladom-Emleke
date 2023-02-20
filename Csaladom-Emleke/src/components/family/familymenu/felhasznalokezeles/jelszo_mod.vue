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
            Jelszó módosítás
        </h1>
       <label for="oldpass"> Régi jelszó: </label>
       <input type="password" name="oldpass" class="form-control mb-3">
       <label for="passwd1"> Új jelszó: </label>
       <input type="password" name="passwd1" class="form-control mb-3">
       <label for="passwd2"> Új jelszó újra: </label>
       <input type="password" name="passwd2" class="form-control mb-3">
       <button class="btn btn-dark" @click="Passchange()">
           Jelszó módosítása 
       </button>
   </div>
    
</template>

<script>
 import { RouterLink, RouterView } from 'vue-router';

export default {
  name: 'felhasznalokezeles',
  components:{
    RouterLink,
    RouterView
  },
  data(){
      
  },
  methods:{
    Passchange(){
        let oldpass = this.oldpass;
        let passwd = this.passwd1;
        let passwd2 = this.passwd2;
        if (oldpass == null || passwd1 == null || passwd2) {
              alert('Nem hagyhat üresen mezőt!');
          }
    }
  }
}

</script>

<style>

</style>