<template>
   <div class="d-flex flex-column justify-content-between m-3">
       <h1>
           Bejelentkezés
       </h1>
       <label for="email"> E-mail cím </label>
       <input v-model="user.email" type="email" name="email" class="form-control mb-3">
       <label for="passwd"> Jelszó: </label>
       <input v-model="user.password" type="password" name="passwd" class="form-control">
      <a id="forgotpass" data-bs-toggle="modal" data-bs-target="#exampleModal" class="mb-3"> Elfelejtette a jelszavát? </a>
       
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
    components:{
    },
    data(){
      return{
        baseURL: this.$store.getters.baseURL + "/login",
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
                //Sikeres bejelentkezés
                sessionStorage.setItem('csaladomemleke', JSON.stringify(res.data));
                this.$store.commit('SetToken',  sessionStorage.getItem('csaladomemleke') ? JSON.parse(sessionStorage.getItem('csaladomemleke')) : "");
                axios.get(this.$store.getters.baseURL + "/csaladfak/felhasznaloID/" + res.data.ID, {headers: {"authorization": "JWT "+this.$store.getters.Token}})
                .then(results => {
                  this.$router.push(import.meta.env.BASE_URL + "csalad/" + results[0].data.find(x => x.alapertelmezett == 0).ID);
                })
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
    cursor: pointer;
  }
  #loginbutton{
      background-color: #ff7112;
  }
</style>