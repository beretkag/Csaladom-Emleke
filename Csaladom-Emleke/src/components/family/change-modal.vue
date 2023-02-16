<template>
    <h1>
        Regisztráció
    </h1>
      <div class="d-flex justify-content-start">
        <label>Neme: &nbsp</label>
        <div class="form-check mb-2">
          <input class="form-check-input" type="radio" name="inlineRadioOptions" value="male" v-model="newUser.gender">
          <label class="form-check-label" for="inlineRadio1">Férfi&nbsp</label>
        </div>
        <div class="form-check mb-2">
            <input class="form-check-input" type="radio" name="inlineRadioOptions" value="female" v-model="newUser.gender">
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
  
    <label for="szuletes">Születés </label>
    <div class="input-group mb-3" name="szuletes">
      <span class="input-group-text">ÉÉ:</span>
      <select class="form-select" v-model="newUser.szulido.ev" placeholder="Születési év">
        <option v-for="i in 120" :value="new Date().getFullYear()-i+1">{{new Date().getFullYear()-i+1}}</option>
      </select>
      <span class="input-group-text">HH:</span>
      <select class="form-select" v-model="newUser.szulido.honap" placeholder="Születési év">
        <option v-for="i in 12" :value="i">{{i}}</option>
      </select>
      <span class="input-group-text">NN:</span>
      <select class="form-select" v-model="newUser.szulido.nap" placeholder="Születési év">
        <option v-for="i in 31" :value="i">{{i}}</option>
      </select>
    </div>
  
  
    <label for="apa">Apa</label>
    <div class="row mb-3" name="apa">
      <div class="col-sm-12 col-lg-6 mb-1">
        <input type="text" placeholder="Vezetéknév:" class="form-control" v-model="newUser.fatherLastName">
      </div>
      <div class="col mb-1">
        <input type="text" placeholder="Keresztnév:" class="form-control" v-model="newUser.fatherFirstName">
      </div>
    </div>
  
    <label for="anya">Anya</label>
    <div class="row mb-3" name="anya">
      <div class="col-sm-12 col-lg-6 mb-1">
        <input type="text" placeholder="Vezetéknév" class="form-control" v-model="newUser.motherLastName">
      </div>
      <div class="col mb-1">
        <input type="text" placeholder="Keresztnév" class="form-control" v-model="newUser.motherFirstName">
      </div>
    </div>
    <div class="d-flex justify-content-around">
      <button id="regbutton" class="btn w-100" @click="Registration()">
          Regisztráció 
      </button>
    </div>
  </template>
  
  <script>
  import axios from "axios";
  import sha256 from "crypto-js/sha256";
  
  export default {
    name: 'Registration',
    components: {},
  
    data() {
      return{
        baseURL: this.$store.getters.baseURL,
        newUser: {
          szulido: {}
        }
      };
    },
  
    methods: {
      Registration(){
        let table = "felhasznalok";
        let value = this.newUser.email;
        let field = "email"
        let data = {
          Nev: this.newUser.firstName + " " + this.newUser.lastName,
          Jelszo: `${sha256(this.newUser.password)}`,
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
                          szulido: this.newUser.szulido.ev + "-" + this.newUser.szulido.honap + "-" + this.newUser.szulido.nap,
                          gender: this.newUser.gender,
                          belsofaID: "aaaa"
                        }
                        axios.post(this.baseURL + "/" + table, csaladtag)
                        .then(()=> {
                          this.$parent.$refs.msg.SetText("Sikeres Regisztráció!\nMostmár bejelentkezhet.", "Sikeres Rewgisztráció!");
                          this.newUser = {};
                          this.$parent.isLoginSet(true);
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
  