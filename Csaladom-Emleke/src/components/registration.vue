<template>
  <h1>
      Regisztráció
  </h1>
  <p>Neme:</p>
  <div class="nemradio d-flex justify-content-start">
    <div class="form-check form-check-inline">
      <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio1" value="Férfi">
      <label class="form-check-label" for="inlineRadio1">Férfi</label>
    </div>
    <div class="form-check form-check-inline">
        <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="Nő">
        <label class="form-check-label" for="inlineRadio2">Nő</label>
    </div>
  </div>
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
  <select class="form-select mb-3">
    <option selected>Születési éve</option>
    <option v-for="i in 120" value="{{i}}">{{new Date().getFullYear()-i+1}}</option>
  </select>
  <div class="d-flex justify-content-evenly">
    <div class="mb-3">
    <input type="text" placeholder="Apja vezetékneve:" style="width: 95%;" class="form-control">
  </div>
  <div class="mb-3">
    <input type="text" placeholder="Apja keresztneve:" style="width: 95%;" class="form-control">
  </div>
  </div>
  <div class="d-flex justify-content-evenly">
    <div class="mb-3">
    <input type="text" placeholder="Anyja vezetékneve:" style="width: 95%;" class="form-control">
  </div>
  <div class="mb-3">
    <input type="text" placeholder="Anyja keresztneve:" style="width: 95%;" class="form-control">
  </div>
  </div>

  <button id="loginbutton" class="btn">
      Regisztráció 
  </button>
</template>

<script>
import axios from "axios";

export default {
  name: 'Registration',
  components: {},

  data() {
    return{
      newUser: {}
    };
  },

  methods: {
    
  }
}
</script>
