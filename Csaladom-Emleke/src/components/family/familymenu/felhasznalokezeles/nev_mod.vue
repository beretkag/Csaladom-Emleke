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
       <label for="oldname"> Régi név: </label>
       <input type="text" name="oldname" class="form-control mb-3">
       <label for="newname"> Új név: </label>
       <input type="text" name="newname" class="form-control mb-3">
       <button class="btn btn-dark" @click="Namechange()">
           Név módosítása 
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
      Namechange(){
        let oldname = this.oldname;
        let newname = this.newname

          if (oldname == null || newname == null) {
              alert('Nem hagyhat üresen mezőt!');
          }
          else if(oldname != oldname){
              //nem egyezik a régi névvel
          }
          else if(newname != newname){
              //új név nem megfelelő
          }
          else{
              //névváltoztatás backend
              alert('Sikeresen megváltozott a neve')
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