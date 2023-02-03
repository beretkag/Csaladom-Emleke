<script>
</script>
<template>
   <div class="d-flex flex-column justify-content-between w-25">
       <h1>
           Bejelentkezés
       </h1>
       <label for="email"> E-mail cím </label>
       <input type="text" name="email">
       <label for="passwd"> Jelszó: </label>
       <input type="password" name="passwd">
       <div>
        <label for="staylogged"> Maradjak bejelentkezve </label>
       <input type="checkbox" name="staylogged">
       </div>
       <a id="forgotpass" href=""> Elfelejtette a jelszavát? </a>
       <button id="loginbutton" class="btn">
           Bejelentkezés 
       </button>
   </div>
</template>
<style>
  #forgotpass{
    text-decoration: none ;
    color: grey;
  }
  #loginbutton{
      background-color: #ff7112;
  }
</style>