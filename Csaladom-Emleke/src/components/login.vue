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
       <button id="loginbutton" class="btn" @click="LogIn()">
           Bejelentkezés 
       </button>
   </div>
</template>

<script>
  import axios from "axios";
  import sha256 from "crypto-js/sha256";

  export default {
    name: "Login",
    components:{},
    data(){
      return{
        baseURL: this.$parent.$parent.$parent.baseURL() + "/login",
        user: {}
      }
    },
    methods:{
      LogIn(){
        let data = {
          table: "felhasznalok",
          email: this.user.email,
          password: `${sha256(this.user.password)}`
        }
        axios.post(this.baseURL, data)
            .then((res) => {
              if (res.data.length < 1) {
                this.$parent.$refs.msg.SetText("Hibás felhasználónév vagy jelszó!", "Hibás bemeneti adatok!");
              } else {
                this.$parent.$refs.msg.SetText("Sikeres Bejelentkezés", "Siker");

                // vue store-ba feltültjük az adatokat
              }
            })
            .catch((err) => console.log(err));
      }
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