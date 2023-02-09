<template>
   <div class="d-flex flex-column justify-content-between m-3">
       <h1>
           Bejelentkezés
       </h1>
       <label for="email"> E-mail cím </label>
       <input v-model="user.email" type="email" name="email" class="form-control mb-3">
       <label for="passwd"> Jelszó: </label>
       <input v-model="user.password" type="password" name="passwd" class="form-control">
       <a id="forgotpass" class="mb-3"> Elfelejtette a jelszavát? </a>
       <button id="loginbutton" class="btn">
           Bejelentkezés 
       </button>
   </div>
</template>

<script>
  import axios from "axios";


  export default {
    name: "Login",
    components:{},
    data(){
      return{
        user: {}
      }
    },
    methods:{

    }

  }
</script>

<style scoped>
  #forgotpass{
    text-decoration: none ;
    color: rgb(180, 180, 180);
  }
  #loginbutton{
      background-color: #ff7112;
  }
</style>