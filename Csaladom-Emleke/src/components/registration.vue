<template>
  <h1>
      Regisztráció
  </h1>
  <p>Neme:
    <div class="d-flex justify-content-start">
      <div class="form-check">
        <input class="form-check-input" type="radio" name="inlineRadioOptions" value="Férfi" v-model="newUser.gender">
        <label class="form-check-label" for="inlineRadio1">Férfi</label>
      </div>
      <div class="form-check">
          <input class="form-check-input" type="radio" name="inlineRadioOptions" value="Nő" v-model="newUser.gender">
          <label class="form-check-label" for="inlineRadio2">Nő</label>
      </div>
    </div>
  </p>
  <div class="mb-3">
    <input type="text" placeholder="Vezetéknév" class="form-control" v-model="newUser.surName">
  </div>
  <div class="mb-3">
    <input type="text" placeholder="Keresztnév" class="form-control" v-model="newUser.firstName">
  </div>
  <div class="mb-3">
    <input type="email" placeholder="E-mail cím" class="form-control" v-model="newUser.email">
  </div>
  <div class="mb-3">
    <input type="password" placeholder="Jelszó" class="form-control" v-model="newUser.password">
  </div>
  <select class="form-select mb-3" v-model="newUser.szulido">
    <option v-for="i in 120" value="{{i}}">{{new Date().getFullYear()-i+1}}</option>
  </select>
  <div class="row mb-3">
    <p>Apa</p>
    <div class="col-sm-12 col-lg-6 mb-1">
    <input type="text" placeholder="Vezetéknév:" class="form-control">
  </div>
  <div class="col mb-1">
    <input type="text" placeholder="Keresztnév:" class="form-control">
  </div>
  </div>
  <div class="row mb-3">
    <p>Anya</p>
    <div class="col-sm-12 col-lg-6 mb-1">
      <input type="text" placeholder="Vezetéknév" class="form-control">
    </div>
    <div class="col mb-1">
      <input type="text" placeholder="Keresztnév" class="form-control">
    </div>
  </div>
  <div>
    <button id="loginbutton" class="btn" @click="Registration()">
        Regisztráció 
    </button>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: 'Registration',
  components: {},

  data() {
    return{
      baseURL: "http://localhost:3000",
      newUser: {}
    };
  },

  methods: {
    Registration(){
      let table = "felhasznalok";
      let value = this.newUser.email;
      let field = "email"
      let data = {
        Nev: this.newUser.firstName + " " + this.newUser.surName,
        Jelszo: this.newUser.password,
        email: this.newUser.email,
        jogosultsag: 1
      }

      this.$parent.$refs.msg.OpenCloseFunction();
      return;

      axios.get(this.baseURL + "/" + table + "/" + field + "/" + value)
        .then((res)=>{
          if (res.data.length > 0) {
            this.$parent.messageText = "újabb"
            this.$parent.$refs.msg.OpenCloseFunction();
          }
          else{
            axios.post(this.baseURL + "/" + table, data)
              .then((res) => {
                table = "csaladfak"
                let csaladfa = {
                  felhasznaloID: res.data.insertId,
                  alapertelmezett: true,
                  Nev: this.newUser.firstName + " " + this.newUser.surName
                }
                axios.post(this.baseURL + "/" + table, csaladfa)
                  .then((res)=>{
                    table = "csaladtagok"
                    let csaladtag = {
                      csaladfaID: res.data.insertId,
                      alapertelmezett: true,
                      Nev: this.newUser.firstName + " " + this.newUser.surName,
                      szulido: this.newUser.szulido,
                      Nem: this.newUser.gender
                    }
                    axios.post(this.baseURL + "/" + table, csaladtag)
                    .then(()=> {
                      this.newUser = {};
                    })
                  })
              })
          }
      })
    }
  }
}
</script>
