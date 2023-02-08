<template>
  <h1>
      Regisztráció
  </h1>
    <div class="d-flex justify-content-start">
      <p>Neme:</p>
      <div class="form-check m-2">
        <input class="form-check-input" type="radio" name="inlineRadioOptions" value="Férfi" v-model="newUser.gender">
        <label class="form-check-label" for="inlineRadio1">Férfi</label>
      </div>
      <div class="form-check m-2">
          <input class="form-check-input" type="radio" name="inlineRadioOptions" value="Nő" v-model="newUser.gender">
          <label class="form-check-label" for="inlineRadio2">Nő</label>
      </div>
    </div>
  <div class="mb-3">
    <input type="text" placeholder="Vezetéknév" class="form-control" v-model="newUser.lastName">
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
    <input type="text" placeholder="Vezetéknév:" class="form-control" v-model="newUser.fatherLastName">
  </div>
  <div class="col mb-1">
    <input type="text" placeholder="Keresztnév:" class="form-control" v-model="newUser.fatherFirstName">
  </div>
  </div>
  <div class="row mb-3">
    <p>Anya</p>
    <div class="col-sm-12 col-lg-6 mb-1">
      <input type="text" placeholder="Vezetéknév" class="form-control" v-model="newUser.motherLastName">
    </div>
    <div class="col mb-1">
      <input type="text" placeholder="Keresztnév" class="form-control" v-model="newUser.motherFirstName">
    </div>
  </div>
  <div class="d-flex justify-content-around">
    <button id="regbutton" class="btn" @click="Registration()">
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
        Nev: this.newUser.firstName + " " + this.newUser.lastName,
        Jelszo: this.newUser.password,
        email: this.newUser.email,
        jogosultsag: 1
      }

      if(this.newUser.gender == null ||
          this.newUser.lastName == null ||
          this.newUser.firstName == null ||
          this.newUser.email == null ||
          this.newUser.password == null){
            this.$parent.$refs.msg.SetText("Nem töltött ki minden kötelező mezőt!", "Hibás bemeneti adatok!");
      }else{
        axios.get(this.baseURL + "/" + table + "/" + field + "/" + value)
          .then((res)=>{
            if (res.data.length > 0) {
              this.$parent.$refs.msg.SetText("Ezzel az e-mail címmel már regisztráltak!", "Hibás bemeneti adatok!");
            }
            else{
              axios.post(this.baseURL + "/" + table, data)
                .then((res) => {
                  table = "csaladfak"
                  let csaladfa = {
                    felhasznaloID: res.data.insertId,
                    alapertelmezett: true,
                    Nev: this.newUser.firstName + " " + this.newUser.lastName
                  }
                  axios.post(this.baseURL + "/" + table, csaladfa)
                    .then((res)=>{
                      table = "csaladtagok"
                      let csaladtag = {
                        csaladfaID: res.data.insertId,
                        alapertelmezett: true,
                        keresztnev: this.newUser.firstName,
                        vezeteknev: this.newUser.lastName,
                        szulido: this.newUser.szulido,
                        nem: this.newUser.gender
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
}
</script>

<style scoped>
      #regbutton{
      background-color: #ff7112;
  }
</style>
