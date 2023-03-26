<template>
   <div class="d-flex flex-column justify-content-between m-3">
       <h1>
           Bejelentkezés
       </h1>
       <label for="email"> E-mail cím </label>
       <input v-model="user.email" type="email" name="email" class="form-control mb-3" :class="{'is-invalid' : missings.email}" @click="SetMissing('email')">
       <label for="passwd"> Jelszó: </label>
       <input v-model="user.password" type="password" name="passwd" class="form-control" :class="{'is-invalid' : missings.password}" @keydown.enter="LogIn()" @click="SetMissing('password')">
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
        user: {},
        missings: {
          email: false,
          password: false
        }
      }
    },
    methods:{
      SetMissing(missing){
        this.missings[missing]=false;
      },
      LogIn(){
        let data = {
          table: "felhasznalok",
          email: this.user.email,
          password: `${sha256(this.user.password)}`
        }
        if (this.Missings().length > 0) {
          this.$store.commit('ShowMsg', {text:"Nem töltött ki minden adatot!", type: "danger"})
        } else {
          axios.post(this.baseURL, data)
          .then((res) => {
            if (res.data.length < 1) {
              this.$store.commit('ShowMsg', {text:"Hibás felhasználónév vagy jelszó!", type: "danger"})
              this.missings.password = true;
            } else {
              axios.post(this.$store.getters.baseURL+ "/user/data", {token :'JWT ' + res.data})
              .then(res => {
                if (res.data.tiltas == 1) {
                  this.$store.commit('ShowMsg', {text:"A felhasználó kitiltva a következőek miatt: \n" + res.data.tiltasmessage, type: "danger"})
                }
                else{
                  //Sikeres bejelentkezés
                  sessionStorage.setItem('csaladomemleke', JSON.stringify(res.data));
                  axios.get(this.$store.getters.baseURL + "/csaladfak/felhasznaloID/" + res.data.ID, {headers: {"authorization": "JWT "+JSON.parse(sessionStorage.getItem('csaladomemleke'))}})
                  .then(results => {
                    this.$router.push(import.meta.env.BASE_URL + "csalad/" + results.data[0].ID);
                  })
                }
              })
            }
          })
        }
      },
      Missings(){
        let required = Object.keys(this.missings);
        let missed = [];
        required.forEach(item => {
          if (this.user[item] == null || this.user[item].length == 0) {
            missed.push(item);
            this.missings[item] = true;
          }
        });
        return missed;
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