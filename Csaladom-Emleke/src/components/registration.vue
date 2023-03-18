<template>
  <h1 class="mb-3">
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
    <input type="text" placeholder="Vezetéknév" class="form-control" :class="{'is-invalid' : missings.lastName}" v-model="newUser.lastName" @click="SetMissing('lastName')">
  </div>
  <div class="mb-3">
    <input type="text" placeholder="Keresztnév" class="form-control" :class="{'is-invalid' : missings.firstName}" v-model="newUser.firstName" @click="SetMissing('firstName')">
  </div>
  <div class="mb-3">
    <input type="email" placeholder="E-mail cím" class="form-control" :class="{'is-invalid' : missings.email}" v-model="newUser.email" @click="SetMissing('email')">
  </div>
  <div class="mb-3 input-group">
    <input type="password" placeholder="Jelszó" class="form-control" :class="{'is-invalid' : missings.password}" v-model="newUser.password" @click="SetMissing('password')">
    <Popper arrow hover>
      <button class="input-group-text"><i class="bi bi-info-circle"></i></button>
      <template #content>
        <h5>Követelmények:</h5>
        <hr>
        <ul>
          <li v-for=" requirement in requirements">
            {{ requirement }}
          </li>
        </ul>
      </template>
    </Popper>
  </div>

  <label>Születés </label>
  <VueDatePicker id="datePicker" class="mb-3" v-model="newUser.szulido" auto-apply :enable-time-picker="false" :max-date="new Date()" :day-names="['Hé', 'Ke', 'Sze', 'Csü', 'Pé', 'Szo', 'Va']" locale="hu"/>

  <hr>

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
import moment from "moment";
import axios from "axios";
import sha256 from "crypto-js/sha256";
import Popper from "vue3-popper";
import VueDatePicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css'


export default {
  name: 'Registration',
  components: {
    VueDatePicker,
    Popper,
    moment,
  },

  data() {
    return{
      baseURL: this.$store.getters.baseURL,
      newUser: {
        szulido: new Date,
        gender: "female"
      },
      missings: {
        lastName: false,
        firstName: false,
        email: false,
        password: false,
        szulido: false
      },
      requirements: ["legalább 8 karakter", "tartalmazzon kisbetűt", "tartalmazzon nagybetűt", "tartalmazzon számot"]
    };
  },
  methods: {
    Registration(){
      let table = "felhasznalok";
      let value = this.newUser.email;
      let field = "email"
      let newUser = {
        Nev: this.newUser.firstName + " " + this.newUser.lastName,
        Jelszo: `${sha256(this.newUser.password)}`,
        email: this.newUser.email,
        jogosultsag: 1
      }

      if(this.Missings().length > 0){
            this.$store.commit('ShowMsg', {text:"Nem töltött ki minden kötelező mezőt!", type: "danger"})
      }else{
        if (!this.newUser.email.match(/(?:[a-z0-9+!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/gi)) {
          this.$store.commit('ShowMsg', {text:"Helytelen e-mail cím formátum!", type: "danger"})
          this.missings.email = true;
        }
        else{
          if (!this.newUser.password.match((/^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])([a-zA-Z0-9]{8,})$/))) {
            this.$store.commit('ShowMsg', {text:"A jelszó nem felel meg a követelményeknek!", type: "danger"})
            this.missings.password = true;
          } else {
          axios.get(this.baseURL + "/" + table + "/" + field + "/" + value)
            .then((res)=>{
              if (res.data.length > 0) {
                this.$store.commit('ShowMsg', {text:"Ezzel az e-mail címmel már regisztráltak!", type: "danger"})
                this.missings.email = true;
              }
              else{
                let data ={};
                data.newUser = newUser;
                data.newCsaladfa = {
                    Nev: this.newUser.firstName + " " + this.newUser.lastName,
                };
                data.csaladtagok = [];
                data.csaladtagok.push({
                  keresztnev: this.newUser.firstName,
                  vezeteknev: this.newUser.lastName,
                  szulido: moment(this.newUser.szulido).format('YYYY-MM-DD'),
                  gender: this.newUser.gender,
                  belsofaID: "aaaa"
                })
                data.csaladtagok = this.AddParent_s(data.csaladtagok);
                axios.post(this.baseURL + "/registration", data)
                .then(() => {
                  this.$store.commit('ShowMsg', {text:"Sikeres Regisztráció!\nMostmár bejelentkezhet.", type: "success"})
                  this.newUser = {};
                  this.$parent.isLoginSet(true);
                })
              }
          })
        }
      }
    }
  },
  AddParent_s(csaladtagok){
    let parents = [{name:"mother", gender:"female"}, {name: "father", gender:"male"}];
    parents.forEach(parent => {
      let name = "";
      this.newUser[parent.name+"LastName"] = this.newUser[parent.name+"LastName"] == undefined ? "" : this.newUser[parent.name +"LastName"]
      this.newUser[parent.name+"FirstName"] = this.newUser[parent.name+"FirstName"] == undefined ? "" : this.newUser[parent.name +"FirstName"]
      if ((name + this.newUser[parent.name+"LastName"] + this.newUser[parent.name+"FirstName"]).length > 0) {
        csaladtagok.push({
          keresztnev: name + this.newUser[parent.name+"FirstName"],
          vezeteknev: name + this.newUser[parent.name+"LastName"],
          gender: parent.gender,
          belsofaID: parent.gender.slice(0,4),
       })
        csaladtagok[0][parent.gender == "female" ? "mid" : "fid"] = parent.gender.slice(0,4);
      }
    });
    if (csaladtagok.length > 2) {
      csaladtagok[1].partnerek = csaladtagok[2].belsofaID;
      csaladtagok[2].partnerek = csaladtagok[1].belsofaID;
    }
    return csaladtagok;
  },
  Missings(){
    let required = Object.keys(this.missings);
    let missed = []
    required.forEach(item => {
      if (this.newUser[item] == null || this.newUser[item] == "") {
        this.missings[item] = true;
        missed.push(item);
      }
    });
    return missed;
  },
  SetMissing(item){
    this.missings[item] = false;
  },
  }
}
</script>

<style>
  #regbutton{
    background-color: #ff7112;
  }

  :root {
    --popper-theme-background-color: #ffffff !important;
    --popper-theme-background-color-hover: #ffffff;
    --popper-theme-text-color: #2b2b2b;
    --popper-theme-border-radius: 6px;
    --popper-theme-padding: 32px;
    --popper-theme-box-shadow: 0 6px 30px -6px rgba(0, 0, 0, 0.25);
  }

</style>
