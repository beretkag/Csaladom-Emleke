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
   <div class="d-flex flex-column justify-content-between w-25 bejelentkezes">
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
        <div class="input-group">
          Vezeték és keresztnév
          <input type="text" aria-label="First name" class="form-control">
          <input type="text" aria-label="Last name" class="form-control">
        </div>
       <label for="email"> E-mail cím </label>
       <input type="text" name="email">
       <label for="passwd"> Jelszó: </label>
       <input type="password" name="passwd">
       <div>
        <label for="staylogged"> Maradjak bejelentkezve </label>
       <input type="checkbox"  name="staylogged">
       </div>
       <a id="forgotpass" href=""> Elfelejtette a jelszavát? </a>
       <button id="loginbutton" class="btn">
           Bejelentkezés 
       </button>
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