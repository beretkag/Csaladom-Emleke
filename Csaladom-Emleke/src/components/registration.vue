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
    <input type="email" placeholder="Vezetéknév" class="form-control" id="lastname">
  </div>
  <div class="mb-3">
    <input type="email" placeholder="Keresztnév" class="form-control" id="firstname">
  </div>
  <div class="mb-3">
    <input type="email" placeholder="E-mail cím" class="form-control" id="email">
  </div>
  <div class="mb-3">
    <input type="password" placeholder="Jelszó" class="form-control" id="passwd">
  </div>
  <select class="form-select mb-3">
    <option selected>Születési éve</option>
    <option v-for="i in 120" value="{{i}}">{{new Date().getFullYear()-i+1}}</option>
  </select>
  <div class="mb-3">
    <label for="fathersname" class="form-label">Apja neve:</label>
    <input type="email" class="form-control" id="fathersname">
  </div>
  <div class="mb-3">
    <label for="mothersname" class="form-label">Anyja neve:</label>
    <input type="email" class="form-control" id="mothersname">
  </div>
  <div>
    <label for="staylogged"> Maradjak bejelentkezve </label>
    <input class="form-check-input mt-0" type="checkbox" id="staylogged" value="" aria-label="Checkbox for following text input">
  </div>

  <a id="forgotpass" href="#ajjaj"> Elfelejtette a jelszavát? </a>
  <button id="loginbutton" class="btn">
      Regisztráció 
  </button>
</template>