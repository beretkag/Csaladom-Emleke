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
  <div class="mb-3">
    <label for="fathersname" class="form-label">Apja neve:</label>
    <input type="text" class="form-control">
  </div>
  <div class="mb-3">
    <label for="mothersname" class="form-label">Anyja neve:</label>
    <input type="text" class="form-control">
  </div>
  <div>
    <label> Maradjak bejelentkezve </label>
    <input class="form-check-input m-1" type="checkbox">
  </div>

  <a href=""> Elfelejtette a jelszavát? </a>
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
