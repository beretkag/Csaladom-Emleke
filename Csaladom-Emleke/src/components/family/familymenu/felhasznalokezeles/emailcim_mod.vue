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
       <label for="oldemail"> Régi e-mail cím: </label>
       <input type="email" name="oldemail" class="form-control mb-3">
       <label for="newmail"> Új e-mail cím: </label>
       <input type="email" name="newmail" class="form-control mb-3">
       <button class="btn btn-dark" @click="Emailchange()">
           E-mail cím módosítása 
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
      Emailchange(){
          let oldemail = this.oldemail;
          let newmail = this.newmail;
          if (oldemail == null || newmail == null) {
                alert('Nem hagyhat üresen mezőt!');
            }
      }
    }
}

</script>

<style>

</style>