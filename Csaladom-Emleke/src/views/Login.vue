<script>
</script>
<template>
  <div class="fejlecdiv d-flex justify-content-around">
    <div class="logodiv">
      <img src="../assets/logopng.png" class="logo" alt="Családomemléke logó">
    </div>
    <div></div>
    <div class="bejelentkezesdiv">
      <a href="#bejelentkezes" class="bejelentkezeslink">Bejelentkezés</a>
    </div>
  </div>
   <div class="d-flex pe-2 flex-row-reverse">
    <div class="d-flex flex-column justify-content-between bejelentkezes col-md-4">
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
   </div>
   </div>
</template>
<style>
.nevekdiv{

}
.fejlecdiv{

}
.bejelentkezeslink{
  text-decoration: none;
  color: white;
}
.bejelentkezeslink:hover{
  color: #ff7112;
}
.bejelentkezesdiv{
  margin-top: 50px;
}
.logo{
  width: 200px;
  height: 125px;

}
h1{

}
body{
  
  background-image: url('../assets/valamihatter.jpg');
  background-repeat: no-repeat;
  background-size: cover;
}
.bejelentkezes{
  backdrop-filter: blur(3px);
  position: relative;
  color: white;
  background-color: rgba(0, 0, 0, 0.5);
  padding: 40px;
  border-radius: 10px;

}
  #forgotpass{
    text-decoration: none ;
    color: grey;
  }
  #loginbutton{
      background-color: #ff7112;
  }
</style>